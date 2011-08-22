/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 24, 2011, at 9:16:33 PM
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
	 * Class	FormIncorrectComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 24, 2011, at 9:16:33 PM
	 * @see		be.arnordhaenens.views.components.notifications.FormIncorrectComponent
	 **/
	public class FormIncorrectComponent extends ContactFormIncorrectMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function FormIncorrectComponent()
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
		 * Set basics
		 * 
		 * Set the position
		 * Add event listener to the close button
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//add event listener
			this.addEventListener(MouseEvent.CLICK, handleCloseClick);
			
			//add drop shadow
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Handle added to stage
		 * Init function
		 * 
		 * Remove event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove event listener
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