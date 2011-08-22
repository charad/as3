/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 1:47:40 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.popup
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.AssignmentEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.views.components.popup.ImagePopupComponent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	ImagePopupMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 22, 2011, at 1:47:40 PM
	 * @see		be.arnordhaenens.views.mediators.popup.ImagePopupMediator
	 **/
	public class AssignmentImagePopupMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:ImagePopupComponent;
		
		/**
		 * Constructor
		 **/
		public function AssignmentImagePopupMediator()
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
			//map view listeners
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.FACEBOOK_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, handleRemoveComponent);
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
			dispatch(new AssignmentEvent(AssignmentEvent.DISPLAY_IMAGES_REMOVED));
			
			eventMap.unmapListeners();
			
			mediatorMap.unmapView(ImagePopupComponent);
			mediatorMap.removeMediatorByView(ImagePopupComponent);
			
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
			//call public function view
			this.view.handleResize();
		}
		
		/**
		 * Handle remove component
		 **/
		private function handleRemoveComponent(evt:*):void
		{
			this.view.parent.removeChild(this.view);
		}
	}
}