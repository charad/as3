/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 20, 2011, at 2:09:55 PM
 ********************************
 **/
package be.arnordhaenens.views.components.footer
{
	import be.arnordhaenens.events.FooterEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ArnorLogo
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 20, 2011, at 2:09:55 PM
	 * @see		be.arnordhaenens.views.components.ArnorLogo
	 **/
	public class ArnorLogo extends ArnorMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function ArnorLogo()
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
		 * Handle stage / window resize
		 **/
		public function handleResize():void
		{
			//reset the position
			this.x = 20;
			this.y = this.stage.stageHeight - this.height - ((30 - this.height)*.5);
		}
		
		/**
		 * Goto website arnor.be
		 * 
		 * Create new urlrequest
		 * Navigate to the url
		 * 
		 * @see 
		 **/
		public function gotoArnor():void
		{
			//create new request
			var req:URLRequest = new URLRequest("http://www.arnor.be");
			
			//navigate to the url
			navigateToURL(req, "_blank");
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
		 * Setting the basics
		 * 
		 * Set the size
		 * Set the position
		 **/
		private function setBasics():void
		{
			//set the size
			this.scaleX = this.scaleY = 95/this.width;
			
			//set the position
			this.x = 20;
			this.y = this.stage.stageHeight - this.height - ((30 - this.height)*.5);
			
			//set the cursor
			this.useHandCursor = true;
			this.mouseChildren = false;
			
			//add event listener
			this.addEventListener(MouseEvent.CLICK, handleClick);
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
		 **/
		private function init(evt:Event=null):void
		{
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the size and position
			setBasics();
		}
		
		/**
		 * Handle logo clicked
		 * 
		 * Dispatch event
		 **/
		private function handleClick(event:MouseEvent):void
		{
			dispatchEvent(new FooterEvent(FooterEvent.ARNOR_CLICKED));
			
		}
	}
}