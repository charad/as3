/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 9:24:32 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.notifications
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.NotificationEvent;
	import be.arnordhaenens.views.components.notifications.FormIncorrectComponent;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	FormIncorrectMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 9:24:32 PM
	 * @see		be.arnordhaenens.views.mediators.notifications.FormIncorrectMediator
	 **/
	public class FormIncorrectMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:FormIncorrectComponent;
		
		/**
		 * Constructor
		 **/
		public function FormIncorrectMediator()
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
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.FACEBOOK_CLICKED, handleComponentRemove);
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
			//dispatch event
			dispatch(new NotificationEvent(NotificationEvent.REMOVE_NOTIFICATION));
			
			//unmap listeners
			eventMap.unmapListeners();
			
			//mediatormap
			mediatorMap.unmapView(FormIncorrectComponent);
			mediatorMap.removeMediatorByView(FormIncorrectComponent);
			
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
			//call public function 
			this.view.handleResize();
		}
		
		private function handleComponentRemove(evt:*):void
		{
			this.view.parent.removeChild(this.view);
		}
	}
}