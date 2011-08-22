/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 2:37:41 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.facebook.FacebookLogoutFailedComponent;
	import be.arnordhaenens.views.mediators.facebook.FacebookLogoutFailedMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookLogoutFailedCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 18, 2011, at 2:37:41 PM
	 * @see		be.arnordhaenens.controllers.facebook.FacebookLogoutFailedCommand
	 **/
	public class FacebookLogoutFailedCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:FacebookLogoutFailedComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookLogoutFailedCommand()
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
			_view = new FacebookLogoutFailedComponent();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(FacebookLogoutFailedComponent))
				mediatorMap.mapView(FacebookLogoutFailedComponent, FacebookLogoutFailedMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}