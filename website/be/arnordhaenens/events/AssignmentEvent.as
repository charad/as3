package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	AssignmentEvent
	 * @author	D'Haenens Arnor
	 * @since	Aug 22, 2011, at 6:38:08 PM
	 * @see		be.arnordhaenens.events.AssignmentEvent
	 * @see		flash.events.Event
	 **/
	public class AssignmentEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const EXIT_FULLSCREEN:String = "assignmenteventexitfullscreen";
		
		public static const LOAD_ASSIGNMENTS:String = "assignmenteventloadassignments";
		public static const ASSIGNMENTS_LOADED:String = "assignmenteventassignmentsloaded";
		
		public static const DISPLAY_IMAGES:String = "assignmenteventdisplayimages";
		public static const DISPLAY_IMAGES_REMOVED:String = "assignmenteventdisplayimagesremoved";
		
		public static const DISPLAY_VIDEOS:String = "assignmenteventdisplayvideos";
		public static const DISPLAY_VIDEOS_REMOVED:String = "assignmenteventdisplayvideosremoved";
		
		public var data:*;
		
		/**
		 * Constructor
		 **/
		public function AssignmentEvent(type:String, data:*=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new AssignmentEvent(type, data, bubbles, cancelable);
		}
	}
}