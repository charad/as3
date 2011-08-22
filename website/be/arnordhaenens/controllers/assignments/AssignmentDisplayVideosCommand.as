/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 8:40:14 PM
 ********************************
 **/
package be.arnordhaenens.controllers.assignments
{	
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.AssignmentEvent;
	import be.arnordhaenens.views.components.popup.VideoPopupComponent;
	import be.arnordhaenens.views.mediators.popup.AssignmentVideoPopupMediator;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * Class	AssignmentDisplayVideosCommand
	 * @author	D'Haenens Arnor
	 * @since	Aug 22, 2011, at 8:40:14 PM
	 * @see		be.arnordhaenens.controllers.assignments.AssignmentDisplayVideosCommand
	 **/
	public class AssignmentDisplayVideosCommand extends Command
	{
		/**
		 * Variables
		 **/
		private var _view:VideoPopupComponent;
		[Inject]public var event:AssignmentEvent;
		
		/**
		 * Constructor
		 **/
		public function AssignmentDisplayVideosCommand()
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
			_view = new VideoPopupComponent(event.data);
			
			//check if it has been mapped
			if(!mediatorMap.hasMediatorForView(VideoPopupComponent))
				mediatorMap.mapView(VideoPopupComponent, AssignmentVideoPopupMediator);
			
			//add child to the context view
			contextView.addChild(_view);
		}
	}
}