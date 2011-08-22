/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 9:08:37 PM
 ********************************
 **/
package be.arnordhaenens.views.components.notifications
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ContactFormSendFailedNotificationComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 24, 2011, at 9:08:37 PM
	 * @see		be.arnordhaenens.views.components.notifications.ContactFormSendFailedNotificationComponent
	 **/
	public class FormSendFailedComponent extends ContactFormSendFailedMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function FormSendFailedComponent()
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
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
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
		 * Add event listener to the  close button
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//add event listener
			this.close.addEventListener(MouseEvent.CLICK, handleCloseClick);
			
			//add drop shadow
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
		 * handle added to the stage
		 * Remove the event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set basics
			setBasics();
		}
		
		/**
		 * Handle clicking on the close button
		 **/
		private function handleCloseClick(evt:MouseEvent):void
		{
			this.parent.removeChild(this);
		}
	}
}