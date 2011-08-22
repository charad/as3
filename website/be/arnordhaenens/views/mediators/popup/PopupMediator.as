/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 4:56:46 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.popup
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.PopupEvent;
	import be.arnordhaenens.views.components.popup.PopUpComponent;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	PopupMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 4:56:46 PM
	 * @see		be.arnordhaenens.views.mediators.popup.PopupMediator
	 **/
	public class PopupMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:PopUpComponent;
		
		/**
		 * Constructor
		 **/
		public function PopupMediator()
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
			eventMap.mapListener(this.view.btnClose, MouseEvent.CLICK, handleBtnCloseClick);
			eventMap.mapListener(this.view, PopupEvent.VIDEO_ENDED, handleBtnCloseClick);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, handleBtnCloseClick);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, handleBtnCloseClick);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, handleBtnCloseClick);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, handleBtnCloseClick);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, handleBtnCloseClick);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, handleBtnCloseClick);
			
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
			
			//unmap
			mediatorMap.unmapView(PopUpComponent);
			mediatorMap.removeMediatorByView(PopUpComponent);
			
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
		 * Remove the view from it's parent
		 **/
		private function removeView():void
		{
			//dispatch event
			dispatch(new PopupEvent(PopupEvent.REMOVED_POPUP));
			
			this.view.destroyVideo();
			
			//remove view from parent
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
			this.view.handleResize();
		}
		
		/**
		 * Handle clicked on button close
		 **/
		private function handleBtnCloseClick(evt:*):void
		{
			TweenMax.to(this.view, .5, {blurFilter:{blurX:20, blurY:20}, alpha:0, scaleX:0, scaleY:0, onComplete:removeView});
		}
	}
}