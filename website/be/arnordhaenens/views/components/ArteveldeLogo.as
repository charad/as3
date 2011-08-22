/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 9:30:30 PM
 ********************************
 **/
package be.arnordhaenens.views.components
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import flash.display.BlendMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ArteveldeLogo
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 19, 2011, at 9:30:30 PM
	 * @see		be.arnordhaenens.views.components.ArteveldeLogo
	 **/
	public class ArteveldeLogo extends ArteveldeMC
	{
		/**
		 * Variables
		 **/
		private var _shadow:DropShadowFilter;
		
		/**
		 * Constructor
		 **/
		public function ArteveldeLogo()
		{
			//set the name
			this.name = "arteveldeLogo";
			
			//add event listener
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Handle resize of stage / window
		 **/
		public function handleResize():void
		{
			//set the position
			this.x = this.stage.stageWidth - this.width - 20;
			this.y = 10;
		}
		
		/**
		 * Goto website Arteveldehogeschool
		 **/
		public function gotoArtevelde():void
		{
			//create new urlrequest
			var req:URLRequest = new URLRequest("http://www.arteveldehs.be/emc.asp");
			
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
		 * Set basics
		 * 
		 * Set the size and the position of the element
		 **/
		private function setBasics():void
		{
			//set the size
			this.width = 53;
			this.height = 32;
			
			//set the position
			this.x = this.stage.stageWidth - this.width - 20;
			this.y = 10;
			
			//hand cursor
			this.useHandCursor = true;
			
			//set the filter
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
		 * Remove the event listener
		 * Set the DropShadow filter
		 **/
		private function init(evt:Event=null):void
		{
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set size and position
			setBasics();
		}
	}
}