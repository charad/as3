/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 9:31:28 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.assignments
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.AssignmentEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.assignments.AssignmentView;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	AssignmentMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 9:31:28 PM
	 * @see		be.arnordhaenens.views.mediators.assignments.AssignmentMediator
	 **/
	public class AssignmentMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:AssignmentView;
		
		/**
		 * Constructor
		 **/
		public function AssignmentMediator()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		/**
		 * Override onRegister
		 * 
		 * Dispatched when everything is constructed
		 * and is ready to interact with the application
		 **/
		override public function onRegister():void
		{
			//set the state
			PromositeDC.state = "assignment";
			
			//map view listeners
			eventMap.mapListener(this.view, AssignmentEvent.EXIT_FULLSCREEN, handleExitFullScreen);
			eventMap.mapListener(this.view, AssignmentEvent.DISPLAY_IMAGES, handleDisplayImages);
			eventMap.mapListener(this.view, AssignmentEvent.LOAD_ASSIGNMENTS, handleLoadAssignments);
			eventMap.mapListener(this.view, AssignmentEvent.DISPLAY_VIDEOS, handleDisplayVideos);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, removeAssignmentView);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, removeAssignmentView);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, removeAssignmentView);
			eventMap.mapListener(eventDispatcher, MenuEvent.FACEBOOK_CLICKED, removeAssignmentView);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, removeAssignmentView);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, removeAssignmentView);
			
			eventMap.mapListener(eventDispatcher, AssignmentEvent.ASSIGNMENTS_LOADED, handleAssignmentsLoaded);
			eventMap.mapListener(eventDispatcher, AssignmentEvent.DISPLAY_IMAGES_REMOVED, handlePopupRemoved);
			eventMap.mapListener(eventDispatcher, AssignmentEvent.DISPLAY_VIDEOS_REMOVED, handlePopupRemoved);
		}
		
		/**
		 * Override onRemove
		 * 
		 * Dispatched when just being deleted from the stage
		 * 
		 * Remove all mapping of events
		 * Remove all instances of this mediator and view
		 * 
		 * Limitation of memory / CPU use!!
		 * Important for mobile devices
		 **/
		override public function onRemove():void
		{
			//unmap event listeners
			eventMap.unmapListeners();
			
			//unmap view
			mediatorMap.unmapView(AssignmentView);
			
			//remove mediator
			mediatorMap.removeMediatorByView(AssignmentView);
			
			//call the parent onremove function,
			//so that we won't forget something
			super.onRemove();
		}
		
		////
		////////////////////////////////
		// Protected functions
		////////////////////////////////
		////
		
		////
		////////////////////////////////
		// Private functions
		////////////////////////////////
		////
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Load the assignments
		 **/
		private function handleLoadAssignments(evt:AssignmentEvent):void
		{
			//dispatch the event
			dispatch(new AssignmentEvent(AssignmentEvent.LOAD_ASSIGNMENTS));
		}
		
		/**
		 * Handle exit fullscreen
		 **/
		private function handleExitFullScreen(evt:AssignmentEvent):void
		{
			dispatch(new AssignmentEvent(AssignmentEvent.EXIT_FULLSCREEN));
		}
		
		/**
		 * Display the images
		 **/
		private function handleDisplayImages(evt:AssignmentEvent):void
		{
			//display the images
			dispatch(new AssignmentEvent(AssignmentEvent.DISPLAY_IMAGES, evt.data));
			
			//disable the buttons
			this.view.disableButtons();
			
			//show the blurfilter
			this.view.filters = [ArnorFilterClass.createBlurFilter()];
		}
		
		/**
		 * Handle display videos
		 **/
		private function handleDisplayVideos(evt:AssignmentEvent):void
		{
			//display the videos
			dispatch(new AssignmentEvent(AssignmentEvent.DISPLAY_VIDEOS, evt.data));
			
			//disable the buttons
			this.view.disableButtons();
			
			//show the blurfilter
			this.view.filters = [ArnorFilterClass.createBlurFilter()];
		}
		
		/**
		 * Handle the resize of the stage / window
		 * This for the components on the HOME-view
		 **/
		private function handleStageResize(evt:ApplicationEvent):void
		{
			this.view.handleResize();
		}
		
		/**
		 * Remove the view from it's parent
		 **/
		private function removeAssignmentView(evt:*):void
		{
			this.view.parent.removeChild(this.view);
		}
		
		/**
		 * Handle the assignments loaded
		 **/
		private function handleAssignmentsLoaded(evt:AssignmentEvent):void
		{
			//call public function from the view to display the data
			this.view.handleAssignmentsLoaded(evt.data);
		}
		
		/**
		 * Handle popup removed
		 **/
		private function handlePopupRemoved(evt:AssignmentEvent):void
		{
			//enable the buttons
			this.view.enableButtons();
			
			//remove the filters
			this.view.filters = [];
		}
	}
}