/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 10:30:43 PM
 ********************************
 **/
package be.arnordhaenens.controllers.pictures
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.views.components.pictures.PictureView;
	import be.arnordhaenens.views.mediators.pictures.PictureMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	PictureCreatorCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 10:30:43 PM
	 * @see		be.arnordhaenens.controllers.PictureCreatorCommand
	 **/
	public class PictureCreatorCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:PictureView;
		
		/**
		 * Constructor
		 **/
		public function PictureCreatorCommand()
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
			_view = new PictureView();
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(PictureView))
				mediatorMap.mapView(PictureView, PictureMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}