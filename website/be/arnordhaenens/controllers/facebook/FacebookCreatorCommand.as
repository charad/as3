/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 29, 2011, at 11:30:50 PM
 ********************************
 **/
package be.arnordhaenens.controllers.facebook
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.facebook.FacebookView;
	import be.arnordhaenens.views.mediators.facebook.FacebookMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	FacebookCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 29, 2011, at 11:30:50 PM
	 * @see		be.arnordhaenens.controllers.facebook.FacebookCreatorCommand
	 **/
	public class FacebookCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:FacebookView;
		
		/**
		 * Constructor
		 **/
		public function FacebookCreatorCommand()
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
			this._view = new FacebookView();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(FacebookView))
				mediatorMap.mapView(FacebookView, FacebookMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}