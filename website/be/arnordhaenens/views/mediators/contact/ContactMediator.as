/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 23, 2011, at 2:48:35 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.contact
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.ContactFormEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.NotificationEvent;
	import be.arnordhaenens.views.components.contact.ContactView;
	
	import flash.events.Event;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	ContactMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 23, 2011, at 2:48:35 PM
	 * @see		be.arnordhaenens.views.mediators.contact.ContactMediator
	 **/
	public class ContactMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:ContactView;
		
		/**
		 * Constructor
		 **/
		public function ContactMediator()
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
			//set the current state
			PromositeDC.state = "contact";
			
			//set view listeners
			eventMap.mapListener(this.view, ContactFormEvent.SENDING_FORM, handleContactFormSubmit);
			eventMap.mapListener(this.view, ContactFormEvent.NOT_CORRECT_YET, handleFormNotCorrectYet);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			eventMap.mapListener(eventDispatcher, NotificationEvent.REMOVE_NOTIFICATION, handleNotificationRemoved);
			eventMap.mapListener(eventDispatcher, ContactFormEvent.MAIL_SEND_SUCCES, handleMailSendSucces);
			
			//menu item clicked
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, removeContactView);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, removeContactView);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, removeContactView);
			eventMap.mapListener(eventDispatcher, MenuEvent.FACEBOOK_CLICKED, removeContactView);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, removeContactView);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, removeContactView);
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
			//unmap all the event listeners from the eventMap
			eventMap.unmapListeners();
			
			//unmap mediator
			mediatorMap.unmapView(ContactView);
			mediatorMap.removeMediatorByView(ContactView);
			
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
			//call public function to resize / reposition the elements
			this.view.handleResize();
		}
		
		/**
		 * Handle contact form send
		 **/
		private function handleContactFormSubmit(evt:ContactFormEvent):void
		{
			dispatch(new ContactFormEvent(ContactFormEvent.SENDING_FORM, evt.data));
			this.view.setBlurFilter();
		}
		
		/**
		 * Handle contact form not correct yet
		 **/
		private function handleFormNotCorrectYet(evt:ContactFormEvent):void
		{
			dispatch(new ContactFormEvent(ContactFormEvent.NOT_CORRECT_YET));
			this.view.setBlurFilter();
		}
		
		/**
		 * Remove the contact view
		 **/
		private function removeContactView(evt:MenuEvent):void
		{
			this.view.parent.removeChild(this.view);
		}
		
		/**
		 * When notification is removed
		 **/
		private function handleNotificationRemoved(evt:NotificationEvent):void
		{
			//remove the blur filter
			this.view.removeBlurFilter();
		}
		
		/**
		 * Handle mail send succes
		 **/
		private function handleMailSendSucces(evt:ContactFormEvent):void
		{
			//reset the form
			this.view.resetContactform();
		}
	}
}