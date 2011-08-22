/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 9:20:48 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.notifications
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.ContactFormEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.NotificationEvent;
	import be.arnordhaenens.views.components.notifications.SendingNotificationComponent;
	
	import flash.events.Event;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	SendingNotificationMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 9:20:48 PM
	 * @see		be.arnordhaenens.views.mediators.notifications.SendingNotificationMediator
	 **/
	public class SendingNotificationMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:SendingNotificationComponent;
		
		/**
		 * Constructor
		 **/
		public function SendingNotificationMediator()
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
			eventMap.mapListener(eventDispatcher, ContactFormEvent.MAIL_SEND_SUCCES, removeSendingNotification);
			eventMap.mapListener(eventDispatcher, ContactFormEvent.MAIL_SEND_FAILED, removeSendingNotification);
			
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
			//dispatch function
			//dispatch(new NotificationEvent(NotificationEvent.REMOVE_NOTIFICATION));
			
			//unmap listener
			eventMap.unmapListeners();
			
			//mediatorMap clear
			mediatorMap.unmapView(SendingNotificationComponent);
			mediatorMap.removeMediatorByView(SendingNotificationComponent);
			
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
		
		private function removeSendingNotification(evt:ContactFormEvent):void
		{
			this.view.removeComponent();
		}
		
		private function handleComponentRemove(evt:*):void
		{
			this.view.parent.removeChild(this.view);
		}
	}
}