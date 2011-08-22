/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 19, 2011, at 2:13:19 PM
 ********************************
 **/
package be.arnordhaenens.views.components.facebook
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	FriendComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 19, 2011, at 2:13:19 PM
	 * @see		be.arnordhaenens.views.components.facebook.FriendComponent
	 **/
	public class FriendComponent extends FriendMC
	{
		/**
		 * Variables
		 **/
		private static const FACEBOOK_LINK:String = "http://facebook.com/profile.php?id=";
		
		/**
		 * Constructor
		 **/
		public function FriendComponent()
		{
			super();	
			
			init();
			
			MonsterDebugger.trace(this, "test");
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
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
			//add drop shadow
			this.filters = [ArnorFilterClass.createDropShadowFilter(), ArnorFilterClass.createBWFilter()];
			
			//add event listeners
			this.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
			this.addEventListener(MouseEvent.CLICK, handleClick);
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init funciton 
		 * 
		 * Handle added to the stage
		 * Remove event listener
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
		 * Handle mouse over object
		 **/
		private function handleMouseOver(evt:MouseEvent):void
		{
			//remove the filters
			this.filters = this.filters.slice(0,0);			
		}
		
		/**
		 * Handle mouse out component
		 **/
		private function handleMouseOut(evt:MouseEvent):void
		{
			//add BW filter on mouse out
			this.filters.push(ArnorFilterClass.createBWFilter());
		}
		
		/**
		 * Handle click on the object
		 **/
		private function handleClick(evt:MouseEvent):void
		{
			//grab the id from the textfield
			var id:String = this.txtID.text;
			
			var url:String = FACEBOOK_LINK + id;
			
			//navigate to the url
			navigateToURL(new URLRequest(url), "_blank");
		}
	}
}