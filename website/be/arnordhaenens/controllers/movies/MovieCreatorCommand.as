/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 9:18:03 PM
 ********************************
 **/
package be.arnordhaenens.controllers.movies
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.movies.MovieView;
	import be.arnordhaenens.views.mediators.movies.MoviesMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	MovieCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 9:18:03 PM
	 * @see		be.arnordhaenens.controllers.movies.MovieCreatorCommand
	 **/
	public class MovieCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:MovieView;
		
		/**
		 * Constructor
		 **/
		public function MovieCreatorCommand()
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
			_view = new MovieView();
			
			//check if it has been mapped
			if(!mediatorMap.hasMapping(MovieView))
				mediatorMap.mapView(MovieView, MoviesMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}