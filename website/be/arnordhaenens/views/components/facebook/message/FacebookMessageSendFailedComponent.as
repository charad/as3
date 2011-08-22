/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 1:43:07 PM
 ********************************
 **/
package be.arnordhaenens.views.components.facebook.message
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import flash.events.Event;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	FacebookMessageSendFailedComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 18, 2011, at 1:43:07 PM
	 * @see		be.arnordhaenens.views.components.facebook.message.FacebookMessageSendFailedComponent
	 **/
	public class FacebookMessageSendFailedComponent extends FacebookMessageSendFailedMC 
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function FacebookMessageSendFailedComponent()
		{			
			//add event listener
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Handle resize stage / window
		 **/
		public function handleResize():void
		{
			//set the position of the component
			this.x = (this.stage.stageWidth - 50 - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
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
		 * 
		 * Set the position
		 * Add filter
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth - 50 - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//add filter
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
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