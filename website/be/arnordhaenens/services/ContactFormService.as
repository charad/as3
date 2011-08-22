/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 4:52:07 PM
 ********************************
 **/
package be.arnordhaenens.services
{
	import be.arnordhaenens.events.ContactFormEvent;
	
	import flash.net.Responder;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ContactFormService
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 24, 2011, at 4:52:07 PM
	 * @see		be.arnordhaenens.services.ContactFormService
	 **/
	public class ContactFormService extends myService
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function ContactFormService()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Send mail
		 **/
		public function sendContactForm(data:Array):void
		{
			responder = new Responder(handleContactFormSendResult, handleFault);
			connection.call("ContactService.sendContactForm", responder, data);
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
		
		/**
		 * Handle result contact form
		 **/
		private function handleContactFormSendResult(result:Object):void
		{
			MonsterDebugger.trace(this, result);
			
			if(result == "success")
				dispatch(new ContactFormEvent(ContactFormEvent.MAIL_SEND_SUCCES));
			else if(result == "failed")
				dispatch(new ContactFormEvent(ContactFormEvent.MAIL_SEND_FAILED));
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
	}
}