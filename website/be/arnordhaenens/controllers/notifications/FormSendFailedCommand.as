/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 9:33:59 PM
 ********************************
 **/
package be.arnordhaenens.controllers.notifications
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.notifications.FormSendFailedComponent;
	import be.arnordhaenens.views.mediators.notifications.FormSendFailedMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FormSendFailedCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 9:33:59 PM
	 * @see		be.arnordhaenens.controllers.contact.FormSendFailedCommand
	 **/
	public class FormSendFailedCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:FormSendFailedComponent;
		
		/**
		 * Constructor
		 **/
		public function FormSendFailedCommand()
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
			this._view = new FormSendFailedComponent();
			
			//check if it has been mapped
			if(!mediatorMap.hasMapping(FormSendFailedComponent))
				mediatorMap.mapView(FormSendFailedComponent, FormSendFailedMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}