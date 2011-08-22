/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 5:42:40 PM
 ********************************
 **/
package be.arnordhaenens.controllers.notifications
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.ContactFormEvent;
	import be.arnordhaenens.services.ContactFormService;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	SendContactFormCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 5:42:40 PM
	 * @see		be.arnordhaenens.controllers.contact.SendContactFormCommand
	 **/
	public class SendContactFormCommand extends Command
	{
		/**
		 * Variables
		 **/
		[Inject]public var event:ContactFormEvent;
		[Inject]public var service:ContactFormService;
		
		/**
		 * Constructor
		 **/
		public function SendContactFormCommand()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Override public function execute
		 * 
		 * When the command has to be executed
		 * Do something and then be destroyed after completion
		 * 
		 * Can be the result of dispatching an event
		 * Can be the result of executing a command directly
		 **/
		override public function execute():void
		{
			//call public function 
			service.sendContactForm(event.data);
		}
	}
}