/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 9:32:32 PM
 ********************************
 **/
package be.arnordhaenens.controllers.notifications
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.notifications.FormIncorrectComponent;
	import be.arnordhaenens.views.mediators.notifications.FormIncorrectMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FormIncorrectNotificationCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 9:32:32 PM
	 * @see		be.arnordhaenens.controllers.contact.FormIncorrectNotificationCommand
	 **/
	public class FormIncorrectNotificationCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:FormIncorrectComponent;
		
		/**
		 * Constructor
		 **/
		public function FormIncorrectNotificationCommand()
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
			this._view = new FormIncorrectComponent();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(FormIncorrectComponent))
				mediatorMap.mapView(FormIncorrectComponent, FormIncorrectMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}