/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 10:36:55 AM
 ********************************
 **/
package be.arnordhaenens.views.mediators.facebook.timeline
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.PopupEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.facebook.timeline.FacebookPostComponent;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	FacebookPostMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 10:36:55 AM
	 * @see		be.arnordhaenens.views.mediators.facebook.timeline.FacebookPostMediator
	 **/
	public class FacebookPostMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:FacebookPostComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookPostMediator()
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
			eventMap.mapListener(this.view, PopupEvent.CREATE_POPUP, handleCreatePopup);
			eventMap.mapListener(this.view, FacebookEvent.EXIT_FULLSCREEN, handleExitFullScreen);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			
			//map listeners to the facebook menu
			//eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_TIMELINE, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_FRIENDS, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_PHOTOS, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.MESSAGE, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOGOUT, handleRemoveComponent);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, handleRemoveComponent);
			
			eventMap.mapListener(eventDispatcher, PopupEvent.REMOVED_POPUP, handlePopupRemoved);
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
			
			//unmap the view
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
		 * Remove the component after the tween is complete
		 **/
		private function removeComponentAfterTweenComplete():void
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
		 * Remove the view
		 **/
		private function handleRemoveComponent(evt:FacebookEvent):void
		{
			//Tween the component
			//onComplete remove the view from it's parent
			TweenMax.to(this.view, .5, {x:(this.view.stage.stageWidth + this.view.width), alpha:0, blurFilter:{blurX:20, blurY:20}, onComplete:removeComponentAfterTweenComplete});
		}
		
		/**
		 * Handle creation of popup
		 **/
		private function handleCreatePopup(evt:PopupEvent):void
		{
			//dispatch event to whole application
			dispatch(new PopupEvent(PopupEvent.CREATE_POPUP, evt.data));
			
			//blurfilter
			//dropshadowfilter
			this.view.filters = [ArnorFilterClass.createDropShadowFilter(), ArnorFilterClass.createBlurFilter()];
		}
		
		/**
		 * When popup is removed
		 * Remove the blur filter
		 **/
		private function handlePopupRemoved(evt:PopupEvent):void
		{
			//only drop shadow filter
			this.view.filters = [ArnorFilterClass.createDropShadowFilter()];
		}
		
		/**
		 * Exit fullscreen display state
		 **/
		private function handleExitFullScreen(evt:FacebookEvent):void
		{
			dispatch(new FacebookEvent(FacebookEvent.EXIT_FULLSCREEN));
		}
	}
}