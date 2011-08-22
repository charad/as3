/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 8:15:37 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.context.PromositeContext;
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.AssignmentEvent;
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.MovieEvent;
	import be.arnordhaenens.events.PictureEvent;
	
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	ApplicationMediator
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 19, 2011, at 8:15:37 PM
	 * @see		be.arnordhaenens.views.mediators.ApplicationMediator
	 **/
	public class ApplicationMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:PromositeDC;
		
		/**
		 * Constructor
		 **/
		public function ApplicationMediator()
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
			//add event listeners to the view
			eventMap.mapListener(view.stage, Event.RESIZE, handleStageResize);			
			
			//add event listeners to the context
			eventMap.mapListener(eventDispatcher, ApplicationEvent.FULLSCREEN, handleFullScreen);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, handleExitFullScreen);
			eventMap.mapListener(eventDispatcher, FacebookEvent.MESSAGE, handleExitFullScreen);
			eventMap.mapListener(eventDispatcher, FacebookEvent.AUTHENTICATION_CLICKED, handleExitFullScreen);
			eventMap.mapListener(eventDispatcher, FacebookEvent.EXIT_FULLSCREEN, handleExitFullScreen);
			eventMap.mapListener(eventDispatcher, MovieEvent.EXIT_FULLSCREEN, handleExitFullScreen);
			eventMap.mapListener(eventDispatcher, PictureEvent.EXIT_FULLSCREEN, handleExitFullScreen);
			eventMap.mapListener(eventDispatcher, AssignmentEvent.EXIT_FULLSCREEN, handleExitFullScreen);
		}
		
		////
		////////////////////////////////
		// Private functions
		////////////////////////////////
		////
		
		/**
		 * Handle the resize of the stage
		 **/
		private function handleStageResize(evt:Event):void
		{
			//dispatch new application event 
			//to notify rest of the application
			dispatch(new ApplicationEvent(ApplicationEvent.RESIZE));
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Handle entering or exiting fullscreen
		 **/
		private function handleFullScreen(evt:ApplicationEvent):void
		{			
			if(this.view.stage.displayState == "normal")
			{
				if(PromositeDC.state != "contact")
					this.view.stage.displayState = StageDisplayState.FULL_SCREEN;
			}
				
			else if(this.view.stage.displayState == "fullScreen")
				this.view.stage.displayState = StageDisplayState.NORMAL;
		}
		
		/**
		 * Handle facebook post message item clicked
		 **/
		private function handleExitFullScreen(evt:*):void
		{
			if(this.view.stage.displayState == "fullScreen")
				this.view.stage.displayState = StageDisplayState.NORMAL;
		}
	}
}