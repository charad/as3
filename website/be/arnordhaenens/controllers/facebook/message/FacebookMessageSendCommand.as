/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 1:15:42 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook.message
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.facebook.message.FacebookMessageSendComponent;
	import be.arnordhaenens.views.mediators.facebook.message.FacebookMessageSendMediator;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookMessageSendCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 18, 2011, at 1:15:42 PM
	 * @see		be.arnordhaenens.controllers.facebook.message.FacebookMessageSendCommand
	 **/
	public class FacebookMessageSendCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:FacebookMessageSendComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookMessageSendCommand()
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
			_view = new FacebookMessageSendComponent();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(FacebookMessageSendComponent))
				mediatorMap.mapView(FacebookMessageSendComponent, FacebookMessageSendMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}