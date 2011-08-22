/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 1:20:00 PM
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
	 * Class	FacebookMessageSendComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 18, 2011, at 1:20:00 PM
	 * @see		be.arnordhaenens.views.components.facebook.message.FacebookMessageSendComponent
	 **/
	public class FacebookMessageSendComponent extends FacebookMessageSendMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function FacebookMessageSendComponent()
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
			//reposition the notification
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
		 **/
		private function setBasics():void
		{
			//set the position
			this.x =(this.stage.stageWidth - 50 - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//add drop shadow filter
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
		 * Added to the stage
		 * Remove event listener
		 * set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
		}
	}
}