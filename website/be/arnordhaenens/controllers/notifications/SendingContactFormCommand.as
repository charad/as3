/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 9:30:54 PM
 ********************************
 **/
package be.arnordhaenens.controllers.notifications
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.notifications.SendingNotificationComponent;
	import be.arnordhaenens.views.mediators.notifications.SendingNotificationMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	SendingContactFormCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 9:30:54 PM
	 * @see		be.arnordhaenens.controllers.contact.SendingContactFormCommand
	 **/
	public class SendingContactFormCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:SendingNotificationComponent;
		
		/**
		 * Constructor
		 **/
		public function SendingContactFormCommand()
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
			//create new instance
			this._view = new SendingNotificationComponent();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(SendingNotificationComponent))
				mediatorMap.mapView(SendingNotificationComponent, SendingNotificationMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}