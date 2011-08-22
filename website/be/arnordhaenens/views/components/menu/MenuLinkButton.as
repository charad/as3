/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 21, 2011, at 9:04:56 PM
 ********************************
 **/
package be.arnordhaenens.views.components.menu
{
	import be.arnordhaenens.events.FooterEvent;
	import be.arnordhaenens.events.MenuEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	MenuLinkButton
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 21, 2011, at 9:04:56 PM
	 * @see		be.arnordhaenens.views.components.menu.MenuLinkButton
	 **/
	public class MenuLinkButton extends MenuLinkMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function MenuLinkButton()
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
			this.y = this.stage.stageHeight - this.height - ((30 - this.height)*.5);
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
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = this.stage.stageHeight - this.height - ((30 - this.height)*.5);
			
			this.mouseChildren = false;
			this.useHandCursor = true;
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.CLICK, handleMenuLinkClick);
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init function 
		 * 
		 * Handle added to stage
		 * 
		 * Remove the event listener
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
		 * Handle menu link clicked
		 **/
		private function handleMenuLinkClick(evt:MouseEvent):void
		{
			dispatchEvent(new FooterEvent(FooterEvent.MENU_CLICKED));
		}
	}
}