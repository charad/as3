/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 11:50:36 AM
 ********************************
 **/
package be.arnordhaenens.controllers.pictures
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.PictureEvent;
	import be.arnordhaenens.views.components.popup.ImagePopupComponent;
	import be.arnordhaenens.views.mediators.popup.ImagePopupMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	DisplayImagesCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 22, 2011, at 11:50:36 AM
	 * @see		be.arnordhaenens.controllers.pictures.DisplayImagesCommand
	 **/
	public class DisplayImagesCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:ImagePopupComponent;
		[Inject]public var event:PictureEvent;
		
		/**
		 * Constructor
		 **/
		public function DisplayImagesCommand()
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
			_view = new ImagePopupComponent(event.data);
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(ImagePopupComponent))
				mediatorMap.mapView(ImagePopupComponent, ImagePopupMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}