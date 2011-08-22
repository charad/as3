/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 9:01:07 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.home
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.ComponentEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.views.components.home.HomeView;
	
	import flash.events.Event;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	HomeMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 19, 2011, at 9:01:07 PM
	 * @see		be.arnordhaenens.views.mediators.home.HomeMediator
	 **/
	public class HomeMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:HomeView;
		
		/**
		 * Constructor
		 **/
		public function HomeMediator()
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
			//set the current state to home
			PromositeDC.state = "home";
			
			//map view listeners
			eventMap.mapListener(this.view, ComponentEvent.REMOVED, removeHomeView);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			
			//menu item clicked
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, hideHomeView);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, hideHomeView);
			eventMap.mapListener(eventDispatcher, MenuEvent.FACEBOOK_CLICKED, hideHomeView);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, hideHomeView);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, hideHomeView);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, hideHomeView);
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
			
			var children:int = this.view.numChildren;
			for(var i:int=children; i>0; i--)
			{
				this.view.removeChildAt(i-1);
			}
			
			mediatorMap.unmapView(HomeView);
			mediatorMap.removeMediatorByView(HomeView);
			
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
			//resize the home components
			this.view.handleResize();
		}
		
		/**
		 * Hide the home view
		 **/
		private function hideHomeView(evt:MenuEvent):void
		{
			//remove the home view
			this.view.removeHomeView();
		}
		
		/**
		 * Remove the home view
		 **/
		private function removeHomeView(evt:ComponentEvent):void
		{
			//remove the view from the context
			contextView.removeChild(this.view);
		}
	}
}