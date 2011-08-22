/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 2:17:45 PM
 ********************************
 **/
package be.arnordhaenens.views.components.facebook.welcome
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import flash.events.Event;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	FacebookWelcomeComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 20, 2011, at 2:17:45 PM
	 * @see		be.arnordhaenens.views.components.facebook.welcome.FacebookWelcomeComponent
	 **/
	public class FacebookWelcomeComponent extends FacebookWelcomeNotificationMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function FacebookWelcomeComponent()
		{
			super();
			
			//add event listener
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Handle resize stage  / window
		 **/
		 public function handleResize():void
		 {
			 //set the position
			 this.x = (this.stage.stageWidth - 50 - this.width) * .5;
			 this.y = (this.stage.stageHeight - this.height) * .5;
			 
			 //add drop shadow filter
			 this.filters = [ArnorFilterClass.createDropShadowFilter()];
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
		 * Set the basics
		 **/
		 private function setBasics():void
		 {
			 //set the position
			 this.x = (this.stage.stageWidth - 50 - this.width) * .5;
			 this.y = (this.stage.stageHeight - this.height) * .5;
		 }
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		 
		 /**
		 * Init function
		 * 
		 * Handle added to the stage
		 * Remove the event listener
		 * Set the basics
		 **/
		 private function init(evt:Event=null):void
		 {
			 //remove the event listener
			 this.removeEventListener(Event.ADDED_TO_STAGE, init);
			 
			 //set the basics
			 setBasics();
		 }
	}
}