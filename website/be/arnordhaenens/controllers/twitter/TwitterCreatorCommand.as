/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 26, 2011, at 5:17:02 PM
 ********************************
 **/
package be.arnordhaenens.controllers.twitter
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.twitter.TwitterView;
	import be.arnordhaenens.views.mediators.twitter.TwitterMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	TwitterCommand
	 * @author	D'Haenens Arnor
	 * @since	Jul 26, 2011, at 5:17:02 PM
	 * @see		be.arnordhaenens.controllers.twitter.TwitterCommand
	 **/
	public class TwitterCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:TwitterView;
		
		/**
		 * Constructor
		 **/
		public function TwitterCreatorCommand()
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
			this._view = new TwitterView();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(TwitterView))
				mediatorMap.mapView(TwitterView, TwitterMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}