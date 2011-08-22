/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 21, 2011, at 2:36:30 PM
 ********************************
 **/
package be.arnordhaenens.views.components.home
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import fl.motion.motion_internal;
	
	import flash.events.Event;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	HomeButton
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 21, 2011, at 2:36:30 PM
	 * @see		be.arnordhaenens.views.components.home.HomeButton
	 **/
	public class HomeButton extends HomeMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function HomeButton()
		{
			//add event listener
			this.addEventListener(Event.ADDED_TO_STAGE, init);
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
		 * Setting the basics
		 * 
		 * Set the size
		 * Set the position
		 **/
		private function setBasics():void
		{
			//set keyframe
			this.gotoAndStop(1);
			
			//set the size
			this.width = 43;
			this.height = 32;
			
			//set the position
			this.x = 20;
			this.y = 10;
			
			//create a new dropshadow filter
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
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
		}
	}
}