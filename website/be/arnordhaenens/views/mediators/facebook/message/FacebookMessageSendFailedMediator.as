/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 1:46:53 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.facebook.message
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.views.components.facebook.message.FacebookMessageSendFailedComponent;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	FacebookMessageSendFailedMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 18, 2011, at 1:46:53 PM
	 * @see		be.arnordhaenens.views.mediators.facebook.message.FacebookMessageSendFailedMediator
	 **/
	public class FacebookMessageSendFailedMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:FacebookMessageSendFailedComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookMessageSendFailedMediator()
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
			
			//map event listeners to the facebook menu items
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_TIMELINE, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_PHOTOS, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_FRIENDS, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.MESSAGE, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOGOUT, handleRemoveComponent);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, handleRemoveComponent);
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
			mediatorMap.unmapView(FacebookMessageSendFailedComponent);
			
			//remove mediator
			mediatorMap.removeMediatorByView(FacebookMessageSendFailedComponent);
			
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
		
		/**
		 * Handle view's tween complete for remove
		 **/
		private function handleRemoveTweenComplete():void
		{
			//remove the view from it's parent
			this.view.parent.removeChild(this.view);
		}
		
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
			//call public function to reposition the view
			this.view.handleResize();
		}
		
		/**
		 * Handle remove of the component
		 **/
		private function handleRemoveComponent(evt:*):void
		{
			TweenMax.to(this.view, 1, {alpha:0, blurFilter:{blurX:20, blurY:20}, scaleX:0, scaleY:0, onComplete:handleRemoveTweenComplete});
		}
	}
}