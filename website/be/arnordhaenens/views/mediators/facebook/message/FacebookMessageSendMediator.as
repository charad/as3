/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 1:24:59 PM
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
	import be.arnordhaenens.views.components.facebook.message.FacebookMessageSendComponent;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	FacebookMessageSendMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 18, 2011, at 1:24:59 PM
	 * @see		be.arnordhaenens.views.mediators.facebook.message.FacebookMessageSendMediator
	 **/
	public class FacebookMessageSendMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:FacebookMessageSendComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookMessageSendMediator()
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
			
			//add facebook menu event listeners
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
			mediatorMap.unmapView(this.view);
			
			//remove the mediator
			mediatorMap.removeMediatorByView(this.view);

			
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
		 * Handle component tween complete
		 **/
		private function handleTweenRemoveComplete():void
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
			//call public function view to resize component
			this.view.handleResize();
		}
		
		/**
		 * Remove the component
		 **/
		private function handleRemoveComponent(evt:*):void
		{
			TweenMax.to(this.view, 1, {scaleX:0, scaleY:0, blurFilter:{blurX:20, blurY:20}, alpha:0, onComplete:handleTweenRemoveComplete});
		}
	}
}