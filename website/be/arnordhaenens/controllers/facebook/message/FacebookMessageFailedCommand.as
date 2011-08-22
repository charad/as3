/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 1:42:40 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.message
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.facebook.message.FacebookMessageSendFailedComponent;
	import be.arnordhaenens.views.mediators.facebook.message.FacebookMessageSendFailedMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookMessageFailedCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 18, 2011, at 1:42:40 PM
	 * @see		be.arnordhaenens.controllers.facebook.message.FacebookMessageFailedCommand
	 **/
	public class FacebookMessageFailedCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:FacebookMessageSendFailedComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookMessageFailedCommand()
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
			_view = new FacebookMessageSendFailedComponent();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(FacebookMessageSendFailedComponent))
				mediatorMap.mapView(FacebookMessageSendFailedComponent, FacebookMessageSendFailedMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}