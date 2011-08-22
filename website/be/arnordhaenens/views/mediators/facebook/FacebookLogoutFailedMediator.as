/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 2:32:15 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.facebook
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.views.components.facebook.FacebookLogoutFailedComponent;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	FacebookLogoutFailedMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 18, 2011, at 2:32:15 PM
	 * @see		be.arnordhaenens.views.mediators.facebook.FacebookLogoutFailedMediator
	 **/
	public class FacebookLogoutFailedMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:FacebookLogoutFailedComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookLogoutFailedMediator()
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
			
			//map facebook menu listeners
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_TIMELINE, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_FRIENDS, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_PHOTOS, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, FacebookEvent.MESSAGE, handleComponentRemove);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, handleComponentRemove);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, handleComponentRemove);
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
			//unmap listeners
			eventMap.unmapListeners();
			
			//unmap view
			mediatorMap.unmapView(FacebookLogoutFailedComponent);
			
			//remove mediator
			mediatorMap.removeMediatorByView(FacebookLogoutFailedComponent);
			
			
			
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
		 * Handle tween remove complete
		 **/
		private function handleComponentTweenRemoveComplete():void
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
			//call public function
			this.view.handleResize();
		}
		
		/**
		 * Handle remove of the component
		 **/
		private function handleComponentRemove(evt:*):void
		{
			TweenMax.to(this.view, 1, {alpha:0, scaleX:0, scaleY:0, blurFilter:{blurX:20, blurY:20}, onComplete:handleComponentTweenRemoveComplete});
		}
	}
}