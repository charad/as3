/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 21, 2011, at 8:55:35 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.menu
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.views.components.menu.MenuComponent;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	MenuMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 21, 2011, at 8:55:35 PM
	 * @see		be.arnordhaenens.views.mediators.menu.MenuMediator
	 **/
	public class MenuMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:MenuComponent;
		
		/**
		 * Constructor
		 **/
		public function MenuMediator()
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
			eventMap.mapListener(this.view, MenuEvent.HOME_CLICKED, handleHomeClicked);
			eventMap.mapListener(this.view, MenuEvent.ASSIGNMENT_CLICKED, handleAssignmentClicked);
			eventMap.mapListener(this.view, MenuEvent.MOVIES_CLICKED, handleMoviesClicked);
			eventMap.mapListener(this.view, MenuEvent.FACEBOOK_CLICKED, handleFacebookClicked);
			eventMap.mapListener(this.view, MenuEvent.TWITTER_CLICKED, handleTwitterClicked);
			eventMap.mapListener(this.view, MenuEvent.PICTURE_CLICKED, handlePictureClicked);
			eventMap.mapListener(this.view, MenuEvent.CONTACT_CLICKED, handleContactClicked);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			eventMap.mapListener(eventDispatcher, MenuEvent.MENU_CLICKED, handleMenuClicked);
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
			//remove all the event listeners
			eventMap.unmapListeners();
			
			//unmap the component and mediator
			
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
			this.view.handleResize();
		}
		
		/**
		 * Menu link button clicked
		 **/
		private function handleMenuClicked(evt:MenuEvent):void
		{
			//MonsterDebugger.trace(this, "final stage");
			
			if(this.view._grown == false)
				this.view.showMenu();
			else if(this.view._grown == true)
				this.view.hideMenu();
		}
		
		/**
		 * Home Menu Item Clicked
		 **/
		private function handleHomeClicked(evt:MenuEvent):void
		{
			if(PromositeDC.state != "home")
				dispatch(new MenuEvent(MenuEvent.HOME_CLICKED));
		}
		
		/**
		 * Assignment menu item clicked
		 **/
		private function handleAssignmentClicked(evt:MenuEvent):void
		{
			if(PromositeDC.state != "assignment")
				dispatch(new MenuEvent(MenuEvent.ASSIGNMENT_CLICKED));
		}
		
		/**
		 * Movies Menu Item clicked
		 **/
		private function handleMoviesClicked(evt:MenuEvent):void
		{
			if(PromositeDC.state != "movies")
				dispatch(new MenuEvent(MenuEvent.MOVIES_CLICKED));
		}
		
		/**
		 * Facebook menu item clicked
		 **/
		private function handleFacebookClicked(evt:MenuEvent):void
		{
			if(PromositeDC.state != "facebook")
				dispatch(new MenuEvent(MenuEvent.FACEBOOK_CLICKED));
		}
		
		/**
		 * Twitter menu item clicked
		 **/
		private function handleTwitterClicked(evt:MenuEvent):void
		{
			if(PromositeDC.state != "twitter")
				dispatch(new MenuEvent(MenuEvent.TWITTER_CLICKED));
		}
		
		/**
		 * Picture menu item clicked
		 **/
		private function handlePictureClicked(evt:MenuEvent):void
		{
			if(PromositeDC.state != "picture")
				dispatch(new MenuEvent(MenuEvent.PICTURE_CLICKED));
		}
		
		/**
		 * Contact menu item clicked
		 **/
		private function handleContactClicked(evt:MenuEvent):void
		{
			if(PromositeDC.state != "contact")
				dispatch(new MenuEvent(MenuEvent.CONTACT_CLICKED));
		}
	}
}