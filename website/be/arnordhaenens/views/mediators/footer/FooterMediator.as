/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 10:23:23 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.footer
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.FooterEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.views.components.footer.FooterComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	FooterMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 19, 2011, at 10:23:23 PM
	 * @see		be.arnordhaenens.views.mediators.footer.FooterMediator
	 **/
	public class FooterMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:FooterComponent;
		
		/**
		 * Constructor
		 **/
		public function FooterMediator()
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
			eventMap.mapListener(this.view, FooterEvent.ARNOR_CLICKED, handleArnorClick);
			eventMap.mapListener(this.view, FooterEvent.FULLSCREEN_CLICKED, handleFullScreenClick);
			eventMap.mapListener(this.view, FooterEvent.MENU_CLICKED, handleMenuClicked);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
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
			//call the public resize function for the footer component
			this.view.handleResize();
		}
		
		/**
		 * Handle click on the arnor.be logo
		 * Call public function of the component
		 **/
		private function handleArnorClick(evt:FooterEvent):void
		{
			//call public function
			this.view.arnor.gotoArnor();
		}
		
		/**
		 * Handle Fullscreen clicked
		 **/
		private function handleFullScreenClick(evt:FooterEvent):void
		{
			//call public function 
			this.view.fullscreen.handleClicked();
			
			//dispatch event to the rest of the application
			dispatch(new ApplicationEvent(ApplicationEvent.FULLSCREEN));
		}
		
		/**
		 * Clicked on the menu link button
		 **/
		private function handleMenuClicked(evt:FooterEvent):void
		{
			dispatch(new MenuEvent(MenuEvent.MENU_CLICKED));
			//MonsterDebugger.trace(this, "footer mediator");
		}
		
	}
}