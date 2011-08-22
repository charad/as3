/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 2:21:06 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.facebook.welcome
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.views.components.facebook.welcome.FacebookWelcomeComponent;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	FacebookWelcomeMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 2:21:06 PM
	 * @see		be.arnordhaenens.views.mediators.facebook.welcome.FacebookWelcomeMediator
	 **/
	public class FacebookWelcomeMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:FacebookWelcomeComponent;
		
		/**
		 * Constructor
		 **/
		public function FacebookWelcomeMediator()
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
			
			//add event listeners for the facebook menu
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_TIMELINE, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOAD_FRIENDS, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.MESSAGE, handleRemoveComponent);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOGOUT, handleRemoveComponent);
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
			//unmap the listeners
			eventMap.unmapListeners();
			
			//remove the mediator
			mediatorMap.removeMediatorByView(FacebookWelcomeComponent);
			
			//unmap the view
			mediatorMap.unmapView(FacebookWelcomeComponent);
			
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
		 * Handle the tween fro removing the component complete
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
			//call the public function from the view
			this.view.handleResize();
		}
		
		/**
		 * Handle the removement of the component
		 **/
		private function handleRemoveComponent(evt:FacebookEvent):void
		{
			//tween the component
			//after the tween is complete
			//remove the component
			TweenMax.to(this.view, 1, {alpha:0, blurFilter:{blurX:20, blurY:20}, scaleX:0, scaleY:0, onComplete:handleRemoveTweenComplete});
		}
	}
}