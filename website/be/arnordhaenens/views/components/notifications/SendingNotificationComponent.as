/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 8:58:52 PM
 ********************************
 **/
package be.arnordhaenens.views.components.notifications
{
	import be.arnordhaenens.events.NotificationEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	SendingNotificationComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 24, 2011, at 8:58:52 PM
	 * @see		be.arnordhaenens.views.components.notifications.SendingNotificationComponent
	 **/
	public class SendingNotificationComponent extends ContactFormSendingMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function SendingNotificationComponent()
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
		 * Handle resize
		 **/
		public function handleResize():void
		{
			//set position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
		}
		
		/**
		 * Remove the sending component
		 **/
		public function removeComponent():void
		{
			this.parent.removeChild(this);
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
		 * Add event listener to the close button
		 **/
		private function setBasics():void
		{
			//set position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//add event listener to the close button
			//this.close.addEventListener(MouseEvent.CLICK, handleCloseClick);
			this.close.visible = false;
			
			//add drop shadow
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Handle added to the stage
		 * 
		 * Init function
		 * 
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
		
		/**
		 * Handle close click
		 **/
		private function handleCloseClick(evt:MouseEvent):void
		{
			this.parent.removeChild(this);
		}
	}
}