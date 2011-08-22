/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 9:42:01 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.views.components.ArteveldeLogo;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	ArteveldeMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 19, 2011, at 9:42:01 PM
	 * @see		be.arnordhaenens.views.mediators.ArteveldeMediator
	 **/
	public class ArteveldeMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:ArteveldeLogo;
		
		/**
		 * Constructor
		 **/
		public function ArteveldeMediator()
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
			eventMap.mapListener(view, MouseEvent.CLICK, handleArteveldeLogoClick);
			
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
			//call the public resize function from the view
			this.view.handleResize();
		}
		
		/**
		 * Handle clicking on the Artevelde Logo
		 * 
		 * Redirect to the portal site of Arteveldehogeschool Gent
		 **/
		private function handleArteveldeLogoClick(evt:MouseEvent):void
		{
			//goto website artevelde
			this.view.gotoArtevelde();
		}
	}
}