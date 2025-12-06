/*******************************************************************************************************************************
**                                                                                                                            **
**                                                 MVD_RP1_Map : Database.sql                                                 **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

-- Rename [{MVD_RP1_Map}] to new database name

USE master
GO

CREATE DATABASE [{MVD_RP1_Map}] ON PRIMARY
(
   NAME       = N'[{MVD_RP1_Map}]',
   FILENAME   = N'D:\MSSQL\Data\[{MVD_RP1_Map}].mdf',
   SIZE       = 4096KB,
   MAXSIZE    = UNLIMITED,
   FILEGROWTH = 10%
)
LOG ON
(
   NAME       = N'[{MVD_RP1_Map}]_log',
   FILENAME   = N'D:\MSSQL\Data\[{MVD_RP1_Map}]_log.ldf',
   SIZE       = 4096KB,
   MAXSIZE    = 2048GB,
   FILEGROWTH = 10%
)
GO

ALTER DATABASE [{MVD_RP1_Map}] SET ANSI_NULL_DEFAULT             OFF
ALTER DATABASE [{MVD_RP1_Map}] SET ANSI_NULLS                    ON
ALTER DATABASE [{MVD_RP1_Map}] SET ANSI_PADDING                  ON
ALTER DATABASE [{MVD_RP1_Map}] SET ANSI_WARNINGS                 OFF
ALTER DATABASE [{MVD_RP1_Map}] SET ARITHABORT                    OFF
ALTER DATABASE [{MVD_RP1_Map}] SET AUTO_CLOSE                    OFF
ALTER DATABASE [{MVD_RP1_Map}] SET AUTO_CREATE_STATISTICS        ON
ALTER DATABASE [{MVD_RP1_Map}] SET AUTO_SHRINK                   OFF
ALTER DATABASE [{MVD_RP1_Map}] SET AUTO_UPDATE_STATISTICS        ON
ALTER DATABASE [{MVD_RP1_Map}] SET CURSOR_CLOSE_ON_COMMIT        OFF
ALTER DATABASE [{MVD_RP1_Map}] SET CURSOR_DEFAULT                GLOBAL
ALTER DATABASE [{MVD_RP1_Map}] SET CONCAT_NULL_YIELDS_NULL       OFF
ALTER DATABASE [{MVD_RP1_Map}] SET NUMERIC_ROUNDABORT            OFF
ALTER DATABASE [{MVD_RP1_Map}] SET QUOTED_IDENTIFIER             OFF
ALTER DATABASE [{MVD_RP1_Map}] SET RECURSIVE_TRIGGERS            OFF
ALTER DATABASE [{MVD_RP1_Map}] SET DISABLE_BROKER
ALTER DATABASE [{MVD_RP1_Map}] SET AUTO_UPDATE_STATISTICS_ASYNC  OFF
ALTER DATABASE [{MVD_RP1_Map}] SET DATE_CORRELATION_OPTIMIZATION OFF
ALTER DATABASE [{MVD_RP1_Map}] SET TRUSTWORTHY                   OFF
ALTER DATABASE [{MVD_RP1_Map}] SET ALLOW_SNAPSHOT_ISOLATION      OFF
ALTER DATABASE [{MVD_RP1_Map}] SET PARAMETERIZATION              SIMPLE
ALTER DATABASE [{MVD_RP1_Map}] SET READ_COMMITTED_SNAPSHOT       OFF
ALTER DATABASE [{MVD_RP1_Map}] SET HONOR_BROKER_PRIORITY         OFF
ALTER DATABASE [{MVD_RP1_Map}] SET READ_WRITE
ALTER DATABASE [{MVD_RP1_Map}] SET RECOVERY                      FULL
ALTER DATABASE [{MVD_RP1_Map}] SET MULTI_USER
ALTER DATABASE [{MVD_RP1_Map}] SET PAGE_VERIFY                   CHECKSUM
ALTER DATABASE [{MVD_RP1_Map}] SET DB_CHAINING                   ON
GO

ALTER AUTHORIZATION ON DATABASE::[{MVD_RP1_Map}] TO sa
GO

USE [{MVD_RP1_Map}]
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Map : WebService.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE USER MapService FOR LOGIN [MV\MapService] WITH DEFAULT_SCHEMA = dbo
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Map : WebService.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE USER WebService FOR LOGIN [MV\WebService] WITH DEFAULT_SCHEMA = dbo
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                 MVD_RP1_Map : RMCObject.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE TABLE dbo.RMCType
(
   bType                     TINYINT         NOT NULL,
   sType                     NVARCHAR (31)   NOT NULL,

   CONSTRAINT PK_RMCType PRIMARY KEY CLUSTERED
   (
      bType ASC
   )
)
ON [PRIMARY]
GO

INSERT dbo.RMCType
       (bType, sType)
VALUES ( 0, ''              ),
       ( 1, 'Universe'      ),
       ( 2, 'Supercluster'  ),
       ( 3, 'Galaxy Cluster'),
       ( 4, 'Galaxy'        ),
       ( 5, 'Black Hole'    ),
       ( 6, 'Nebula'        ),
       ( 7, 'Star Cluster'  ),
       ( 8, 'Constellation' ),
       ( 9, 'Star System'   ),
       (10, 'Star'          ),
       (11, 'Planet System' ),
       (12, 'Planet'        ),
       (13, 'Moon'          ),
       (14, 'Debris'        ),
       (15, 'Satellite'     ),
       (16, 'Transport'     ),
       (17, 'Surface'       )

GO

/******************************************************************************************************************************/

CREATE TABLE dbo.RMCObject
(
   ObjectHead_Parent_wClass            SMALLINT        NOT NULL,
   ObjectHead_Parent_twObjectIx        BIGINT          NOT NULL,
   ObjectHead_Self_wClass              SMALLINT        NOT NULL,
   ObjectHead_Self_twObjectIx          BIGINT          NOT NULL IDENTITY (1, 1),
   ObjectHead_twEventIz                BIGINT          NOT NULL,
   ObjectHead_wFlags                   SMALLINT        NOT NULL,

   Name_wsRMCObjectId                  NVARCHAR (48)   NOT NULL,
   Type_bType                          TINYINT         NOT NULL,
   Type_bSubtype                       TINYINT         NOT NULL,
   Type_bFiction                       TINYINT         NOT NULL,
   Owner_twRPersonaIx                  BIGINT          NOT NULL,
   Resource_qwResource                 BIGINT          NOT NULL,
   Resource_sName                      NVARCHAR (48)   NOT NULL DEFAULT (''),
   Resource_sReference                 NVARCHAR (128)  NOT NULL DEFAULT (''),
   Transform_Position_dX               FLOAT (53)      NOT NULL,
   Transform_Position_dY               FLOAT (53)      NOT NULL,
   Transform_Position_dZ               FLOAT (53)      NOT NULL,
   Transform_Rotation_dX               FLOAT (53)      NOT NULL,
   Transform_Rotation_dY               FLOAT (53)      NOT NULL,
   Transform_Rotation_dZ               FLOAT (53)      NOT NULL,
   Transform_Rotation_dW               FLOAT (53)      NOT NULL,
   Transform_Scale_dX                  FLOAT (53)      NOT NULL,
   Transform_Scale_dY                  FLOAT (53)      NOT NULL,
   Transform_Scale_dZ                  FLOAT (53)      NOT NULL,
   Orbit_Spin_tmPeriod                 BIGINT          NOT NULL,
   Orbit_Spin_tmStart                  BIGINT          NOT NULL,
   Orbit_Spin_dA                       FLOAT (53)      NOT NULL,
   Orbit_Spin_dB                       FLOAT (53)      NOT NULL,
   Bound_dX                            FLOAT (53)      NOT NULL,
   Bound_dY                            FLOAT (53)      NOT NULL,
   Bound_dZ                            FLOAT (53)      NOT NULL,
   Properties_fMass                    FLOAT (24)      NOT NULL,                        
   Properties_fGravity                 FLOAT (24)      NOT NULL,                        
   Properties_fColor                   FLOAT (24)      NOT NULL,                        
   Properties_fBrightness              FLOAT (24)      NOT NULL,                        
   Properties_fReflectivity            FLOAT (24)      NOT NULL                        

   CONSTRAINT PK_RMCObject PRIMARY KEY CLUSTERED
   (
      ObjectHead_Self_twObjectIx       ASC
   ),

   INDEX      IX_RMCObject_ObjectHead_Parent_twObjectIx NONCLUSTERED
   (
      ObjectHead_Parent_twObjectIx     ASC
   ),

   INDEX      IX_RMCObject_Name_wsRMCObjectId    NONCLUSTERED
   (
      Name_wsRMCObjectId               ASC
   ),
)
ON [PRIMARY]
GO

/******************************************************************************************************************************/

-- bOp     Meaning
-- 0       NULL
-- 1       RMCObject_Open
-- 2       RMCObject_Close
-- 3       RMCObject_Name
-- 4       RMCObject_Type
-- 5       RMCObject_Owner
-- 6       RMCObject_Resource
-- 7       RMCObject_Transform
-- 8       RMCObject_Orbit
-- 9       RMCObject_Spin
-- 10      RMCObject_Bound
-- 11      RMCObject_Properties

CREATE TABLE dbo.RMCObjectLog
(
   dtCreated                    DATETIME2       NOT NULL    CONSTRAINT DF_RMCObjectLog_dtCreated     DEFAULT SYSUTCDATETIME (),
   twLogIx                      BIGINT          NOT NULL    IDENTITY (1, 1),

   bOp                          TINYINT         NOT NULL,
   dwIPAddress                  BINARY (4)      NOT NULL,
   twRPersonaIx                 BIGINT          NOT NULL,
   twRMCObjectIx                BIGINT          NOT NULL

   CONSTRAINT PK_RMCObjectLog PRIMARY KEY CLUSTERED
   (
      twLogIx                   ASC
   ),
)
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                  MVD_RP1_Map : RMEvent.sql                                                 **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE TABLE dbo.RMEvent
(
   twEventIx                     BIGINT          NOT NULL IDENTITY (0, 1),

   sType                         VARCHAR (32)    NOT NULL,

   Self_wClass                   TINYINT         NOT NULL,
   Self_twObjectIx               BIGINT          NOT NULL,
   Child_wClass                  TINYINT         NOT NULL,
   Child_twObjectIx              BIGINT          NOT NULL,
   wFlags                        SMALLINT        NOT NULL,
   twEventIz                     BIGINT          NOT NULL,
   
   sJSON_Object                  NVARCHAR (4000) NOT NULL,
   sJSON_Child                   NVARCHAR (4000) NOT NULL,
   sJSON_Change                  NVARCHAR (4000) NOT NULL,

   CONSTRAINT PK_RMEvent PRIMARY KEY CLUSTERED
   (
      twEventIx                  ASC
   ),
)
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                 MVD_RP1_Map : RMPObject.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE TABLE dbo.RMPType
(
   bType                     TINYINT         NOT NULL,
   sType                     NVARCHAR (31)   NOT NULL,

   CONSTRAINT PK_RMPType PRIMARY KEY CLUSTERED
   (
      bType ASC
   )
)
ON [PRIMARY]
GO

INSERT dbo.RMPType
       (bType, sType)
VALUES ( 0, ''         ),
       ( 1, 'Transport'),
       ( 2, 'Other'    )

GO

/******************************************************************************************************************************/

CREATE TABLE dbo.RMPObject
(
   ObjectHead_Parent_wClass            SMALLINT        NOT NULL,
   ObjectHead_Parent_twObjectIx        BIGINT          NOT NULL,
   ObjectHead_Self_wClass              SMALLINT        NOT NULL,
   ObjectHead_Self_twObjectIx          BIGINT          NOT NULL IDENTITY (1, 1),
   ObjectHead_twEventIz                BIGINT          NOT NULL,
   ObjectHead_wFlags                   SMALLINT        NOT NULL,

   Name_wsRMPObjectId                  NVARCHAR (48)   NOT NULL,
   Type_bType                          TINYINT         NOT NULL,
   Type_bSubtype                       TINYINT         NOT NULL,
   Type_bFiction                       TINYINT         NOT NULL,
   Type_bMovable                       TINYINT         NOT NULL,
   Owner_twRPersonaIx                  BIGINT          NOT NULL,
   Resource_qwResource                 BIGINT          NOT NULL,
   Resource_sName                      NVARCHAR (48)   NOT NULL DEFAULT (''),
   Resource_sReference                 NVARCHAR (128)  NOT NULL DEFAULT (''),
   Transform_Position_dX               FLOAT (53)      NOT NULL,
   Transform_Position_dY               FLOAT (53)      NOT NULL,
   Transform_Position_dZ               FLOAT (53)      NOT NULL,
   Transform_Rotation_dX               FLOAT (53)      NOT NULL,
   Transform_Rotation_dY               FLOAT (53)      NOT NULL,
   Transform_Rotation_dZ               FLOAT (53)      NOT NULL,
   Transform_Rotation_dW               FLOAT (53)      NOT NULL,
   Transform_Scale_dX                  FLOAT (53)      NOT NULL,
   Transform_Scale_dY                  FLOAT (53)      NOT NULL,
   Transform_Scale_dZ                  FLOAT (53)      NOT NULL,
   Bound_dX                            FLOAT (53)      NOT NULL,
   Bound_dY                            FLOAT (53)      NOT NULL,
   Bound_dZ                            FLOAT (53)      NOT NULL,

   CONSTRAINT PK_RMPObject           PRIMARY KEY CLUSTERED
   (
      ObjectHead_Self_twObjectIx       ASC
   ),

   INDEX      IX_RMPObject_ObjectHead_Parent_twObjectIx NONCLUSTERED
   (
      ObjectHead_Parent_twObjectIx     ASC
   )
)
ON [PRIMARY]
GO

/******************************************************************************************************************************/

-- bOp     Meaning
-- 0       NULL
-- 1       RMPObject_Open
-- 2       RMPObject_Close
-- 3    -- RMPObject_Name
-- 4       RMPObject_Type
-- 5       RMPObject_Owner
-- 6       RMPObject_Resource
-- 7       RMPObject_Transform
-- 8    -- RMPObject_Orbit
-- 9    -- RMPObject_Spin
-- 10      RMPObject_Bound
-- 11   -- RMPObject_Properties

CREATE TABLE dbo.RMPObjectLog
(
   dtCreated                    DATETIME2       NOT NULL    CONSTRAINT DF_RMPObjectLog_dtCreated     DEFAULT SYSUTCDATETIME (),
   twLogIx                      BIGINT          NOT NULL    IDENTITY (1, 1),

   bOp                          TINYINT         NOT NULL,
   dwIPAddress                  BINARY (4)      NOT NULL,
   twRPersonaIx                 BIGINT          NOT NULL,
   twRMPObjectIx                BIGINT          NOT NULL

   CONSTRAINT PK_RMPObjectLog PRIMARY KEY CLUSTERED
   (
      twLogIx                   ASC
   ),
)
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                  MVD_RP1_Map : RMRoot.sql                                                  **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE TABLE dbo.RMRoot
(
   ObjectHead_Parent_wClass            SMALLINT        NOT NULL,
   ObjectHead_Parent_twObjectIx        BIGINT          NOT NULL,
   ObjectHead_Self_wClass              SMALLINT        NOT NULL,
   ObjectHead_Self_twObjectIx          BIGINT          NOT NULL IDENTITY (1, 1),
   ObjectHead_twEventIz                BIGINT          NOT NULL,
   ObjectHead_wFlags                   SMALLINT        NOT NULL,

   Name_wsRMRootId                     NVARCHAR (48)   NOT NULL,
   Owner_twRPersonaIx                  BIGINT          NOT NULL,

   CONSTRAINT PK_RMRoot PRIMARY KEY CLUSTERED
   (
      ObjectHead_Self_twObjectIx       ASC
   )
)
ON [PRIMARY]
GO

INSERT dbo.RMRoot
       ( ObjectHead_Parent_wClass, ObjectHead_Parent_twObjectIx, ObjectHead_Self_wClass, ObjectHead_twEventIz, ObjectHead_wFlags, Name_wsRMRootId, Owner_twRPersonaIx )
VALUES ( 52,                       1,                            70,                     0,                    32,                'Root',          1                  )
GO

/******************************************************************************************************************************/

-- bOp     Meaning
-- 0       NULL
-- 1    -- RMRoot_Open
-- 2    -- RMRoot_Close
-- 3       RMRoot_Name
-- 4    -- RMRoot_Type
-- 5       RMRoot_Owner
-- 6    -- RMRoot_Resource
-- 7    -- RMRoot_Transform
-- 8    -- RMRoot_Orbit
-- 9    -- RMRoot_Spin
-- 10   -- RMRoot_Bound
-- 11   -- RMRoot_Properties
-- 12   -- RMRoot_RMRoot_Open
-- 13   -- RMRoot_RMRoot_Close
-- 14      RMRoot_RMCObject_Open
-- 15      RMRoot_RMCObject_Close
-- 16      RMRoot_RMTObject_Open
-- 17      RMRoot_RMTObject_Close
-- 18      RMRoot_RMPObject_Open
-- 19      RMRoot_RMPObject_Close

CREATE TABLE dbo.RMRootLog
(
   dtCreated                    DATETIME2       NOT NULL    CONSTRAINT DF_RMRootLog_dtCreated     DEFAULT SYSUTCDATETIME (),
   twLogIx                      BIGINT          NOT NULL    IDENTITY (1, 1),

   bOp                          TINYINT         NOT NULL,
   dwIPAddress                  BINARY (4)      NOT NULL,
   twRPersonaIx                 BIGINT          NOT NULL,
   twRMRootIx                   BIGINT          NOT NULL

   CONSTRAINT PK_RMRootLog PRIMARY KEY CLUSTERED
   (
      twLogIx                   ASC
   ),
)
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Map : RMTBuilding.sql                                               **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE TABLE dbo.RMTBuilding
(
   twRMTObjectIx                       BIGINT     NOT NULL,  -- sector
   bnOSMWay                            BIGINT     NOT NULL,  -- building

   PRIMARY KEY CLUSTERED
   (
      twRMTObjectIx                    ASC,
      bnOSMWay                         ASC
   ),
)
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                 MVD_RP1_Map : RMTMatrix.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE TABLE dbo.RMTSubsurface
(
   twRMTObjectIx                       BIGINT     NOT NULL,
                                                                 --                        Nul      Car      Cyl      Geo
   tnGeometry                          TINYINT    NOT NULL,      --                        0        1        2        3
   dA                                  FLOAT (53) NOT NULL,      -- original coordinates   -        x        angle    latitude
   dB                                  FLOAT (53) NOT NULL,      -- original coordinates   -        y        y        longitude
   dC                                  FLOAT (53) NOT NULL,      -- original coordinates   -        z        radius   radius

-- bnMatrix =  twRMTObjectIx is the         transform for this subsurface
-- bnMatrix = -twRMTObjectIx is the inverse transform for this subsurface

   PRIMARY KEY CLUSTERED
   (
      twRMTObjectIx                    ASC
   ),
)
GO

CREATE TABLE dbo.RMTMatrix
(
   bnMatrix                            BIGINT     NOT NULL,

   d00                                 FLOAT (53) NOT NULL DEFAULT 1,
   d01                                 FLOAT (53) NOT NULL DEFAULT 0,
   d02                                 FLOAT (53) NOT NULL DEFAULT 0,
   d03                                 FLOAT (53) NOT NULL DEFAULT 0,

   d10                                 FLOAT (53) NOT NULL DEFAULT 0,
   d11                                 FLOAT (53) NOT NULL DEFAULT 1,
   d12                                 FLOAT (53) NOT NULL DEFAULT 0,
   d13                                 FLOAT (53) NOT NULL DEFAULT 0,

   d20                                 FLOAT (53) NOT NULL DEFAULT 0,
   d21                                 FLOAT (53) NOT NULL DEFAULT 0,
   d22                                 FLOAT (53) NOT NULL DEFAULT 1,
   d23                                 FLOAT (53) NOT NULL DEFAULT 0,

   d30                                 FLOAT (53) NOT NULL DEFAULT 0,
   d31                                 FLOAT (53) NOT NULL DEFAULT 0,
   d32                                 FLOAT (53) NOT NULL DEFAULT 0,
   d33                                 FLOAT (53) NOT NULL DEFAULT 1,

   PRIMARY KEY CLUSTERED
   (
      bnMatrix                         ASC
   ),
)
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                 MVD_RP1_Map : RMTObject.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE TABLE dbo.RMTType
(
   bType                     TINYINT         NOT NULL,
   sType                     NVARCHAR (31)   NOT NULL,

   CONSTRAINT PK_RMTType PRIMARY KEY CLUSTERED
   (
      bType ASC
   )
)
ON [PRIMARY]
GO

INSERT dbo.RMTType
       (bType, sType)
VALUES ( 0, ''         ),
       ( 1, 'Root'     ),
       ( 2, 'Water'    ),
       ( 3, 'Land'     ),
       ( 4, 'Country'  ),
       ( 5, 'Territory'),
       ( 6, 'State'    ),
       ( 7, 'County'   ),
       ( 8, 'City'     ),
       ( 9, 'Community'),
       (10, 'Sector'   ),
       (11, 'Parcel'   )
GO

/******************************************************************************************************************************/

CREATE TABLE dbo.RMTObject
(
   ObjectHead_Parent_wClass            SMALLINT        NOT NULL,
   ObjectHead_Parent_twObjectIx        BIGINT          NOT NULL,
   ObjectHead_Self_wClass              SMALLINT        NOT NULL,
   ObjectHead_Self_twObjectIx          BIGINT          NOT NULL IDENTITY (1, 1),
   ObjectHead_twEventIz                BIGINT          NOT NULL,
   ObjectHead_wFlags                   SMALLINT        NOT NULL,

   Name_wsRMTObjectId                  NVARCHAR (48)   NOT NULL,
   Type_bType                          TINYINT         NOT NULL,
   Type_bSubtype                       TINYINT         NOT NULL,
   Type_bFiction                       TINYINT         NOT NULL,
   Owner_twRPersonaIx                  BIGINT          NOT NULL,
   Resource_qwResource                 BIGINT          NOT NULL,
   Resource_sName                      NVARCHAR (48)   NOT NULL DEFAULT (''),
   Resource_sReference                 NVARCHAR (128)  NOT NULL DEFAULT (''),
   Transform_Position_dX               FLOAT (53)      NOT NULL,
   Transform_Position_dY               FLOAT (53)      NOT NULL,
   Transform_Position_dZ               FLOAT (53)      NOT NULL,
   Transform_Rotation_dX               FLOAT (53)      NOT NULL,
   Transform_Rotation_dY               FLOAT (53)      NOT NULL,
   Transform_Rotation_dZ               FLOAT (53)      NOT NULL,
   Transform_Rotation_dW               FLOAT (53)      NOT NULL,
   Transform_Scale_dX                  FLOAT (53)      NOT NULL,
   Transform_Scale_dY                  FLOAT (53)      NOT NULL,
   Transform_Scale_dZ                  FLOAT (53)      NOT NULL,
   Bound_dX                            FLOAT (53)      NOT NULL,
   Bound_dY                            FLOAT (53)      NOT NULL,
   Bound_dZ                            FLOAT (53)      NOT NULL,
   Properties_bLockToGround            TINYINT         NOT NULL,
   Properties_bYouth                   TINYINT         NOT NULL,
   Properties_bAdult                   TINYINT         NOT NULL,
   Properties_bAvatar                  TINYINT         NOT NULL,

   CONSTRAINT PK_RMTObject           PRIMARY KEY CLUSTERED
   (
      ObjectHead_Self_twObjectIx       ASC
   ),

   INDEX      IX_RMTObject_ObjectHead_Parent_twObjectIx NONCLUSTERED
   (
      ObjectHead_Parent_twObjectIx     ASC
   ),

   INDEX      IX_RMTObject_Name_wsRMTObjectId    NONCLUSTERED
   (
      Name_wsRMTObjectId               ASC
   ),
)
ON [PRIMARY]
GO

/******************************************************************************************************************************/

-- bOp     Meaning
-- 0       NULL
-- 1       RMTObject_Open
-- 2       RMTObject_Close
-- 3       RMTObject_Name
-- 4       RMTObject_Type
-- 5       RMTObject_Owner
-- 6       RMTObject_Resource
-- 7       RMTObject_Transform
-- 8    -- RMTObject_Orbit
-- 9    -- RMTObject_Spin
-- 10      RMTObject_Bound
-- 11      RMTObject_Properties

CREATE TABLE dbo.RMTObjectLog
(
   dtCreated                    DATETIME2       NOT NULL    CONSTRAINT DF_RMTObjectLog_dtCreated     DEFAULT SYSUTCDATETIME (),
   twLogIx                      BIGINT          NOT NULL    IDENTITY (1, 1),

   bOp                          TINYINT         NOT NULL,
   dwIPAddress                  BINARY (4)      NOT NULL,
   twRPersonaIx                 BIGINT          NOT NULL,
   twRMTObjectIx                BIGINT          NOT NULL

   CONSTRAINT PK_RMTObjectLog PRIMARY KEY CLUSTERED
   (
      twLogIx                   ASC
   ),
)
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                 MVD_RP1_Map : ArcLength.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.ArcLength
(
   @dRadius          FLOAT (53),

   @dX0              FLOAT (53),
   @dY0              FLOAT (53),
   @dZ0              FLOAT (53),

   @dX               FLOAT (53),
   @dY               FLOAT (53),
   @dZ               FLOAT (53)
)
RETURNS FLOAT (53)
AS
BEGIN
            -- arc length = 2 * radius * arcsin (distance / (2 * radius))

            -- This function assumes dX0, dY0, and dZ0 have already been normalized to dRadius
            -- Origins in the database sit below the surface and must also be normalized to dRadius

       DECLARE @dNormal FLOAT (53) = @dRadius / SQRT ((@dX * @dX) + (@dY * @dY) + (@dZ * @dZ))

           SET @dX *= @dNormal
           SET @dY *= @dNormal
           SET @dZ *= @dNormal

           SET @dX -= @dX0
           SET @dY -= @dY0
           SET @dZ -= @dZ0

        RETURN (2.0 * @dRadius) * ASIN (SQRT ((@dX * @dX) + (@dY * @dY) + (@dZ * @dZ)) / (2.0 * @dRadius))
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : DateTime2_Time.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

-- TIME reports time in 1/64 sec from UTC Jan 1, 1601
-- UNIX reports time in 1/1000 sec from UTC Jan 1, 1970
-- There are  134774 days between UTC Jan 1, 1601 and UTC Jan 1, 1970
-- There are 5529600 1/64 sec per day

-- 134774 * 5529600 = 745246310400

CREATE FUNCTION dbo.DateTime2_Time
(
   @tmStamp BIGINT
)
RETURNS DATETIME2  -- DATETIME2 values must be in UTC
AS
BEGIN

      DECLARE @dt2 DATETIME2,
              @s   BIGINT,
              @mcs BIGINT

          SET @tmStamp -= 745246310400

          SET @s        = @tmStamp / 64;

          SET @mcs      = @tmStamp % 64;
          SET @mcs     *= 1000000
          SET @mcs     /= 64

          SET @dt2 = dateadd (s,   @s, '1970-01-01')
          SET @dt2 = dateadd (mcs, @mcs, @dt2)

       RETURN @dt2
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : Date_DateTime2.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

-- DATETIME2  reports time in 1/10000000 sec from UTC Jan 1, 0001
-- JavaScript reports time in 1/1000     sec from UTC Jan 1, 1970 (Unix Epoch Time)
-- There are  719162 days between Jan 1, 0001 and Jan 1, 1970
-- There are 86400000 1/1000 sec per day

CREATE FUNCTION dbo.Date_DateTime2
(
   @dtStamp DATETIME2  -- DATETIME2 values must be in UTC and generally generated from GETUTCDATE ()
)
RETURNS BIGINT
AS
BEGIN
      DECLARE @vb10 VARBINARY (10), 
              @date BIGINT, 
              @time BIGINT

          SET @vb10 = CONVERT (VARBINARY (10), @dtStamp)
          SET @vb10 = CONVERT (VARBINARY (10), REVERSE (@vb10))

          SET @date = CAST (SUBSTRING (@vb10, 1, 3) AS BIGINT)
          SET @time = CAST (SUBSTRING (@vb10, 4, 5) AS BIGINT)

          SET @date -= 719162 -- shift from (SQL) Jan 1, 0001 to (JavaScript) Jan 1, 1970
          SET @time /= 10000

       RETURN @date * 86400000 + @time
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Bound.sql                                               **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Bound
(
   @dX                      FLOAT (53),
   @dY                      FLOAT (53),
   @dZ                      FLOAT (53)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"Max": ' + dbo.Format_Double3 (@dX, @dY, @dZ) +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : Format_Control.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Control
(
   @Self_wClass             SMALLINT,
   @Self_twObjectIx         BIGINT,
   @Child_wClass            SMALLINT,
   @Child_twObjectIx        BIGINT,
   @wFlags                  SMALLINT,
   @twEventIz               BIGINT
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"wClass_Object": ' + CAST (@Self_wClass      AS NVARCHAR (16)) + ', ' +
                '"twObjectIx": '    + CAST (@Self_twObjectIx  AS NVARCHAR (16)) + ', ' +
                '"wClass_Child": '  + CAST (@Child_wClass     AS NVARCHAR (16)) + ', ' +
                '"twChildIx": '     + CAST (@Child_twObjectIx AS NVARCHAR (16)) + ', ' +
                '"wFlags": '        + CAST (@wFlags           AS NVARCHAR (16)) + ', ' +
                '"twEventIz": '     + CAST (@twEventIz        AS NVARCHAR (16)) + 
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Double.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Double
(
   @d   FLOAT (53)
)
RETURNS NVARCHAR (32)
AS
BEGIN

      DECLARE @dA      FLOAT (53)    = ABS (@d)
      DECLARE @e       INT           = 0
      DECLARE @sSign   NVARCHAR (1)  = ''
      DECLARE @sExp    NVARCHAR (8)  = ''
      DECLARE @sNum    NVARCHAR (20) = ''

           IF (@dA <> @d)
              SET @sSign = '-'

           IF @dA <> 0  AND  @dA <> 1
        BEGIN
                   IF @dA < CAST ('1e+0' AS FLOAT (53))
                BEGIN
                      WHILE (@dA < CAST (CONCAT ('1e', 0 - @e) AS FLOAT (53))  AND  @e < 310)
                            SET @e += 1

                        SET @dA  *= CAST (CONCAT ('1e+', @e) AS FLOAT (53))
                        SET @sExp = CONCAT ('e-', @e)
                  END
              ELSE IF @dA >= CAST ('1e+1' AS FLOAT (53))
                BEGIN
                      WHILE (@dA >= CAST (CONCAT ('1e+', @e + 1) AS FLOAT (53))  AND  @e < 310)
                            SET @e += 1

                        SET @dA  *= CAST (CONCAT ('1e-', @e) AS FLOAT (53))
                        SET @sExp = CONCAT ('e+', @e)
                  END
          END

           IF (FLOOR (@da) = CEILING (@da))
              SET @sNum = STR (@da, 1)
         ELSE SET @sNum = STR (@dA, 18, 16)

       RETURN CONCAT (@sSign, @sNum, @sExp)
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : Format_Double3.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Double3
(
   @dX   FLOAT (53),
   @dY   FLOAT (53),
   @dZ   FLOAT (53)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN CONCAT ('[', dbo.Format_Double (@dX), ',', dbo.Format_Double (@dY), ',', dbo.Format_Double (@dZ), ']')
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : Format_Double4.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Double4
(
   @dX   FLOAT (53),
   @dY   FLOAT (53),
   @dZ   FLOAT (53),
   @dW   FLOAT (53)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN CONCAT ('[', dbo.Format_Double (@dX), ',', dbo.Format_Double (@dY), ',', dbo.Format_Double (@dZ), ',', dbo.Format_Double (@dW), ']')
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Float.sql                                               **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Float
(
   @d   FLOAT (24)
)
RETURNS NVARCHAR (32)
AS
BEGIN

      DECLARE @dA      FLOAT (24)    = ABS (@d)
      DECLARE @e       INT           = 0
      DECLARE @sSign   NVARCHAR (1)  = ''
      DECLARE @sExp    NVARCHAR (8)  = ''
      DECLARE @sNum    NVARCHAR (20) = ''

           IF (@dA <> @d)
              SET @sSign = '-'

           IF @dA <> 0  AND  @dA <> 1
        BEGIN
                   IF @dA < CAST ('1e+0' AS FLOAT (24))
                BEGIN
                      WHILE (@dA < CAST (CONCAT ('1e', 0 - @e) AS FLOAT (24))  AND  @e < 310)
                            SET @e += 1

                        SET @dA  *= CAST (CONCAT ('1e+', @e) AS FLOAT (24))
                        SET @sExp = CONCAT ('e-', @e)
                  END
              ELSE IF @dA >= CAST ('1e+1' AS FLOAT (24))
                BEGIN
                      WHILE (@dA >= CAST (CONCAT ('1e+', @e + 1) AS FLOAT (24))  AND  @e < 310)
                            SET @e += 1

                        SET @dA  *= CAST (CONCAT ('1e-', @e) AS FLOAT (24))
                        SET @sExp = CONCAT ('e+', @e)
                  END
          END

           IF (FLOOR (@da) = CEILING (@da))
              SET @sNum = STR (@da, 1)
         ELSE SET @sNum = STR (@dA, 10, 8)

       RETURN CONCAT (@sSign, @sNum, @sExp)
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Name_C.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Name_C
(
   @wsRMCObjectId            NVARCHAR (48)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"wsRMCObjectId": "' + @wsRMCObjectId + '"' +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Name_P.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Name_P
(
   @wsRMPObjectId            NVARCHAR (48)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"wsRMPObjectId": "' + @wsRMPObjectId + '"' +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Name_R.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Name_R
(
   @wsRMRootId            NVARCHAR (48)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"wsRMRootId": "' + @wsRMRootId + '"' +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Name_T.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Name_T
(
   @wsRMTObjectId            NVARCHAR (48)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"wsRMTObjectId": "' + @wsRMTObjectId + '"' +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : Format_ObjectHead.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_ObjectHead
(
   @Parent_wClass           SMALLINT,
   @Parent_twObjectIx       BIGINT,
   @Self_wClass             SMALLINT,
   @Self_twObjectIx         BIGINT,
   @wFlags                  SMALLINT,
   @twEventIz               BIGINT
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"wClass_Parent": ' + CAST (@Parent_wClass     AS NVARCHAR (16)) + ', ' +
                '"twParentIx": '    + CAST (@Parent_twObjectIx AS NVARCHAR (16)) + ', ' +
                '"wClass_Object": ' + CAST (@Self_wClass       AS NVARCHAR (16)) + ', ' +
                '"twObjectIx": '    + CAST (@Self_twObjectIx   AS NVARCHAR (16)) + ', ' +
                '"wFlags": '        + CAST (@wFlags            AS NVARCHAR (16)) + ', ' +
                '"twEventIz": '     + CAST (@twEventIz         AS NVARCHAR (16)) +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : Format_Orbit_Spin.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Orbit_Spin
(
   @tmPeriod                 BIGINT,
   @tmStart                  BIGINT,
   @dA                       FLOAT (53),
   @dB                       FLOAT (53)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"tmPeriod": ' + CAST (@tmPeriod AS NVARCHAR (32)) + ', ' +
                '"tmStart": '  + CAST (@tmStart  AS NVARCHAR (32)) + ', ' +
                '"dA": '       + dbo.Format_Double (@dA)           + ', ' +
                '"dB": '       + dbo.Format_Double (@dB)           +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Owner.sql                                               **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Owner
(
   @twRPersonaIx                BIGINT
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"twRPersonaIx": ' + CAST (@twRPersonaIx AS NVARCHAR (16)) +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : Format_Properties_C.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Properties_C
(
   @fMass                    FLOAT (24),
   @fGravity                 FLOAT (24),
   @fColor                   FLOAT (24),
   @fBrightness              FLOAT (24),
   @fReflectivity            FLOAT (24)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"fMass": '         + dbo.Format_Float (@fMass)         + ', ' +
                '"fGravity": '      + dbo.Format_Float (@fGravity)      + ', ' +
                '"fColor": '        + dbo.Format_Float (@fColor)        + ', ' +
                '"fBrightness": '   + dbo.Format_Float (@fBrightness)   + ', ' +
                '"fReflectivity": ' + dbo.Format_Float (@fReflectivity) +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : Format_Properties_T.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Properties_T
(
   @bLockToGround            TINYINT,
   @bYouth                   TINYINT,
   @bAdult                   TINYINT,
   @bAvatar                  TINYINT
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"bLockToGround": ' + CAST (@bLockToGround AS NVARCHAR (4)) + ', ' +
                '"bYouth": '        + CAST (@bYouth        AS NVARCHAR (4)) + ', ' +
                '"bAdult": '        + CAST (@bAdult        AS NVARCHAR (4)) + ', ' +
                '"bAvatar": '       + CAST (@bAvatar       AS NVARCHAR (4)) +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : Format_Resource.sql                                             **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Resource
(
   @qwResource               BIGINT,
   @sName                    NVARCHAR (48),
   @sReference               NVARCHAR (128)
)
RETURNS NVARCHAR (256)
AS
BEGIN
      DECLARE @n        INT,
              @sName_   NVARCHAR (128)

          SET @sName_ = @sName

           IF SUBSTRING (@sName, 1, 1) = '~'
        BEGIN
              SET @n = CHARINDEX (':', @sName)
               IF @n > 0  AND  LEN (@sName) = @n + 10
                  SET @sName_ = 'https://' + SUBSTRING (@sName, 2, @n - 2) + '-cdn.rp1.com/sector/' + SUBSTRING (@sName, @n + 1, 1) + '/' + SUBSTRING (@sName, @n + 2, 3) + '/' + SUBSTRING (@sName, @n + 5, 3) + '/' + SUBSTRING (@sName, @n + 1, 10) + '.json'
          END

      RETURN '{ ' + 
                '"qwResource": ' + CAST (@qwResource AS NVARCHAR (32)) + ', ' +
                '"sName": '      + '"' + @sName_                 + '"' + ', ' +
                '"sReference": ' + '"' + @sReference             + '"' +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : Format_Transform.sql                                             **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Transform
(
   @Position_dX               FLOAT (53),
   @Position_dY               FLOAT (53),
   @Position_dZ               FLOAT (53),
   @Rotation_dX               FLOAT (53),
   @Rotation_dY               FLOAT (53),
   @Rotation_dZ               FLOAT (53),
   @Rotation_dW               FLOAT (53),
   @Scale_dX                  FLOAT (53),
   @Scale_dY                  FLOAT (53),
   @Scale_dZ                  FLOAT (53)
)
RETURNS NVARCHAR (512)
AS
BEGIN
      RETURN '{ ' + 
                '"Position": ' + dbo.Format_Double3 (@Position_dX, @Position_dY, @Position_dZ)               + ', ' +
                '"Rotation": ' + dbo.Format_Double4 (@Rotation_dX, @Rotation_dY, @Rotation_dZ, @Rotation_dW) + ', ' +
                '"Scale": '    + dbo.Format_Double3 (@Scale_dX,    @Scale_dY,    @Scale_dZ)                  +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Type_C.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Type_C
(
   @bType                    TINYINT,
   @bSubtype                 TINYINT,
   @bFiction                 TINYINT
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"bType": '    + CAST (@bType    AS NVARCHAR (4)) + ', ' +
                '"bSubtype": ' + CAST (@bSubtype AS NVARCHAR (4)) + ', ' +
                '"bFiction": ' + CAST (@bFiction AS NVARCHAR (4)) +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Type_P.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Type_P
(
   @bType                    TINYINT,
   @bSubtype                 TINYINT,
   @bFiction                 TINYINT,
   @bMovable                 TINYINT
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"bType": '    + CAST (@bType    AS NVARCHAR (4)) + ', ' +
                '"bSubtype": ' + CAST (@bSubtype AS NVARCHAR (4)) + ', ' +
                '"bFiction": ' + CAST (@bFiction AS NVARCHAR (4)) + ', ' +
                '"bMovable": ' + CAST (@bMovable AS NVARCHAR (4)) +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Format_Type_T.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Format_Type_T
(
   @bType                    TINYINT,
   @bSubtype                 TINYINT,
   @bFiction                 TINYINT
)
RETURNS NVARCHAR (256)
AS
BEGIN
      RETURN '{ ' + 
                '"bType": '    + CAST (@bType    AS NVARCHAR (4)) + ', ' +
                '"bSubtype": ' + CAST (@bSubtype AS NVARCHAR (4)) + ', ' +
                '"bFiction": ' + CAST (@bFiction AS NVARCHAR (4)) +
             ' }'
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Friends : IPstob.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2024 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.IPstob
(
   @sIPAddress     NVARCHAR (16)
)
RETURNS BINARY (4)
AS
BEGIN
      DECLARE @a       INT,
              @b       INT,
              @c       INT,
              @x       BIGINT

          SET @a = CHARINDEX ('.', @sIPAddress)
          SET @b = CHARINDEX ('.', @sIPAddress, @a + 1)
          SET @c = CHARINDEX ('.', @sIPAddress, @b + 1)

          SET @x = 0
          SET @x = @x * 256 + CONVERT (BIGINT, SUBSTRING (@sIPAddress,      1,      @a - 1))
          SET @x = @x * 256 + CONVERT (BIGINT, SUBSTRING (@sIPAddress, @a + 1, @b - @a - 1))
          SET @x = @x * 256 + CONVERT (BIGINT, SUBSTRING (@sIPAddress, @b + 1, @c - @b - 1))
          SET @x = @x * 256 + CONVERT (BIGINT, SUBSTRING (@sIPAddress, @c + 1, 16 - @c - 1))

       RETURN CONVERT (BINARY (4), @x)
END
GO

CREATE FUNCTION dbo.IPbtos
(
   @dwIPAddress    BINARY (4)
)
RETURNS NVARCHAR (16)
AS
BEGIN
      RETURN  CONVERT (VARCHAR (3), CONVERT (INT, SUBSTRING (@dwIPAddress, 1, 1)))
      + '.' + CONVERT (VARCHAR (3), CONVERT (INT, SUBSTRING (@dwIPAddress, 2, 1)))
      + '.' + CONVERT (VARCHAR (3), CONVERT (INT, SUBSTRING (@dwIPAddress, 3, 1)))
      + '.' + CONVERT (VARCHAR (3), CONVERT (INT, SUBSTRING (@dwIPAddress, 4, 1)))
END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Map : Table_Error.sql                                               **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Table_Error ()
RETURNS @Error TABLE
(
   nOrder                        INT             NOT NULL IDENTITY (0, 1),
   dwError                       INT             NOT NULL,
   sError                        NVARCHAR (255)  NOT NULL
)
AS
BEGIN
       -- This function returns an empty table from which the #Error table is created

       RETURN
END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Map : Table_Event.sql                                               **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Table_Event ()
RETURNS @Event TABLE
(
   nOrder                        INT             NOT NULL IDENTITY (0, 1),

   sType                         VARCHAR (32)    NOT NULL,

   Self_wClass                   SMALLINT        NOT NULL,
   Self_twObjectIx               BIGINT          NOT NULL,
   Child_wClass                  SMALLINT        NOT NULL,
   Child_twObjectIx              BIGINT          NOT NULL,
   wFlags                        SMALLINT        NOT NULL,
   twEventIz                     BIGINT          NOT NULL,
   
   sJSON_Object                  NVARCHAR (4000) NOT NULL,
   sJSON_Child                   NVARCHAR (4000) NOT NULL,
   sJSON_Change                  NVARCHAR (4000) NOT NULL
)
AS
BEGIN
       -- This function returns an empty table from which the #Event table is created

       RETURN
END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Table_Results.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE FUNCTION dbo.Table_Results ()
RETURNS @Results TABLE
(
   nResultSet                    INT,
   ObjectHead_Self_twObjectIx    BIGINT
)
AS
BEGIN
       -- This function returns an empty table from which the #Results table is created

       RETURN
END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : Time_Current.sql                                               **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

-- This function is really Date_Current

CREATE FUNCTION dbo.Time_Current
(
)
RETURNS BIGINT
AS
BEGIN
       RETURN dbo.Date_DateTime2 (GETUTCDATE ())
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : Time_DateTime2.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

-- DATETIME2  reports time in 1/10000000 sec from UTC Jan 1, 0001
-- S3         reports time in 1/64       sec from UTC Jan 1, 1601
-- There are  584388 days between UTC Jan 1, 0001 and UTC Jan 1, 1601
-- There are 5529600 1/64 sec per day

-- 584388 * 5529600 = 3231431884800

CREATE FUNCTION dbo.Time_DateTime2
(
   @dtStamp DATETIME2  -- DATETIME2 values must be in UTC and generally generated from GETUTCDATE ()
)
RETURNS BIGINT
AS
BEGIN
      DECLARE @vb10 VARBINARY (10), 
              @date BIGINT, 
              @time BIGINT

          SET @vb10 = CONVERT (VARBINARY (10), @dtStamp)
          SET @vb10 = CONVERT (VARBINARY (10), REVERSE (@vb10))

          SET @date = CAST (SUBSTRING (@vb10, 1, 3) AS BIGINT)
          SET @time = CAST (SUBSTRING (@vb10, 4, 5) AS BIGINT)

          SET @date -= 584388 -- shift from (SQL) Jan 1, 0001 to (S3) Jan 1, 1601
          SET @time /= 156250 -- 10000000 / 64

       RETURN @date * 86400 * 64 + @time
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Map : call_Error.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_Error
(
   @dwError                      INT,
   @sError                       NVARCHAR (255),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

        INSERT #Error
             (  dwError,  sError )
        SELECT @dwError, @sError

           SET @nError += 1

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : call_Event_Push.sql                                             **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

/*
** Procedures call this function to push events onto the queue.
*/

CREATE PROCEDURE dbo.call_Event_Push
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @bError INT

        INSERT dbo.RMEvent
             ( sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change )
        SELECT sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change
          FROM #Event
      ORDER BY nOrder ASC

           SET @bError = IIF (@@ERROR = 0, 0, 1)

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Map : etl_Events.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

/*
** The NodeJS server calls this function periodically to retrieve events from the queue.
*/

CREATE PROCEDURE dbo.etl_Events
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @t TABLE
                  (
                     twEventIx      BIGINT
                  )

         BEGIN TRANSACTION

        INSERT @t
             ( twEventIx )
        SELECT TOP 100
               twEventIx
          FROM dbo.RMEvent
      ORDER BY twEventIx ASC

        SELECT CONCAT
               (
                 '{ ',
                   '"sType": ',     '"', e.sType, '"',
                 ', "pControl": ',  dbo.Format_Control (e.Self_wClass, e.Self_twObjectIx, e.Child_wClass, e.Child_twObjectIx, e.wFlags, e.twEventIz),
                 ', "pObject": ',   e.sJSON_Object,
                 ', "pChild": ',    e.sJSON_Child,
                 ', "pChange": ',   e.sJSON_Change,
                ' }'
               )
               AS [Object]
          FROM dbo.RMEvent AS e
          JOIN @t          AS t ON t.twEventIx = e.twEventIx
      ORDER BY e.twEventIx
       
        DELETE e
          FROM dbo.RMEvent AS e
          JOIN @t          AS t ON t.twEventIx = e.twEventIx

        SELECT COUNT (*) AS nCount
          FROM dbo.RMEvent
       
        COMMIT TRANSACTION

        RETURN 0
  END
GO

GRANT EXECUTE ON dbo.etl_Events TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMPObject_Event.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event
(
   @twRMPObjectIx                BIGINT,
   @twEventIz                    BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @bError INT

        SELECT @twEventIz = ObjectHead_twEventIz
          FROM dbo.RMPObject
         WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

            -- Success will be tested on the update below

        UPDATE dbo.RMPObject
           SET ObjectHead_twEventIz += 1
         WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : call_RMPObject_Event_Bound.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event_Bound
(
   @twRMPObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMPObject_Event @twRMPObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMPObject
                  SET Bound_dX = @Bound_dX,
                      Bound_dY = @Bound_dY,
                      Bound_dZ = @Bound_dZ
                WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'BOUND',

                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pBound": ',        dbo.Format_Bound
                                                      (
                                                         @Bound_dX,
                                                         @Bound_dY,
                                                         @Bound_dZ
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMPObject_Event_Name.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event_Name
(
   @twRMPObjectIx                BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMPObject_Event @twRMPObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMPObject
                  SET Name_wsRMPObjectId = @Name_wsRMPObjectId
                WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'NAME',

                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_P
                                                      (
                                                         @Name_wsRMPObjectId
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : call_RMPObject_Event_Owner.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event_Owner
(
   @twRMPObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMPObject_Event @twRMPObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMPObject
                  SET Owner_twRPersonaIx = @Owner_twRPersonaIx
                WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'OWNER',

                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMPObject_Event_Resource.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event_Resource
(
   @twRMPObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMPObject_Event @twRMPObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMPObject
                  SET Resource_qwResource = @Resource_qwResource,
                      Resource_sName      = @Resource_sName,
                      Resource_sReference = @Resource_sReference       
                WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RESOURCE',

                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pResource": ',     dbo.Format_Resource
                                                      (
                                                         @Resource_qwResource,
                                                         @Resource_sName,
                                                         @Resource_sReference
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                   MVD_RP1_Map : call_RMPObject_Event_RMPObject_Close.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event_RMPObject_Close
(
   @twRMPObjectIx                BIGINT,
   @twRMPObjectIx_Close          BIGINT,
   @bReparent                    TINYINT
)
AS
BEGIN
           SET NOCOUNT ON


       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE INT = 0x02

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMPObject_Event @twRMPObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
                   IF @bReparent = 0
                BEGIN
                        DELETE dbo.RMPObject                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                         WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx_Close
         
                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMPOBJECT_CLOSE',

                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx,
                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx_Close,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE,
                             @twEventIz,

                             '{ }',

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                    MVD_RP1_Map : call_RMPObject_Event_RMPObject_Open.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event_RMPObject_Open
(
   @twRMPObjectIx                BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @twRMPObjectIx_Open           BIGINT OUTPUT,
   @bReparent                    TINYINT
)
AS
BEGIN
           SET NOCOUNT ON


       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN  INT = 0x01

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMPObject_Event @twRMPObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
                   IF @bReparent = 0
                BEGIN
                        INSERT dbo.RMPObject
                               ( ObjectHead_Parent_wClass,  ObjectHead_Parent_twObjectIx,  ObjectHead_Self_wClass,  ObjectHead_twEventIz,  ObjectHead_wFlags,  Name_wsRMPObjectId,  Type_bType,  Type_bSubtype,  Type_bFiction,  Type_bMovable,  Owner_twRPersonaIx,  Resource_qwResource,  Resource_sName,  Resource_sReference,  Transform_Position_dX,  Transform_Position_dY,  Transform_Position_dZ,  Transform_Rotation_dX,  Transform_Rotation_dY,  Transform_Rotation_dZ,  Transform_Rotation_dW,  Transform_Scale_dX,  Transform_Scale_dY,  Transform_Scale_dZ,  Bound_dX,  Bound_dY,  Bound_dZ)
                        VALUES (@SBO_CLASS_RMPOBJECT,      @twRMPObjectIx,                @SBO_CLASS_RMPOBJECT,     0,                     32,                @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ)

                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                           SET @twRMPObjectIx_Open = SCOPE_IDENTITY ()
                  END

                   IF @bError = 0
                BEGIN
                        INSERT #Event
                               (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                        SELECT 'RMPOBJECT_OPEN',

                               @SBO_CLASS_RMPOBJECT,
                               @twRMPObjectIx,
                               @SBO_CLASS_RMPOBJECT,
                               @twRMPObjectIx_Open,
                               @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN,
                               @twEventIz,

                               '{ }',

                               CONCAT
                               (
                                 '{ ',
                                   '"pName": ',         dbo.Format_Name_P
                                                        (
                                                           @Name_wsRMPObjectId
                                                        ),
                                 ', "pType": ',         dbo.Format_Type_P
                                                        (
                                                           @Type_bType,
                                                           @Type_bSubtype,
                                                           @Type_bFiction,
                                                           @Type_bMovable
                                                        ),
                                 ', "pOwner": ',        dbo.Format_Owner
                                                        (
                                                           @Owner_twRPersonaIx
                                                        ),
                                 ', "pResource": ',     dbo.Format_Resource
                                                        (
                                                           @Resource_qwResource,
                                                           @Resource_sName,
                                                           @Resource_sReference
                                                        ),
                                 ', "pTransform": ',    dbo.Format_Transform
                                                        (
                                                           @Transform_Position_dX,
                                                           @Transform_Position_dY,
                                                           @Transform_Position_dZ,
                                                           @Transform_Rotation_dX,
                                                           @Transform_Rotation_dY,
                                                           @Transform_Rotation_dZ,
                                                           @Transform_Rotation_dW,
                                                           @Transform_Scale_dX,
                                                           @Transform_Scale_dY,
                                                           @Transform_Scale_dZ
                                                        ),
                                 ', "pBound": ',        dbo.Format_Bound
                                                        (
                                                           @Bound_dX,
                                                           @Bound_dY,
                                                           @Bound_dZ
                                                        ),
                                ' }'
                               ),

                               '{ }'

                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : call_RMPObject_Event_Transform.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event_Transform
(
   @twRMPObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMPObject_Event @twRMPObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMPObject
                  SET Transform_Position_dX = @Transform_Position_dX,
                      Transform_Position_dY = @Transform_Position_dY,
                      Transform_Position_dZ = @Transform_Position_dZ,
                      Transform_Rotation_dX = @Transform_Rotation_dX,
                      Transform_Rotation_dY = @Transform_Rotation_dY,
                      Transform_Rotation_dZ = @Transform_Rotation_dZ,
                      Transform_Rotation_dW = @Transform_Rotation_dW,
                      Transform_Scale_dX    = @Transform_Scale_dX,
                      Transform_Scale_dY    = @Transform_Scale_dY,
                      Transform_Scale_dZ    = @Transform_Scale_dZ
                WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'TRANSFORM',

                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pTransform": ',    dbo.Format_Transform
                                                      (
                                                         @Transform_Position_dX,
                                                         @Transform_Position_dY,
                                                         @Transform_Position_dZ,
                                                         @Transform_Rotation_dX,
                                                         @Transform_Rotation_dY,
                                                         @Transform_Rotation_dZ,
                                                         @Transform_Rotation_dW,
                                                         @Transform_Scale_dX,
                                                         @Transform_Scale_dY,
                                                         @Transform_Scale_dZ
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMPObject_Event_Type.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Event_Type
(
   @twRMPObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMPObject_Event @twRMPObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMPObject
                  SET Type_bType    = @Type_bType,
                      Type_bSubtype = @Type_bSubtype,
                      Type_bFiction = @Type_bFiction,
                      Type_bMovable = @Type_bMovable
                WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'TYPE',

                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pType": ',         dbo.Format_Type_P
                                                      (
                                                         @Type_bType,
                                                         @Type_bSubtype,
                                                         @Type_bFiction,
                                                         @Type_bMovable
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMPObject_Log.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Log
   @bOp                          TINYINT,
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT
AS
BEGIN
          SET NOCOUNT ON

      DECLARE @bError INT

      DECLARE @dwIPAddress BINARY (4) = dbo.IPstob (@sIPAddress)

       INSERT dbo.RMPObjectLog
              ( bOp,  dwIPAddress,  twRPersonaIx,  twRMPObjectIx)
       VALUES (@bOp, @dwIPAddress, @twRPersonaIx, @twRMPObjectIx)

          SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

       RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMPObject_Select.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Select
(
   @nResultSet                   INT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @OBJECTHEAD_FLAG_SUBSCRIBE_PARTIAL         INT = 0x10
       DECLARE @OBJECTHEAD_FLAG_SUBSCRIBE_FULL            INT = 0x20

       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

        SELECT CONCAT
               (
                 '{ ',
                    '"pObjectHead": ',   dbo.Format_ObjectHead
                                         (
                                            p.ObjectHead_Parent_wClass,
                                            p.ObjectHead_Parent_twObjectIx,
                                            p.ObjectHead_Self_wClass,
                                            p.ObjectHead_Self_twObjectIx,
                                            IIF (@nResultSet = 0, @OBJECTHEAD_FLAG_SUBSCRIBE_FULL, @OBJECTHEAD_FLAG_SUBSCRIBE_PARTIAL),
                                            p.ObjectHead_twEventIz
                                         ),

                  ', "twRMPObjectIx": ', p.ObjectHead_Self_twObjectIx,      -- is this necessary

                  ', "pName": ',         dbo.Format_Name_P
                                         (
                                            p.Name_wsRMPObjectId
                                         ),
                  ', "pType": ',         dbo.Format_Type_P
                                         (
                                            p.Type_bType,
                                            p.Type_bSubtype,
                                            p.Type_bFiction,
                                            p.Type_bMovable
                                         ),
                  ', "pOwner": ',        dbo.Format_Owner
                                         (
                                            p.Owner_twRPersonaIx
                                         ),
                  ', "pResource": ',     dbo.Format_Resource
                                         (
                                            p.Resource_qwResource,
                                            p.Resource_sName,
                                            p.Resource_sReference
                                         ),
                  ', "pTransform": ',    dbo.Format_Transform
                                         (
                                            p.Transform_Position_dX,
                                            p.Transform_Position_dY,
                                            p.Transform_Position_dZ,
                                            p.Transform_Rotation_dX,
                                            p.Transform_Rotation_dY,
                                            p.Transform_Rotation_dZ,
                                            p.Transform_Rotation_dW,
                                            p.Transform_Scale_dX,
                                            p.Transform_Scale_dY,
                                            p.Transform_Scale_dZ
                                         ),
                  ', "pBound": ',        dbo.Format_Bound
                                         (
                                            p.Bound_dX,
                                            p.Bound_dY,
                                            p.Bound_dZ
                                         ),

                  ', "nChildren":  ',    cap.nCount,
                 ' }'               
               ) AS [Object]
          FROM #Results      AS x
          JOIN dbo.RMPObject AS p on p.ObjectHead_Self_twObjectIx = x.ObjectHead_Self_twObjectIx
         CROSS APPLY (SELECT COUNT (*) AS nCount FROM dbo.RMPObject WHERE ObjectHead_Parent_twObjectIx = p.ObjectHead_Self_twObjectIx AND ObjectHead_Parent_wClass = @SBO_CLASS_RMPOBJECT) AS cap
         WHERE nResultSet = @nResultSet
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : call_RMPObject_Validate.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Validate
(
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @ObjectHead_Parent_wClass     SMALLINT        OUTPUT,
   @ObjectHead_Parent_twObjectIx BIGINT          OUTPUT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nCount INT

        SELECT @ObjectHead_Parent_wClass     = ObjectHead_Parent_wClass,
               @ObjectHead_Parent_twObjectIx = ObjectHead_Parent_twObjectIx
          FROM dbo.RMPObject
         WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

           SET @nCount = @@ROWCOUNT

            IF @twRPersonaIx <= 0
               EXEC dbo.call_Error 1,  'twRPersonaIx is invalid',  @nError OUTPUT
       ELSE IF @twRMPObjectIx <= 0
               EXEC dbo.call_Error 2,  'twRMPObjectIx is invalid', @nError OUTPUT
       ELSE IF @nCount <> 1
               EXEC dbo.call_Error 3,  'twRMPObjectIx is unknown', @nError OUTPUT
       ELSE IF @twRPersonaIx <> @twRPersonaIx                                             -- TBD
               EXEC dbo.call_Error 4,  'Invalid rights',           @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMPObject_Validate_Bound.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Validate_Bound
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMPObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

            IF @Bound_dX IS NULL OR @Bound_dX <> @Bound_dX
               EXEC dbo.call_Error 21, 'Bound_dX is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dX < 0
               EXEC dbo.call_Error 21, 'Bound_dX is invalid',     @nError OUTPUT

            IF @Bound_dY IS NULL OR @Bound_dY <> @Bound_dY
               EXEC dbo.call_Error 21, 'Bound_dY is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dY < 0
               EXEC dbo.call_Error 21, 'Bound_dY is invalid',     @nError OUTPUT

            IF @Bound_dZ IS NULL OR @Bound_dZ <> @Bound_dZ
               EXEC dbo.call_Error 21, 'Bound_dZ is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dZ < 0
               EXEC dbo.call_Error 21, 'Bound_dZ is invalid',     @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate bound is inside  parent's   bound
               -- validate bound is outside children's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMPObject_Validate_Name.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Validate_Name
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMPObjectIx                BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Name_wsRMPObjectId IS NULL
               EXEC dbo.call_Error 21, 'Name_wsRMPObjectId is NULL',    @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMPObject_Validate_Owner.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Validate_Owner
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMPObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Owner_twRPersonaIx IS NULL
               EXEC dbo.call_Error 21, 'Owner_twRPersonaIx is NULL',    @nError OUTPUT
       ELSE IF @Owner_twRPersonaIx NOT BETWEEN 1 AND 0x0000FFFFFFFFFFFC
               EXEC dbo.call_Error 21, 'Owner_twRPersonaIx is invalid', @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMPObject_Validate_Resource.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Validate_Resource
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMPObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Resource_qwResource IS NULL
               EXEC dbo.call_Error 21, 'Resource_qwResource is NULL', @nError OUTPUT
            IF @Resource_sName IS NULL
               EXEC dbo.call_Error 21, 'Resource_sName is NULL',      @nError OUTPUT
            IF @Resource_sReference IS NULL
               EXEC dbo.call_Error 21, 'Resource_sReference is NULL', @nError OUTPUT

            -- do we want to check sName and sReference for length or invalid characters

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMPObject_Validate_Transform.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Validate_Transform
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMPObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

            IF @Transform_Position_dX IS NULL OR @Transform_Position_dX <> @Transform_Position_dX
               EXEC dbo.call_Error 21, 'Transform_Position_dX is NULL or NaN', @nError OUTPUT
            IF @Transform_Position_dY IS NULL OR @Transform_Position_dY <> @Transform_Position_dY
               EXEC dbo.call_Error 21, 'Transform_Position_dY is NULL or NaN', @nError OUTPUT
            IF @Transform_Position_dZ IS NULL OR @Transform_Position_dZ <> @Transform_Position_dZ
               EXEC dbo.call_Error 21, 'Transform_Position_dZ is NULL or NaN', @nError OUTPUT

            IF @Transform_Rotation_dX IS NULL OR @Transform_Rotation_dX <> @Transform_Rotation_dX
               EXEC dbo.call_Error 21, 'Transform_Rotation_dX is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dY IS NULL OR @Transform_Rotation_dY <> @Transform_Rotation_dY
               EXEC dbo.call_Error 21, 'Transform_Rotation_dY is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dZ IS NULL OR @Transform_Rotation_dZ <> @Transform_Rotation_dZ
               EXEC dbo.call_Error 21, 'Transform_Rotation_dZ is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dW IS NULL OR @Transform_Rotation_dW <> @Transform_Rotation_dW
               EXEC dbo.call_Error 21, 'Transform_Rotation_dW is NULL or NaN', @nError OUTPUT

            IF @Transform_Scale_dX    IS NULL OR @Transform_Scale_dX    <> @Transform_Scale_dX
               EXEC dbo.call_Error 21, 'Transform_Scale_dX    is NULL or NaN', @nError OUTPUT
            IF @Transform_Scale_dY    IS NULL OR @Transform_Scale_dY    <> @Transform_Scale_dY
               EXEC dbo.call_Error 21, 'Transform_Scale_dY    is NULL or NaN', @nError OUTPUT
            IF @Transform_Scale_dZ    IS NULL OR @Transform_Scale_dZ    <> @Transform_Scale_dZ
               EXEC dbo.call_Error 21, 'Transform_Scale_dZ    is NULL or NaN', @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate position is inside parent's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMPObject_Validate_Type.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMPObject_Validate_Type
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMPObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @MVO_RMTOBJECT_TYPE_PARCEL                 INT = 11

       DECLARE @Parent_bType    TINYINT,
               @Parent_bSubtype TINYINT,
               @Self_bType      TINYINT,
               @Self_bSubtype   TINYINT

            IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT
         BEGIN
                 SELECT @Parent_bType    = Type_bType
                   FROM dbo.RMTObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @ObjectHead_Parent_twObjectIx
           END
       ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMPOBJECT
         BEGIN
                 SELECT @Parent_bType    = Type_bType,
                        @Parent_bSubtype = Type_bSubtype
                   FROM dbo.RMPObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @ObjectHead_Parent_twObjectIx
           END

            IF @twRMPObjectIx > 0
         BEGIN
                 SELECT @Self_bType    = Type_bType,
                        @Self_bSubtype = Type_bSubtype
                   FROM dbo.RMPObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx
-- get max children's type and subtype

           END

-- attachment points can't have cildren

            IF @Type_bType IS NULL
               EXEC dbo.call_Error 21, 'Type_bType is NULL',       @nError OUTPUT

            IF @Type_bSubtype IS NULL
               EXEC dbo.call_Error 21, 'Type_bSubtype is NULL',    @nError OUTPUT

            IF @Type_bFiction IS NULL
               EXEC dbo.call_Error 21, 'Type_bFiction is NULL',    @nError OUTPUT
       ELSE IF @Type_bFiction NOT BETWEEN 0 AND 1
               EXEC dbo.call_Error 21, 'Type_bFiction is invalid', @nError OUTPUT

            IF @Type_bMovable IS NULL
               EXEC dbo.call_Error 21, 'Type_bMovable is NULL', @nError OUTPUT
       ELSE IF @Type_bMovable NOT BETWEEN 0 AND 1
               EXEC dbo.call_Error 21, 'Type_bMovable is invalid', @nError OUTPUT

            IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT  AND  @Parent_bType <> @MVO_RMTOBJECT_TYPE_PARCEL
               EXEC dbo.call_Error 21, 'Parent''s Type_bType must be equal to PARCEL when its parent''s class is RMTOBJECT', @nError OUTPUT
/*
       ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMPOBJECT  AND  @Type_bType < @Parent_bType
               EXEC dbo.call_Error 21, 'Type_bType must be greater than or equal to its parent''s Type_bType', @nError OUTPUT
       ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMPOBJECT  AND  @Type_bType = @Parent_bType  AND  @Type_bSubtype <= @Parent_bSubtype
               EXEC dbo.call_Error 21, 'Type_bSubtype must be greater than its parent''s Type_bType', @nError OUTPUT
*/

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : get_RMPObject.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.get_RMPObject
(
   @sIPAddress                   NVARCHAR (16),
   @twRMPObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @bError  INT = 0,
               @bCommit INT = 0,
               @nError  INT

            -- Create the temp Results table
        SELECT * INTO #Results FROM dbo.Table_Results ()

         BEGIN TRANSACTION

--        EXEC @nError = dbo.call_
           SET @nError = 0
            IF @nError = 0
         BEGIN
                  -- validate input

               DECLARE @bType TINYINT

               SELECT @bType = Type_bType
                 FROM dbo.RMPObject
                WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                   IF @bType IS NULL
                      SET @bError = 1

                  IF (@bError = 0)
               BEGIN
                     INSERT #Results
                     SELECT 0,
                            ObjectHead_Self_twObjectIx
                       FROM dbo.RMPObject
                      WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                     INSERT #Results
                     SELECT 1,
                            ObjectHead_Self_twObjectIx
                       FROM dbo.RMPObject
                      WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMPOBJECT
                        AND ObjectHead_Parent_twObjectIx = @twRMPObjectIx

                      EXEC dbo.call_RMPObject_Select 0
                      EXEC dbo.call_RMPObject_Select 1

                       SET @bCommit = 1
                 END
           END

            IF (@bCommit = 0)
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - @bError - 1
  END
GO

GRANT EXECUTE ON dbo.get_RMPObject TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : get_RMPObject_Update.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.get_RMPObject_Update
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0

            -- Create the temp Results table
        SELECT * INTO #Results FROM dbo.Table_Results ()

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

            IF @twRPersonaIx < 0
               EXEC dbo.call_Error 1,  'Session is invalid', @nError OUTPUT

            IF @twRMPObjectIx <= 0
               EXEC dbo.call_Error 2,  'PObject is invalid', @nError OUTPUT

            IF @nError = 0
         BEGIN
                 INSERT #Results
                 SELECT 0,
                        p.ObjectHead_Self_twObjectIx
                   FROM dbo.RMPObject AS p
                  WHERE p.ObjectHead_Self_twObjectIx = @twRMPObjectIx

                     IF @@ROWCOUNT = 1
                  BEGIN
                          INSERT #Results
                          SELECT 1,
                                 x.ObjectHead_Self_twObjectIx
                            FROM dbo.RMPObject AS p
                            JOIN dbo.RMPObject AS x ON x.ObjectHead_Parent_wClass     = p.ObjectHead_Self_wClass
                                                   AND x.ObjectHead_Parent_twObjectIx = p.ObjectHead_Self_twObjectIx
                           WHERE p.ObjectHead_Self_twObjectIx = @twRMPObjectIx
                        ORDER BY x.ObjectHead_Self_twObjectIx ASC
             
                            EXEC dbo.call_RMPObject_Select 0
                            EXEC dbo.call_RMPObject_Select 1
             
                             SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error 3,  'PObject does not exist', @nError OUTPUT
           END

            IF @bCommit = 0
               SELECT dwError, sError FROM #Error

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.get_RMPObject_Update TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMPObject_Bound.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMPObject_Bound
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

       DECLARE @RMPOBJECT_OP_BOUND                        INT = 8

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Bound @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMPObject_Event_Bound @twRMPObjectIx, @Bound_dX, @Bound_dY, @Bound_dZ
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_BOUND, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_Bound TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMPObject_Name.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMPObject_Name
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

       DECLARE @RMPOBJECT_OP_NAME                         INT = 1

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Name @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, @Name_wsRMPObjectId, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMPObject_Event_Name @twRMPObjectIx, @Name_wsRMPObjectId
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_NAME, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_Name TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMPObject_Owner.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMPObject_Owner
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

       DECLARE @RMPOBJECT_OP_OWNER                        INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Owner @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, @Owner_twRPersonaIx, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMPObject_Event_Owner @twRMPObjectIx, @Owner_twRPersonaIx
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_OWNER, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_Owner TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : set_RMPObject_Parent.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

-- Note that this is not a function of the RMPObject itself, but rather a function of the two parents involved.

CREATE PROCEDURE dbo.set_RMPObject_Parent
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @wClass                       SMALLINT,
   @twObjectIx                   BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @RMPOBJECT_OP_PARENT                       INT = 18

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT,
               @nCount                       INT

       DECLARE @Name_wsRMPObjectId           NVARCHAR (48),
               @Type_bType                   TINYINT,
               @Type_bSubtype                TINYINT,
               @Type_bFiction                TINYINT,
               @Type_bMovable                TINYINT,
               @Owner_twRPersonaIx           BIGINT,
               @Resource_qwResource          BIGINT,
               @Resource_sName               NVARCHAR (48),
               @Resource_sReference          NVARCHAR (128),
               @Transform_Position_dX        FLOAT (53),
               @Transform_Position_dY        FLOAT (53),
               @Transform_Position_dZ        FLOAT (53),
               @Transform_Rotation_dX        FLOAT (53),
               @Transform_Rotation_dY        FLOAT (53),
               @Transform_Rotation_dZ        FLOAT (53),
               @Transform_Rotation_dW        FLOAT (53),
               @Transform_Scale_dX           FLOAT (53),
               @Transform_Scale_dY           FLOAT (53),
               @Transform_Scale_dZ           FLOAT (53),
               @Bound_dX                     FLOAT (53),
               @Bound_dY                     FLOAT (53),
               @Bound_dZ                     FLOAT (53)

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                     IF @wClass = @ObjectHead_Parent_wClass  AND  @twObjectIx = @ObjectHead_Parent_twObjectIx
                        EXEC dbo.call_Error 99, 'The new parent is the same as the current parent', @nError OUTPUT
                ELSE IF @wClass = @SBO_CLASS_RMROOT
                  BEGIN
                              IF NOT EXISTS (SELECT 1 FROM dbo.RMRoot    WHERE ObjectHead_Self_twObjectIx = @twObjectIx)
                                 EXEC dbo.call_Error 99, 'twObjectIx is invalid', @nError OUTPUT
                    END
                ELSE IF @wClass = @SBO_CLASS_RMTOBJECT
                  BEGIN
                              IF NOT EXISTS (SELECT 1 FROM dbo.RMTObject WHERE ObjectHead_Self_twObjectIx = @twObjectIx)
                                 EXEC dbo.call_Error 99, 'twObjectIx is invalid', @nError OUTPUT
                    END
                ELSE IF @wClass = @SBO_CLASS_RMPOBJECT
                  BEGIN
                              IF NOT EXISTS (SELECT 1 FROM dbo.RMPObject WHERE ObjectHead_Self_twObjectIx = @twObjectIx)
                                 EXEC dbo.call_Error 99, 'twObjectIx is invalid', @nError OUTPUT
                    END
                   ELSE EXEC dbo.call_Error 99, 'wClass is invalid', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                 SELECT @Name_wsRMPObjectId    = Name_wsRMPObjectId,
                        @Type_bType            = Type_bType,
                        @Type_bSubtype         = Type_bSubtype,
                        @Type_bFiction         = Type_bFiction,
                        @Type_bMovable         = Type_bMovable,
                        @Owner_twRPersonaIx    = Owner_twRPersonaIx,
                        @Resource_qwResource   = Resource_qwResource,
                        @Resource_sName        = Resource_sName,
                        @Resource_sReference   = Resource_sReference,
                        @Transform_Position_dX = Transform_Position_dX,
                        @Transform_Position_dY = Transform_Position_dY,
                        @Transform_Position_dZ = Transform_Position_dZ,
                        @Transform_Rotation_dX = Transform_Rotation_dX,
                        @Transform_Rotation_dY = Transform_Rotation_dY,
                        @Transform_Rotation_dZ = Transform_Rotation_dZ,
                        @Transform_Rotation_dW = Transform_Rotation_dW,
                        @Transform_Scale_dX    = Transform_Scale_dX,
                        @Transform_Scale_dY    = Transform_Scale_dY,
                        @Transform_Scale_dZ    = Transform_Scale_dZ,
                        @Bound_dX              = Bound_dX,
                        @Bound_dY              = Bound_dY,
                        @Bound_dZ              = Bound_dZ
                   FROM dbo.RMPObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                   EXEC dbo.call_RMPObject_Validate_Type @wClass, @twObjectIx, @twRMPObjectIx, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN

                     IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMROOT
                        EXEC @bError = dbo.call_RMRoot_Event_RMPObject_Close    @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, 1
                ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT
                        EXEC @bError = dbo.call_RMTObject_Event_RMPObject_Close @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, 1
                ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMPOBJECT
                        EXEC @bError = dbo.call_RMPObject_Event_RMPObject_Close @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, 1
                   ELSE EXEC dbo.call_Error 99, 'Internal error', @nError OUTPUT

                     IF @bError = 0
                  BEGIN
                          UPDATE dbo.RMPObject
                             SET ObjectHead_Parent_wClass     = @wClass,
                                 ObjectHead_Parent_twObjectIx = @twObjectIx
                           WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx

                             SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                              IF @bError = 0
                           BEGIN
                                       IF @wClass = @SBO_CLASS_RMROOT
                                          EXEC @bError = dbo.call_RMRoot_Event_RMPObject_Open    @twObjectIx, @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @twRMPObjectIx OUTPUT, 1
                                  ELSE IF @wClass = @SBO_CLASS_RMTOBJECT
                                          EXEC @bError = dbo.call_RMTObject_Event_RMPObject_Open @twObjectIx, @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @twRMPObjectIx OUTPUT, 1
                                  ELSE IF @wClass = @SBO_CLASS_RMPOBJECT
                                          EXEC @bError = dbo.call_RMPObject_Event_RMPObject_Open @twObjectIx, @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @twRMPObjectIx OUTPUT, 1
                                     ELSE EXEC dbo.call_Error 99, 'Internal error', @nError OUTPUT
                  
                                       IF @bError = 0
                                    BEGIN
                                          SET @bCommit = 1
                                      END
                                     ELSE EXEC dbo.call_Error -3, 'Failed to update new parent'
                             END
                            ELSE EXEC dbo.call_Error -2, 'Failed to update RMPObject'
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete from old parent'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_PARENT, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_Parent TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : set_RMPObject_Resource.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMPObject_Resource
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

       DECLARE @RMPOBJECT_OP_RESOURCE                     INT = 4

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Resource @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMPObject_Event_Resource @twRMPObjectIx, @Resource_qwResource, @Resource_sName, @Resource_sReference
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_RESOURCE, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_Resource TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMPObject_RMPObject_Close.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMPObject_RMPObject_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @twRMPObjectIx_Close          BIGINT,
   @bDeleteAll                   TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx        = ISNULL (@twRPersonaIx,        0)
           SET @twRMPObjectIx       = ISNULL (@twRMPObjectIx,       0)
           SET @twRMPObjectIx_Close = ISNULL (@twRMPObjectIx_Close, 0)

       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @RMPOBJECT_OP_RMPOBJECT_CLOSE              INT = 17

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMPObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMPOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMPObjectIx_Close

                     IF @twRMPObjectIx_Close <= 0
                        EXEC dbo.call_Error 5,  'twRMPObjectIx_Close is invalid', @nError OUTPUT

                     IF @bDeleteAll = 0  AND  @nCount > 0
                        EXEC dbo.call_Error 6,  'twRMPObjectIx is not empty',     @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMPObject_Event_RMPObject_Close @twRMPObjectIx, @twRMPObjectIx_Close, 0
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_RMPOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_RMPObject_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMPObject_RMPObject_Open.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMPObject_RMPObject_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @RMPOBJECT_OP_RMPOBJECT_OPEN               INT = 16

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMPObjectIx_Open           BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Name      @SBO_CLASS_RMPOBJECT, @twRMPObjectIx, 0, @Name_wsRMPObjectId, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Type      @SBO_CLASS_RMPOBJECT, @twRMPObjectIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Owner     @SBO_CLASS_RMPOBJECT, @twRMPObjectIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Resource  @SBO_CLASS_RMPOBJECT, @twRMPObjectIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Transform @SBO_CLASS_RMPOBJECT, @twRMPObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Bound     @SBO_CLASS_RMPOBJECT, @twRMPObjectIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMPObject_Event_RMPObject_Open @twRMPObjectIx, @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @twRMPObjectIx_Open OUTPUT, 0
                     IF @bError = 0
                  BEGIN
                        SELECT @twRMPObjectIx_Open AS twRMPObjectIx
   
                           SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_RMPOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_RMPObject_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : set_RMPObject_Transform.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMPObject_Transform
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

       DECLARE @RMPOBJECT_OP_TRANSFORM                    INT = 5

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Transform @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMPObject_Event_Transform @twRMPObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_TRANSFORM, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_Transform TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMPObject_Type.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMPObject_Type
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMPObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMPObjectIx = ISNULL (@twRMPObjectIx, 0)

       DECLARE @RMPOBJECT_OP_TYPE                         INT = 2

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMPObject_Validate @twRPersonaIx, @twRMPObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Type @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMPObjectIx, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMPObject_Event_Type @twRMPObjectIx, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMPObject_Log @RMPOBJECT_OP_TYPE, @sIPAddress, @twRPersonaIx, @twRMPObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMPObject_Type TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMTMatrix_Car.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Car
(
   @twRMTObjectIx                BIGINT,
   @dX                           FLOAT (53),
   @dY                           FLOAT (53),
   @dZ                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @RMTMATRIX_COORD_CAR                       INT = 1

       DECLARE @nResult INT = 0

        INSERT dbo.RMTSubsurface
               (  twRMTObjectIx, tnGeometry,            dA,  dB,  dC )
        VALUES ( @twRMTObjectIx, @RMTMATRIX_COORD_CAR, @dX, @dY, @dZ )

        INSERT dbo.RMTMatrix
               (  bnMatrix,

                  d00, d01, d02, d03,
                  d10, d11, d12, d13,
                  d20, d21, d22, d23,
                  d30, d31, d32, d33
               )
        VALUES ( @twRMTObjectIx,

                  1 ,  0 ,  0 ,  @dX ,
                  0 ,  1 ,  0 ,  @dY ,
                  0 ,  0 ,  1 ,  @dZ ,
                  0 ,  0 ,  0 ,  1
               )

        INSERT dbo.RMTMatrix
               ( bnMatrix           )
        VALUES ( 0 - @twRMTObjectIx )

          EXEC @nResult = dbo.call_RMTMatrix_Inverse @twRMTObjectIx

        RETURN @nResult
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMTMatrix_Cyl.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Cyl
(
   @twRMTObjectIx                BIGINT,
   @dTheta                       FLOAT (53),
   @dY                           FLOAT (53),
   @dRadius                      FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @RMTMATRIX_COORD_CYL                       INT = 2

       DECLARE @nResult INT = 0

            -- right handed (counter-clockwise rotation), Y up, negative Z forward
            -- theta == 0 degrees aligns with the +z axis
         
            -- this is a special case of the geographic coordiate system with latitude = 0

       DECLARE @dThe    FLOAT (53) = RADIANS (@dTheta),
            -- @dY      FLOAT (53) =          @dY,
               @dRad    FLOAT (53) =          @dRadius,
               @dOI     FLOAT (53) = 1

       DECLARE @dCThe FLOAT (53) = COS (@dThe),
               @dSThe FLOAT (53) = SIN (@dThe)

            IF @dRad < 0
         BEGIN
               SET @dRad *= -1
               SET @dOI  *= -1
           END

            -- MXform_Identity     (MXform);
            -- MXform_Translate    (MXform, dRad * dCLat * dSThe, dRad * dSLat, dRad * dCLat * dCThe);
            -- MXform_Rotate_Y     (MXform, dThe);                                                              -- +z axis aligns with theta
            -- MXform_Rotate_X     (MXform, 90);                                                                -- +y axis aligns with latitude = 0
            -- MXform_Rotate_Z     (MXform, 90 +/- 90);                                                         -- +y axis aligns with latitude = 0 (direction depends on dOI)
         
            -- Matrix multiplication progresses left to right
         
            -- [ 1   0   0   0 ]     [ 1   0   0   X ]     [  dCThe   0   dSThe   0 ]     [ 1   0    0   0 ]     [ dOI   0     0   0 ]
            -- [ 0   1   0   0 ]  X  [ 0   1   0   Y ]  X  [  0       1   0       0 ]  X  [ 0   0   -1   0 ]  X  [ 0     dOI   0   0 ]
            -- [ 0   0   1   0 ]     [ 0   0   1   Z ]     [ -dSThe   0   dCThe   0 ]     [ 0   1    0   0 ]     [ 0     0     1   0 ]
            -- [ 0   0   0   1 ]     [ 0   0   0   1 ]     [  0       0   0       1 ]     [ 0   0    0   1 ]     [ 0     0     0   1 ]

        INSERT dbo.RMTSubsurface
               (  twRMTObjectIx, tnGeometry,            dA,      dB,  dC      )
        VALUES ( @twRMTObjectIx, @RMTMATRIX_COORD_CYL, @dTheta, @dY, @dRadius )

        INSERT dbo.RMTMatrix
               ( bnMatrix,

                 d00,                 d01,                d02,     d03,
                 d10,                 d11,                d12,     d13,
                 d20,                 d21,                d22,     d23,
                 d30,                 d31,                d32,     d33
               )
        VALUES ( @twRMTObjectIx,

                 @dOI *  @dCThe ,     @dOI * @dSThe ,      0 ,     @dRad * @dSThe ,
                         0      ,            0      ,     -1 ,     @dY            ,
                 @dOI * -@dSThe ,     @dOI * @dCThe ,      0 ,     @dRad * @dCThe ,
                         0      ,            0      ,      0 ,     1             
               )

        INSERT dbo.RMTMatrix
               ( bnMatrix           )
        VALUES ( 0 - @twRMTObjectIx )

          EXEC @nResult = dbo.call_RMTMatrix_Inverse @twRMTObjectIx

        RETURN @nResult
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMTMatrix_Geo.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Geo
(
   @twRMTObjectIx                BIGINT,
   @dLatitude                    FLOAT (53),
   @dLongitude                   FLOAT (53),
   @dRadius                      FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @RMTMATRIX_COORD_GEO                       INT = 3

       DECLARE @nResult INT = 0

            -- right handed (counter-clockwise rotation), Y up, negative Z forward
            -- longitude == 0 degrees (the prime meridian) aligns with the +z axis

       DECLARE @dLatX   FLOAT (53) = RADIANS (90.0 - @dLatitude ),
               @dLat    FLOAT (53) = RADIANS (       @dLatitude ),
               @dLon    FLOAT (53) = RADIANS (       @dLongitude),
               @dRad    FLOAT (53) =                 @dRadius,
               @dOI     FLOAT (53) = 1

       DECLARE @dCLatX  FLOAT (53) = COS (@dLatX),
               @dSLatX  FLOAT (53) = SIN (@dLatX),
               @dCLat   FLOAT (53) = COS (@dLat),
               @dSLat   FLOAT (53) = SIN (@dLat),
               @dCLon   FLOAT (53) = COS (@dLon),
               @dSLon   FLOAT (53) = SIN (@dLon)

            IF @dRad < 0
         BEGIN
               SET @dRad *= -1
               SET @dOI  *= -1
           END

            -- MXform_Identity     (MXform);
            -- MXform_Translate    (MXform, dRad * dCLat * dSLon, dRad * dSLat, dRad * dCLat * dCLon);
            -- MXform_Rotate_Y     (MXform, dLon);                                                              -- +z axis aligns with longitude
            -- MXform_Rotate_X     (MXform, dLatX);                                                             -- +y axis aligns with latitude
            -- MXform_Rotate_Z     (MXform, 90 +/- 90);                                                         -- +y axis aligns with latitude (direction depends on dOI)

            -- Matrix multiplication progresses left to right

            -- [ 1   0   0   0 ]     [ 1   0   0   X ]     [  dCLon   0   dSLon   0 ]     [ 1   0         0        0 ]     [ dOI   0     0   0 ]
            -- [ 0   1   0   0 ]  X  [ 0   1   0   Y ]  X  [  0       1   0       0 ]  X  [ 0   dCLatX   -dSLatX   0 ]  X  [ 0     dOI   0   0 ]
            -- [ 0   0   1   0 ]     [ 0   0   1   Z ]     [ -dSLon   0   dCLon   0 ]     [ 0   dSLatX    dCLatX   0 ]     [ 0     0     1   0 ]
            -- [ 0   0   0   1 ]     [ 0   0   0   1 ]     [  0       0   0       1 ]     [ 0   0         0        1 ]     [ 0     0     0   1 ]

        INSERT dbo.RMTSubsurface
               (  twRMTObjectIx, tnGeometry,            dA,         dB,          dC      )
        VALUES ( @twRMTObjectIx, @RMTMATRIX_COORD_GEO, @dLatitude, @dLongitude, @dRadius )

        INSERT dbo.RMTMatrix
               ( bnMatrix,

                 d00,                 d01,                           d02,                   d03,
                 d10,                 d11,                           d12,                   d13,
                 d20,                 d21,                           d22,                   d23,
                 d30,                 d31,                           d32,                   d33
               )
        VALUES ( @twRMTObjectIx,

                 @dOI *  @dCLon ,     @dOI * @dSLon * @dSLatX ,      @dSLon * @dCLatX ,     @dRad * @dCLat * @dSLon ,
                         0      ,     @dOI * @dCLatX          ,     -@dSLatX          ,     @dRad * @dSLat          ,
                 @dOI * -@dSLon ,     @dOI * @dCLon * @dSLatX ,      @dCLon * @dCLatX ,     @dRad * @dCLat * @dCLon ,
                         0      ,            0                ,      0                ,     1
               )

        INSERT dbo.RMTMatrix
               ( bnMatrix           )
        VALUES ( 0 - @twRMTObjectIx )

          EXEC @nResult = dbo.call_RMTMatrix_Inverse @twRMTObjectIx

        RETURN @nResult
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : call_RMTMatrix_Inverse.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Inverse
(
   @bnMatrix                     BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nResult INT = 0

       DECLARE @d00 FLOAT (53), @d01 FLOAT (53), @d02 FLOAT (53), @d03 FLOAT (53),
               @d10 FLOAT (53), @d11 FLOAT (53), @d12 FLOAT (53), @d13 FLOAT (53),
               @d20 FLOAT (53), @d21 FLOAT (53), @d22 FLOAT (53), @d23 FLOAT (53),
               @d30 FLOAT (53), @d31 FLOAT (53), @d32 FLOAT (53), @d33 FLOAT (53)

        SELECT @d00 = d00, @d01 = d01, @d02 = d02, @d03 = d03,
               @d10 = d10, @d11 = d11, @d12 = d12, @d13 = d13,
               @d20 = d20, @d21 = d21, @d22 = d22, @d23 = d23,
               @d30 = d30, @d31 = d31, @d32 = d32, @d33 = d33
          FROM dbo.RMTMatrix
         WHERE bnMatrix = @bnMatrix

       DECLARE @s0 FLOAT (53) = @d00 * @d11 - @d10 * @d01,
               @s1 FLOAT (53) = @d00 * @d12 - @d10 * @d02,
               @s2 FLOAT (53) = @d00 * @d13 - @d10 * @d03,
               @s3 FLOAT (53) = @d01 * @d12 - @d11 * @d02,
               @s4 FLOAT (53) = @d01 * @d13 - @d11 * @d03,
               @s5 FLOAT (53) = @d02 * @d13 - @d12 * @d03,

               @c5 FLOAT (53) = @d22 * @d33 - @d32 * @d23,
               @c4 FLOAT (53) = @d21 * @d33 - @d31 * @d23,
               @c3 FLOAT (53) = @d21 * @d32 - @d31 * @d22,
               @c2 FLOAT (53) = @d20 * @d33 - @d30 * @d23,
               @c1 FLOAT (53) = @d20 * @d32 - @d30 * @d22,
               @c0 FLOAT (53) = @d20 * @d31 - @d30 * @d21

       DECLARE @dDeterminant FLOAT (53) = @s0 * @c5 - @s1 * @c4 + @s2 * @c3 + @s3 * @c2 - @s4 * @c1 + @s5 * @c0

            IF @dDeterminant <> 0
         BEGIN
                DECLARE @dDeterminant_ FLOAT (53) = 1 / @dDeterminant
           
                 UPDATE dbo.RMTMatrix
                    SET d00 = ( @d11 * @c5 - @d12 * @c4 + @d13 * @c3) * @dDeterminant_,
                        d01 = (-@d01 * @c5 + @d02 * @c4 - @d03 * @c3) * @dDeterminant_,
                        d02 = ( @d31 * @s5 - @d32 * @s4 + @d33 * @s3) * @dDeterminant_,
                        d03 = (-@d21 * @s5 + @d22 * @s4 - @d23 * @s3) * @dDeterminant_,
           
                        d10 = (-@d10 * @c5 + @d12 * @c2 - @d13 * @c1) * @dDeterminant_,
                        d11 = ( @d00 * @c5 - @d02 * @c2 + @d03 * @c1) * @dDeterminant_,
                        d12 = (-@d30 * @s5 + @d32 * @s2 - @d33 * @s1) * @dDeterminant_,
                        d13 = ( @d20 * @s5 - @d22 * @s2 + @d23 * @s1) * @dDeterminant_,
           
                        d20 = ( @d10 * @c4 - @d11 * @c2 + @d13 * @c0) * @dDeterminant_,
                        d21 = (-@d00 * @c4 + @d01 * @c2 - @d03 * @c0) * @dDeterminant_,
                        d22 = ( @d30 * @s4 - @d31 * @s2 + @d33 * @s0) * @dDeterminant_,
                        d23 = (-@d20 * @s4 + @d21 * @s2 - @d23 * @s0) * @dDeterminant_,
           
                        d30 = (-@d10 * @c3 + @d11 * @c1 - @d12 * @c0) * @dDeterminant_,
                        d31 = ( @d00 * @c3 - @d01 * @c1 + @d02 * @c0) * @dDeterminant_,
                        d32 = (-@d30 * @s3 + @d31 * @s1 - @d32 * @s0) * @dDeterminant_,
                        d33 = ( @d20 * @s3 - @d21 * @s1 + @d22 * @s0) * @dDeterminant_
                  WHERE bnMatrix = 0 - @bnMatrix

                    SET @nResult = 1
           END

        RETURN @nResult
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMTMatrix_Mult.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Mult
(
   @bnMatrix_R                   BIGINT,
   @bnMatrix_L                   BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nResult INT = 0

        UPDATE mr
           SET mr.d00 = (ml.d00 * mr.d00) + (ml.d01 * mr.d10) + (ml.d02 * mr.d20) + (ml.d03 * mr.d30),
               mr.d01 = (ml.d00 * mr.d01) + (ml.d01 * mr.d11) + (ml.d02 * mr.d21) + (ml.d03 * mr.d31),
               mr.d02 = (ml.d00 * mr.d02) + (ml.d01 * mr.d12) + (ml.d02 * mr.d22) + (ml.d03 * mr.d32),
               mr.d03 = (ml.d00 * mr.d03) + (ml.d01 * mr.d13) + (ml.d02 * mr.d23) + (ml.d03 * mr.d33),

               mr.d10 = (ml.d10 * mr.d00) + (ml.d11 * mr.d10) + (ml.d12 * mr.d20) + (ml.d13 * mr.d30),
               mr.d11 = (ml.d10 * mr.d01) + (ml.d11 * mr.d11) + (ml.d12 * mr.d21) + (ml.d13 * mr.d31),
               mr.d12 = (ml.d10 * mr.d02) + (ml.d11 * mr.d12) + (ml.d12 * mr.d22) + (ml.d13 * mr.d32),
               mr.d13 = (ml.d10 * mr.d03) + (ml.d11 * mr.d13) + (ml.d12 * mr.d23) + (ml.d13 * mr.d33),

               mr.d20 = (ml.d20 * mr.d00) + (ml.d21 * mr.d10) + (ml.d22 * mr.d20) + (ml.d23 * mr.d30),
               mr.d21 = (ml.d20 * mr.d01) + (ml.d21 * mr.d11) + (ml.d22 * mr.d21) + (ml.d23 * mr.d31),
               mr.d22 = (ml.d20 * mr.d02) + (ml.d21 * mr.d12) + (ml.d22 * mr.d22) + (ml.d23 * mr.d32),
               mr.d23 = (ml.d20 * mr.d03) + (ml.d21 * mr.d13) + (ml.d22 * mr.d23) + (ml.d23 * mr.d33),

               mr.d30 = (ml.d30 * mr.d00) + (ml.d31 * mr.d10) + (ml.d32 * mr.d20) + (ml.d33 * mr.d30),
               mr.d31 = (ml.d30 * mr.d01) + (ml.d31 * mr.d11) + (ml.d32 * mr.d21) + (ml.d33 * mr.d31),
               mr.d32 = (ml.d30 * mr.d02) + (ml.d31 * mr.d12) + (ml.d32 * mr.d22) + (ml.d33 * mr.d32),
               mr.d33 = (ml.d30 * mr.d03) + (ml.d31 * mr.d13) + (ml.d32 * mr.d23) + (ml.d33 * mr.d33)

          FROM dbo.RMTMatrix AS ml
          JOIN dbo.RMTMatrix AS mr ON mr.bnMatrix = @bnMatrix_R
         WHERE ml.bnMatrix = @bnMatrix_L
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMTMatrix_Nul.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Nul
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @RMTMATRIX_COORD_NUL                       INT = 0

       DECLARE @nResult INT = 0

        INSERT dbo.RMTSubsurface
               (  twRMTObjectIx, tnGeometry,            dA,  dB,  dC )
        VALUES ( @twRMTObjectIx, @RMTMATRIX_COORD_NUL,   0,   0,   0 )

        INSERT dbo.RMTMatrix
               ( bnMatrix       )
        VALUES ( @twRMTObjectIx )

            IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT AND @ObjectHead_Parent_twObjectIx <> 0
               EXEC dbo.call_RMTMatrix_Mult @twRMTObjectIx, @ObjectHead_Parent_twObjectIx

          EXEC dbo.call_RMTMatrix_Translate @twRMTObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ

          EXEC dbo.call_RMTMatrix_Rotate    @twRMTObjectIx, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW

          EXEC dbo.call_RMTMatrix_Scale     @twRMTObjectIx, @Transform_Scale_dX,     @Transform_Scale_dY,    @Transform_Scale_dZ

        INSERT dbo.RMTMatrix
               ( bnMatrix           )
        VALUES ( 0 - @twRMTObjectIx )

          EXEC @nResult = dbo.call_RMTMatrix_Inverse @twRMTObjectIx

        RETURN @nResult
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : call_RMTMatrix_Relative.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Relative
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

       DECLARE @d00 FLOAT (53), @d01 FLOAT (53), @d02 FLOAT (53), @d03 FLOAT (53),
               @d10 FLOAT (53), @d11 FLOAT (53), @d12 FLOAT (53), @d13 FLOAT (53),
               @d20 FLOAT (53), @d21 FLOAT (53), @d22 FLOAT (53), @d23 FLOAT (53),
               @d30 FLOAT (53), @d31 FLOAT (53), @d32 FLOAT (53), @d33 FLOAT (53)

       DECLARE @dTX FLOAT (53), @dTY FLOAT (53), @dTZ FLOAT (53),
               @dRX FLOAT (53), @dRY FLOAT (53), @dRZ FLOAT (53), @dRW FLOAT (53),
               @dSX FLOAT (53), @dSY FLOAT (53), @dSZ FLOAT (53)

            IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT AND @ObjectHead_Parent_twObjectIx <> 0
         BEGIN
                     -- perform a mult into local variables

                 SELECT @d00 = (ml.d00 * mr.d00) + (ml.d01 * mr.d10) + (ml.d02 * mr.d20) + (ml.d03 * mr.d30),
                        @d01 = (ml.d00 * mr.d01) + (ml.d01 * mr.d11) + (ml.d02 * mr.d21) + (ml.d03 * mr.d31),
                        @d02 = (ml.d00 * mr.d02) + (ml.d01 * mr.d12) + (ml.d02 * mr.d22) + (ml.d03 * mr.d32),
                        @d03 = (ml.d00 * mr.d03) + (ml.d01 * mr.d13) + (ml.d02 * mr.d23) + (ml.d03 * mr.d33),

                        @d10 = (ml.d10 * mr.d00) + (ml.d11 * mr.d10) + (ml.d12 * mr.d20) + (ml.d13 * mr.d30),
                        @d11 = (ml.d10 * mr.d01) + (ml.d11 * mr.d11) + (ml.d12 * mr.d21) + (ml.d13 * mr.d31),
                        @d12 = (ml.d10 * mr.d02) + (ml.d11 * mr.d12) + (ml.d12 * mr.d22) + (ml.d13 * mr.d32),
                        @d13 = (ml.d10 * mr.d03) + (ml.d11 * mr.d13) + (ml.d12 * mr.d23) + (ml.d13 * mr.d33),

                        @d20 = (ml.d20 * mr.d00) + (ml.d21 * mr.d10) + (ml.d22 * mr.d20) + (ml.d23 * mr.d30),
                        @d21 = (ml.d20 * mr.d01) + (ml.d21 * mr.d11) + (ml.d22 * mr.d21) + (ml.d23 * mr.d31),
                        @d22 = (ml.d20 * mr.d02) + (ml.d21 * mr.d12) + (ml.d22 * mr.d22) + (ml.d23 * mr.d32),
                        @d23 = (ml.d20 * mr.d03) + (ml.d21 * mr.d13) + (ml.d22 * mr.d23) + (ml.d23 * mr.d33),

                        @d30 = (ml.d30 * mr.d00) + (ml.d31 * mr.d10) + (ml.d32 * mr.d20) + (ml.d33 * mr.d30),
                        @d31 = (ml.d30 * mr.d01) + (ml.d31 * mr.d11) + (ml.d32 * mr.d21) + (ml.d33 * mr.d31),
                        @d32 = (ml.d30 * mr.d02) + (ml.d31 * mr.d12) + (ml.d32 * mr.d22) + (ml.d33 * mr.d32),
                        @d33 = (ml.d30 * mr.d03) + (ml.d31 * mr.d13) + (ml.d32 * mr.d23) + (ml.d33 * mr.d33)

                   FROM dbo.RMTMatrix AS ml
                   JOIN dbo.RMTMatrix AS mr ON mr.bnMatrix = @twRMTObjectIx
                  WHERE ml.bnMatrix = 0 - @ObjectHead_Parent_twObjectIx                 -- parent's inverse matrix
           END
          ELSE
         BEGIN
                     -- copy matrix to local variables

                 SELECT @d00 = mr.d00,
                        @d01 = mr.d01,
                        @d02 = mr.d02,
                        @d03 = mr.d03,

                        @d10 = mr.d10,
                        @d11 = mr.d11,
                        @d12 = mr.d12,
                        @d13 = mr.d13,

                        @d20 = mr.d20,
                        @d21 = mr.d21,
                        @d23 = mr.d23,
                        @d22 = mr.d22,

                        @d30 = mr.d30,
                        @d31 = mr.d31,
                        @d32 = mr.d32,
                        @d33 = mr.d33

                   FROM dbo.RMTMatrix AS mr
                  WHERE mr.bnMatrix = @twRMTObjectIx
           END

            -- Extract the translation from the matrix

        SELECT @dTX = @d03,
               @dTY = @d13,
               @dTZ = @d23

--SELECT 'T', @dTX, @dTY, @dTZ

            -- Extract the rotation (quaternion) from the matrix

       DECLARE @dTrace FLOAT (53),
               @dS     FLOAT (53),
               @dN     FLOAT (53)

           SET @dTrace = @d00 + @d11 + @d22

            IF @dTrace > 0
         BEGIN
                  SET @dS = 1 / (SQRT (@dTrace + 1) * 2)

               SELECT @dRX = (@d21 - @d12) * @dS,
                      @dRY = (@d02 - @d20) * @dS,
                      @dRZ = (@d10 - @d01) * @dS,
                      @dRW = 1 / (@dS * 4)
           END
       ELSE IF @d00 > @d11  AND  @d00 > @d22
         BEGIN
                  SET @dS = 2 * SQRT (1 + @d00 - @d11 - @d22)

               SELECT @dRX = @dS / 4,
                      @dRY = (@d01 + @d10) / @dS,
                      @dRZ = (@d02 + @d20) / @dS,
                      @dRW = (@d21 - @d12) / @dS
           END
       ELSE IF @d11 > @d22
         BEGIN
                  SET @dS = 2 * SQRT (1 + @d11 - @d00 - @d22)

               SELECT @dRX = (@d01 + @d10) / @dS,
                      @dRY = @dS / 4,
                      @dRZ = (@d12 + @d21) / @dS,
                      @dRW = (@d02 - @d20) / @dS
           END
          ELSE
         BEGIN
                  SET @dS = 2 * SQRT (1 + @d22 - @d00 - @d11)

               SELECT @dRX = (@d02 + @d20) / @dS,
                      @dRY = (@d12 + @d21) / @dS,
                      @dRZ = @dS / 4,
                      @dRW = (@d10 - @d01) / @dS
           END

        SELECT @dN = SQRT ((@dRX * @dRX) + (@dRY * @dRY) + (@dRZ * @dRZ) + (@dRW * @dRW))

        SELECT @dRX /= @dN,
               @dRY /= @dN,
               @dRZ /= @dN,
               @dRW /= @dN

--SELECT 'R', @dRX, @dRY, @dRZ, @dRW

            -- Extract the scale from the matrix

        SELECT @dSX = SQRT ((@d00 * @d00) + (@d10 * @d10) + (@d20 * @d20)),
               @dSY = SQRT ((@d01 * @d01) + (@d11 * @d11) + (@d21 * @d21)),
               @dSZ = SQRT ((@d02 * @d02) + (@d12 * @d12) + (@d22 * @d22))

            -- Update the relative transform in the object

        UPDATE dbo.RMTObject
           SET Transform_Position_dX = @dTX,
               Transform_Position_dY = @dTY,
               Transform_Position_dZ = @dTZ,
               Transform_Rotation_dX = @dRX,
               Transform_Rotation_dY = @dRY,
               Transform_Rotation_dZ = @dRZ,
               Transform_Rotation_dW = @dRW,
               Transform_Scale_dX    = @dSX,
               Transform_Scale_dY    = @dSY,
               Transform_Scale_dZ    = @dSZ
         WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

        RETURN
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMTMatrix_Rotate.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Rotate
(
   @bnMatrix_L                   BIGINT,
   @dX                           FLOAT (53),
   @dY                           FLOAT (53),
   @dZ                           FLOAT (53),
   @dW                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nResult INT = 0

       DECLARE @d00 FLOAT (53) = 1 - 2 * @dY * @dY - 2 * @dZ * @dZ,
               @d01 FLOAT (53) =     2 * @dX * @dY - 2 * @dZ * @dW,
               @d02 FLOAT (53) =     2 * @dX * @dZ + 2 * @dY * @dW,
               @d03 FLOAT (53) =                                 0,

               @d10 FLOAT (53) =     2 * @dX * @dY + 2 * @dZ * @dW,
               @d11 FLOAT (53) = 1 - 2 * @dX * @dX - 2 * @dZ * @dZ,
               @d12 FLOAT (53) =     2 * @dY * @dZ - 2 * @dX * @dW,
               @d13 FLOAT (53) =                                 0,

               @d20 FLOAT (53) =     2 * @dX * @dZ - 2 * @dY * @dW,
               @d21 FLOAT (53) =     2 * @dY * @dZ + 2 * @dX * @dW,
               @d22 FLOAT (53) = 1 - 2 * @dX * @dX - 2 * @dY * @dY,
               @d23 FLOAT (53) =                                 0,

               @d30 FLOAT (53) =                                 0,            
               @d31 FLOAT (53) =                                 0,
               @d32 FLOAT (53) =                                 0,
               @d33 FLOAT (53) =                                 1

        UPDATE ml
           SET ml.d00 = (ml.d00 * @d00) + (ml.d01 * @d10) + (ml.d02 * @d20) + (ml.d03 * @d30),
               ml.d01 = (ml.d00 * @d01) + (ml.d01 * @d11) + (ml.d02 * @d21) + (ml.d03 * @d31),
               ml.d02 = (ml.d00 * @d02) + (ml.d01 * @d12) + (ml.d02 * @d22) + (ml.d03 * @d32),
               ml.d03 = (ml.d00 * @d03) + (ml.d01 * @d13) + (ml.d02 * @d23) + (ml.d03 * @d33),

               ml.d10 = (ml.d10 * @d00) + (ml.d11 * @d10) + (ml.d12 * @d20) + (ml.d13 * @d30),
               ml.d11 = (ml.d10 * @d01) + (ml.d11 * @d11) + (ml.d12 * @d21) + (ml.d13 * @d31),
               ml.d12 = (ml.d10 * @d02) + (ml.d11 * @d12) + (ml.d12 * @d22) + (ml.d13 * @d32),
               ml.d13 = (ml.d10 * @d03) + (ml.d11 * @d13) + (ml.d12 * @d23) + (ml.d13 * @d33),

               ml.d20 = (ml.d20 * @d00) + (ml.d21 * @d10) + (ml.d22 * @d20) + (ml.d23 * @d30),
               ml.d21 = (ml.d20 * @d01) + (ml.d21 * @d11) + (ml.d22 * @d21) + (ml.d23 * @d31),
               ml.d22 = (ml.d20 * @d02) + (ml.d21 * @d12) + (ml.d22 * @d22) + (ml.d23 * @d32),
               ml.d23 = (ml.d20 * @d03) + (ml.d21 * @d13) + (ml.d22 * @d23) + (ml.d23 * @d33),

               ml.d30 = (ml.d30 * @d00) + (ml.d31 * @d10) + (ml.d32 * @d20) + (ml.d33 * @d30),
               ml.d31 = (ml.d30 * @d01) + (ml.d31 * @d11) + (ml.d32 * @d21) + (ml.d33 * @d31),
               ml.d32 = (ml.d30 * @d02) + (ml.d31 * @d12) + (ml.d32 * @d22) + (ml.d33 * @d32),
               ml.d33 = (ml.d30 * @d03) + (ml.d31 * @d13) + (ml.d32 * @d23) + (ml.d33 * @d33)

          FROM dbo.RMTMatrix AS ml
         WHERE ml.bnMatrix = @bnMatrix_L
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMTMatrix_Scale.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Scale
(
   @bnMatrix_L                   BIGINT,
   @dX                           FLOAT (53),
   @dY                           FLOAT (53),
   @dZ                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nResult INT = 0

       DECLARE @d00 FLOAT (53) = @dX,
               @d01 FLOAT (53) = 0,
               @d02 FLOAT (53) = 0,
               @d03 FLOAT (53) = 0,

               @d10 FLOAT (53) = 0,
               @d11 FLOAT (53) = @dY,
               @d12 FLOAT (53) = 0,
               @d13 FLOAT (53) = 0,

               @d20 FLOAT (53) = 0,
               @d21 FLOAT (53) = 0,
               @d22 FLOAT (53) = @dZ,
               @d23 FLOAT (53) = 0,

               @d30 FLOAT (53) = 0,
               @d31 FLOAT (53) = 0,
               @d32 FLOAT (53) = 0,
               @d33 FLOAT (53) = 1

        UPDATE ml
           SET ml.d00 = (ml.d00 * @d00) + (ml.d01 * @d10) + (ml.d02 * @d20) + (ml.d03 * @d30),
               ml.d01 = (ml.d00 * @d01) + (ml.d01 * @d11) + (ml.d02 * @d21) + (ml.d03 * @d31),
               ml.d02 = (ml.d00 * @d02) + (ml.d01 * @d12) + (ml.d02 * @d22) + (ml.d03 * @d32),
               ml.d03 = (ml.d00 * @d03) + (ml.d01 * @d13) + (ml.d02 * @d23) + (ml.d03 * @d33),

               ml.d10 = (ml.d10 * @d00) + (ml.d11 * @d10) + (ml.d12 * @d20) + (ml.d13 * @d30),
               ml.d11 = (ml.d10 * @d01) + (ml.d11 * @d11) + (ml.d12 * @d21) + (ml.d13 * @d31),
               ml.d12 = (ml.d10 * @d02) + (ml.d11 * @d12) + (ml.d12 * @d22) + (ml.d13 * @d32),
               ml.d13 = (ml.d10 * @d03) + (ml.d11 * @d13) + (ml.d12 * @d23) + (ml.d13 * @d33),

               ml.d20 = (ml.d20 * @d00) + (ml.d21 * @d10) + (ml.d22 * @d20) + (ml.d23 * @d30),
               ml.d21 = (ml.d20 * @d01) + (ml.d21 * @d11) + (ml.d22 * @d21) + (ml.d23 * @d31),
               ml.d22 = (ml.d20 * @d02) + (ml.d21 * @d12) + (ml.d22 * @d22) + (ml.d23 * @d32),
               ml.d23 = (ml.d20 * @d03) + (ml.d21 * @d13) + (ml.d22 * @d23) + (ml.d23 * @d33),

               ml.d30 = (ml.d30 * @d00) + (ml.d31 * @d10) + (ml.d32 * @d20) + (ml.d33 * @d30),
               ml.d31 = (ml.d30 * @d01) + (ml.d31 * @d11) + (ml.d32 * @d21) + (ml.d33 * @d31),
               ml.d32 = (ml.d30 * @d02) + (ml.d31 * @d12) + (ml.d32 * @d22) + (ml.d33 * @d32),
               ml.d33 = (ml.d30 * @d03) + (ml.d31 * @d13) + (ml.d32 * @d23) + (ml.d33 * @d33)

          FROM dbo.RMTMatrix AS ml
         WHERE ml.bnMatrix = @bnMatrix_L
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMTMatrix_Translate.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTMatrix_Translate
(
   @bnMatrix_L                   BIGINT,
   @dX                           FLOAT (53),
   @dY                           FLOAT (53),
   @dZ                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nResult INT = 0

       DECLARE @d00 FLOAT (53) = 1,
               @d01 FLOAT (53) = 0,
               @d02 FLOAT (53) = 0,
               @d03 FLOAT (53) = @dX,

               @d10 FLOAT (53) = 0,
               @d11 FLOAT (53) = 1,
               @d12 FLOAT (53) = 0,
               @d13 FLOAT (53) = @dY,

               @d20 FLOAT (53) = 0,
               @d21 FLOAT (53) = 0,
               @d22 FLOAT (53) = 1,
               @d23 FLOAT (53) = @dZ,

               @d30 FLOAT (53) = 0,
               @d31 FLOAT (53) = 0,
               @d32 FLOAT (53) = 0,
               @d33 FLOAT (53) = 1

        UPDATE ml
           SET ml.d00 = (ml.d00 * @d00) + (ml.d01 * @d10) + (ml.d02 * @d20) + (ml.d03 * @d30),
               ml.d01 = (ml.d00 * @d01) + (ml.d01 * @d11) + (ml.d02 * @d21) + (ml.d03 * @d31),
               ml.d02 = (ml.d00 * @d02) + (ml.d01 * @d12) + (ml.d02 * @d22) + (ml.d03 * @d32),
               ml.d03 = (ml.d00 * @d03) + (ml.d01 * @d13) + (ml.d02 * @d23) + (ml.d03 * @d33),

               ml.d10 = (ml.d10 * @d00) + (ml.d11 * @d10) + (ml.d12 * @d20) + (ml.d13 * @d30),
               ml.d11 = (ml.d10 * @d01) + (ml.d11 * @d11) + (ml.d12 * @d21) + (ml.d13 * @d31),
               ml.d12 = (ml.d10 * @d02) + (ml.d11 * @d12) + (ml.d12 * @d22) + (ml.d13 * @d32),
               ml.d13 = (ml.d10 * @d03) + (ml.d11 * @d13) + (ml.d12 * @d23) + (ml.d13 * @d33),

               ml.d20 = (ml.d20 * @d00) + (ml.d21 * @d10) + (ml.d22 * @d20) + (ml.d23 * @d30),
               ml.d21 = (ml.d20 * @d01) + (ml.d21 * @d11) + (ml.d22 * @d21) + (ml.d23 * @d31),
               ml.d22 = (ml.d20 * @d02) + (ml.d21 * @d12) + (ml.d22 * @d22) + (ml.d23 * @d32),
               ml.d23 = (ml.d20 * @d03) + (ml.d21 * @d13) + (ml.d22 * @d23) + (ml.d23 * @d33),

               ml.d30 = (ml.d30 * @d00) + (ml.d31 * @d10) + (ml.d32 * @d20) + (ml.d33 * @d30),
               ml.d31 = (ml.d30 * @d01) + (ml.d31 * @d11) + (ml.d32 * @d21) + (ml.d33 * @d31),
               ml.d32 = (ml.d30 * @d02) + (ml.d31 * @d12) + (ml.d32 * @d22) + (ml.d33 * @d32),
               ml.d33 = (ml.d30 * @d03) + (ml.d31 * @d13) + (ml.d32 * @d23) + (ml.d33 * @d33)

          FROM dbo.RMTMatrix AS ml
         WHERE ml.bnMatrix = @bnMatrix_L
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMTObject_Event.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event
(
   @twRMTObjectIx                BIGINT,
   @twEventIz                    BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @bError INT

        SELECT @twEventIz = ObjectHead_twEventIz
          FROM dbo.RMTObject
         WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

            -- Success will be tested on the update below

        UPDATE dbo.RMTObject
           SET ObjectHead_twEventIz += 1
         WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : call_RMTObject_Event_Bound.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_Bound
(
   @twRMTObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMTObject
                  SET Bound_dX = @Bound_dX,
                      Bound_dY = @Bound_dY,
                      Bound_dZ = @Bound_dZ
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'BOUND',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pBound": ',        dbo.Format_Bound
                                                      (
                                                         @Bound_dX,
                                                         @Bound_dY,
                                                         @Bound_dZ
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMTObject_Event_Name.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_Name
(
   @twRMTObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMTObject
                  SET Name_wsRMTObjectId = @Name_wsRMTObjectId
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'NAME',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_T
                                                      (
                                                         @Name_wsRMTObjectId
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : call_RMTObject_Event_Owner.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_Owner
(
   @twRMTObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMTObject
                  SET Owner_twRPersonaIx = @Owner_twRPersonaIx
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'OWNER',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : call_RMTObject_Event_Properties.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_Properties
(
   @twRMTObjectIx                BIGINT,
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMTObject
                  SET Properties_bLockToGround = @Properties_bLockToGround,
                      Properties_bYouth        = @Properties_bYouth,
                      Properties_bAdult        = @Properties_bAdult,
                      Properties_bAvatar       = @Properties_bAvatar
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'PROPERTIES',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pProperties": ',   dbo.Format_Properties_T
                                                      (
                                                         @Properties_bLockToGround,
                                                         @Properties_bYouth,
                                                         @Properties_bAdult,
                                                         @Properties_bAvatar
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMTObject_Event_Resource.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_Resource
(
   @twRMTObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMTObject
                  SET Resource_qwResource = @Resource_qwResource,
                      Resource_sName      = @Resource_sName,
                      Resource_sReference = @Resource_sReference       
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RESOURCE',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pResource": ',     dbo.Format_Resource
                                                      (
                                                         @Resource_qwResource,
                                                         @Resource_sName,
                                                         @Resource_sReference
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                   MVD_RP1_Map : call_RMTObject_Event_RMPObject_Close.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_RMPObject_Close
(
   @twRMTObjectIx                BIGINT,
   @twRMPObjectIx_Close          BIGINT,
   @bReparent                    TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE INT = 0x02

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
                   IF @bReparent = 0
                BEGIN
                        DELETE dbo.RMPObject                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                         WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx_Close
         
                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMPOBJECT_CLOSE',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx_Close,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE,
                             @twEventIz,

                             '{ }',

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                    MVD_RP1_Map : call_RMTObject_Event_RMPObject_Open.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_RMPObject_Open
(
   @twRMTObjectIx                BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @twRMPObjectIx_Open           BIGINT OUTPUT,
   @bReparent                    TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN  INT = 0x01

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
                   IF @bReparent = 0
                BEGIN
                        INSERT dbo.RMPObject
                               ( ObjectHead_Parent_wClass,  ObjectHead_Parent_twObjectIx,  ObjectHead_Self_wClass,  ObjectHead_twEventIz,  ObjectHead_wFlags,  Name_wsRMPObjectId,  Type_bType,  Type_bSubtype,  Type_bFiction,  Type_bMovable,  Owner_twRPersonaIx,  Resource_qwResource,  Resource_sName,  Resource_sReference,  Transform_Position_dX,  Transform_Position_dY,  Transform_Position_dZ,  Transform_Rotation_dX,  Transform_Rotation_dY,  Transform_Rotation_dZ,  Transform_Rotation_dW,  Transform_Scale_dX,  Transform_Scale_dY,  Transform_Scale_dZ,  Bound_dX,  Bound_dY,  Bound_dZ)
                        VALUES (@SBO_CLASS_RMTOBJECT,      @twRMTObjectIx,                @SBO_CLASS_RMPOBJECT,     0,                     32,                @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ)
         
                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                           SET @twRMPObjectIx_Open = SCOPE_IDENTITY ()
                  END

                   IF @bError = 0
                BEGIN
                        INSERT #Event
                               (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                        SELECT 'RMPOBJECT_OPEN',
  
                               @SBO_CLASS_RMTOBJECT,
                               @twRMTObjectIx,
                               @SBO_CLASS_RMPOBJECT,
                               @twRMPObjectIx_Open,
                               @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN,
                               @twEventIz,
  
                               '{ }',
  
                               CONCAT
                               (
                                 '{ ',
                                   '"pName": ',         dbo.Format_Name_P
                                                        (
                                                           @Name_wsRMPObjectId
                                                        ),
                                 ', "pType": ',         dbo.Format_Type_P
                                                        (
                                                           @Type_bType,
                                                           @Type_bSubtype,
                                                           @Type_bFiction,
                                                           @Type_bMovable
                                                        ),
                                 ', "pOwner": ',        dbo.Format_Owner
                                                        (
                                                           @Owner_twRPersonaIx
                                                        ),
                                 ', "pResource": ',     dbo.Format_Resource
                                                        (
                                                           @Resource_qwResource,
                                                           @Resource_sName,
                                                           @Resource_sReference
                                                        ),
                                 ', "pTransform": ',    dbo.Format_Transform
                                                        (
                                                           @Transform_Position_dX,
                                                           @Transform_Position_dY,
                                                           @Transform_Position_dZ,
                                                           @Transform_Rotation_dX,
                                                           @Transform_Rotation_dY,
                                                           @Transform_Rotation_dZ,
                                                           @Transform_Rotation_dW,
                                                           @Transform_Scale_dX,
                                                           @Transform_Scale_dY,
                                                           @Transform_Scale_dZ
                                                        ),
                                 ', "pBound": ',        dbo.Format_Bound
                                                        (
                                                           @Bound_dX,
                                                           @Bound_dY,
                                                           @Bound_dZ
                                                        ),
                                ' }'
                               ),
  
                               '{ }'
  
                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                   MVD_RP1_Map : call_RMTObject_Event_RMTObject_Close.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_RMTObject_Close
(
   @twRMTObjectIx                BIGINT,
   @twRMTObjectIx_Close          BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE INT = 0x02

       DECLARE @bError    INT,
               @twEventIz BIGINT

       DECLARE @nCount    INT = 0

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               DELETE dbo.RMTMatrix                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE bnMatrix =     @twRMTObjectIx_Close
                   OR bnMatrix = 0 - @twRMTObjectIx_Close

                  SET @nCount += @@ROWCOUNT -- 2

               DELETE dbo.RMTSubsurface                                    -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE twRMTObjectIx = @twRMTObjectIx_Close

                  SET @nCount += @@ROWCOUNT -- 1

               DELETE dbo.RMTObject                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx_Close

                  SET @nCount += @@ROWCOUNT -- 1

                  SET @bError = IIF (@nCount = 4, @@ERROR, 1) -- this will only return the error of the last delete statement

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMTOBJECT_CLOSE',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx_Close,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE,
                             @twEventIz,

                             '{ }',

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                    MVD_RP1_Map : call_RMTObject_Event_RMTObject_Open.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_RMTObject_Open
(
   @twRMTObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT,
   @twRMTObjectIx_Open           BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN  INT = 0x01

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               INSERT dbo.RMTObject
                      ( ObjectHead_Parent_wClass,  ObjectHead_Parent_twObjectIx,  ObjectHead_Self_wClass,  ObjectHead_twEventIz,  ObjectHead_wFlags,  Name_wsRMTObjectId,  Type_bType,  Type_bSubtype,  Type_bFiction,  Owner_twRPersonaIx,  Resource_qwResource,  Resource_sName,  Resource_sReference,  Transform_Position_dX,  Transform_Position_dY,  Transform_Position_dZ,  Transform_Rotation_dX,  Transform_Rotation_dY,  Transform_Rotation_dZ,  Transform_Rotation_dW,  Transform_Scale_dX,  Transform_Scale_dY,  Transform_Scale_dZ,  Bound_dX,  Bound_dY,  Bound_dZ,  Properties_bLockToGround,  Properties_bYouth,  Properties_bAdult,  Properties_bAvatar)
               VALUES (@SBO_CLASS_RMTOBJECT,      @twRMTObjectIx,                @SBO_CLASS_RMTOBJECT,     0,                     32,                @Name_wsRMTObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar)

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                         SET @twRMTObjectIx_Open = SCOPE_IDENTITY ()

                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMTOBJECT_OPEN',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx_Open,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN,
                             @twEventIz,

                             '{ }',

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_T
                                                      (
                                                         @Name_wsRMTObjectId
                                                      ),
                               ', "pType": ',         dbo.Format_Type_T
                                                      (
                                                         @Type_bType,
                                                         @Type_bSubtype,
                                                         @Type_bFiction
                                                      ),
                               ', "pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                               ', "pResource": ',     dbo.Format_Resource
                                                      (
                                                         @Resource_qwResource,
                                                         @Resource_sName,
                                                         @Resource_sReference
                                                      ),
                               ', "pTransform": ',    dbo.Format_Transform
                                                      (
                                                         @Transform_Position_dX,
                                                         @Transform_Position_dY,
                                                         @Transform_Position_dZ,
                                                         @Transform_Rotation_dX,
                                                         @Transform_Rotation_dY,
                                                         @Transform_Rotation_dZ,
                                                         @Transform_Rotation_dW,
                                                         @Transform_Scale_dX,
                                                         @Transform_Scale_dY,
                                                         @Transform_Scale_dZ
                                                      ),
                               ', "pBound": ',        dbo.Format_Bound
                                                      (
                                                         @Bound_dX,
                                                         @Bound_dY,
                                                         @Bound_dZ
                                                      ),
                               ', "pProperties": ',   dbo.Format_Properties_T
                                                      (
                                                         @Properties_bLockToGround,
                                                         @Properties_bYouth,
                                                         @Properties_bAdult,
                                                         @Properties_bAvatar
                                                      ),
                              ' }'
                             ),

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : call_RMTObject_Event_Transform.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_Transform
(
   @twRMTObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMTObject
                  SET Transform_Position_dX = @Transform_Position_dX,
                      Transform_Position_dY = @Transform_Position_dY,
                      Transform_Position_dZ = @Transform_Position_dZ,
                      Transform_Rotation_dX = @Transform_Rotation_dX,
                      Transform_Rotation_dY = @Transform_Rotation_dY,
                      Transform_Rotation_dZ = @Transform_Rotation_dZ,
                      Transform_Rotation_dW = @Transform_Rotation_dW,
                      Transform_Scale_dX    = @Transform_Scale_dX,
                      Transform_Scale_dY    = @Transform_Scale_dY,
                      Transform_Scale_dZ    = @Transform_Scale_dZ
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'TRANSFORM',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pTransform": ',    dbo.Format_Transform
                                                      (
                                                         @Transform_Position_dX,
                                                         @Transform_Position_dY,
                                                         @Transform_Position_dZ,
                                                         @Transform_Rotation_dX,
                                                         @Transform_Rotation_dY,
                                                         @Transform_Rotation_dZ,
                                                         @Transform_Rotation_dW,
                                                         @Transform_Scale_dX,
                                                         @Transform_Scale_dY,
                                                         @Transform_Scale_dZ
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMTObject_Event_Type.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Event_Type
(
   @twRMTObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMTObject_Event @twRMTObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMTObject
                  SET Type_bType    = @Type_bType,
                      Type_bSubtype = @Type_bSubtype,
                      Type_bFiction = @Type_bFiction
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'TYPE',

                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pType": ',         dbo.Format_Type_T
                                                      (
                                                         @Type_bType,
                                                         @Type_bSubtype,
                                                         @Type_bFiction
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'
                                                                                                                                                                                                                                                 
                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMTObject_Log.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Log
   @bOp                          TINYINT,
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT
AS
BEGIN
          SET NOCOUNT ON

      DECLARE @bError INT

      DECLARE @dwIPAddress BINARY (4) = dbo.IPstob (@sIPAddress)

       INSERT dbo.RMTObjectLog
              ( bOp,  dwIPAddress,  twRPersonaIx,  twRMTObjectIx)
       VALUES (@bOp, @dwIPAddress, @twRPersonaIx, @twRMTObjectIx)

          SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

       RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMTObject_Parent_Geo.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Parent_Geo
(
   @dLatitude                    FLOAT (53),
   @dLongitude                   FLOAT (53),
   @dRadius                      FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @dLat       FLOAT (53) = RADIANS (@dLatitude),
               @dLon       FLOAT (53) = RADIANS (@dLongitude)
      
       DECLARE @dX         FLOAT (53) = @dRadius * COS (@dLat) * SIN (@dLon),
               @dY         FLOAT (53) = @dRadius * SIN (@dLat),
               @dZ         FLOAT (53) = @dRadius * COS (@dLat) * COS (@dLon)
      
       DECLARE @nCount        INT,
               @bType         TINYINT,
               @bSubtype      TINYINT,
               @twRMTObjectIx BIGINT = 0
      
-- SELECT @dX, @dY, @dZ
      
       DECLARE @Match TABLE
               (
                  nStep         INT,
                  twRMTObjectIx BIGINT
               )
      
       DECLARE @Child TABLE
               (
                  twRMTObjectIx BIGINT,
                  dX            FLOAT (53),
                  dY            FLOAT (53),
                  dZ            FLOAT (53)
               )
      
       DECLARE @Bound TABLE
               (
                  twRMTObjectIx BIGINT,
                  dX            FLOAT (53),
                  dY            FLOAT (53),
                  dZ            FLOAT (53)
               )
      
        INSERT @Match
             ( nStep, twRMTObjectIx )
        SELECT 0,     1
      
           SET @nCount = @@ROWCOUNT
      
         WHILE @nCount > 0
         BEGIN
                 DELETE @Child
      
                 INSERT @Child
                      ( twRMTObjectIx, dX, dY, dZ )
                 SELECT o.ObjectHead_Self_twObjectIx, o.Bound_dX / 2, o.Bound_dY, o.Bound_dZ / 2
                   FROM @Match        AS m
                   JOIN dbo.RMTObject AS o  ON m.nStep                        = 0
                                           AND o.ObjectHead_Parent_wClass     = 72
                                           AND o.ObjectHead_Parent_twObjectIx = m.twRMTObjectIx
                                           AND o.Type_bType                   < 11 -- PARCEL
      
                    SET @nCount = @@ROWCOUNT
      
                 DELETE @Bound
      
                 INSERT @Bound (twRMTObjectIx, dX, dY, dZ) SELECT twRMTObjectIx,  dX,   0,  dZ FROM @Child
                 INSERT @Bound (twRMTObjectIx, dX, dY, dZ) SELECT twRMTObjectIx,  dX,   0, -dZ FROM @Child
                 INSERT @Bound (twRMTObjectIx, dX, dY, dZ) SELECT twRMTObjectIx, -dX,   0,  dZ FROM @Child
                 INSERT @Bound (twRMTObjectIx, dX, dY, dZ) SELECT twRMTObjectIx, -dX,   0, -dZ FROM @Child
                 INSERT @Bound (twRMTObjectIx, dX, dY, dZ) SELECT twRMTObjectIx,  dX,  dY,  dZ FROM @Child
                 INSERT @Bound (twRMTObjectIx, dX, dY, dZ) SELECT twRMTObjectIx,  dX,  dY, -dZ FROM @Child
                 INSERT @Bound (twRMTObjectIx, dX, dY, dZ) SELECT twRMTObjectIx, -dX,  dY,  dZ FROM @Child
                 INSERT @Bound (twRMTObjectIx, dX, dY, dZ) SELECT twRMTObjectIx, -dX,  dY, -dZ FROM @Child
      
                 UPDATE b
                    SET b.dX = (m.d00 * b.dX) + (m.d01 * b.dY) + (m.d02 * b.dZ) + (m.d03 * 1),
                        b.dY = (m.d10 * b.dX) + (m.d11 * b.dY) + (m.d12 * b.dZ) + (m.d13 * 1),
                        b.dZ = (m.d20 * b.dX) + (m.d21 * b.dY) + (m.d22 * b.dZ) + (m.d23 * 1)
                   FROM @Bound        AS b
                   JOIN dbo.RMTMatrix AS m ON m.bnMatrix = b.twRMTObjectIx
      
                 UPDATE @Match
                    SET nStep = 1
      
                 INSERT @Match
                      ( nStep, twRMTObjectIx)
                 SELECT 0,     twRMTObjectIx
                   FROM
                      (
                          SELECT twRMTObjectIx, MIN (dX) AS dX_Min, MAX (dX) AS dX_Max, MIN (dY) AS dY_Min, MAX (dY) AS dY_Max, MIN (dZ) AS dZ_Min, MAX (dZ) AS dZ_Max
                            FROM @Bound
                        GROUP BY twRMTObjectIx
                      ) AS b
                  WHERE @dX BETWEEN b.dX_Min AND b.dX_Max
                    AND @dY BETWEEN b.dY_Min AND b.dY_Max
                    AND @dZ BETWEEN b.dZ_Min AND b.dZ_Max
      
/*
SELECT COUNT (*) FROM @Match
      
SELECT * 
  FROM @Match        AS m
  JOIN dbo.RMTObject AS o ON o.ObjectHead_Self_twObjectIx = m.twRMTObjectIx
*/
           END
      
/*
SELECT * 
  FROM @Match        AS m
  JOIN dbo.RMTObject AS o ON o.ObjectHead_Self_twObjectIx = m.twRMTObjectIx
*/
      
        SELECT @bType    = MAX (o.Type_bType)
          FROM @Match        AS m
          JOIN dbo.RMTObject AS o ON o.ObjectHead_Self_twObjectIx = m.twRMTObjectIx
        
        SELECT @bSubtype = MAX (o.Type_bSubtype)
          FROM @Match        AS m
          JOIN dbo.RMTObject AS o ON o.ObjectHead_Self_twObjectIx = m.twRMTObjectIx AND o.Type_bType = @bType
      
/*
SELECT *
  FROM @Match        AS m
  JOIN dbo.RMTObject AS o ON o.ObjectHead_Self_twObjectIx = m.twRMTObjectIx AND o.Type_bType = @bType AND o.Type_bSubtype = @bSubtype
*/
      
            IF @bType >= 6 -- STATE
        SELECT @twRMTObjectIx = twRMTObjectIx
          FROM
             (
                 SELECT TOP 1
                        twRMTObjectIx, ((@dX - dX) * (@dX - dX)) + ((@dY - dY) * (@dY - dY)) + ((@dZ - dZ) * (@dZ - dZ)) AS dDistance_2
                   FROM
                      (
                          SELECT m.twRMTObjectIx,
                                 x.d03           AS dX,
                                 x.d13           AS dY,
                                 x.d23           AS dZ
                            FROM @Match        AS m
                            JOIN dbo.RMTMatrix AS x ON x.bnMatrix                   = m.twRMTObjectIx
                            JOIN dbo.RMTObject AS o ON o.ObjectHead_Self_twObjectIx = m.twRMTObjectIx
                                                   AND o.Type_bType                 = @bType
                                                   AND o.Type_bSubtype              = @bSubtype
                      ) AS a
               ORDER BY 2
             ) AS b
      
        RETURN @twRMTObjectIx
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMTObject_Select.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Select
(
   @nResultSet                   INT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @OBJECTHEAD_FLAG_SUBSCRIBE_PARTIAL         INT = 0x10
       DECLARE @OBJECTHEAD_FLAG_SUBSCRIBE_FULL            INT = 0x20

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

        SELECT CONCAT
               (
                 '{ ',
                    '"pObjectHead": ',   dbo.Format_ObjectHead
                                         (
                                            t.ObjectHead_Parent_wClass,
                                            t.ObjectHead_Parent_twObjectIx,
                                            t.ObjectHead_Self_wClass,
                                            t.ObjectHead_Self_twObjectIx,
                                            IIF (@nResultSet = 0, @OBJECTHEAD_FLAG_SUBSCRIBE_FULL, @OBJECTHEAD_FLAG_SUBSCRIBE_PARTIAL),
                                            t.ObjectHead_twEventIz
                                         ),

                  ', "twRMTObjectIx": ', t.ObjectHead_Self_twObjectIx,      -- is this necessary

                  ', "pName": ',         dbo.Format_Name_T
                                         (
                                            t.Name_wsRMTObjectId
                                         ),
                  ', "pType": ',         dbo.Format_Type_T
                                         (
                                            t.Type_bType,
                                            t.Type_bSubtype,
                                            t.Type_bFiction
                                         ),
                  ', "pOwner": ',        dbo.Format_Owner
                                         (
                                            t.Owner_twRPersonaIx
                                         ),
                  ', "pResource": ',     dbo.Format_Resource
                                         (
                                            t.Resource_qwResource,
                                            t.Resource_sName,
                                            t.Resource_sReference
                                         ),
                  ', "pTransform": ',    dbo.Format_Transform
                                         (
                                            t.Transform_Position_dX,
                                            t.Transform_Position_dY,
                                            t.Transform_Position_dZ,
                                            t.Transform_Rotation_dX,
                                            t.Transform_Rotation_dY,
                                            t.Transform_Rotation_dZ,
                                            t.Transform_Rotation_dW,
                                            t.Transform_Scale_dX,
                                            t.Transform_Scale_dY,
                                            t.Transform_Scale_dZ
                                         ),
                  ', "pBound": ',        dbo.Format_Bound
                                         (
                                            t.Bound_dX,
                                            t.Bound_dY,
                                            t.Bound_dZ
                                         ),
                  ', "pProperties": ',   dbo.Format_Properties_T
                                         (
                                            t.Properties_bLockToGround,
                                            t.Properties_bYouth,
                                            t.Properties_bAdult,
                                            t.Properties_bAvatar
                                         ),

                  ', "nChildren":  ',    cat.nCount + cap.nCount,
                 ' }'               
               ) AS [Object]
          FROM #Results      AS x
          JOIN dbo.RMTObject AS t on t.ObjectHead_Self_twObjectIx = x.ObjectHead_Self_twObjectIx
         CROSS APPLY (SELECT COUNT (*) AS nCount FROM dbo.RMTObject WHERE ObjectHead_Parent_twObjectIx = t.ObjectHead_Self_twObjectIx AND ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT) AS cat
         CROSS APPLY (SELECT COUNT (*) AS nCount FROM dbo.RMPObject WHERE ObjectHead_Parent_twObjectIx = t.ObjectHead_Self_twObjectIx AND ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT) AS cap
         WHERE nResultSet = @nResultSet
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : call_RMTObject_Validate.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate
(
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @ObjectHead_Parent_wClass     SMALLINT        OUTPUT,
   @ObjectHead_Parent_twObjectIx BIGINT          OUTPUT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nCount INT

        SELECT @ObjectHead_Parent_wClass     = ObjectHead_Parent_wClass,
               @ObjectHead_Parent_twObjectIx = ObjectHead_Parent_twObjectIx
          FROM dbo.RMTObject
         WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

           SET @nCount = @@ROWCOUNT

            IF @twRPersonaIx <= 0
               EXEC dbo.call_Error 1,  'twRPersonaIx is invalid',  @nError OUTPUT
       ELSE IF @twRMTObjectIx <= 0
               EXEC dbo.call_Error 2,  'twRMTObjectIx is invalid', @nError OUTPUT
       ELSE IF @nCount <> 1
               EXEC dbo.call_Error 3,  'twRMTObjectIx is unknown', @nError OUTPUT
       ELSE IF @twRPersonaIx <> @twRPersonaIx                                             -- TBD
               EXEC dbo.call_Error 4,  'Invalid rights',           @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMTObject_Validate_Bound.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Bound
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

            IF @Bound_dX IS NULL OR @Bound_dX <> @Bound_dX
               EXEC dbo.call_Error 21, 'Bound_dX is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dX < 0
               EXEC dbo.call_Error 21, 'Bound_dX is invalid',     @nError OUTPUT

            IF @Bound_dY IS NULL OR @Bound_dY <> @Bound_dY
               EXEC dbo.call_Error 21, 'Bound_dY is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dY < 0
               EXEC dbo.call_Error 21, 'Bound_dY is invalid',     @nError OUTPUT

            IF @Bound_dZ IS NULL OR @Bound_dZ <> @Bound_dZ
               EXEC dbo.call_Error 21, 'Bound_dZ is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dZ < 0
               EXEC dbo.call_Error 21, 'Bound_dZ is invalid',     @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate bound is inside  parent's   bound
               -- validate bound is outside children's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMTObject_Validate_Coord_Car.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Coord_Car
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @dX                           FLOAT (53),
   @dY                           FLOAT (53),
   @dZ                           FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

            IF @dX IS NULL OR @dX <> @dX
               EXEC dbo.call_Error 21, 'dX is NULL or NaN', @nError OUTPUT

            IF @dY IS NULL OR @dY <> @dY
               EXEC dbo.call_Error 21, 'dY is NULL or NaN', @nError OUTPUT

            IF @dZ IS NULL OR @dZ <> @dZ
               EXEC dbo.call_Error 21, 'dZ is NULL or NaN', @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate position is inside parent's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMTObject_Validate_Coord_Cyl.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Coord_Cyl
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @dTheta                       FLOAT (53),
   @dY                           FLOAT (53),
   @dRadius                      FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

            IF @dTheta IS NULL OR @dTheta <> @dTheta
               EXEC dbo.call_Error 21, 'dTheta is NULL or NaN',  @nError OUTPUT
       ELSE IF @dTheta NOT BETWEEN -180 AND 180
               EXEC dbo.call_Error 21, 'dTheta is invalid',      @nError OUTPUT

            IF @dY IS NULL OR @dY <> @dY
               EXEC dbo.call_Error 21, 'dY is NULL or NaN',      @nError OUTPUT

            IF @dRadius IS NULL OR @dRadius <> @dRadius
               EXEC dbo.call_Error 21, 'dRadius is NULL or NaN', @nError OUTPUT
       ELSE IF @dRadius = 0
               EXEC dbo.call_Error 21, 'dRadius is invalid',     @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate position is inside parent's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMTObject_Validate_Coord_Geo.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Coord_Geo
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @dLatitude                    FLOAT (53),
   @dLongitude                   FLOAT (53),
   @dRadius                      FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

            IF @dLatitude IS NULL OR @dLatitude <> @dLatitude
               EXEC dbo.call_Error 21, 'dLatitude is NULL or NaN',  @nError OUTPUT
       ELSE IF @dLatitude NOT BETWEEN -180 AND 180
               EXEC dbo.call_Error 21, 'dLatitude is invalid',      @nError OUTPUT

            IF @dLongitude IS NULL OR @dLongitude <> @dLongitude
               EXEC dbo.call_Error 21, 'dLongitude is NULL or NaN', @nError OUTPUT
       ELSE IF @dLongitude NOT BETWEEN -180 AND 180
               EXEC dbo.call_Error 21, 'dLongitude is invalid',     @nError OUTPUT

            IF @dRadius IS NULL OR @dRadius <> @dRadius
               EXEC dbo.call_Error 21, 'dRadius is NULL or NaN',    @nError OUTPUT
       ELSE IF @dRadius = 0
               EXEC dbo.call_Error 21, 'dRadius is invalid',        @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate position is inside parent's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMTObject_Validate_Coord_Nul.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Coord_Nul
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

            IF @Transform_Position_dX IS NULL OR @Transform_Position_dX <> @Transform_Position_dX
               EXEC dbo.call_Error 21, 'Transform_Position_dX is NULL or NaN', @nError OUTPUT
            IF @Transform_Position_dY IS NULL OR @Transform_Position_dY <> @Transform_Position_dY
               EXEC dbo.call_Error 21, 'Transform_Position_dY is NULL or NaN', @nError OUTPUT
            IF @Transform_Position_dZ IS NULL OR @Transform_Position_dZ <> @Transform_Position_dZ
               EXEC dbo.call_Error 21, 'Transform_Position_dZ is NULL or NaN', @nError OUTPUT

            IF @Transform_Rotation_dX IS NULL OR @Transform_Rotation_dX <> @Transform_Rotation_dX
               EXEC dbo.call_Error 21, 'Transform_Rotation_dX is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dY IS NULL OR @Transform_Rotation_dY <> @Transform_Rotation_dY
               EXEC dbo.call_Error 21, 'Transform_Rotation_dY is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dZ IS NULL OR @Transform_Rotation_dZ <> @Transform_Rotation_dZ
               EXEC dbo.call_Error 21, 'Transform_Rotation_dZ is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dW IS NULL OR @Transform_Rotation_dW <> @Transform_Rotation_dW
               EXEC dbo.call_Error 21, 'Transform_Rotation_dW is NULL or NaN', @nError OUTPUT

            IF @Transform_Scale_dX    IS NULL OR @Transform_Scale_dX    <> @Transform_Scale_dX
               EXEC dbo.call_Error 21, 'Transform_Scale_dX    is NULL or NaN', @nError OUTPUT
            IF @Transform_Scale_dY    IS NULL OR @Transform_Scale_dY    <> @Transform_Scale_dY
               EXEC dbo.call_Error 21, 'Transform_Scale_dY    is NULL or NaN', @nError OUTPUT
            IF @Transform_Scale_dZ    IS NULL OR @Transform_Scale_dZ    <> @Transform_Scale_dZ
               EXEC dbo.call_Error 21, 'Transform_Scale_dZ    is NULL or NaN', @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate position is inside parent's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMTObject_Validate_Name.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Name
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Name_wsRMTObjectId IS NULL
               EXEC dbo.call_Error 21, 'Name_wsRMTObjectId is NULL',    @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMTObject_Validate_Owner.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Owner
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Owner_twRPersonaIx IS NULL
               EXEC dbo.call_Error 21, 'Owner_twRPersonaIx is NULL',    @nError OUTPUT
       ELSE IF @Owner_twRPersonaIx NOT BETWEEN 1 AND 0x0000FFFFFFFFFFFC
               EXEC dbo.call_Error 21, 'Owner_twRPersonaIx is invalid', @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                    MVD_RP1_Map : call_RMTObject_Validate_Properties.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Properties
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Properties_bLockToGround IS NULL
               EXEC dbo.call_Error 21, 'Properties_bLockToGround is NULL',    @nError OUTPUT
       ELSE IF @Properties_bLockToGround NOT BETWEEN 0 AND 1
               EXEC dbo.call_Error 21, 'Properties_bLockToGround is invalid', @nError OUTPUT

            IF @Properties_bYouth IS NULL
               EXEC dbo.call_Error 21, 'Properties_bYouth is NULL',           @nError OUTPUT
       ELSE IF @Properties_bYouth NOT BETWEEN 0 AND 1
               EXEC dbo.call_Error 21, 'Properties_bYouth is invalid',        @nError OUTPUT

            IF @Properties_bAdult IS NULL
               EXEC dbo.call_Error 21, 'Properties_bAdult is NULL',           @nError OUTPUT
       ELSE IF @Properties_bAdult NOT BETWEEN 0 AND 1
               EXEC dbo.call_Error 21, 'Properties_bAdult is invalid',        @nError OUTPUT

            IF @Properties_bAvatar IS NULL
               EXEC dbo.call_Error 21, 'Properties_bAvatar is NULL',          @nError OUTPUT
       ELSE IF @Properties_bAvatar NOT BETWEEN 0 AND 1
               EXEC dbo.call_Error 21, 'Properties_bAvatar is invalid',       @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMTObject_Validate_Resource.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Resource
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Resource_qwResource IS NULL
               EXEC dbo.call_Error 21, 'Resource_qwResource is NULL', @nError OUTPUT
            IF @Resource_sName IS NULL
               EXEC dbo.call_Error 21, 'Resource_sName is NULL',      @nError OUTPUT
            IF @Resource_sReference IS NULL
               EXEC dbo.call_Error 21, 'Resource_sReference is NULL', @nError OUTPUT

            -- do we want to check sName and sReference for length or invalid characters

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMTObject_Validate_Transform.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Transform
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72

            IF @Transform_Position_dX IS NULL OR @Transform_Position_dX <> @Transform_Position_dX
               EXEC dbo.call_Error 21, 'Transform_Position_dX is NULL or NaN', @nError OUTPUT
            IF @Transform_Position_dY IS NULL OR @Transform_Position_dY <> @Transform_Position_dY
               EXEC dbo.call_Error 21, 'Transform_Position_dY is NULL or NaN', @nError OUTPUT
            IF @Transform_Position_dZ IS NULL OR @Transform_Position_dZ <> @Transform_Position_dZ
               EXEC dbo.call_Error 21, 'Transform_Position_dZ is NULL or NaN', @nError OUTPUT

            IF @Transform_Rotation_dX IS NULL OR @Transform_Rotation_dX <> @Transform_Rotation_dX
               EXEC dbo.call_Error 21, 'Transform_Rotation_dX is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dY IS NULL OR @Transform_Rotation_dY <> @Transform_Rotation_dY
               EXEC dbo.call_Error 21, 'Transform_Rotation_dY is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dZ IS NULL OR @Transform_Rotation_dZ <> @Transform_Rotation_dZ
               EXEC dbo.call_Error 21, 'Transform_Rotation_dZ is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dW IS NULL OR @Transform_Rotation_dW <> @Transform_Rotation_dW
               EXEC dbo.call_Error 21, 'Transform_Rotation_dW is NULL or NaN', @nError OUTPUT

            IF @Transform_Scale_dX    IS NULL OR @Transform_Scale_dX    <> @Transform_Scale_dX
               EXEC dbo.call_Error 21, 'Transform_Scale_dX    is NULL or NaN', @nError OUTPUT
            IF @Transform_Scale_dY    IS NULL OR @Transform_Scale_dY    <> @Transform_Scale_dY
               EXEC dbo.call_Error 21, 'Transform_Scale_dY    is NULL or NaN', @nError OUTPUT
            IF @Transform_Scale_dZ    IS NULL OR @Transform_Scale_dZ    <> @Transform_Scale_dZ
               EXEC dbo.call_Error 21, 'Transform_Scale_dZ    is NULL or NaN', @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate position is inside parent's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMTObject_Validate_Type.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMTObject_Validate_Type
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMTObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @MVO_RMCOBJECT_TYPE_SURFACE                INT = 17

       DECLARE @Parent_bType    TINYINT,
               @Parent_bSubtype TINYINT,
               @Self_bType      TINYINT,
               @Self_bSubtype   TINYINT

            IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMCOBJECT
         BEGIN
                 SELECT @Parent_bType    = Type_bType
                   FROM dbo.RMCObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @ObjectHead_Parent_twObjectIx
           END
       ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT
         BEGIN
                 SELECT @Parent_bType    = Type_bType,
                        @Parent_bSubtype = Type_bSubtype
                   FROM dbo.RMTObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @ObjectHead_Parent_twObjectIx
           END

            IF @twRMTObjectIx > 0
         BEGIN
                 SELECT @Self_bType    = Type_bType,
                        @Self_bSubtype = Type_bSubtype
                   FROM dbo.RMTObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx
-- get max children's type and subtype

           END

-- attachment points can't have cildren

            IF @Type_bType IS NULL
               EXEC dbo.call_Error 21, 'Type_bType is NULL',       @nError OUTPUT

            IF @Type_bSubtype IS NULL
               EXEC dbo.call_Error 21, 'Type_bSubtype is NULL',    @nError OUTPUT

            IF @Type_bFiction IS NULL
               EXEC dbo.call_Error 21, 'Type_bFiction is NULL',    @nError OUTPUT
       ELSE IF @Type_bFiction NOT BETWEEN 0 AND 1
               EXEC dbo.call_Error 21, 'Type_bFiction is invalid', @nError OUTPUT

            IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMCOBJECT  AND  @Parent_bType <> @MVO_RMCOBJECT_TYPE_SURFACE
               EXEC dbo.call_Error 21, 'Parent''s Type_bType must be equal to SURFACE when its parent''s class is RMCOBJECT', @nError OUTPUT
       ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT  AND  @Type_bType < @Parent_bType
               EXEC dbo.call_Error 21, 'Type_bType must be greater than or equal to its parent''s Type_bType', @nError OUTPUT
       ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMTOBJECT  AND  @Type_bType = @Parent_bType  AND  @Type_bSubtype <= @Parent_bSubtype
               EXEC dbo.call_Error 21, 'Type_bSubtype must be greater than its parent''s Type_bType', @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : get_RMTObject.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

/*
*/

CREATE PROCEDURE dbo.get_RMTObject
(
   @sIPAddress                   NVARCHAR (16),
   @twRMTObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @MVO_RMTOBJECT_TYPE_PARCEL                 INT = 11

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @bError  INT = 0,
               @bCommit INT = 0,
               @nError  INT

            -- Create the temp Results table
        SELECT * INTO #Results FROM dbo.Table_Results ()

         BEGIN TRANSACTION

--        EXEC @nError = dbo.call_
           SET @nError = 0
            IF @nError = 0
         BEGIN
                  -- validate input

               DECLARE @bType TINYINT

               SELECT @bType = Type_bType
                 FROM dbo.RMTObject
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                   IF @bType IS NULL
                      SET @bError = 1

                  IF (@bError = 0)
               BEGIN
                     INSERT #Results
                     SELECT 0,
                            ObjectHead_Self_twObjectIx
                       FROM dbo.RMTObject
                      WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                         IF @bType <> @MVO_RMTOBJECT_TYPE_PARCEL
                      BEGIN
                            INSERT #Results
                            SELECT 1,
                                   ObjectHead_Self_twObjectIx
                              FROM dbo.RMTObject
                             WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMTOBJECT
                               AND ObjectHead_Parent_twObjectIx = @twRMTObjectIx
                        END
                       ELSE
                      BEGIN
                            INSERT #Results
                            SELECT 1,
                                   ObjectHead_Self_twObjectIx
                              FROM dbo.RMPObject
                             WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMTOBJECT
                               AND ObjectHead_Parent_twObjectIx = @twRMTObjectIx
                        END

                       EXEC dbo.call_RMTObject_Select 0
                         IF @bType <> @MVO_RMTOBJECT_TYPE_PARCEL
                            EXEC dbo.call_RMTObject_Select 1
                       ELSE EXEC dbo.call_RMPObject_Select 1

                        SET @bCommit = 1
                 END
           END

            IF (@bCommit = 0)
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - @bError - 1
  END
GO

GRANT EXECUTE ON dbo.get_RMTObject TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : get_RMTObject_Update.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.get_RMTObject_Update
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @MVO_RMTOBJECT_TYPE_PARCEL                 INT = 11

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0

            -- Create the temp Results table
        SELECT * INTO #Results FROM dbo.Table_Results ()

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

            IF @twRPersonaIx < 0
               EXEC dbo.call_Error 1,  'Session is invalid', @nError OUTPUT

            IF @twRMTObjectIx <= 0
               EXEC dbo.call_Error 2,  'TObject is invalid', @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @bType TINYINT

                 SELECT @bType = t.Type_bType
                   FROM dbo.RMTObject AS t
                  WHERE t.ObjectHead_Self_twObjectIx = @twRMTObjectIx

                 INSERT #Results
                 SELECT 0,
                        t.ObjectHead_Self_twObjectIx
                   FROM dbo.RMTObject AS t
                  WHERE t.ObjectHead_Self_twObjectIx = @twRMTObjectIx

                     IF @@ROWCOUNT = 1  AND  @bType IS NOT NULL
                  BEGIN
                              IF @bType <> @MVO_RMTOBJECT_TYPE_PARCEL
                           BEGIN
                                   INSERT #Results
                                   SELECT 1,
                                          x.ObjectHead_Self_twObjectIx
                                     FROM dbo.RMTObject AS t
                                     JOIN dbo.RMTObject AS x ON x.ObjectHead_Parent_wClass     = t.ObjectHead_Self_wClass
                                                            AND x.ObjectHead_Parent_twObjectIx = t.ObjectHead_Self_twObjectIx
                                    WHERE t.ObjectHead_Self_twObjectIx = @twRMTObjectIx
                                 ORDER BY x.ObjectHead_Self_twObjectIx ASC
                             END
                            ELSE
                           BEGIN
                                   INSERT #Results
                                   SELECT 1,
                                          p.ObjectHead_Self_twObjectIx
                                     FROM dbo.RMTObject AS t
                                     JOIN dbo.RMPObject AS p ON p.ObjectHead_Parent_wClass     = t.ObjectHead_Self_wClass
                                                            AND p.ObjectHead_Parent_twObjectIx = t.ObjectHead_Self_twObjectIx
                                    WHERE t.ObjectHead_Self_twObjectIx = @twRMTObjectIx
                                 ORDER BY p.ObjectHead_Self_twObjectIx ASC
                             END
             
                            EXEC dbo.call_RMTObject_Select 0
                              IF @bType <> @MVO_RMTOBJECT_TYPE_PARCEL
                                 EXEC dbo.call_RMTObject_Select 1
                            ELSE EXEC dbo.call_RMPObject_Select 1
             
                             SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error 3,  'TObject does not exist', @nError OUTPUT
           END

            IF @bCommit = 0
               SELECT dwError, sError FROM #Error

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.get_RMTObject_Update TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : search_RMTObject.sql                                             **
**                                                                                                                             **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.search_RMTObject
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @dX                           FLOAT (53),
   @dY                           FLOAT (53),
   @dZ                           FLOAT (53),
   @sText                        NVARCHAR (48)
)
AS
BEGIN
            SET NOCOUNT ON

       DECLARE @MVO_RMTOBJECT_TYPE_COMMUNITY              INT = 9
       DECLARE @MVO_RMTOBJECT_TYPE_PARCEL                 INT = 11

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @bError  INT = 0,
               @bCommit INT = 0,
               @nError  INT

        DECLARE @bType   TINYINT,
                @dRange  FLOAT (53),
                @nCount  INT = 0

         SELECT @bType = Type_bType
           FROM dbo.RMTObject
          WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

             IF @bType IS NULL
                SET @bError = 1

             IF @bError = 0
          BEGIN
                  SET @sText = RTRIM (LTRIM (ISNULL (@sText, '')))

                   IF @sText <> ''
                BEGIN
                            -- positions must be normalized to the surface

                       DECLARE @dRadius FLOAT (53) = 6371000 -- where do we get this?
                       DECLARE @dNormal FLOAT (53) = @dRadius / SQRT ((@dX * @dX) + (@dY * @dY) + (@dZ * @dZ))

                           SET @dX *= @dNormal
                           SET @dY *= @dNormal
                           SET @dZ *= @dNormal

                       DECLARE @Result TABLE
                                       (
                                          nOrder                          INT         IDENTITY (0, 1),
                                          ObjectHead_Self_twObjectIx      BIGINT,
                                          dFactor                         FLOAT (53),
                                          dDistance                       FLOAT (53)
                                       )

                        INSERT @Result
                             (
                               ObjectHead_Self_twObjectIx, 
                               dFactor,
                               dDistance
                             )
                        SELECT TOP 10
                               o.ObjectHead_Self_twObjectIx, 
                               f.dFactor, 
                               d.dDistance
                          FROM dbo.RMTObject AS o
                          JOIN dbo.RMTMatrix AS m ON m.bnMatrix = o.ObjectHead_Self_twObjectIx
                   CROSS APPLY (SELECT POWER (CAST (4.0 AS FLOAT (53)), o.Type_bType - 7)           AS dFactor  ) AS f
                   CROSS APPLY (SELECT dbo.ArcLength (@dRadius, @dX, @dY, @dZ, m.d03, m.d13, m.d23) AS dDistance) AS d

                         WHERE o.Name_wsRMTObjectId LIKE @sText + '%'
                           AND    (o.Type_bType      BETWEEN @bType + 1 AND @MVO_RMTOBJECT_TYPE_COMMUNITY
                               OR  o.Type_bType                           = @MVO_RMTOBJECT_TYPE_PARCEL)
                      ORDER BY f.dFactor * d.dDistance, o.Name_wsRMTObjectId

                        SELECT o.ObjectHead_Parent_wClass     AS ObjectHead_wClass_Parent,  -- change client to new names
                               o.ObjectHead_Parent_twObjectIx AS ObjectHead_twParentIx,     -- change client to new names
                               o.ObjectHead_Self_wClass       AS ObjectHead_wClass_Object,  -- change client to new names
                               o.ObjectHead_Self_twObjectIx   AS ObjectHead_twObjectIx,     -- change client to new names
                               o.ObjectHead_wFlags,
                               o.ObjectHead_twEventIz,
                               o.Name_wsRMTObjectId,
                               o.Type_bType,
                               o.Type_bSubtype,
                               o.Type_bFiction,
                               r.nOrder,
                               r.dFactor,
                               r.dDistance
                          FROM dbo.RMTObject AS o
                          JOIN @Result       AS r ON r.ObjectHead_Self_twObjectIx = o.ObjectHead_Self_twObjectIx
                      ORDER BY r.nOrder

                            -- select also all of the ancestors of the result set

                        ; WITH Tree AS
                               (
                                 SELECT oa.ObjectHead_Parent_wClass,
                                        oa.ObjectHead_Parent_twObjectIx,
                                        oa.ObjectHead_Self_wClass,
                                        oa.ObjectHead_Self_twObjectIx,
                                        r.nOrder,
                                        0                               AS nAncestor
                                   FROM dbo.RMTObject AS oa
                                   JOIN @Result       AS r  ON r.ObjectHead_Self_twObjectIx = oa.ObjectHead_Self_twObjectIx
 
                                  UNION ALL
 
                                 SELECT ob.ObjectHead_Parent_wClass,
                                        ob.ObjectHead_Parent_twObjectIx,
                                        ob.ObjectHead_Self_wClass,
                                        ob.ObjectHead_Self_twObjectIx,
                                        x.nOrder,
                                        x.nAncestor + 1                 AS nAncestor
                                   FROM dbo.RMTObject AS ob
                                   JOIN Tree          AS x  ON x.ObjectHead_Parent_twObjectIx = ob.ObjectHead_Self_twObjectIx
                                                           AND x.ObjectHead_Parent_wClass     = ob.ObjectHead_Self_wClass
                               )
                        SELECT o.ObjectHead_Parent_wClass     AS ObjectHead_wClass_Parent,  -- change client to new names
                               o.ObjectHead_Parent_twObjectIx AS ObjectHead_twParentIx,     -- change client to new names
                               o.ObjectHead_Self_wClass       AS ObjectHead_wClass_Object,  -- change client to new names
                               o.ObjectHead_Self_twObjectIx   AS ObjectHead_twObjectIx,     -- change client to new names
                               o.ObjectHead_wFlags,
                               o.ObjectHead_twEventIz,
                               o.Name_wsRMTObjectId,
                               o.Type_bType,
                               o.Type_bSubtype,
                               o.Type_bFiction,
                               x.nOrder,
                               x.nAncestor
                          FROM dbo.RMTObject AS o
                          JOIN Tree          AS x ON x.ObjectHead_Self_twObjectIx = o.ObjectHead_Self_twObjectIx
                         WHERE x.nAncestor > 0
                      ORDER BY x.nOrder,
                               x.nAncestor

                  END
                 ELSE
                BEGIN
                        SELECT TOP 0 NULL AS Unused
                        SELECT TOP 0 NULL AS Unused
                  END

                  SET @bCommit = 1
            END
           ELSE EXEC dbo.call_Error 1, 'twRMTObjectIx is invalid'

             IF @bCommit = 0
                  SELECT dwError, sError FROM #Error

         RETURN @bCommit - @bError - 1
  END
GO

GRANT EXECUTE ON dbo.search_RMTObject TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMTObject_Bound.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Bound
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @RMTOBJECT_OP_BOUND                        INT = 8

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Bound @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_Bound @twRMTObjectIx, @Bound_dX, @Bound_dY, @Bound_dZ
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_BOUND, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Bound TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : set_RMTObject_Fabric_Close.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Fabric_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
-- @twRMTObjectIx                BIGINT,
   @twRMPObjectIx_Close          BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
        -- SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @MVO_RMTOBJECT_TYPE_PARCEL                 INT = 11
       DECLARE @RMTOBJECT_OP_RMTOBJECT_CLOSE              INT = 15

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Grand_wClass      SMALLINT,
               @ObjectHead_Grand_twObjectIx  BIGINT,
               @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT,
               @ObjectHead_Self_wClass       SMALLINT,
               @ObjectHead_Self_twObjectIx   BIGINT,
               @Type_bType                   TINYINT,
               @Type_bSubtype                TINYINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

        SELECT @ObjectHead_Grand_wClass      = t.ObjectHead_Parent_wClass,
               @ObjectHead_Grand_twObjectIx  = t.ObjectHead_Parent_twObjectIx,
               @ObjectHead_Parent_wClass     = t.ObjectHead_Self_wClass,
               @ObjectHead_Parent_twObjectIx = t.ObjectHead_Self_twObjectIx,
               @Type_bType                   = t.Type_bType,
               @ObjectHead_Self_wClass       = p.ObjectHead_Self_wClass,
               @ObjectHead_Self_twObjectIx   = p.ObjectHead_Self_twObjectIx,
               @Type_bSubtype                = p.Type_bSubtype
          FROM dbo.RMPObject AS p
          JOIN dbo.RMTObject AS t  ON t.ObjectHead_Self_wClass     = p.ObjectHead_Parent_wClass
                                  AND t.ObjectHead_Self_twObjectIx = p.ObjectHead_Parent_twObjectIx
         WHERE p.ObjectHead_Self_wClass     = @SBO_CLASS_RMPOBJECT
           AND p.ObjectHead_Self_twObjectIx = @twRMPObjectIx_Close

            IF @ObjectHead_Grand_wClass IS NULL
               EXEC dbo.call_Error 1, 'Unknown Object', @nError OUTPUT
       ELSE IF @ObjectHead_Grand_wClass <> @SBO_CLASS_RMTOBJECT  OR  @ObjectHead_Parent_wClass <> @SBO_CLASS_RMTOBJECT  OR  @Type_bType <> @MVO_RMTOBJECT_TYPE_PARCEL
               EXEC dbo.call_Error 2, 'Invalid Object', @nError OUTPUT
       ELSE IF @Type_bSubtype <> 255
               EXEC dbo.call_Error 3, 'Invalid Object', @nError OUTPUT

      -- EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_RMPObject_Close @ObjectHead_Parent_twObjectIx, @twRMPObjectIx_Close, 0
                     IF @bError = 0
                  BEGIN
                            EXEC @bError = dbo.call_RMTObject_Event_RMTObject_Close @ObjectHead_Grand_twObjectIx, @ObjectHead_Parent_twObjectIx
                              IF @bError = 0
                           BEGIN
                                      SET @bCommit = 1
                             END
                            ELSE EXEC dbo.call_Error -1, 'Failed to delete RMTObject'
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RMTOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @ObjectHead_Grand_twObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Fabric_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : set_RMTObject_Fabric_Configure.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Fabric_Configure
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
-- @twRMTObjectIx                BIGINT,
   @twRMPObjectIx_Configure      BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
        -- SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

/*
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @MVO_RMTOBJECT_TYPE_PARCEL                 INT = 11
       DECLARE @RMTOBJECT_OP_RMTOBJECT_CLOSE              INT = 15

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Grand_wClass      SMALLINT,
               @ObjectHead_Grand_twObjectIx  BIGINT,
               @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT,
               @ObjectHead_Self_wClass       SMALLINT,
               @ObjectHead_Self_twObjectIx   BIGINT,
               @Type_bType                   TINYINT,
               @Type_bSubtype                TINYINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

        SELECT @ObjectHead_Grand_wClass      = t.ObjectHead_Parent_wClass,
               @ObjectHead_Grand_twObjectIx  = t.ObjectHead_Parent_twObjectIx,
               @ObjectHead_Parent_wClass     = t.ObjectHead_Self_wClass,
               @ObjectHead_Parent_twObjectIx = t.ObjectHead_Self_twObjectIx,
               @Type_bType                   = t.Type_bType,
               @ObjectHead_Self_wClass       = p.ObjectHead_Self_wClass,
               @ObjectHead_Self_twObjectIx   = p.ObjectHead_Self_twObjectIx,
               @Type_bSubtype                = p.Type_bSubtype
          FROM dbo.RMPObject AS p
          JOIN dbo.RMTObject AS t  ON t.ObjectHead_Self_wClass     = p.ObjectHead_Parent_wClass
                                  AND t.ObjectHead_Self_twObjectIx = p.ObjectHead_Parent_twObjectIx
         WHERE p.ObjectHead_Self_wClass     = @SBO_CLASS_RMPOBJECT
           AND p.ObjectHead_Self_twObjectIx = @twRMPObjectIx_Close

            IF @ObjectHead_Grand_wClass IS NULL
               EXEC dbo.call_Error 1, 'Unknown Object', @nError OUTPUT
       ELSE IF @ObjectHead_Grand_wClass <> @SBO_CLASS_RMTOBJECT  OR  @ObjectHead_Parent_wClass <> @SBO_CLASS_RMTOBJECT  OR  @Type_bType <> @MVO_RMTOBJECT_TYPE_PARCEL
               EXEC dbo.call_Error 2, 'Invalid Object', @nError OUTPUT
       ELSE IF @Type_bSubtype <> 255
               EXEC dbo.call_Error 3, 'Invalid Object', @nError OUTPUT

      -- EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_RMPObject_Close @ObjectHead_Parent_twObjectIx, @twRMPObjectIx_Close, 0
                     IF @bError = 0
                  BEGIN
                            EXEC @bError = dbo.call_RMTObject_Event_RMTObject_Close @ObjectHead_Grand_twObjectIx, @ObjectHead_Parent_twObjectIx
                              IF @bError = 0
                           BEGIN
                                      SET @bCommit = 1
                             END
                            ELSE EXEC dbo.call_Error -1, 'Failed to delete RMTObject'
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RMTOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @ObjectHead_Grand_twObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
*/
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Fabric_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : set_RMTObject_Fabric_Open_Earth.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Fabric_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
-- @twRMTObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
-- @Type_bSubtype                TINYINT,
-- @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
-- @Properties_bLockToGround     TINYINT,
-- @Properties_bYouth            TINYINT,
-- @Properties_bAdult            TINYINT,
-- @Properties_bAvatar           TINYINT,
   @Transform_Rotate             FLOAT (53),
   @bCoord                       TINYINT,
   @dA                           FLOAT (53),
   @dB                           FLOAT (53),
   @dC                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
        -- SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

           SET @Bound_dY      = (@Bound_dX + @Bound_dZ) / 4.0
           SET @dC            = 6371000.0

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @MVO_RMTOBJECT_TYPE_PARCEL                 INT = 11
       DECLARE @RMTOBJECT_OP_RMTOBJECT_OPEN               INT = 14
       DECLARE @RMTMATRIX_COORD_NUL                       INT = 0
       DECLARE @RMTMATRIX_COORD_CAR                       INT = 1
       DECLARE @RMTMATRIX_COORD_CYL                       INT = 2
       DECLARE @RMTMATRIX_COORD_GEO                       INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

    -- DECLARE @ObjectHead_Parent_wClass     SMALLINT,
    --         @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMTObjectIx        BIGINT = 0,
               @twRMTObjectIx_Open   BIGINT,
               @twRMPObjectIx_Open   BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

/*
   validate the input
   find a parcel parent
      determine which bounding box(es) contain that coordinate (with type < parcel)
      pick the one with the largest type
      select the closest
   create a parcel (TObject)
   create an attachment point (PObject)
   return the attachment point object index

*/
      -- EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Name       @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Name_wsRMTObjectId, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Type       @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Owner      @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Resource   @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Transform  @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Bound      @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Properties @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @nError OUTPUT

                     IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                        EXEC dbo.call_RMTObject_Validate_Coord_Nul @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                        EXEC dbo.call_RMTObject_Validate_Coord_Car @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                        EXEC dbo.call_RMTObject_Validate_Coord_Cyl @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                        EXEC dbo.call_RMTObject_Validate_Coord_Geo @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                   ELSE EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
           END

            IF @nError = 0  AND  @bCoord = 0 -- @RMTMATRIX_COORD_GEO
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMTSubsurface AS s
                   JOIN dbo.RMTObject     AS o ON o.ObjectHead_Self_twObjectIx = s.twRMTObjectIx
                  WHERE o.Type_bType = 11
                    AND 2 * @dC * ASIN (SQRT (SQUARE (SIN ((RADIANS (s.dA) - RADIANS (@dA)) / 2)) + (COS (RADIANS (s.dA)) * COS (RADIANS (@dA)) * SQUARE (SIN ((RADIANS (s.dB) - RADIANS (@dB)) / 2))))) < IIF (o.Bound_dX > o.Bound_dZ, o.Bound_dX, o.Bound_dZ) + IIF (@Bound_dX > @Bound_dZ, @Bound_dX, @Bound_dZ)

                     IF @nCount > 0
                        EXEC dbo.call_Error 97, 'Parcel overlaps with another parcel', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                     IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                        EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
                ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                        EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
                ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                        EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
                ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                        EXEC @twRMTObjectIx = dbo.call_RMTObject_Parent_Geo @dA, @dB, @dC
                   ELSE EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT

                     IF @twRMTObjectIx = 0
                        EXEC dbo.call_Error 98, 'Coordinate is not within a mapped land area', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_RMTObject_Open @twRMTObjectIx, @Name_wsRMTObjectId, @MVO_RMTOBJECT_TYPE_PARCEL, 0, 0,  1,  0, '', '',  0, 0, 0,  0, 0, 0, 1,  1, 1, 1,  @Bound_dX, @Bound_dY, @Bound_dZ,  0, 0, 0, 0,  @twRMTObjectIx_Open OUTPUT
                     IF @bError = 0
                  BEGIN
                              IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                                 EXEC dbo.call_RMTMatrix_Nul @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, @twRMTObjectIx_Open,  @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                         ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                                 EXEC dbo.call_RMTMatrix_Car                                       @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                                 EXEC dbo.call_RMTMatrix_Cyl                                       @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                                 EXEC dbo.call_RMTMatrix_Geo                                       @twRMTObjectIx_Open, @dA, @dB, @dC

                            EXEC dbo.call_RMTMatrix_Relative @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, @twRMTObjectIx_Open

                          SELECT @Transform_Rotation_dX = 0,
                                 @Transform_Rotation_dY = SIN (RADIANS (@Transform_Rotate) * 0.5),
                                 @Transform_Rotation_dZ = 0,
                                 @Transform_Rotation_dW = COS (RADIANS (@Transform_Rotate) * 0.5)

                            EXEC @bError = dbo.call_RMTObject_Event_RMPObject_Open @twRMTObjectIx_Open, '', @Type_bType, 255, 0, 0,  @Owner_twRPersonaIx,  @Resource_qwResource, @Resource_sName, @Resource_sReference,  0, 0, 0,  @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW,  1, 1, 1,  @Bound_dX, @Bound_dY, @Bound_dZ,  @twRMPObjectIx_Open OUTPUT, 0
                              IF @bError = 0
                           BEGIN
                                   SELECT @SBO_CLASS_RMPOBJECT AS wClass,
                                          @twRMPObjectIx_Open  AS twRMPObjectIx
   
                                      SET @bCommit = 1
                             END
                            ELSE EXEC dbo.call_Error -1, 'Failed to insert RMPObject'
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RMTOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Fabric_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : set_RMTObject_Fabric_Open_Misc.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Fabric_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
-- @twRMTObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
-- @Type_bSubtype                TINYINT,
-- @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
-- @Properties_bLockToGround     TINYINT,
-- @Properties_bYouth            TINYINT,
-- @Properties_bAdult            TINYINT,
-- @Properties_bAvatar           TINYINT,
   @Transform_Rotate             FLOAT (53),
   @bCoord                       TINYINT,
   @dA                           FLOAT (53),
   @dB                           FLOAT (53),
   @dC                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
        -- SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

           SET @Bound_dY      = (@Bound_dX + @Bound_dZ) / 4.0
           SET @dC            = 6371000.0

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @MVO_RMTOBJECT_TYPE_PARCEL                 INT = 11
       DECLARE @RMTOBJECT_OP_RMTOBJECT_OPEN               INT = 14
       DECLARE @RMTMATRIX_COORD_NUL                       INT = 0
       DECLARE @RMTMATRIX_COORD_CAR                       INT = 1
       DECLARE @RMTMATRIX_COORD_CYL                       INT = 2
       DECLARE @RMTMATRIX_COORD_GEO                       INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

    -- DECLARE @ObjectHead_Parent_wClass     SMALLINT,
    --         @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMTObjectIx        BIGINT = 0,
               @twRMTObjectIx_Open   BIGINT,
               @twRMPObjectIx_Open   BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

/*
   validate the input
   find a parcel parent
      determine which bounding box(es) contain that coordinate (with type < parcel)
      pick the one with the largest type
      select the closest
   create a parcel (TObject)
   create an attachment point (PObject)
   return the attachment point object index

*/
      -- EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Name       @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Name_wsRMTObjectId, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Type       @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Owner      @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Resource   @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Transform  @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Bound      @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Properties @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @nError OUTPUT

                     IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                        EXEC dbo.call_RMTObject_Validate_Coord_Nul @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                        EXEC dbo.call_RMTObject_Validate_Coord_Car @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                        EXEC dbo.call_RMTObject_Validate_Coord_Cyl @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                        EXEC dbo.call_RMTObject_Validate_Coord_Geo @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                   ELSE EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                     IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                        EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
                ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                        EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
                ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                        EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
                ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                        EXEC @twRMTObjectIx = dbo.call_RMTObject_Parent_Geo @dA, @dB, @dC
                   ELSE EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT

                     IF @twRMTObjectIx = 0
                        EXEC dbo.call_Error 98, 'Coordinate is not within a mapped land area', @nError OUTPUT
           END

            IF @nError = 0  AND  @bCoord = 0 -- @RMTMATRIX_COORD_GEO
         BEGIN
                DECLARE @nCount INT

                 SELECT COUNT (*)
                   FROM dbo.RMTSubsurface AS s
                   JOIN dbo.RMTObject     AS o ON o.ObjectHead_Self_twObjectIx = s.twRMTObjectIx
                  WHERE o.Type_bType = 11
                    AND 2 * @dC * ASIN (SQRT (SQUARE (SIN ((RADIANS (s.dA) - RADIANS (@dA)) / 2)) + (COS (RADIANS (s.dA)) * COS (RADIANS (@dA)) * SQUARE (SIN ((RADIANS (s.dB) - RADIANS (@dB)) / 2))))) < IIF (o.Bound_dX > o.Bound_dZ, o.Bound_dX, o.Bound_dZ) + IIF (@Bound_dX > @Bound_dZ, @Bound_dX, @Bound_dZ)

                     IF @nCount > 0
                        EXEC dbo.call_Error 97, 'Parcel overlaps with another parcel', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_RMTObject_Open @twRMTObjectIx,  @Name_wsRMTObjectId,  @MVO_RMTOBJECT_TYPE_PARCEL, 0, 0,  1,  0, '', '',  0, 0, 0,  0, 0, 0, 1,  1, 1, 1,  @Bound_dX, @Bound_dY, @Bound_dZ,  0, 0, 0, 0,  @twRMTObjectIx_Open OUTPUT
                     IF @bError = 0
                  BEGIN
                              IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                                 EXEC dbo.call_RMTMatrix_Nul @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, @twRMTObjectIx_Open,  @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                         ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                                 EXEC dbo.call_RMTMatrix_Car                                       @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                                 EXEC dbo.call_RMTMatrix_Cyl                                       @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                                 EXEC dbo.call_RMTMatrix_Geo                                       @twRMTObjectIx_Open, @dA, @dB, @dC

                            EXEC dbo.call_RMTMatrix_Relative @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, @twRMTObjectIx_Open

                          SELECT @Transform_Rotation_dX = 0,
                                 @Transform_Rotation_dY = SIN (RADIANS (@Transform_Rotate) * 0.5),
                                 @Transform_Rotation_dZ = 0,
                                 @Transform_Rotation_dW = COS (RADIANS (@Transform_Rotate) * 0.5)

                            EXEC @bError = dbo.call_RMTObject_Event_RMPObject_Open @twRMTObjectIx_Open,  @Type_bType, 255, 0, 0,  @Owner_twRPersonaIx,  @Resource_qwResource, @Resource_sName, @Resource_sReference,  0, 0, 0,  @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW,  1, 1, 1,  @Bound_dX, @Bound_dY, @Bound_dZ,  @twRMPObjectIx_Open OUTPUT, 0
                              IF @bError = 0
                           BEGIN
                                   SELECT @SBO_CLASS_RMPOBJECT AS wClass,
                                          @twRMPObjectIx_Open  AS twRMPObjectIx
   
                                      SET @bCommit = 1
                             END
                            ELSE EXEC dbo.call_Error -1, 'Failed to insert RMPObject'
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RMTOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Fabric_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMTObject_Name.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Name
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @RMTOBJECT_OP_NAME                         INT = 1

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Name @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Name_wsRMTObjectId, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_Name @twRMTObjectIx, @Name_wsRMTObjectId
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_NAME, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Name TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMTObject_Owner.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Owner
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @RMTOBJECT_OP_OWNER                        INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Owner @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Owner_twRPersonaIx, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_Owner @twRMTObjectIx, @Owner_twRPersonaIx
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_OWNER, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Owner TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : set_RMTObject_Properties.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Properties
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @RMTOBJECT_OP_PROPERTIES                   INT = 9

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Properties @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_Properties @twRMTObjectIx, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_PROPERTIES, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Properties TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : set_RMTObject_Resource.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Resource
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @RMTOBJECT_OP_RESOURCE                     INT = 4

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Resource @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_Resource @twRMTObjectIx, @Resource_qwResource, @Resource_sName, @Resource_sReference
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RESOURCE, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Resource TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMTObject_RMPObject_Close.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_RMPObject_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @twRMPObjectIx_Close          BIGINT,
   @bDeleteAll                   TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx        = ISNULL (@twRPersonaIx,        0)
           SET @twRMTObjectIx       = ISNULL (@twRMTObjectIx,       0)
           SET @twRMPObjectIx_Close = ISNULL (@twRMPObjectIx_Close, 0)

       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @RMTOBJECT_OP_RMPOBJECT_CLOSE              INT = 17

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMPObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMPOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMPObjectIx_Close

                     IF @twRMPObjectIx_Close <= 0
                        EXEC dbo.call_Error 5,  'twRMPObjectIx_Close is invalid',   @nError OUTPUT
                ELSE IF @bDeleteAll = 0  AND  @nCount > 0
                        EXEC dbo.call_Error 6,  'twRMPObjectIx_Close is not empty', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_RMPObject_Close @twRMTObjectIx, @twRMPObjectIx_Close, 0
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RMPOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_RMPObject_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMTObject_RMPObject_Open.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_RMPObject_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @RMTOBJECT_OP_RMPOBJECT_OPEN               INT = 16

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMPObjectIx_Open           BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Name      @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Name_wsRMPObjectId, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Type      @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Owner     @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Resource  @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Transform @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Bound     @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_RMPObject_Open @twRMTObjectIx, @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @twRMPObjectIx_Open OUTPUT, 0
                     IF @bError = 0
                  BEGIN
                        SELECT @twRMPObjectIx_Open AS twRMPObjectIx
   
                           SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RMPOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_RMPObject_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMTObject_RMTObject_Close.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_RMTObject_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @twRMTObjectIx_Close          BIGINT,
   @bDeleteAll                   TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx        = ISNULL (@twRPersonaIx,        0)
           SET @twRMTObjectIx       = ISNULL (@twRMTObjectIx,       0)
           SET @twRMTObjectIx_Close = ISNULL (@twRMTObjectIx_Close, 0)

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @RMTOBJECT_OP_RMTOBJECT_CLOSE              INT = 15

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMTObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMTOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMTObjectIx_Close

                 SELECT @nCount += COUNT (*)
                   FROM dbo.RMPObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMTOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMTObjectIx_Close

                     IF @twRMTObjectIx_Close <= 0
                        EXEC dbo.call_Error 5,  'twRMTObjectIx_Close is invalid',   @nError OUTPUT
                ELSE IF @bDeleteAll = 0  AND  @nCount > 0
                        EXEC dbo.call_Error 6,  'twRMTObjectIx_Close is not empty', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_RMTObject_Close @twRMTObjectIx, @twRMTObjectIx_Close
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RMTOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_RMTObject_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMTObject_RMTObject_Open.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_RMTObject_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT,
   @bCoord                       TINYINT,
   @dA                           FLOAT (53),
   @dB                           FLOAT (53),
   @dC                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @RMTOBJECT_OP_RMTOBJECT_OPEN               INT = 14
       DECLARE @RMTMATRIX_COORD_NUL                       INT = 0
       DECLARE @RMTMATRIX_COORD_CAR                       INT = 1
       DECLARE @RMTMATRIX_COORD_CYL                       INT = 2
       DECLARE @RMTMATRIX_COORD_GEO                       INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMTObjectIx_Open   BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Name       @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Name_wsRMTObjectId, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Type       @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Owner      @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Resource   @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Transform  @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Bound      @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Properties @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @nError OUTPUT

                     IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                        EXEC dbo.call_RMTObject_Validate_Coord_Nul @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                        EXEC dbo.call_RMTObject_Validate_Coord_Car @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                        EXEC dbo.call_RMTObject_Validate_Coord_Cyl @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                        EXEC dbo.call_RMTObject_Validate_Coord_Geo @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                   ELSE EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_RMTObject_Open @twRMTObjectIx, @Name_wsRMTObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @twRMTObjectIx_Open OUTPUT
                     IF @bError = 0
                  BEGIN
                              IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                                 EXEC dbo.call_RMTMatrix_Nul @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, @twRMTObjectIx_Open, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                         ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                                 EXEC dbo.call_RMTMatrix_Car                                       @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                                 EXEC dbo.call_RMTMatrix_Cyl                                       @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                                 EXEC dbo.call_RMTMatrix_Geo                                       @twRMTObjectIx_Open, @dA, @dB, @dC

                            EXEC dbo.call_RMTMatrix_Relative @SBO_CLASS_RMTOBJECT, @twRMTObjectIx, @twRMTObjectIx_Open

                          SELECT @twRMTObjectIx_Open AS twRMTObjectIx
   
                             SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_RMTOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_RMTObject_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : set_RMTObject_Transform.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Transform
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @bCoord                       TINYINT,
   @dA                           FLOAT (53),
   @dB                           FLOAT (53),
   @dC                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @RMTOBJECT_OP_TRANSFORM                    INT = 5
       DECLARE @RMTMATRIX_COORD_NUL                       INT = 0
       DECLARE @RMTMATRIX_COORD_CAR                       INT = 1
       DECLARE @RMTMATRIX_COORD_CYL                       INT = 2
       DECLARE @RMTMATRIX_COORD_GEO                       INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                -- EXEC dbo.call_RMTObject_Validate_Transform @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT

                     IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                        EXEC dbo.call_RMTObject_Validate_Coord_Nul @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                        EXEC dbo.call_RMTObject_Validate_Coord_Car @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                        EXEC dbo.call_RMTObject_Validate_Coord_Cyl @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                        EXEC dbo.call_RMTObject_Validate_Coord_Geo @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @dA, @dB, @dC, @nError OUTPUT
                   ELSE EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_Transform @twRMTObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                     IF @bError = 0
                  BEGIN
                          DELETE dbo.RMTMatrix
                           WHERE bnMatrix =     @twRMTObjectIx
                              OR bnMatrix = 0 - @twRMTObjectIx

                          -- SET @nCount += @@ROWCOUNT -- 2

                          DELETE dbo.RMTSubsurface
                           WHERE twRMTObjectIx = @twRMTObjectIx

                          -- SET @nCount += @@ROWCOUNT -- 1

                          -- assume these succeeded for now

                              IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                                 EXEC dbo.call_RMTMatrix_Nul @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                         ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                                 EXEC dbo.call_RMTMatrix_Car                                                           @twRMTObjectIx, @dA, @dB, @dC
                         ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                                 EXEC dbo.call_RMTMatrix_Cyl                                                           @twRMTObjectIx, @dA, @dB, @dC
                         ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                                 EXEC dbo.call_RMTMatrix_Geo                                                           @twRMTObjectIx, @dA, @dB, @dC

                            EXEC dbo.call_RMTMatrix_Relative @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx

                             SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_TRANSFORM, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Transform TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMTObject_Type.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMTObject_Type
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMTObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMTObjectIx = ISNULL (@twRMTObjectIx, 0)

       DECLARE @RMTOBJECT_OP_TYPE                         INT = 2

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMTObject_Validate @twRPersonaIx, @twRMTObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Type @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMTObjectIx, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMTObject_Event_Type @twRMTObjectIx, @Type_bType, @Type_bSubtype, @Type_bFiction
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMTObject_Log @RMTOBJECT_OP_TYPE, @sIPAddress, @twRPersonaIx, @twRMTObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMTObject_Type TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMCObject_Event.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event
(
   @twRMCObjectIx                BIGINT,
   @twEventIz                    BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @bError INT

        SELECT @twEventIz = ObjectHead_twEventIz
          FROM dbo.RMCObject
         WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

            -- Success will be tested on the update below

        UPDATE dbo.RMCObject
           SET ObjectHead_twEventIz += 1
         WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : call_RMCObject_Event_Bound.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_Bound
(
   @twRMCObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMCObject
                  SET Bound_dX = @Bound_dX,
                      Bound_dY = @Bound_dY,
                      Bound_dZ = @Bound_dZ
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'BOUND',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pBound": ',        dbo.Format_Bound
                                                      (
                                                         @Bound_dX,
                                                         @Bound_dY,
                                                         @Bound_dZ
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMCObject_Event_Name.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_Name
(
   @twRMCObjectIx                BIGINT,
   @Name_wsRMCObjectId           NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMCObject
                  SET Name_wsRMCObjectId = @Name_wsRMCObjectId
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'NAME',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_C
                                                      (
                                                         @Name_wsRMCObjectId
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : call_RMCObject_Event_Orbit_Spin.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_Orbit_Spin
(
   @twRMCObjectIx                BIGINT,
   @Orbit_Spin_tmPeriod          FLOAT (53),
   @Orbit_Spin_tmStart           FLOAT (53),
   @Orbit_Spin_dA                FLOAT (53),
   @Orbit_Spin_dB                FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMCObject
                  SET Orbit_Spin_tmPeriod = @Orbit_Spin_tmPeriod,
                      Orbit_Spin_tmStart  = @Orbit_Spin_tmStart,
                      Orbit_Spin_dA       = @Orbit_Spin_dA,
                      Orbit_Spin_dB       = @Orbit_Spin_dB
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'ORBIT_SPIN',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pOrbit_Spin": ',   dbo.Format_Orbit_Spin
                                                      (
                                                         @Orbit_Spin_tmPeriod,
                                                         @Orbit_Spin_tmStart,
                                                         @Orbit_Spin_dA,
                                                         @Orbit_Spin_dB
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : call_RMCObject_Event_Owner.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_Owner
(
   @twRMCObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMCObject
                  SET Owner_twRPersonaIx = @Owner_twRPersonaIx
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'OWNER',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : call_RMCObject_Event_Properties.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_Properties
(
   @twRMCObjectIx                BIGINT,
   @Properties_fMass             FLOAT (24),
   @Properties_fGravity          FLOAT (24),
   @Properties_fColor            FLOAT (24),
   @Properties_fBrightness       FLOAT (24),
   @Properties_fReflectivity     FLOAT (24)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMCObject
                  SET Properties_fMass         = @Properties_fMass,
                      Properties_fGravity      = @Properties_fGravity,
                      Properties_fColor        = @Properties_fColor,
                      Properties_fBrightness   = @Properties_fBrightness,
                      Properties_fReflectivity = @Properties_fReflectivity
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'PROPERTIES',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pProperties": ',   dbo.Format_Properties_C
                                                      (
                                                         @Properties_fMass,
                                                         @Properties_fGravity,
                                                         @Properties_fColor,
                                                         @Properties_fBrightness,
                                                         @Properties_fReflectivity
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMCObject_Event_Resource.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_Resource
(
   @twRMCObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMCObject
                  SET Resource_qwResource = @Resource_qwResource,
                      Resource_sName      = @Resource_sName,
                      Resource_sReference = @Resource_sReference       
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RESOURCE',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pResource": ',     dbo.Format_Resource
                                                      (
                                                         @Resource_qwResource,
                                                         @Resource_sName,
                                                         @Resource_sReference
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                   MVD_RP1_Map : call_RMCObject_Event_RMCObject_Close.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_RMCObject_Close
(
   @twRMCObjectIx                BIGINT,
   @twRMCObjectIx_Close          BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE INT = 0x02

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               DELETE dbo.RMCObject                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx_Close

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMCOBJECT_CLOSE',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx_Close,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE,
                             @twEventIz,

                             '{ }',

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                    MVD_RP1_Map : call_RMCObject_Event_RMCObject_Open.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_RMCObject_Open
(
   @twRMCObjectIx                BIGINT,
   @Name_wsRMCObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Orbit_Spin_tmPeriod          BIGINT,
   @Orbit_Spin_tmStart           BIGINT,
   @Orbit_Spin_dA                FLOAT (53),
   @Orbit_Spin_dB                FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_fMass             FLOAT (24),
   @Properties_fGravity          FLOAT (24),
   @Properties_fColor            FLOAT (24),
   @Properties_fBrightness       FLOAT (24),
   @Properties_fReflectivity     FLOAT (24),
   @twRMCObjectIx_Open           BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN  INT = 0x01

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               INSERT dbo.RMCObject
                      ( ObjectHead_Parent_wClass,  ObjectHead_Parent_twObjectIx,  ObjectHead_Self_wClass,  ObjectHead_twEventIz,  ObjectHead_wFlags,  Name_wsRMCObjectId,  Type_bType,  Type_bSubtype,  Type_bFiction,  Owner_twRPersonaIx,  Resource_qwResource,  Resource_sName,  Resource_sReference,  Transform_Position_dX,  Transform_Position_dY,  Transform_Position_dZ,  Transform_Rotation_dX,  Transform_Rotation_dY,  Transform_Rotation_dZ,  Transform_Rotation_dW,  Transform_Scale_dX,  Transform_Scale_dY,  Transform_Scale_dZ,  Orbit_Spin_tmPeriod,  Orbit_Spin_tmStart,  Orbit_Spin_dA,  Orbit_Spin_dB,  Bound_dX,  Bound_dY,  Bound_dZ,  Properties_fMass,  Properties_fGravity,  Properties_fColor,  Properties_fBrightness,  Properties_fReflectivity)
               VALUES (@SBO_CLASS_RMCOBJECT,      @twRMCObjectIx,                @SBO_CLASS_RMCOBJECT,     0,                     32,                @Name_wsRMCObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Orbit_Spin_tmPeriod, @Orbit_Spin_tmStart, @Orbit_Spin_dA, @Orbit_Spin_dB, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_fMass, @Properties_fGravity, @Properties_fColor, @Properties_fBrightness, @Properties_fReflectivity)

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                         SET @twRMCObjectIx_Open = SCOPE_IDENTITY ()

                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMCOBJECT_OPEN',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx_Open,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN,
                             @twEventIz,

                             '{ }',

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_C
                                                      (
                                                         @Name_wsRMCObjectId
                                                      ),
                               ', "pType": ',         dbo.Format_Type_C
                                                      (
                                                         @Type_bType,
                                                         @Type_bSubtype,
                                                         @Type_bFiction
                                                      ),
                               ', "pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                               ', "pResource": ',     dbo.Format_Resource
                                                      (
                                                         @Resource_qwResource,
                                                         @Resource_sName,
                                                         @Resource_sReference
                                                      ),
                               ', "pTransform": ',    dbo.Format_Transform
                                                      (
                                                         @Transform_Position_dX,
                                                         @Transform_Position_dY,
                                                         @Transform_Position_dZ,
                                                         @Transform_Rotation_dX,
                                                         @Transform_Rotation_dY,
                                                         @Transform_Rotation_dZ,
                                                         @Transform_Rotation_dW,
                                                         @Transform_Scale_dX,
                                                         @Transform_Scale_dY,
                                                         @Transform_Scale_dZ
                                                      ),
                               ', "pOrbit_Spin": ',   dbo.Format_Orbit_Spin
                                                      (
                                                         @Orbit_Spin_tmPeriod,
                                                         @Orbit_Spin_tmStart,
                                                         @Orbit_Spin_dA,
                                                         @Orbit_Spin_dB
                                                      ),
                               ', "pBound": ',        dbo.Format_Bound
                                                      (
                                                         @Bound_dX,
                                                         @Bound_dY,
                                                         @Bound_dZ
                                                      ),
                               ', "pProperties": ',   dbo.Format_Properties_C
                                                      (
                                                         @Properties_fMass,
                                                         @Properties_fGravity,
                                                         @Properties_fColor,
                                                         @Properties_fBrightness,
                                                         @Properties_fReflectivity
                                                      ),
                              ' }'
                             ),

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                   MVD_RP1_Map : call_RMCObject_Event_RMTObject_Close.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_RMTObject_Close
(
   @twRMCObjectIx                BIGINT,
   @twRMTObjectIx_Close          BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE INT = 0x02

       DECLARE @bError    INT,
               @twEventIz BIGINT

       DECLARE @nCount    INT = 0

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               DELETE dbo.RMTMatrix                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE bnMatrix =     @twRMTObjectIx_Close
                   OR bnMatrix = 0 - @twRMTObjectIx_Close

                  SET @nCount += @@ROWCOUNT -- 2

               DELETE dbo.RMTSubsurface                                    -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE twRMTObjectIx = @twRMTObjectIx_Close

                  SET @nCount += @@ROWCOUNT -- 1

               DELETE dbo.RMTObject                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx_Close

                  SET @nCount += @@ROWCOUNT -- 1

                  SET @bError = IIF (@nCount = 4, @@ERROR, 1) -- this will only return the error of the last delete statement

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMTOBJECT_CLOSE',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx_Close,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE,
                             @twEventIz,

                             '{ }',

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                    MVD_RP1_Map : call_RMCObject_Event_RMTObject_Open.sql                                   **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_RMTObject_Open
(
   @twRMCObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT,
   @twRMTObjectIx                BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN  INT = 0x01

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               INSERT dbo.RMTObject
                      ( ObjectHead_Parent_wClass,  ObjectHead_Parent_twObjectIx,  ObjectHead_Self_wClass,  ObjectHead_twEventIz,  ObjectHead_wFlags,  Name_wsRMTObjectId,  Type_bType,  Type_bSubtype,  Type_bFiction,  Owner_twRPersonaIx,  Resource_qwResource,  Resource_sName,  Resource_sReference,  Transform_Position_dX,  Transform_Position_dY,  Transform_Position_dZ,  Transform_Rotation_dX,  Transform_Rotation_dY,  Transform_Rotation_dZ,  Transform_Rotation_dW,  Transform_Scale_dX,  Transform_Scale_dY,  Transform_Scale_dZ,  Bound_dX,  Bound_dY,  Bound_dZ,  Properties_bLockToGround,  Properties_bYouth,  Properties_bAdult,  Properties_bAvatar)
               VALUES (@SBO_CLASS_RMCOBJECT,      @twRMCObjectIx,                @SBO_CLASS_RMTOBJECT,     0,                     32,                @Name_wsRMTObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar)

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                         SET @twRMTObjectIx = SCOPE_IDENTITY ()

                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMTOBJECT_OPEN',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN,
                             @twEventIz,

                             '{ }',

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_T
                                                      (
                                                         @Name_wsRMTObjectId
                                                      ),
                               ', "pType": ',         dbo.Format_Type_T
                                                      (
                                                         @Type_bType,
                                                         @Type_bSubtype,
                                                         @Type_bFiction
                                                      ),
                               ', "pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                               ', "pResource": ',     dbo.Format_Resource
                                                      (
                                                         @Resource_qwResource,
                                                         @Resource_sName,
                                                         @Resource_sReference
                                                      ),
                               ', "pTransform": ',    dbo.Format_Transform
                                                      (
                                                         @Transform_Position_dX,
                                                         @Transform_Position_dY,
                                                         @Transform_Position_dZ,
                                                         @Transform_Rotation_dX,
                                                         @Transform_Rotation_dY,
                                                         @Transform_Rotation_dZ,
                                                         @Transform_Rotation_dW,
                                                         @Transform_Scale_dX,
                                                         @Transform_Scale_dY,
                                                         @Transform_Scale_dZ
                                                      ),
                               ', "pBound": ',        dbo.Format_Bound
                                                      (
                                                         @Bound_dX,
                                                         @Bound_dY,
                                                         @Bound_dZ
                                                      ),
                               ', "pProperties": ',   dbo.Format_Properties_T
                                                      (
                                                         @Properties_bLockToGround,
                                                         @Properties_bYouth,
                                                         @Properties_bAdult,
                                                         @Properties_bAvatar
                                                      ),
                              ' }'
                             ),

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                      MVD_RP1_Map : call_RMCObject_Event_Transform.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_Transform
(
   @twRMCObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMCObject
                  SET Transform_Position_dX = @Transform_Position_dX,
                      Transform_Position_dY = @Transform_Position_dY,
                      Transform_Position_dZ = @Transform_Position_dZ,
                      Transform_Rotation_dX = @Transform_Rotation_dX,
                      Transform_Rotation_dY = @Transform_Rotation_dY,
                      Transform_Rotation_dZ = @Transform_Rotation_dZ,
                      Transform_Rotation_dW = @Transform_Rotation_dW,
                      Transform_Scale_dX    = @Transform_Scale_dX,
                      Transform_Scale_dY    = @Transform_Scale_dY,
                      Transform_Scale_dZ    = @Transform_Scale_dZ
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'TRANSFORM',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pTransform": ',    dbo.Format_Transform
                                                      (
                                                         @Transform_Position_dX,
                                                         @Transform_Position_dY,
                                                         @Transform_Position_dZ,
                                                         @Transform_Rotation_dX,
                                                         @Transform_Rotation_dY,
                                                         @Transform_Rotation_dZ,
                                                         @Transform_Rotation_dW,
                                                         @Transform_Scale_dX,
                                                         @Transform_Scale_dY,
                                                         @Transform_Scale_dZ
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMCObject_Event_Type.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Event_Type
(
   @twRMCObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMCObject_Event @twRMCObjectIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMCObject
                  SET Type_bType    = @Type_bType,
                      Type_bSubtype = @Type_bSubtype,
                      Type_bFiction = @Type_bFiction
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'TYPE',

                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pType": ',         dbo.Format_Type_C
                                                      (
                                                         @Type_bType,
                                                         @Type_bSubtype,
                                                         @Type_bFiction
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMCObject_Log.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Log
   @bOp                          TINYINT,
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT
AS
BEGIN
          SET NOCOUNT ON

      DECLARE @bError INT

      DECLARE @dwIPAddress BINARY (4) = dbo.IPstob (@sIPAddress)

       INSERT dbo.RMCObjectLog
              ( bOp,  dwIPAddress,  twRPersonaIx,  twRMCObjectIx)
       VALUES (@bOp, @dwIPAddress, @twRPersonaIx, @twRMCObjectIx)

          SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

       RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMCObject_Select.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Select
(
   @nResultSet                   INT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @OBJECTHEAD_FLAG_SUBSCRIBE_PARTIAL         INT = 0x10
       DECLARE @OBJECTHEAD_FLAG_SUBSCRIBE_FULL            INT = 0x20

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

        SELECT CONCAT
               (
                 '{ ',
                    '"pObjectHead": ',   dbo.Format_ObjectHead
                                         (
                                            c.ObjectHead_Parent_wClass,
                                            c.ObjectHead_Parent_twObjectIx,
                                            c.ObjectHead_Self_wClass,
                                            c.ObjectHead_Self_twObjectIx,
                                            IIF (@nResultSet = 0, @OBJECTHEAD_FLAG_SUBSCRIBE_FULL, @OBJECTHEAD_FLAG_SUBSCRIBE_PARTIAL),
                                            c.ObjectHead_twEventIz
                                         ),

                  ', "twRMCObjectIx": ', c.ObjectHead_Self_twObjectIx,      -- is this necessary

                  ', "pName": ',         dbo.Format_Name_C
                                         (
                                            c.Name_wsRMCObjectId
                                         ),
                  ', "pType": ',         dbo.Format_Type_C
                                         (
                                            c.Type_bType,
                                            c.Type_bSubtype,
                                            c.Type_bFiction
                                         ),
                  ', "pOwner": ',        dbo.Format_Owner
                                         (
                                            c.Owner_twRPersonaIx
                                         ),
                  ', "pResource": ',     dbo.Format_Resource
                                         (
                                            c.Resource_qwResource,
                                            c.Resource_sName,
                                            c.Resource_sReference
                                         ),
                  ', "pTransform": ',    dbo.Format_Transform
                                         (
                                            c.Transform_Position_dX,
                                            c.Transform_Position_dY,
                                            c.Transform_Position_dZ,
                                            c.Transform_Rotation_dX,
                                            c.Transform_Rotation_dY,
                                            c.Transform_Rotation_dZ,
                                            c.Transform_Rotation_dW,
                                            c.Transform_Scale_dX,
                                            c.Transform_Scale_dY,
                                            c.Transform_Scale_dZ
                                         ),
                  ', "pOrbit_Spin": ',   dbo.Format_Orbit_Spin
                                         (
                                            c.Orbit_Spin_tmPeriod,
                                            c.Orbit_Spin_tmStart,
                                            c.Orbit_Spin_dA,
                                            c.Orbit_Spin_dB
                                         ),
                  ', "pBound": ',        dbo.Format_Bound
                                         (
                                            c.Bound_dX,
                                            c.Bound_dY,
                                            c.Bound_dZ
                                         ),
                  ', "pProperties": ',   dbo.Format_Properties_C
                                         (
                                            c.Properties_fMass,
                                            c.Properties_fGravity,
                                            c.Properties_fColor,
                                            c.Properties_fBrightness,
                                            c.Properties_fReflectivity
                                         ),

                  ', "nChildren":  ',    cac.nCount + cat.nCount,
                 ' }'               
               ) AS [Object]
          FROM #Results      AS x
          JOIN dbo.RMCObject AS c on c.ObjectHead_Self_twObjectIx = x.ObjectHead_Self_twObjectIx
         CROSS APPLY (SELECT COUNT (*) AS nCount FROM dbo.RMCObject WHERE ObjectHead_Parent_twObjectIx = c.ObjectHead_Self_twObjectIx AND ObjectHead_Parent_wClass = @SBO_CLASS_RMCOBJECT) AS cac
         CROSS APPLY (SELECT COUNT (*) AS nCount FROM dbo.RMTObject WHERE ObjectHead_Parent_twObjectIx = c.ObjectHead_Self_twObjectIx AND ObjectHead_Parent_wClass = @SBO_CLASS_RMCOBJECT) AS cat
         WHERE nResultSet = @nResultSet
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : call_RMCObject_Validate.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate
(
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @ObjectHead_Parent_wClass     SMALLINT        OUTPUT,
   @ObjectHead_Parent_twObjectIx BIGINT          OUTPUT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nCount INT

        SELECT @ObjectHead_Parent_wClass     = ObjectHead_Parent_wClass,
               @ObjectHead_Parent_twObjectIx = ObjectHead_Parent_twObjectIx
          FROM dbo.RMCObject
         WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

           SET @nCount = @@ROWCOUNT

            IF @twRPersonaIx <= 0
               EXEC dbo.call_Error 1,  'twRPersonaIx is invalid',  @nError OUTPUT
       ELSE IF @twRMCObjectIx <= 0
               EXEC dbo.call_Error 2,  'twRMCObjectIx is invalid', @nError OUTPUT
       ELSE IF @nCount <> 1
               EXEC dbo.call_Error 3,  'twRMCObjectIx is unknown', @nError OUTPUT
       ELSE IF @twRPersonaIx <> @twRPersonaIx                                             -- TBD
               EXEC dbo.call_Error 4,  'Invalid rights',           @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMCObject_Validate_Bound.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate_Bound
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMCObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

            IF @Bound_dX IS NULL OR @Bound_dX <> @Bound_dX
               EXEC dbo.call_Error 21, 'Bound_dX is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dX < 0
               EXEC dbo.call_Error 21, 'Bound_dX is invalid',     @nError OUTPUT

            IF @Bound_dY IS NULL OR @Bound_dY <> @Bound_dY
               EXEC dbo.call_Error 21, 'Bound_dY is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dY < 0
               EXEC dbo.call_Error 21, 'Bound_dY is invalid',     @nError OUTPUT

            IF @Bound_dZ IS NULL OR @Bound_dZ <> @Bound_dZ
               EXEC dbo.call_Error 21, 'Bound_dZ is NULL or NaN', @nError OUTPUT
       ELSE IF @Bound_dZ < 0
               EXEC dbo.call_Error 21, 'Bound_dZ is invalid',     @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate bound is inside  parent's   bound
               -- validate bound is outside children's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMCObject_Validate_Name.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate_Name
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMCObjectIx                BIGINT,
   @Name_wsRMCObjectId           NVARCHAR (48),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Name_wsRMCObjectId IS NULL
               EXEC dbo.call_Error 21, 'Name_wsRMCObjectId is NULL',    @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                    MVD_RP1_Map : call_RMCObject_Validate_Orbit_Spin.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate_Orbit_Spin
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMCObjectIx                BIGINT,
   @Orbit_Spin_tmPeriod          BIGINT,
   @Orbit_Spin_tmStart           BIGINT,
   @Orbit_Spin_dA                FLOAT (53),
   @Orbit_Spin_dB                FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

            IF @Orbit_Spin_tmPeriod IS NULL
               EXEC dbo.call_Error 21, 'Orbit_Spin_tmPeriod is NULL',    @nError OUTPUT
       ELSE IF @Orbit_Spin_tmPeriod < 0
               EXEC dbo.call_Error 21, 'Orbit_Spin_tmPeriod is invalid', @nError OUTPUT

            IF @Orbit_Spin_tmStart IS NULL
               EXEC dbo.call_Error 21, 'Orbit_Spin_tmStart is NULL',     @nError OUTPUT
       ELSE IF @Orbit_Spin_tmStart NOT BETWEEN 0 AND @Orbit_Spin_tmPeriod
               EXEC dbo.call_Error 21, 'Orbit_Spin_tmStart is invalid',  @nError OUTPUT

            IF @Orbit_Spin_dA IS NULL OR @Orbit_Spin_dA <> @Orbit_Spin_dA
               EXEC dbo.call_Error 21, 'Orbit_Spin_dA is NULL or NaN',   @nError OUTPUT
       ELSE IF @Orbit_Spin_dA < 0
               EXEC dbo.call_Error 21, 'Orbit_Spin_dA is invalid',       @nError OUTPUT

            IF @Orbit_Spin_dB IS NULL OR @Orbit_Spin_dB <> @Orbit_Spin_dB
               EXEC dbo.call_Error 21, 'Orbit_Spin_dB is NULL or NaN',   @nError OUTPUT
       ELSE IF @Orbit_Spin_dB < 0
               EXEC dbo.call_Error 21, 'Orbit_Spin_dB is invalid',       @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate bound is inside  parent's   bound
               -- validate bound is outside children's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMCObject_Validate_Owner.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate_Owner
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMCObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Owner_twRPersonaIx IS NULL
               EXEC dbo.call_Error 21, 'Owner_twRPersonaIx is NULL',    @nError OUTPUT
       ELSE IF @Owner_twRPersonaIx NOT BETWEEN 1 AND 0x0000FFFFFFFFFFFC
               EXEC dbo.call_Error 21, 'Owner_twRPersonaIx is invalid', @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                    MVD_RP1_Map : call_RMCObject_Validate_Properties.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate_Properties
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMCObjectIx                BIGINT,
   @Properties_fMass             FLOAT (24),
   @Properties_fGravity          FLOAT (24),
   @Properties_fColor            FLOAT (24),
   @Properties_fBrightness       FLOAT (24),
   @Properties_fReflectivity     FLOAT (24),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Properties_fMass IS NULL OR @Properties_fMass <> @Properties_fMass
               EXEC dbo.call_Error 21, 'Properties_fMass is NULL or NaN',         @nError OUTPUT
       ELSE IF @Properties_fMass < 0                                              
               EXEC dbo.call_Error 21, 'Properties_fMass is invalid',             @nError OUTPUT

            IF @Properties_fGravity IS NULL OR @Properties_fGravity <> @Properties_fGravity
               EXEC dbo.call_Error 21, 'Properties_fGravity is NULL or NaN',      @nError OUTPUT
       ELSE IF @Properties_fGravity < 0                                           
               EXEC dbo.call_Error 21, 'Properties_fGravity is invalid',          @nError OUTPUT

            IF @Properties_fColor IS NULL OR @Properties_fColor <> @Properties_fColor
               EXEC dbo.call_Error 21, 'Properties_fColor is NULL or NaN',        @nError OUTPUT
       ELSE IF @Properties_fColor < 0
               EXEC dbo.call_Error 21, 'Properties_fColor is invalid',            @nError OUTPUT

            IF @Properties_fBrightness IS NULL OR @Properties_fBrightness <> @Properties_fBrightness
               EXEC dbo.call_Error 21, 'Properties_fBrightness is NULL or NaN',   @nError OUTPUT
       ELSE IF @Properties_fBrightness < 0
               EXEC dbo.call_Error 21, 'Properties_fBrightness is invalid',       @nError OUTPUT

            IF @Properties_fReflectivity IS NULL OR @Properties_fReflectivity <> @Properties_fReflectivity
               EXEC dbo.call_Error 21, 'Properties_fReflectivity is NULL or NaN', @nError OUTPUT
       ELSE IF @Properties_fReflectivity < 0
               EXEC dbo.call_Error 21, 'Properties_fReflectivity is invalid',     @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMCObject_Validate_Resource.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate_Resource
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMCObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Resource_qwResource IS NULL
               EXEC dbo.call_Error 21, 'Resource_qwResource is NULL', @nError OUTPUT
            IF @Resource_sName IS NULL
               EXEC dbo.call_Error 21, 'Resource_sName is NULL',      @nError OUTPUT
            IF @Resource_sReference IS NULL
               EXEC dbo.call_Error 21, 'Resource_sReference is NULL', @nError OUTPUT

            -- do we want to check sName and sReference for length or invalid characters

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMCObject_Validate_Transform.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate_Transform
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMCObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

            IF @Transform_Position_dX IS NULL OR @Transform_Position_dX <> @Transform_Position_dX
               EXEC dbo.call_Error 21, 'Transform_Position_dX is NULL or NaN', @nError OUTPUT
            IF @Transform_Position_dY IS NULL OR @Transform_Position_dY <> @Transform_Position_dY
               EXEC dbo.call_Error 21, 'Transform_Position_dY is NULL or NaN', @nError OUTPUT
            IF @Transform_Position_dZ IS NULL OR @Transform_Position_dZ <> @Transform_Position_dZ
               EXEC dbo.call_Error 21, 'Transform_Position_dZ is NULL or NaN', @nError OUTPUT

            IF @Transform_Rotation_dX IS NULL OR @Transform_Rotation_dX <> @Transform_Rotation_dX
               EXEC dbo.call_Error 21, 'Transform_Rotation_dX is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dY IS NULL OR @Transform_Rotation_dY <> @Transform_Rotation_dY
               EXEC dbo.call_Error 21, 'Transform_Rotation_dY is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dZ IS NULL OR @Transform_Rotation_dZ <> @Transform_Rotation_dZ
               EXEC dbo.call_Error 21, 'Transform_Rotation_dZ is NULL or NaN', @nError OUTPUT
            IF @Transform_Rotation_dW IS NULL OR @Transform_Rotation_dW <> @Transform_Rotation_dW
               EXEC dbo.call_Error 21, 'Transform_Rotation_dW is NULL or NaN', @nError OUTPUT

            IF @Transform_Scale_dX    IS NULL OR @Transform_Scale_dX    <> @Transform_Scale_dX
               EXEC dbo.call_Error 21, 'Transform_Scale_dX    is NULL or NaN', @nError OUTPUT
            IF @Transform_Scale_dY    IS NULL OR @Transform_Scale_dY    <> @Transform_Scale_dY
               EXEC dbo.call_Error 21, 'Transform_Scale_dY    is NULL or NaN', @nError OUTPUT
            IF @Transform_Scale_dZ    IS NULL OR @Transform_Scale_dZ    <> @Transform_Scale_dZ
               EXEC dbo.call_Error 21, 'Transform_Scale_dZ    is NULL or NaN', @nError OUTPUT

            IF @nError = 0
         BEGIN
               -- validate position is inside parent's bound
                  SET @nError = @nError
           END

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : call_RMCObject_Validate_Type.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMCObject_Validate_Type
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMCObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71

       DECLARE @Parent_bType    TINYINT,
               @Parent_bSubtype TINYINT,
               @Self_bType      TINYINT,
               @Self_bSubtype   TINYINT

            IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMCOBJECT
         BEGIN
                 SELECT @Parent_bType    = Type_bType,
                        @Parent_bSubtype = Type_bSubtype
                   FROM dbo.RMCObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @ObjectHead_Parent_twObjectIx
           END

            IF @twRMCObjectIx > 0
         BEGIN
                 SELECT @Self_bType    = Type_bType,
                        @Self_bSubtype = Type_bSubtype
                   FROM dbo.RMCObject AS o
                  WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx
-- get max children's type and subtype

           END

-- attachment points can't have cildren

            IF @Type_bType IS NULL
               EXEC dbo.call_Error 21, 'Type_bType is NULL',       @nError OUTPUT

            IF @Type_bSubtype IS NULL
               EXEC dbo.call_Error 21, 'Type_bSubtype is NULL',    @nError OUTPUT

            IF @Type_bFiction IS NULL
               EXEC dbo.call_Error 21, 'Type_bFiction is NULL',    @nError OUTPUT
       ELSE IF @Type_bFiction NOT BETWEEN 0 AND 1
               EXEC dbo.call_Error 21, 'Type_bFiction is invalid', @nError OUTPUT

            IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMCOBJECT  AND  @Type_bType < @Parent_bType
               EXEC dbo.call_Error 21, 'Type_bType must be greater than or equal to its parent''s Type_bType', @nError OUTPUT
       ELSE IF @ObjectHead_Parent_wClass = @SBO_CLASS_RMCOBJECT  AND  @Type_bType = @Parent_bType  AND  @Type_bSubtype <= @Parent_bSubtype
               EXEC dbo.call_Error 21, 'Type_bSubtype must be greater than its parent''s Type_bType', @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                               MVD_RP1_Map : get_RMCObject.sql                                              **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

/*
*/

CREATE PROCEDURE dbo.get_RMCObject
(
   @sIPAddress                   NVARCHAR (16),
   @twRMCObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @MVO_RMCOBJECT_TYPE_SURFACE                INT = 17

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @bError  INT = 0,
               @bCommit INT = 0,
               @nError  INT

            -- Create the temp Results table
        SELECT * INTO #Results FROM dbo.Table_Results ()

         BEGIN TRANSACTION

--        EXEC @nError = dbo.call_
           SET @nError = 0
            IF @nError = 0
         BEGIN
                  -- validate input

               DECLARE @bType TINYINT

               SELECT @bType = Type_bType
                 FROM dbo.RMCObject
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                   IF @bType IS NULL
                      SET @bError = 1

                  IF (@bError = 0)
               BEGIN
                     INSERT #Results
                     SELECT 0,
                            ObjectHead_Self_twObjectIx
                       FROM dbo.RMCObject
                      WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                         IF @bType <> @MVO_RMCOBJECT_TYPE_SURFACE
                      BEGIN
                            INSERT #Results
                            SELECT 1,
                                   ObjectHead_Self_twObjectIx
                              FROM dbo.RMCObject
                             WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMCOBJECT
                               AND ObjectHead_Parent_twObjectIx = @twRMCObjectIx
                        END
                       ELSE
                      BEGIN
                            INSERT #Results
                            SELECT 1,
                                   ObjectHead_Self_twObjectIx
                              FROM dbo.RMTObject
                             WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMCOBJECT
                               AND ObjectHead_Parent_twObjectIx = @twRMCObjectIx
                        END

                       EXEC dbo.call_RMCObject_Select 0
                         IF @bType <> @MVO_RMCOBJECT_TYPE_SURFACE
                            EXEC dbo.call_RMCObject_Select 1
                       ELSE EXEC dbo.call_RMTObject_Select 1

                        SET @bCommit = 1
                 END
           END

            IF (@bCommit = 0)
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - @bError - 1
  END
GO

GRANT EXECUTE ON dbo.get_RMCObject TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : get_RMCObject_Update.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.get_RMCObject_Update
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @MVO_RMCOBJECT_TYPE_SURFACE                INT = 17

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0

            -- Create the temp Results table
        SELECT * INTO #Results FROM dbo.Table_Results ()

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

            IF @twRPersonaIx < 0
               EXEC dbo.call_Error 1,  'Session is invalid', @nError OUTPUT

            IF @twRMCObjectIx <= 0
               EXEC dbo.call_Error 2,  'CObject is invalid', @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @bType TINYINT

                 SELECT @bType = c.Type_bType
                   FROM dbo.RMCObject AS c
                  WHERE c.ObjectHead_Self_twObjectIx = @twRMCObjectIx

                 INSERT #Results
                 SELECT 0,
                        c.ObjectHead_Self_twObjectIx
                   FROM dbo.RMCObject AS c
                  WHERE c.ObjectHead_Self_twObjectIx = @twRMCObjectIx

                     IF @@ROWCOUNT = 1  AND  @bType IS NOT NULL
                  BEGIN
                              IF @bType <> @MVO_RMCOBJECT_TYPE_SURFACE
                           BEGIN
                                   INSERT #Results
                                   SELECT 1,
                                          x.ObjectHead_Self_twObjectIx
                                     FROM dbo.RMCObject AS c
                                     JOIN dbo.RMCObject AS x ON x.ObjectHead_Parent_wClass     = c.ObjectHead_Self_wClass
                                                            AND x.ObjectHead_Parent_twObjectIx = c.ObjectHead_Self_twObjectIx
                                    WHERE c.ObjectHead_Self_twObjectIx = @twRMCObjectIx
                                 ORDER BY x.ObjectHead_Self_twObjectIx ASC
                             END
                            ELSE
                           BEGIN
                                   INSERT #Results
                                   SELECT 1,
                                          t.ObjectHead_Self_twObjectIx
                                     FROM dbo.RMCObject AS c
                                     JOIN dbo.RMTObject AS t ON t.ObjectHead_Parent_wClass     = c.ObjectHead_Self_wClass
                                                            AND t.ObjectHead_Parent_twObjectIx = c.ObjectHead_Self_twObjectIx
                                    WHERE c.ObjectHead_Self_twObjectIx = @twRMCObjectIx
                                 ORDER BY t.ObjectHead_Self_twObjectIx ASC
                             END
             
                            EXEC dbo.call_RMCObject_Select 0
                              IF @bType <> @MVO_RMCOBJECT_TYPE_SURFACE
                                 EXEC dbo.call_RMCObject_Select 1
                            ELSE EXEC dbo.call_RMTObject_Select 1
             
                             SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error 3,  'CObject does not exist', @nError OUTPUT
           END

            IF @bCommit = 0
               SELECT dwError, sError FROM #Error

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.get_RMCObject_Update TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : search_RMCObject.sql                                             **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.search_RMCObject
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @dX                           FLOAT (53),
   @dY                           FLOAT (53),
   @dZ                           FLOAT (53),
   @sText                        NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @MVO_RMCOBJECT_TYPE_SATELLITE              INT = 15

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @bError  INT = 0,
               @bCommit INT = 0,
               @nError  INT

       DECLARE @bType   TINYINT,
               @dRange  FLOAT (53),
               @nCount  INT = 0

        SELECT @bType = Type_bType
          FROM dbo.RMCObject
         WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

            IF @bType IS NULL
               SET @bError = 1

            IF @bError = 0
         BEGIN
                 SET @sText = RTRIM (LTRIM (ISNULL (@sText, '')))

                  IF @sText <> ''
               BEGIN
                      DECLARE @Result TABLE
                                      (
                                         nOrder                          INT         IDENTITY (0, 1),
                                         ObjectHead_Self_twObjectIx      BIGINT,
                                         dFactor                         FLOAT (53),
                                         dDistance                       FLOAT (53)
                                      )

                       INSERT @Result
                            (
                              ObjectHead_Self_twObjectIx, 
                              dFactor,
                              dDistance
                            )
                       SELECT TOP 10
                              o.ObjectHead_Self_twObjectIx, 
                              f.dFactor, 
                              d.dDistance
                         FROM dbo.RMCObject AS o
                      -- JOIN dbo.RMTMatrix AS m ON m.bnMatrix = o.ObjectHead_Self_twObjectIx
                  CROSS APPLY (SELECT POWER (CAST (4.0 AS FLOAT (53)), o.Type_bType - 7)           AS dFactor  ) AS f
               -- CROSS APPLY (SELECT dbo.ArcLength (@dRadius, @dX, @dY, @dZ, m.d03, m.d13, m.d23) AS dDistance) AS d
                  CROSS APPLY (SELECT -1                                                           AS dDistance) AS d  -- remove DESC from sort when distance can be properly calculated
                        WHERE o.Name_wsRMCObjectId LIKE @sText + '%'
                          AND o.Type_bType      BETWEEN @bType + 1 AND @MVO_RMCOBJECT_TYPE_SATELLITE
                     ORDER BY f.dFactor * d.dDistance DESC, o.Name_wsRMCObjectId

                       SELECT o.ObjectHead_Parent_wClass     AS ObjectHead_wClass_Parent,  -- change client to new names
                              o.ObjectHead_Parent_twObjectIx AS ObjectHead_twParentIx,     -- change client to new names
                              o.ObjectHead_Self_wClass       AS ObjectHead_wClass_Object,  -- change client to new names
                              o.ObjectHead_Self_twObjectIx   AS ObjectHead_twObjectIx,     -- change client to new names
                              o.ObjectHead_wFlags,
                              o.ObjectHead_twEventIz,
                              o.Name_wsRMCObjectId,
                              o.Type_bType,
                              o.Type_bSubtype,
                              o.Type_bFiction,
                              r.dFactor,
                              r.dDistance
                         FROM dbo.RMCObject AS o
                         JOIN @Result       AS r ON r.ObjectHead_Self_twObjectIx = o.ObjectHead_Self_twObjectIx
                     ORDER BY r.nOrder

                           -- select also all of the ancestors of the result set

                       ; WITH Tree AS
                              (
                                SELECT oa.ObjectHead_Parent_wClass,
                                       oa.ObjectHead_Parent_twObjectIx,
                                       oa.ObjectHead_Self_wClass,
                                       oa.ObjectHead_Self_twObjectIx,
                                       r.nOrder,
                                       0                               AS nAncestor
                                  FROM dbo.RMCObject AS oa
                                  JOIN @Result       AS r  ON r.ObjectHead_Self_twObjectIx = oa.ObjectHead_Self_twObjectIx
 
                                 UNION ALL
 
                                SELECT ob.ObjectHead_Parent_wClass,
                                       ob.ObjectHead_Parent_twObjectIx,
                                       ob.ObjectHead_Self_wClass,
                                       ob.ObjectHead_Self_twObjectIx,
                                       x.nOrder,
                                       x.nAncestor + 1                 AS nAncestor
                                  FROM dbo.RMCObject AS ob
                                  JOIN Tree          AS x  ON x.ObjectHead_Parent_twObjectIx = ob.ObjectHead_Self_twObjectIx
                                                          AND x.ObjectHead_Parent_wClass     = ob.ObjectHead_Self_wClass
                              )
                       SELECT o.ObjectHead_Parent_wClass     AS ObjectHead_wClass_Parent,  -- change client to new names
                              o.ObjectHead_Parent_twObjectIx AS ObjectHead_twParentIx,     -- change client to new names
                              o.ObjectHead_Self_wClass       AS ObjectHead_wClass_Object,  -- change client to new names
                              o.ObjectHead_Self_twObjectIx   AS ObjectHead_twObjectIx,     -- change client to new names
                              o.ObjectHead_wFlags,
                              o.ObjectHead_twEventIz,
                              o.Name_wsRMCObjectId,
                              o.Type_bType,
                              o.Type_bSubtype,
                              o.Type_bFiction,
                              x.nAncestor
                         FROM dbo.RMCObject AS o
                         JOIN Tree          AS x ON x.ObjectHead_Self_twObjectIx = o.ObjectHead_Self_twObjectIx
                        WHERE x.nAncestor > 0
                     ORDER BY x.nOrder,
                              x.nAncestor

                 END
                ELSE
               BEGIN
                       SELECT TOP 0 NULL AS Unused
                       SELECT TOP 0 NULL AS Unused
                 END

                 SET @bCommit = 1
           END
          ELSE EXEC dbo.call_Error 1, 'twRMCObjectIx is invalid'

            IF @bCommit = 0
                 SELECT dwError, sError FROM #Error

        RETURN @bCommit - @bError - 1
  END
GO

GRANT EXECUTE ON dbo.search_RMCObject TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMCObject_Bound.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_Bound
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @RMCOBJECT_OP_BOUND                        INT = 7

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Bound @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMCObjectIx, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_Bound @twRMCObjectIx, @Bound_dX, @Bound_dY, @Bound_dZ
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_BOUND, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_Bound TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMCObject_Name.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_Name
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Name_wsRMCObjectId           NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx       = ISNULL (@twRPersonaIx,       0)
           SET @twRMCObjectIx      = ISNULL (@twRMCObjectIx,      0)
           SET @Name_wsRMCObjectId = ISNULL (@Name_wsRMCObjectId, '')

       DECLARE @RMCOBJECT_OP_NAME                         INT = 1

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Name @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMCObjectIx, @Name_wsRMCObjectId, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_Name @twRMCObjectIx, @Name_wsRMCObjectId
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_NAME, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_Name TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : set_RMCObject_Orbit_Spin.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_Orbit_Spin
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Orbit_Spin_tmPeriod          FLOAT (53),
   @Orbit_Spin_tmStart           FLOAT (53),
   @Orbit_Spin_dA                FLOAT (53),
   @Orbit_Spin_dB                FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @RMCOBJECT_OP_ORBIT_SPIN                   INT = 6

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Orbit_Spin @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMCObjectIx, @Orbit_Spin_tmPeriod, @Orbit_Spin_tmStart, @Orbit_Spin_dA, @Orbit_Spin_dB, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_Orbit_Spin @twRMCObjectIx, @Orbit_Spin_tmPeriod, @Orbit_Spin_tmStart, @Orbit_Spin_dA, @Orbit_Spin_dB
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_ORBIT_SPIN, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_Orbit_Spin TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMCObject_Owner.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_Owner
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Owner_twRPersonaIx           BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @RMCOBJECT_OP_OWNER                        INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Owner @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMCObjectIx, @Owner_twRPersonaIx, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_Owner @twRMCObjectIx, @Owner_twRPersonaIx
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_OWNER, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_Owner TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : set_RMCObject_Properties.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_Properties
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Properties_fMass             FLOAT (24),
   @Properties_fGravity          FLOAT (24),
   @Properties_fColor            FLOAT (24),
   @Properties_fBrightness       FLOAT (24),
   @Properties_fReflectivity     FLOAT (24)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @RMCOBJECT_OP_PROPERTIES                   INT = 8

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Properties @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMCObjectIx, @Properties_fMass, @Properties_fGravity, @Properties_fColor, @Properties_fBrightness, @Properties_fReflectivity, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_Properties @twRMCObjectIx, @Properties_fMass, @Properties_fGravity, @Properties_fColor, @Properties_fBrightness, @Properties_fReflectivity
                        IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_PROPERTIES, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_Properties TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : set_RMCObject_Resource.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_Resource
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @RMCOBJECT_OP_RESOURCE                     INT = 4

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Resource @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMCObjectIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_Resource @twRMCObjectIx, @Resource_qwResource, @Resource_sName, @Resource_sReference
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_RESOURCE, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_Resource TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMCObject_RMCObject_Close.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_RMCObject_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @twRMCObjectIx_Close          BIGINT,
   @bDeleteAll                   TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx        = ISNULL (@twRPersonaIx,        0)
           SET @twRMCObjectIx       = ISNULL (@twRMCObjectIx,       0)
           SET @twRMCObjectIx_Close = ISNULL (@twRMCObjectIx_Close, 0)

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @RMCOBJECT_OP_RMCOBJECT_CLOSE              INT = 12

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMCObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMCOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMCObjectIx_Close

                 SELECT @nCount += COUNT (*)
                   FROM dbo.RMTObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMCOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMCObjectIx_Close

                     IF @twRMCObjectIx_Close <= 0
                        EXEC dbo.call_Error 5,  'twRMCObjectIx_Close is invalid',   @nError OUTPUT
                ELSE IF @bDeleteAll = 0  AND  @nCount > 0
                        EXEC dbo.call_Error 6,  'twRMCObjectIx_Close is not empty', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_RMCObject_Close @twRMCObjectIx, @twRMCObjectIx_Close
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_RMCOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_RMCObject_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMCObject_RMCObject_Open.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_RMCObject_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Name_wsRMCObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Orbit_Spin_tmPeriod          BIGINT,
   @Orbit_Spin_tmStart           BIGINT,
   @Orbit_Spin_dA                FLOAT (53),
   @Orbit_Spin_dB                FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_fMass             FLOAT (24),
   @Properties_fGravity          FLOAT (24),
   @Properties_fColor            FLOAT (24),
   @Properties_fBrightness       FLOAT (24),
   @Properties_fReflectivity     FLOAT (24)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @RMCOBJECT_OP_RMCOBJECT_OPEN               INT = 11

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMCObjectIx_Open   BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Name       @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Name_wsRMCObjectId, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Type       @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Owner      @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Resource   @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Transform  @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Orbit_Spin @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Orbit_Spin_tmPeriod, @Orbit_Spin_tmStart, @Orbit_Spin_dA, @Orbit_Spin_dB, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Bound      @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Properties @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Properties_fMass, @Properties_fGravity, @Properties_fColor, @Properties_fBrightness, @Properties_fReflectivity, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_RMCObject_Open @twRMCObjectIx, @Name_wsRMCObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Orbit_Spin_tmPeriod, @Orbit_Spin_tmStart, @Orbit_Spin_dA, @Orbit_Spin_dB, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_fMass, @Properties_fGravity, @Properties_fColor, @Properties_fBrightness, @Properties_fReflectivity, @twRMCObjectIx_Open OUTPUT
                     IF @bError = 0
                  BEGIN
                        SELECT @twRMCObjectIx_Open AS twRMCObjectIx
   
                           SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_RMCOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_RMCObject_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMCObject_RMTObject_Close.sql                                      **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_RMTObject_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @twRMTObjectIx_Close          BIGINT,
   @bDeleteAll                   TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx        = ISNULL (@twRPersonaIx,        0)
           SET @twRMCObjectIx       = ISNULL (@twRMCObjectIx,       0)
           SET @twRMTObjectIx_Close = ISNULL (@twRMTObjectIx_Close, 0)

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @RMCOBJECT_OP_RMTOBJECT_CLOSE              INT = 14

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMTObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMTOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMTObjectIx_Close

                     IF @twRMTObjectIx_Close <= 0
                        EXEC dbo.call_Error 5,  'twRMTObjectIx_Close is invalid',   @nError OUTPUT
                ELSE IF @bDeleteAll = 0  AND  @nCount > 0
                        EXEC dbo.call_Error 6,  'twRMTObjectIx_Close is not empty', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_RMTObject_Close @twRMCObjectIx, @twRMTObjectIx_Close
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_RMTOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_RMTObject_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                       MVD_RP1_Map : set_RMCObject_RMTObject_Open.sql                                       **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_RMTObject_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT,
   @bCoord                       TINYINT,
   @dA                           FLOAT (53),
   @dB                           FLOAT (53),
   @dC                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @RMCOBJECT_OP_RMTOBJECT_OPEN               INT = 13
       DECLARE @RMTMATRIX_COORD_NUL                       INT = 0
       DECLARE @RMTMATRIX_COORD_CAR                       INT = 1
       DECLARE @RMTMATRIX_COORD_CYL                       INT = 2
       DECLARE @RMTMATRIX_COORD_GEO                       INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMTObjectIx_Open   BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Name       @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Name_wsRMTObjectId, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Type       @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Owner      @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Resource   @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Transform  @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Bound      @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Properties @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @nError OUTPUT

                     IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                        EXEC dbo.call_RMTObject_Validate_Coord_Nul @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                        EXEC dbo.call_RMTObject_Validate_Coord_Car @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                        EXEC dbo.call_RMTObject_Validate_Coord_Cyl @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                        EXEC dbo.call_RMTObject_Validate_Coord_Geo @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, 0, @dA, @dB, @dC, @nError OUTPUT
                   ELSE EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_RMTObject_Open @twRMCObjectIx, @Name_wsRMTObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @twRMTObjectIx_Open OUTPUT
                     IF @bError = 0
                  BEGIN
                              IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                                 EXEC dbo.call_RMTMatrix_Nul @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, @twRMTObjectIx_Open, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                         ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                                 EXEC dbo.call_RMTMatrix_Car                                       @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                                 EXEC dbo.call_RMTMatrix_Cyl                                       @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                                 EXEC dbo.call_RMTMatrix_Geo                                       @twRMTObjectIx_Open, @dA, @dB, @dC

                            EXEC dbo.call_RMTMatrix_Relative @SBO_CLASS_RMCOBJECT, @twRMCObjectIx, @twRMTObjectIx_Open

                          SELECT @twRMTObjectIx_Open AS twRMTObjectIx
   
                             SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_RMTOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_RMTObject_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : set_RMCObject_Transform.sql                                         **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_Transform
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @RMCOBJECT_OP_TRANSFORM                    INT = 5

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Transform @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMCObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_Transform @twRMCObjectIx, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_TRANSFORM, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_Transform TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : set_RMCObject_Type.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMCObject_Type
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMCObjectIx                BIGINT,
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx  = ISNULL (@twRPersonaIx,  0)
           SET @twRMCObjectIx = ISNULL (@twRMCObjectIx, 0)

       DECLARE @RMCOBJECT_OP_TYPE                         INT = 2

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMCObject_Validate @twRPersonaIx, @twRMCObjectIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Type @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMCObjectIx, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMCObject_Event_Type @twRMCObjectIx, @Type_bType, @Type_bSubtype, @Type_bFiction
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMCObject_Log @RMCOBJECT_OP_TYPE, @sIPAddress, @twRPersonaIx, @twRMCObjectIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMCObject_Type TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : call_RMRoot_Event.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event
(
   @twRMRootIx                   BIGINT,
   @twEventIz                    BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @bError INT

        SELECT @twEventIz = ObjectHead_twEventIz
          FROM dbo.RMRoot
         WHERE ObjectHead_Self_twObjectIx = @twRMRootIx

            -- Success will be tested on the update below

        UPDATE dbo.RMRoot
           SET ObjectHead_twEventIz += 1
         WHERE ObjectHead_Self_twObjectIx = @twRMRootIx

           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : call_RMRoot_Event_Name.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event_Name
(
   @twRMRootIx                   BIGINT,
   @Name_wsRMRootId              NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMROOT                          INT = 70

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMRoot_Event @twRMRootIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMRoot
                  SET Name_wsRMRootId = @Name_wsRMRootId
                WHERE ObjectHead_Self_twObjectIx = @twRMRootIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'NAME',

                             @SBO_CLASS_RMROOT,
                             @twRMRootIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_R
                                                      (
                                                         @Name_wsRMRootId
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                          MVD_RP1_Map : call_RMRoot_Event_Owner.sql                                          **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event_Owner
(
   @twRMRootIx                   BIGINT,
   @Owner_twRPersonaIx           BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_NULL                            INT = 0
       DECLARE @SBO_CLASS_RMROOT                          INT = 70

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMRoot_Event @twRMRootIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               UPDATE dbo.RMRoot
                  SET Owner_twRPersonaIx = @Owner_twRPersonaIx
                WHERE ObjectHead_Self_twObjectIx = @twRMRootIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'OWNER',

                             @SBO_CLASS_RMROOT,
                             @twRMRootIx,
                             @SBO_CLASS_NULL,
                             0,
                             0,
                             @twEventIz,

                             CONCAT
                             (
                               '{ ',
                                 '"pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                              ' }'
                             ),

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMRoot_Event_RMCObject_Close.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event_RMCObject_Close
(
   @twRMRootIx                   BIGINT,
   @twRMCObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE INT = 0x02

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMRoot_Event @twRMRootIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               DELETE dbo.RMCObject                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE ObjectHead_Self_twObjectIx = @twRMCObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMCOBJECT_CLOSE',

                             @SBO_CLASS_RMROOT,
                             @twRMRootIx,
                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE,
                             @twEventIz,

                             '{ }',

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMRoot_Event_RMCObject_Open.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event_RMCObject_Open
(
   @twRMRootIx                   BIGINT,
   @Name_wsRMCObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Orbit_Spin_tmPeriod          BIGINT,
   @Orbit_Spin_tmStart           BIGINT,
   @Orbit_Spin_dA                FLOAT (53),
   @Orbit_Spin_dB                FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_fMass             FLOAT (24),
   @Properties_fGravity          FLOAT (24),
   @Properties_fColor            FLOAT (24),
   @Properties_fBrightness       FLOAT (24),
   @Properties_fReflectivity     FLOAT (24),
   @twRMCObjectIx                BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN  INT = 0x01

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMRoot_Event @twRMRootIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               INSERT dbo.RMCObject
                      ( ObjectHead_Parent_wClass,  ObjectHead_Parent_twObjectIx,  ObjectHead_Self_wClass,  ObjectHead_twEventIz,  ObjectHead_wFlags,  Name_wsRMCObjectId,  Type_bType,  Type_bSubtype,  Type_bFiction,  Owner_twRPersonaIx,  Resource_qwResource,  Resource_sName,  Resource_sReference,  Transform_Position_dX,  Transform_Position_dY,  Transform_Position_dZ,  Transform_Rotation_dX,  Transform_Rotation_dY,  Transform_Rotation_dZ,  Transform_Rotation_dW,  Transform_Scale_dX,  Transform_Scale_dY,  Transform_Scale_dZ,  Orbit_Spin_tmPeriod,  Orbit_Spin_tmStart,  Orbit_Spin_dA,  Orbit_Spin_dB,  Bound_dX,  Bound_dY,  Bound_dZ,  Properties_fMass,  Properties_fGravity,  Properties_fColor,  Properties_fBrightness,  Properties_fReflectivity)
               VALUES (@SBO_CLASS_RMROOT,         @twRMCObjectIx,                @SBO_CLASS_RMCOBJECT,     0,                     32,                @Name_wsRMCObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Orbit_Spin_tmPeriod, @Orbit_Spin_tmStart, @Orbit_Spin_dA, @Orbit_Spin_dB, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_fMass, @Properties_fGravity, @Properties_fColor, @Properties_fBrightness, @Properties_fReflectivity)

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                         SET @twRMCObjectIx = SCOPE_IDENTITY ()

                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMCOBJECT_OPEN',

                             @SBO_CLASS_RMROOT,
                             @twRMRootIx,
                             @SBO_CLASS_RMCOBJECT,
                             @twRMCObjectIx,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN,
                             @twEventIz,

                             '{ }',

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_C
                                                      (
                                                         @Name_wsRMCObjectId
                                                      ),
                               ', "pType": ',         dbo.Format_Type_C
                                                      (
                                                         @Type_bType,
                                                         @Type_bSubtype,
                                                         @Type_bFiction
                                                      ),
                               ', "pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                               ', "pResource": ',     dbo.Format_Resource
                                                      (
                                                         @Resource_qwResource,
                                                         @Resource_sName,
                                                         @Resource_sReference
                                                      ),
                               ', "pTransform": ',    dbo.Format_Transform
                                                      (
                                                         @Transform_Position_dX,
                                                         @Transform_Position_dY,
                                                         @Transform_Position_dZ,
                                                         @Transform_Rotation_dX,
                                                         @Transform_Rotation_dY,
                                                         @Transform_Rotation_dZ,
                                                         @Transform_Rotation_dW,
                                                         @Transform_Scale_dX,
                                                         @Transform_Scale_dY,
                                                         @Transform_Scale_dZ
                                                      ),
                               ', "pOrbit_Spin": ',   dbo.Format_Orbit_Spin
                                                      (
                                                         @Orbit_Spin_tmPeriod,
                                                         @Orbit_Spin_tmStart,
                                                         @Orbit_Spin_dA,
                                                         @Orbit_Spin_dB
                                                      ),
                               ', "pBound": ',        dbo.Format_Bound
                                                      (
                                                         @Bound_dX,
                                                         @Bound_dY,
                                                         @Bound_dZ
                                                      ),
                               ', "pProperties": ',   dbo.Format_Properties_C
                                                      (
                                                         @Properties_fMass,
                                                         @Properties_fGravity,
                                                         @Properties_fColor,
                                                         @Properties_fBrightness,
                                                         @Properties_fReflectivity
                                                      ),
                              ' }'
                             ),

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMRoot_Event_RMPObject_Close.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event_RMPObject_Close
(
   @twRMRootIx                   BIGINT,
   @twRMPObjectIx_Close          BIGINT,
   @bReparent                    TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE INT = 0x02

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMRoot_Event @twRMRootIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
                   IF @bReparent = 0
                BEGIN
                        DELETE dbo.RMPObject                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                         WHERE ObjectHead_Self_twObjectIx = @twRMPObjectIx_Close
         
                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMPOBJECT_CLOSE',

                             @SBO_CLASS_RMROOT,
                             @twRMRootIx,
                             @SBO_CLASS_RMPOBJECT,
                             @twRMPObjectIx_Close,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE,
                             @twEventIz,

                             '{ }',

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMRoot_Event_RMPObject_Open.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event_RMPObject_Open
(
   @twRMRootIx                   BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @twRMPObjectIx_Open           BIGINT OUTPUT,
   @bReparent                    TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN  INT = 0x01

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMRoot_Event @twRMRootIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
                   IF @bReparent = 0
                BEGIN
                        INSERT dbo.RMPObject
                               ( ObjectHead_Parent_wClass,  ObjectHead_Parent_twObjectIx,  ObjectHead_Self_wClass,  ObjectHead_twEventIz,  ObjectHead_wFlags,  Name_wsRMPObjectId,  Type_bType,  Type_bSubtype,  Type_bFiction,  Type_bMovable,  Owner_twRPersonaIx,  Resource_qwResource,  Resource_sName,  Resource_sReference,  Transform_Position_dX,  Transform_Position_dY,  Transform_Position_dZ,  Transform_Rotation_dX,  Transform_Rotation_dY,  Transform_Rotation_dZ,  Transform_Rotation_dW,  Transform_Scale_dX,  Transform_Scale_dY,  Transform_Scale_dZ,  Bound_dX,  Bound_dY,  Bound_dZ)
                        VALUES (@SBO_CLASS_RMROOT,         @twRMRootIx,                   @SBO_CLASS_RMPOBJECT,     0,                     32,                @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ)

                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                           SET @twRMPObjectIx_Open = SCOPE_IDENTITY ()
                  END

                   IF @bError = 0
                BEGIN
                        INSERT #Event
                               (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                        SELECT 'RMPOBJECT_OPEN',
  
                               @SBO_CLASS_RMROOT,
                               @twRMRootIx,
                               @SBO_CLASS_RMPOBJECT,
                               @twRMPObjectIx_Open,
                               @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN,
                               @twEventIz,
  
                               '{ }',
  
                               CONCAT
                               (
                                 '{ ',
                                   '"pName": ',         dbo.Format_Name_P
                                                        (
                                                           @Name_wsRMPObjectId
                                                        ),
                                 ', "pType": ',         dbo.Format_Type_P
                                                        (
                                                           @Type_bType,
                                                           @Type_bSubtype,
                                                           @Type_bFiction,
                                                           @Type_bMovable
                                                        ),
                                 ', "pOwner": ',        dbo.Format_Owner
                                                        (
                                                           @Owner_twRPersonaIx
                                                        ),
                                 ', "pResource": ',     dbo.Format_Resource
                                                        (
                                                           @Resource_qwResource,
                                                           @Resource_sName,
                                                           @Resource_sReference
                                                        ),
                                 ', "pTransform": ',    dbo.Format_Transform
                                                        (
                                                           @Transform_Position_dX,
                                                           @Transform_Position_dY,
                                                           @Transform_Position_dZ,
                                                           @Transform_Rotation_dX,
                                                           @Transform_Rotation_dY,
                                                           @Transform_Rotation_dZ,
                                                           @Transform_Rotation_dW,
                                                           @Transform_Scale_dX,
                                                           @Transform_Scale_dY,
                                                           @Transform_Scale_dZ
                                                        ),
                                 ', "pBound": ',        dbo.Format_Bound
                                                        (
                                                           @Bound_dX,
                                                           @Bound_dY,
                                                           @Bound_dZ
                                                        ),
                                ' }'
                               ),
  
                               '{ }'
  
                           SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMRoot_Event_RMTObject_Close.sql                                    **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event_RMTObject_Close
(
   @twRMRootIx                   BIGINT,
   @twRMTObjectIx                BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE INT = 0x02

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMRoot_Event @twRMRootIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               DELETE dbo.RMTObject                                        -- we actually want to delete the entire tree - all the way down to the pobject!
                WHERE ObjectHead_Self_twObjectIx = @twRMTObjectIx

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMTOBJECT_Close',

                             @SBO_CLASS_RMROOT,
                             @twRMRootIx,
                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_CLOSE,
                             @twEventIz,

                             '{ }',

                             '{ }',

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                     MVD_RP1_Map : call_RMRoot_Event_RMTObject_Open.sql                                     **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Event_RMTObject_Open
(
   @twRMRootIx                   BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT,
   @twRMTObjectIx                BIGINT OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN  INT = 0x01

       DECLARE @bError    INT,
               @twEventIz BIGINT

          EXEC @bError = dbo.call_RMRoot_Event @twRMRootIx, @twEventIz OUTPUT

            IF @bError = 0
         BEGIN
               INSERT dbo.RMTObject
                      ( ObjectHead_Parent_wClass,  ObjectHead_Parent_twObjectIx,  ObjectHead_Self_wClass,  ObjectHead_twEventIz,  ObjectHead_wFlags,  Name_wsRMTObjectId,  Type_bType,  Type_bSubtype,  Type_bFiction,  Owner_twRPersonaIx,  Resource_qwResource,  Resource_sName,  Resource_sReference,  Transform_Position_dX,  Transform_Position_dY,  Transform_Position_dZ,  Transform_Rotation_dX,  Transform_Rotation_dY,  Transform_Rotation_dZ,  Transform_Rotation_dW,  Transform_Scale_dX,  Transform_Scale_dY,  Transform_Scale_dZ,  Bound_dX,  Bound_dY,  Bound_dZ,  Properties_bLockToGround,  Properties_bYouth,  Properties_bAdult,  Properties_bAvatar)
               VALUES (@SBO_CLASS_RMROOT,         @twRMRootIx,                   @SBO_CLASS_RMTOBJECT,     0,                     32,                @Name_wsRMTObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar)

                  SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

                   IF @bError = 0
                BEGIN
                         SET @twRMTObjectIx = SCOPE_IDENTITY ()

                      INSERT #Event
                             (sType, Self_wClass, Self_twObjectIx, Child_wClass, Child_twObjectIx, wFlags, twEventIz, sJSON_Object, sJSON_Child, sJSON_Change)
                      SELECT 'RMTOBJECT_OPEN',

                             @SBO_CLASS_RMROOT,
                             @twRMRootIx,
                             @SBO_CLASS_RMTOBJECT,
                             @twRMTObjectIx,
                             @SBA_SUBSCRIBE_REFRESH_EVENT_EX_FLAG_OPEN,
                             @twEventIz,

                             '{ }',

                             CONCAT
                             (
                               '{ ',
                                 '"pName": ',         dbo.Format_Name_T
                                                      (
                                                         @Name_wsRMTObjectId
                                                      ),
                               ', "pType": ',         dbo.Format_Type_T
                                                      (
                                                         @Type_bType,
                                                         @Type_bSubtype,
                                                         @Type_bFiction
                                                      ),
                               ', "pOwner": ',        dbo.Format_Owner
                                                      (
                                                         @Owner_twRPersonaIx
                                                      ),
                               ', "pResource": ',     dbo.Format_Resource
                                                      (
                                                         @Resource_qwResource,
                                                         @Resource_sName,
                                                         @Resource_sReference
                                                      ),
                               ', "pTransform": ',    dbo.Format_Transform
                                                      (
                                                         @Transform_Position_dX,
                                                         @Transform_Position_dY,
                                                         @Transform_Position_dZ,
                                                         @Transform_Rotation_dX,
                                                         @Transform_Rotation_dY,
                                                         @Transform_Rotation_dZ,
                                                         @Transform_Rotation_dW,
                                                         @Transform_Scale_dX,
                                                         @Transform_Scale_dY,
                                                         @Transform_Scale_dZ
                                                      ),
                               ', "pBound": ',        dbo.Format_Bound
                                                      (
                                                         @Bound_dX,
                                                         @Bound_dY,
                                                         @Bound_dZ
                                                      ),
                               ', "pProperties": ',   dbo.Format_Properties_T
                                                      (
                                                         @Properties_bLockToGround,
                                                         @Properties_bYouth,
                                                         @Properties_bAdult,
                                                         @Properties_bAvatar
                                                      ),
                              ' }'
                             ),

                             '{ }'

                         SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)
                  END
           END

        RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : call_RMRoot_Log.sql                                             **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Log
   @bOp                          TINYINT,
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT
AS
BEGIN
          SET NOCOUNT ON

      DECLARE @bError INT

      DECLARE @dwIPAddress BINARY (4) = dbo.IPstob (@sIPAddress)

       INSERT dbo.RMRootLog
              ( bOp,  dwIPAddress,  twRPersonaIx,  twRMRootIx)
       VALUES (@bOp, @dwIPAddress, @twRPersonaIx, @twRMRootIx)

          SET @bError = IIF (@@ROWCOUNT = 1, @@ERROR, 1)

       RETURN @bError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                            MVD_RP1_Map : call_RMRoot_Select.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Select
(
   @nResultSet                   INT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @OBJECTHEAD_FLAG_SUBSCRIBE_PARTIAL         INT = 0x10
       DECLARE @OBJECTHEAD_FLAG_SUBSCRIBE_FULL            INT = 0x20

        SELECT CONCAT
               (
                 '{ ',
                    '"pObjectHead": ',   dbo.Format_ObjectHead
                                         (
                                            r.ObjectHead_Parent_wClass,
                                            r.ObjectHead_Parent_twObjectIx,
                                            r.ObjectHead_Self_wClass,
                                            r.ObjectHead_Self_twObjectIx,
                                            IIF (@nResultSet = 0, @OBJECTHEAD_FLAG_SUBSCRIBE_FULL, @OBJECTHEAD_FLAG_SUBSCRIBE_PARTIAL),
                                            r.ObjectHead_twEventIz
                                         ),
 
                  ', "twRMRootIx": ',    r.ObjectHead_Self_twObjectIx,      -- is this necessary
 
                  ', "pName": ',         dbo.Format_Name_R
                                         (
                                            r.Name_wsRMRootId
                                         ),
                  ', "pOwner": ',        dbo.Format_Owner
                                         (
                                            r.Owner_twRPersonaIx
                                         ),
                 ' }'               
               ) AS [Object]
          FROM #Results   AS x
          JOIN dbo.RMRoot AS r on r.ObjectHead_Self_twObjectIx = x.ObjectHead_Self_twObjectIx
         WHERE nResultSet = @nResultSet
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                           MVD_RP1_Map : call_RMRoot_Validate.sql                                           **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Validate
(
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @ObjectHead_Parent_wClass     SMALLINT        OUTPUT,
   @ObjectHead_Parent_twObjectIx BIGINT          OUTPUT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @nCount INT

        SELECT @ObjectHead_Parent_wClass     = ObjectHead_Parent_wClass,
               @ObjectHead_Parent_twObjectIx = ObjectHead_Parent_twObjectIx
          FROM dbo.RMRoot
         WHERE ObjectHead_Self_twObjectIx = @twRMRootIx

           SET @nCount = @@ROWCOUNT

            IF @twRPersonaIx <= 0
               EXEC dbo.call_Error 1,  'twRPersonaIx is invalid',  @nError OUTPUT
       ELSE IF @twRMRootIx <= 0
               EXEC dbo.call_Error 2,  'twRMRootIx is invalid',    @nError OUTPUT
       ELSE IF @nCount <> 1
               EXEC dbo.call_Error 3,  'twRMRootIx is unknown',    @nError OUTPUT
       ELSE IF @twRPersonaIx <> @twRPersonaIx                                             -- TBD
               EXEC dbo.call_Error 4,  'Invalid rights',           @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : call_RMRoot_Validate_Name.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Validate_Name
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMRootIx                   BIGINT,
   @Name_wsRMRootId              NVARCHAR (48),
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Name_wsRMRootId IS NULL
               EXEC dbo.call_Error 21, 'Name_wsRMRootId is NULL',    @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : call_RMRoot_Validate_Owner.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.call_RMRoot_Validate_Owner
(
   @ObjectHead_Parent_wClass     SMALLINT,
   @ObjectHead_Parent_twObjectIx BIGINT,
   @twRMRootIx                   BIGINT,
   @Owner_twRPersonaIx           BIGINT,
   @nError                       INT = 0         OUTPUT
)
AS
BEGIN
           SET NOCOUNT ON

            IF @Owner_twRPersonaIx IS NULL
               EXEC dbo.call_Error 21, 'Owner_twRPersonaIx is NULL',    @nError OUTPUT
       ELSE IF @Owner_twRPersonaIx NOT BETWEEN 1 AND 0x0000FFFFFFFFFFFC
               EXEC dbo.call_Error 21, 'Owner_twRPersonaIx is invalid', @nError OUTPUT

        RETURN @nError
  END
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                                MVD_RP1_Map : get_RMRoot.sql                                                **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2023 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.get_RMRoot
(
   @sIPAddress                   NVARCHAR (16),
   @twRMRootIx                   BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

       DECLARE @SBO_CLASS_RMROOT                          INT = 70

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @bError  INT = 0,
               @bCommit INT = 0,
               @nError  INT

            -- Create the temp Results table
        SELECT * INTO #Results FROM dbo.Table_Results ()

         BEGIN TRANSACTION

--        EXEC @nError = dbo.call_
           SET @nError = 0
            IF @nError = 0
         BEGIN
                  -- validate input

                  IF (@bError = 0)
               BEGIN
                     INSERT #Results
                     SELECT 0,
                            ObjectHead_Self_twObjectIx
                       FROM dbo.RMRoot
                      WHERE ObjectHead_Self_twObjectIx = @twRMRootIx

                     INSERT #Results
                     SELECT 1,
                            ObjectHead_Self_twObjectIx
                       FROM dbo.RMCObject
                      WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMROOT
                        AND ObjectHead_Parent_twObjectIx = @twRMRootIx

                       EXEC dbo.call_RMRoot_Select    0
                       EXEC dbo.call_RMCObject_Select 1

                        SET @bCommit = 1
                 END
           END

            IF (@bCommit = 0)
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - @bError - 1
  END
GO

GRANT EXECUTE ON dbo.get_RMRoot TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : get_RMRoot_Update.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.get_RMRoot_Update
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0

            -- Create the temp Results table
        SELECT * INTO #Results FROM dbo.Table_Results ()

           SET @twRPersonaIx = ISNULL (@twRPersonaIx, 0)
           SET @twRMRootIx   = ISNULL (@twRMRootIx,   0)

            IF @twRPersonaIx < 0
               EXEC dbo.call_Error 1,  'Session is invalid', @nError OUTPUT

            IF @twRMRootIx <= 0
               EXEC dbo.call_Error 2,  'Root is invalid',    @nError OUTPUT

            IF @nError = 0
         BEGIN
                 INSERT #Results
                 SELECT 0,
                        r.ObjectHead_Self_twObjectIx
                   FROM dbo.RMRoot    AS r
                  WHERE r.ObjectHead_Self_twObjectIx = @twRMRootIx

                     IF @@ROWCOUNT = 1
                  BEGIN
                          INSERT #Results
                          SELECT 1,
                                 c.ObjectHead_Self_twObjectIx
                            FROM dbo.RMRoot    AS r
                            JOIN dbo.RMCObject AS c ON c.ObjectHead_Parent_wClass     = r.ObjectHead_Self_wClass
                                                   AND c.ObjectHead_Parent_twObjectIx = r.ObjectHead_Self_twObjectIx
                           WHERE r.ObjectHead_Self_twObjectIx = @twRMRootIx
                        ORDER BY c.ObjectHead_Self_twObjectIx ASC
          
                          INSERT #Results
                          SELECT 2,
                                 t.ObjectHead_Self_twObjectIx
                            FROM dbo.RMRoot    AS r
                            JOIN dbo.RMTObject AS t ON t.ObjectHead_Parent_wClass     = r.ObjectHead_Self_wClass
                                                   AND t.ObjectHead_Parent_twObjectIx = r.ObjectHead_Self_twObjectIx
                           WHERE r.ObjectHead_Self_twObjectIx = @twRMRootIx
                        ORDER BY t.ObjectHead_Self_twObjectIx ASC
          
                          INSERT #Results
                          SELECT 3,
                                 p.ObjectHead_Self_twObjectIx
                            FROM dbo.RMRoot    AS r
                            JOIN dbo.RMPObject AS p ON p.ObjectHead_Parent_wClass     = r.ObjectHead_Self_wClass
                                                   AND p.ObjectHead_Parent_twObjectIx = r.ObjectHead_Self_twObjectIx
                           WHERE r.ObjectHead_Self_twObjectIx = @twRMRootIx
                        ORDER BY p.ObjectHead_Self_twObjectIx ASC
          
                            EXEC dbo.call_RMRoot_Select    0
                            EXEC dbo.call_RMCObject_Select 1
                            EXEC dbo.call_RMTObject_Select 2
                            EXEC dbo.call_RMPObject_Select 3
          
                             SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error 3,  'Root does not exist', @nError OUTPUT
           END

            IF @bCommit = 0
               SELECT dwError, sError FROM #Error

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.get_RMRoot_Update TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                              MVD_RP1_Map : set_RMRoot_Name.sql                                             **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMRoot_Name
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @Name_wsRMRootId              NVARCHAR (48)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx = ISNULL (@twRPersonaIx, 0)
           SET @twRMRootIx   = ISNULL (@twRMRootIx,   0)

       DECLARE @RMROOT_OP_NAME                            INT = 1

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMRoot_Validate @twRPersonaIx, @twRMRootIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMRoot_Validate_Name @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMRootIx, @Name_wsRMRootId, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMRoot_Event_Name @twRMRootIx, @Name_wsRMRootId
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMRoot'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMRoot_Log @RMROOT_OP_NAME, @sIPAddress, @twRPersonaIx, @twRMRootIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMRoot_Name TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : set_RMRoot_Owner.sql                                             **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMRoot_Owner
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @Owner_twRPersonaIx           BIGINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx = ISNULL (@twRPersonaIx, 0)
           SET @twRMRootIx   = ISNULL (@twRMRootIx,   0)

       DECLARE @RMROOT_OP_OWNER                           INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMRoot_Validate @twRPersonaIx, @twRMRootIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMRoot_Validate_Owner @ObjectHead_Parent_wClass, @ObjectHead_Parent_twObjectIx, @twRMRootIx, @Owner_twRPersonaIx, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMRoot_Event_Owner @twRMRootIx, @Owner_twRPersonaIx
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to update RMRoot'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMRoot_Log @RMROOT_OP_OWNER, @sIPAddress, @twRPersonaIx, @twRMRootIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMRoot_Owner TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : set_RMRoot_RMCObject_Close.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMRoot_RMCObject_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @twRMCObjectIx_Close          BIGINT,
   @bDeleteAll                   TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx        = ISNULL (@twRPersonaIx,        0)
           SET @twRMRootIx          = ISNULL (@twRMRootIx,          0)
           SET @twRMCObjectIx_Close = ISNULL (@twRMCObjectIx_Close, 0)

       DECLARE @SBO_CLASS_RMCOBJECT                       INT = 71
       DECLARE @RMROOT_OP_RMCOBJECT_CLOSE                 INT = 14

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMRoot_Validate @twRPersonaIx, @twRMRootIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMCObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMCOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMCObjectIx_Close

                     IF @twRMCObjectIx_Close <= 0
                        EXEC dbo.call_Error 5,  'twRMCObjectIx_Close is invalid',   @nError OUTPUT
                ELSE IF @bDeleteAll = 0  AND  @nCount > 0
                        EXEC dbo.call_Error 6,  'twRMCObjectIx_Close is not empty', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMRoot_Event_RMCObject_Close @twRMRootIx, @twRMCObjectIx_Close
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMRoot_Log @RMROOT_OP_RMCOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @twRMRootIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMRoot_RMCObject_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : set_RMRoot_RMCObject_Open.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMRoot_RMCObject_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @Name_wsRMCObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Orbit_Spin_tmPeriod          BIGINT,
   @Orbit_Spin_tmStart           BIGINT,
   @Orbit_Spin_dA                FLOAT (53),
   @Orbit_Spin_dB                FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_fMass             FLOAT (24),
   @Properties_fGravity          FLOAT (24),
   @Properties_fColor            FLOAT (24),
   @Properties_fBrightness       FLOAT (24),
   @Properties_fReflectivity     FLOAT (24)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx = ISNULL (@twRPersonaIx, 0)
           SET @twRMRootIx   = ISNULL (@twRMRootIx,   0)

       DECLARE @SBO_CLASS_RMROOT                          INT = 79
       DECLARE @RMROOT_OP_RMCOBJECT_OPEN                  INT = 12

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMCObjectIx_Open   BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMRoot_Validate @twRPersonaIx, @twRMRootIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMCObject_Validate_Name       @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Name_wsRMCObjectId, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Type       @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Owner      @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Resource   @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Transform  @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Orbit_Spin @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Orbit_Spin_tmPeriod, @Orbit_Spin_tmStart, @Orbit_Spin_dA, @Orbit_Spin_dB, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Bound      @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
                   EXEC dbo.call_RMCObject_Validate_Properties @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Properties_fMass, @Properties_fGravity, @Properties_fColor, @Properties_fBrightness, @Properties_fReflectivity, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMRoot_Event_RMCObject_Open @twRMRootIx, @Name_wsRMCObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Orbit_Spin_tmPeriod, @Orbit_Spin_tmStart, @Orbit_Spin_dA, @Orbit_Spin_dB, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_fMass, @Properties_fGravity, @Properties_fColor, @Properties_fBrightness, @Properties_fReflectivity, @twRMCObjectIx_Open OUTPUT
                     IF @bError = 0
                  BEGIN
                        SELECT @twRMCObjectIx_Open AS twRMCObjectIx
   
                           SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMCObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMRoot_Log @RMROOT_OP_RMCOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMRootIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMRoot_RMCObject_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : set_RMRoot_RMPObject_Close.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMRoot_RMPObject_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @twRMPObjectIx_Close          BIGINT,
   @bDeleteAll                   TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx        = ISNULL (@twRPersonaIx,        0)
           SET @twRMRootIx          = ISNULL (@twRMRootIx,          0)
           SET @twRMPObjectIx_Close = ISNULL (@twRMPObjectIx_Close, 0)

       DECLARE @SBO_CLASS_RMPOBJECT                       INT = 73
       DECLARE @RMROOT_OP_RMPOBJECT_CLOSE                 INT = 17

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMRoot_Validate @twRPersonaIx, @twRMRootIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMPObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMPOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMPObjectIx_Close

                     IF @twRMPObjectIx_Close <= 0
                        EXEC dbo.call_Error 5,  'twRMPObjectIx_Close is invalid',   @nError OUTPUT
                ELSE IF @bDeleteAll = 0  AND  @nCount > 0
                        EXEC dbo.call_Error 6,  'twRMPObjectIx_Close is not empty', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMRoot_Event_RMPObject_Close @twRMRootIx, @twRMPObjectIx_Close, 0
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMRoot_Log @RMROOT_OP_RMPOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @twRMRootIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMRoot_RMPObject_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : set_RMRoot_RMPObject_Open.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMRoot_RMPObject_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @Name_wsRMPObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Type_bMovable                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx = ISNULL (@twRPersonaIx, 0)
           SET @twRMRootIx   = ISNULL (@twRMRootIx,   0)

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @RMROOT_OP_RMPOBJECT_OPEN                  INT = 16

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMPObjectIx_Open           BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMRoot_Validate @twRPersonaIx, @twRMRootIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMPObject_Validate_Name      @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Name_wsRMPObjectId, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Type      @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Owner     @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Resource  @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Transform @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                   EXEC dbo.call_RMPObject_Validate_Bound     @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMRoot_Event_RMPObject_Open @twRMRootIx, @Name_wsRMPObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Type_bMovable, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @twRMPObjectIx_Open OUTPUT, 0
                     IF @bError = 0
                  BEGIN
                        SELECT @twRMPObjectIx_Open AS twRMPObjectIx
   
                           SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMPObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMRoot_Log @RMROOT_OP_RMPOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMRootIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMRoot_RMPObject_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                        MVD_RP1_Map : set_RMRoot_RMTObject_Close.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMRoot_RMTObject_Close
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @twRMTObjectIx_Close          BIGINT,
   @bDeleteAll                   TINYINT
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx        = ISNULL (@twRPersonaIx,        0)
           SET @twRMRootIx          = ISNULL (@twRMRootIx,          0)
           SET @twRMTObjectIx_Close = ISNULL (@twRMTObjectIx_Close, 0)

       DECLARE @SBO_CLASS_RMTOBJECT                       INT = 72
       DECLARE @RMROOT_OP_RMTOBJECT_CLOSE                 INT = 14

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMRoot_Validate @twRPersonaIx, @twRMRootIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                DECLARE @nCount INT

                 SELECT @nCount = COUNT (*)
                   FROM dbo.RMTObject
                  WHERE ObjectHead_Parent_wClass     = @SBO_CLASS_RMTOBJECT
                    AND ObjectHead_Parent_twObjectIx = @twRMTObjectIx_Close

                     IF @twRMTObjectIx_Close <= 0
                        EXEC dbo.call_Error 5,  'twRMTObjectIx_Close is invalid',   @nError OUTPUT
                ELSE IF @bDeleteAll = 0  AND  @nCount > 0
                        EXEC dbo.call_Error 6,  'twRMTObjectIx_Close is not empty', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMRoot_Event_RMTObject_Close @twRMRootIx, @twRMTObjectIx_Close
                     IF @bError = 0
                  BEGIN
                        SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to delete RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMRoot_Log @RMROOT_OP_RMTOBJECT_CLOSE, @sIPAddress, @twRPersonaIx, @twRMRootIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMRoot_RMTObject_Close TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                         MVD_RP1_Map : set_RMRoot_RMTObject_Open.sql                                        **
**                                                                                                                            **
********************************************************************************************************************************
**                              Copyright 2023-2025 Metaversal Corporation. All rights reserved.                              **
*******************************************************************************************************************************/

CREATE PROCEDURE dbo.set_RMRoot_RMTObject_Open
(
   @sIPAddress                   NVARCHAR (16),
   @twRPersonaIx                 BIGINT,
   @twRMRootIx                   BIGINT,
   @Name_wsRMTObjectId           NVARCHAR (48),
   @Type_bType                   TINYINT,
   @Type_bSubtype                TINYINT,
   @Type_bFiction                TINYINT,
   @Owner_twRPersonaIx           BIGINT,
   @Resource_qwResource          BIGINT,
   @Resource_sName               NVARCHAR (48),
   @Resource_sReference          NVARCHAR (128),
   @Transform_Position_dX        FLOAT (53),
   @Transform_Position_dY        FLOAT (53),
   @Transform_Position_dZ        FLOAT (53),
   @Transform_Rotation_dX        FLOAT (53),
   @Transform_Rotation_dY        FLOAT (53),
   @Transform_Rotation_dZ        FLOAT (53),
   @Transform_Rotation_dW        FLOAT (53),
   @Transform_Scale_dX           FLOAT (53),
   @Transform_Scale_dY           FLOAT (53),
   @Transform_Scale_dZ           FLOAT (53),
   @Bound_dX                     FLOAT (53),
   @Bound_dY                     FLOAT (53),
   @Bound_dZ                     FLOAT (53),
   @Properties_bLockToGround     TINYINT,
   @Properties_bYouth            TINYINT,
   @Properties_bAdult            TINYINT,
   @Properties_bAvatar           TINYINT,
   @bCoord                       TINYINT,
   @dA                           FLOAT (53),
   @dB                           FLOAT (53),
   @dC                           FLOAT (53)
)
AS
BEGIN
           SET NOCOUNT ON

           SET @twRPersonaIx = ISNULL (@twRPersonaIx, 0)
           SET @twRMRootIx   = ISNULL (@twRMRootIx,   0)

       DECLARE @SBO_CLASS_RMROOT                          INT = 70
       DECLARE @RMROOT_OP_RMTOBJECT_OPEN                  INT = 13
       DECLARE @RMTMATRIX_COORD_NUL                       INT = 0
       DECLARE @RMTMATRIX_COORD_CAR                       INT = 1
       DECLARE @RMTMATRIX_COORD_CYL                       INT = 2
       DECLARE @RMTMATRIX_COORD_GEO                       INT = 3

            -- Create the temp Error table
        SELECT * INTO #Error FROM dbo.Table_Error ()

       DECLARE @nError  INT = 0,
               @bCommit INT = 0,
               @bError  INT

       DECLARE @ObjectHead_Parent_wClass     SMALLINT,
               @ObjectHead_Parent_twObjectIx BIGINT

       DECLARE @twRMTObjectIx_Open   BIGINT

            -- Create the temp Event table
        SELECT * INTO #Event FROM dbo.Table_Event ()

         BEGIN TRANSACTION

          EXEC dbo.call_RMRoot_Validate @twRPersonaIx, @twRMRootIx, @ObjectHead_Parent_wClass OUTPUT, @ObjectHead_Parent_twObjectIx OUTPUT, @nError OUTPUT

            IF @nError = 0
         BEGIN
                   EXEC dbo.call_RMTObject_Validate_Name       @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Name_wsRMTObjectId, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Type       @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Type_bType, @Type_bSubtype, @Type_bFiction, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Owner      @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Owner_twRPersonaIx, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Resource   @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Resource_qwResource, @Resource_sName, @Resource_sReference, @nError OUTPUT
                -- EXEC dbo.call_RMTObject_Validate_Transform  @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Bound      @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Bound_dX, @Bound_dY, @Bound_dZ, @nError OUTPUT
                   EXEC dbo.call_RMTObject_Validate_Properties @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @nError OUTPUT

                     IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                        EXEC dbo.call_RMTObject_Validate_Coord_Nul @SBO_CLASS_RMROOT, @twRMRootIx, 0, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @nError OUTPUT
                ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                        EXEC dbo.call_RMTObject_Validate_Coord_Car @SBO_CLASS_RMROOT, @twRMRootIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                        EXEC dbo.call_RMTObject_Validate_Coord_Cyl @SBO_CLASS_RMROOT, @twRMRootIx, 0, @dA, @dB, @dC, @nError OUTPUT
                ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                        EXEC dbo.call_RMTObject_Validate_Coord_Geo @SBO_CLASS_RMROOT, @twRMRootIx, 0, @dA, @dB, @dC, @nError OUTPUT
                   ELSE EXEC dbo.call_Error 99, 'bCoord is invalid', @nError OUTPUT
           END

            IF @nError = 0
         BEGIN
                   EXEC @bError = dbo.call_RMRoot_Event_RMTObject_Open @twRMRootIx, @Name_wsRMTObjectId, @Type_bType, @Type_bSubtype, @Type_bFiction, @Owner_twRPersonaIx, @Resource_qwResource, @Resource_sName, @Resource_sReference, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ, @Bound_dX, @Bound_dY, @Bound_dZ, @Properties_bLockToGround, @Properties_bYouth, @Properties_bAdult, @Properties_bAvatar, @twRMTObjectIx_Open OUTPUT
                     IF @bError = 0
                  BEGIN
                              IF @bCoord = 3 -- @RMTMATRIX_COORD_NUL
                                 EXEC dbo.call_RMTMatrix_Nul @SBO_CLASS_RMROOT, @twRMRootIx, @twRMTObjectIx_Open, @Transform_Position_dX, @Transform_Position_dY, @Transform_Position_dZ, @Transform_Rotation_dX, @Transform_Rotation_dY, @Transform_Rotation_dZ, @Transform_Rotation_dW, @Transform_Scale_dX, @Transform_Scale_dY, @Transform_Scale_dZ
                         ELSE IF @bCoord = 2 -- @RMTMATRIX_COORD_CAR
                                 EXEC dbo.call_RMTMatrix_Car                                 @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 1 -- @RMTMATRIX_COORD_CYL
                                 EXEC dbo.call_RMTMatrix_Cyl                                 @twRMTObjectIx_Open, @dA, @dB, @dC
                         ELSE IF @bCoord = 0 -- @RMTMATRIX_COORD_GEO
                                 EXEC dbo.call_RMTMatrix_Geo                                 @twRMTObjectIx_Open, @dA, @dB, @dC

                            EXEC dbo.call_RMTMatrix_Relative @SBO_CLASS_RMROOT, @twRMRootIx, @twRMTObjectIx_Open

                          SELECT @twRMTObjectIx_Open AS twRMTObjectIx
   
                             SET @bCommit = 1
                    END
                   ELSE EXEC dbo.call_Error -1, 'Failed to insert RMTObject'
           END
       
            IF @bCommit = 1
         BEGIN
                    SET @bCommit = 0
                 
                   EXEC @bError = dbo.call_RMRoot_Log @RMROOT_OP_RMTOBJECT_OPEN, @sIPAddress, @twRPersonaIx, @twRMRootIx
                     IF @bError = 0
                  BEGIN
                         EXEC @bError = dbo.call_Event_Push
                           IF @bError = 0
                        BEGIN
                              SET @bCommit = 1
                          END
                         ELSE EXEC dbo.call_Error -9, 'Failed to push events'
                    END
                   ELSE EXEC dbo.call_Error -8, 'Failed to log action'
           END
       
            IF @bCommit = 0
         BEGIN
                 SELECT dwError, sError FROM #Error

               ROLLBACK TRANSACTION
           END
          ELSE COMMIT TRANSACTION

        RETURN @bCommit - 1 - @nError
  END
GO

GRANT EXECUTE ON dbo.set_RMRoot_RMTObject_Open TO WebService
GO

/******************************************************************************************************************************/
/*******************************************************************************************************************************
**                                                                                                                            **
**                                             MVD_RP1_Map : init_DefaultScene.sql                                            **
**                                                                                                                            **
********************************************************************************************************************************
**                            Copyright (c) 2023-2025 Metaversal Corporation. All rights reserved.                            **
*******************************************************************************************************************************/

EXEC dbo.set_RMRoot_RMPObject_Open

   '0.0.0.0',                 -- sIPAddress           
   1,                         -- twRPersonaIx         
   1,                         -- twRMRootIx           
   'My First Scene',          -- Name_wsRMPObjectId   
   1,                         -- Type_bType           
   0,                         -- Type_bSubtype        
   1,                         -- Type_bFiction        
   0,                         -- Type_bMovable        
   1,                         -- Owner_twRPersonaIx   
   0,                         -- Resource_qwResource  
   '',                        -- Resource_sName       
   '',                        -- Resource_sReference  
   0,                         -- Transform_Position_dX
   0,                         -- Transform_Position_dY
   0,                         -- Transform_Position_dZ
   0,                         -- Transform_Rotation_dX
   0,                         -- Transform_Rotation_dY
   0,                         -- Transform_Rotation_dZ
   1,                         -- Transform_Rotation_dW
   1,                         -- Transform_Scale_dX   
   1,                         -- Transform_Scale_dY   
   1,                         -- Transform_Scale_dZ   
   150,                       -- Bound_dX             
   150,                       -- Bound_dY             
   150                        -- Bound_dZ             

-- twRMPObjectIx = 1
GO

EXEC dbo.set_RMPObject_RMPObject_Open

   '0.0.0.0',                 -- sIPAddress           
   1,                         -- twRPersonaIx         
   1,                         -- twRMPObjectIx        
   'Hello World!',            -- Name_wsRMPObjectId   
   1,                         -- Type_bType           
   0,                         -- Type_bSubtype        
   1,                         -- Type_bFiction        
   0,                         -- Type_bMovable        
   1,                         -- Owner_twRPersonaIx   
   0,                         -- Resource_qwResource  
   '',                        -- Resource_sName       
   '/scenes/hello_world.glb', -- Resource_sReference  
   0,                         -- Transform_Position_dX
   0,                         -- Transform_Position_dY
   0,                         -- Transform_Position_dZ
   0,                         -- Transform_Rotation_dX
   0,                         -- Transform_Rotation_dY
   0,                         -- Transform_Rotation_dZ
   1,                         -- Transform_Rotation_dW
   1,                         -- Transform_Scale_dX   
   1,                         -- Transform_Scale_dY   
   1,                         -- Transform_Scale_dZ   
   134.65382385253906,        -- Bound_dX             
   13.596150933846705,        -- Bound_dY             
   129.60743890149325         -- Bound_dZ             

-- twRMPObjectIx = 2
GO

/******************************************************************************************************************************/
