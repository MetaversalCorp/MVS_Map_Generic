const { MVSF         } = require ('@metaversalcorp/mvsf');
const { InitSQL      } = require ('./utils.js');
const Settings      = require ('./settings.json');

const { MVSQL_MYSQL  } = require ('@metaversalcorp/mvsql_mysql');

/*******************************************************************************************************************************
**                                                     Main                                                                   **
*******************************************************************************************************************************/

class AuthSimple
{
   constructor ()
   {
   }

   Exec (bREST, sAction, pConn, Session, pData, fnRSP, fn)
   {
      if (sAction == 'login')
         this.#Login (Session, pData, fnRSP, fn);
      else if (sAction == 'logout')
         this.#Logout (Session, pData, fnRSP, fn);
      else
         fnRSP (fn, { nResult: -1 });
   }

   #Login (Session, pData, fnRSP, fn)
   {
      let pResult = { nResult: -1 };
      
      if (pData && pData.acToken64U_RP1 == Settings.MVSF.sKey)
      {
         pResult.nResult           = 0;
         pResult.sSessionToken     = Settings.MVSF.sKey;

         Session.twRPersonaIx      = 1;
      }

      fnRSP (fn, pResult);
   }

   #Logout (Session, pData, fnRSP, fn)
   {
      Session.twRPersonaIx     = 0;
      
      fnRSP (fn, { nResult: 0 });
   }
}

class MVSF_Map
{
   #pServer;
   #pSQL;

   constructor ()
   {
      switch (Settings.SQL.type)
      {
      case 'MYSQL':         this.#pSQL = new MVSQL_MYSQL (Settings.SQL.config, this.onSQLReady.bind (this)); break;

      default:
         console.log ('No Database was configured for this service.');
         break;
      }
   }

   onSQLReady (pMVSQL, err)
   {
      if (pMVSQL)
      {
         this.#pServer = new MVSF (Settings.MVSF, require ('./handler.json'), __dirname, new AuthSimple (), 'application/json');
         this.#pServer.LoadHtmlSite (__dirname, [ './web/admin', './web/public']);
         this.#pServer.Run ();

         console.log ('SQL Server READY');
         InitSQL (pMVSQL, this.#pServer, Settings.Info);
      }
      else
      {
         console.log ('SQL Server Connect Error: ', err);
      }
   }
}

const g_pServer = new MVSF_Map ();
