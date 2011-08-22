package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	PictureEvent
	 * @author	D'Haenens Arnor
	 * @since	Aug 21, 2011, at 12:28:43 PM
	 * @see		be.arnordhaenens.events.PictureEvent
	 * @see		flash.events.Event
	 **/
	public class PictureEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const LOAD_PICTURE_ASSIGNMENTS:String = "pictureeventloadpictureassignments";
		public static const PICTURE_ASSIGNMENTS_LOADED:String = "pictureeventpictureassignmentsloaded";
		
		public static const VIEW_ONLINE:String = "pictureeventviewonline";
		
		public static const DISPLAY_IMAGES:String = "pictureeventdisplayimages";
		public static const DISPLAY_IMAGES_REMOVED:String = "pictureeventdisplayimagesremoved";
		
		public static const LOAD_IMAGES:String = "pictureeventloadimages";
		public static const IMAGES_LOADED:String = "pictureeventimagesloaded";
		
		public static const EXIT_FULLSCREEN:String = "pictureeventexitfullscreen";
		
		public var data:*;
		
		/**
		 * Constructor
		 **/
		public function PictureEvent(type:String, data:*=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			//set the data
			this.data = data;
			
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new PictureEvent(type, data, bubbles, cancelable);
		}
	}
}