/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 17, 2011, at 12:54:41 PM
 ********************************
 **/
package be.arnordhaenens.services
{
	import be.arnordhaenens.events.FacebookEvent;
	
	import flash.net.Responder;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	FacebookService
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 17, 2011, at 12:54:41 PM
	 * @see		be.arnordhaenens.services.FacebookService
	 **/
	public class FacebookService extends myService
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function FacebookService()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		/**
		 * Save uid and access token to the database
		 **/
		public function saveUidToken(data:Array):void
		{
			//MonsterDebugger.trace(this, "<!--FACEBOOK SERVICE SAVE UID TOKEN-->");
			
			//grab the data
			var uid:String = data[0].toString();
			var token:String = data[1].toString();
			
			//create new responder
			responder = new Responder(handleSaveUidToken, handleFault);
			
			//call the function
			connection.call("FacebookService.saveUidToken", responder, uid, token);
		}
		
		/**
		 * Get access token for given uid
		 **/
		public function getAccessToken(data:Array):void
		{
			//MonsterDebugger.trace(this, "<!--FACEBOOK SERVICE GET TOKEN-->");
			
			//grab the data
			var uid:String = data[0].toString();
			
			//create new responder
			responder = new Responder(handleGetAccessToken, handleFault);
			
			//call the function from the service
			connection.call("FacebookService.getToken", responder, uid);
		}
		
		////
		////////////////////////////////
		// Protected functions
		////////////////////////////////
		////
		
		////
		////////////////////////////////
		// Private functions
		////////////////////////////////
		////
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		/**
		 * Handle return save uid & token
		 **/
		private function handleSaveUidToken(result:Object):void
		{
			if(result)
				dispatch(new FacebookEvent(FacebookEvent.SAVED_UID_TOKEN));
			else
				MonsterDebugger.trace(this, "saved failed" + result);
		}
		
		/**
		 * Handle the return of the getAccessToken function
		 **/
		private function handleGetAccessToken(result:Object):void
		{
			if(result)
				dispatch(new FacebookEvent(FacebookEvent.ACCES_TOKEN_RETURN, result));
			else
				MonsterDebugger.trace(this, "get access token failed" + result);
		}
	}
}