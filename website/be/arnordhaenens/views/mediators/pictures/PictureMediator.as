/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 9:39:01 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.pictures
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.PictureEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.pictures.PictureView;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	PictureMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 9:39:01 PM
	 * @see		be.arnordhaenens.views.mediators.pictures.PictureMediator
	 **/
	public class PictureMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:PictureView;
		
		/**
		 * Constructor
		 **/
		public function PictureMediator()
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
			PromositeDC.state = "picture";
			
			//map view listeners
			eventMap.mapListener(this.view, PictureEvent.LOAD_PICTURE_ASSIGNMENTS, handleLoadPictureAssignments);
			//eventMap.mapListener(this.view, PictureEvent.LOAD_IMAGES, handleLoadImagesAssignment);
			eventMap.mapListener(this.view, PictureEvent.DISPLAY_IMAGES, handleDisplayImages);
			eventMap.mapListener(this.view, PictureEvent.EXIT_FULLSCREEN, handleExitFullscreen);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, removePictureView);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, removePictureView);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, removePictureView);
			eventMap.mapListener(eventDispatcher, MenuEvent.FACEBOOK_CLICKED, removePictureView);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, removePictureView);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, removePictureView);
			
			eventMap.mapListener(eventDispatcher, PictureEvent.PICTURE_ASSIGNMENTS_LOADED, handleAssignmentsLoaded);
			eventMap.mapListener(eventDispatcher, PictureEvent.DISPLAY_IMAGES_REMOVED, handleImageDisplayRemoved);
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
			
			//unmap and remove mediator
			mediatorMap.unmapView(PictureView);
			mediatorMap.removeMediatorByView(PictureView);
			
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
		private function removePictureView(evt:*):void
		{
			this.view.parent.removeChild(this.view);
		}
		
		/**
		 * Load the picture assignments
		 **/
		private function handleLoadPictureAssignments(evt:PictureEvent):void
		{
			dispatch(new PictureEvent(PictureEvent.LOAD_PICTURE_ASSIGNMENTS));
		}
		
		/**
		 * Load the images for an assignment
		 **/
		private function handleLoadImagesAssignment(evt:PictureEvent):void
		{
			dispatch(new PictureEvent(PictureEvent.LOAD_IMAGES, evt.data));
		}
		
		/**
		 * Handle exit fullscreen
		 **/
		private function handleExitFullscreen(evt:PictureEvent):void
		{
			dispatch(new PictureEvent(PictureEvent.EXIT_FULLSCREEN));
		}
		
		/**
		 * handle assignment loaded
		 **/
		private function handleAssignmentsLoaded(evt:PictureEvent):void
		{
			//call public function from view
			this.view.handleAssignmentsLoaded(evt.data);
		}
		
		/**
		 * Handle assignment images loaded
		 **/
		private function handleAssignmentImagesLoaded(evt:PictureEvent):void
		{
			
		}
		
		/**
		 * Handle the display of the images
		 **/
		private function handleDisplayImages(evt:PictureEvent):void
		{
			//dispatch event
			dispatch(new PictureEvent(PictureEvent.DISPLAY_IMAGES, evt.data));
			
			//disable the components
			this.view.disableButtons();
			
			//set the filters for the view
			this.view.filters = [ArnorFilterClass.createBlurFilter()];
		}
		
		/**
		 * Handle image display removed
		 **/
		private function handleImageDisplayRemoved(evt:PictureEvent):void
		{
			//enable the components
			this.view.enableButtons();
			
			//remove the filters
			this.view.filters = [];
		}
	}
}