/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 8:02:18 PM
 ********************************
 **/
package be.arnordhaenens.controllers.assignments
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.AssignmentEvent;
	import be.arnordhaenens.views.components.assignments.AssignmentInfoComponent;
	import be.arnordhaenens.views.components.popup.ImagePopupComponent;
	import be.arnordhaenens.views.mediators.popup.AssignmentImagePopupMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	AssignmentDisplayImagesCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 22, 2011, at 8:02:18 PM
	 * @see		be.arnordhaenens.controllers.assignments.AssignmentDisplayImagesCommand
	 **/
	public class AssignmentDisplayImagesCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:ImagePopupComponent;
		[Inject]public var event:AssignmentEvent;
		
		/**
		 * Constructor
		 **/
		public function AssignmentDisplayImagesCommand()
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
				mediatorMap.mapView(ImagePopupComponent, AssignmentImagePopupMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}