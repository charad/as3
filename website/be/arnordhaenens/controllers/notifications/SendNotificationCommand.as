/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 8:19:51 PM
 ********************************
 **/
package be.arnordhaenens.controllers.notifications
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.notifications.SendNotificationComponent;
	import be.arnordhaenens.views.mediators.notifications.SendNotificationMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	SendNotificationCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 8:19:51 PM
	 * @see		be.arnordhaenens.controllers.notifications.SendNotificationCommand
	 **/
	public class SendNotificationCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:SendNotificationComponent;
		
		/**
		 * Constructor
		 **/
		public function SendNotificationCommand()
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
			this._view = new SendNotificationComponent();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(SendNotificationComponent))
				mediatorMap.mapView(SendNotificationComponent, SendNotificationMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}