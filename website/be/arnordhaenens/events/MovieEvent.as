package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	MovieEvent
	 * @author	D'Haenens Arnor
	 * @since	Aug 21, 2011, at 8:58:08 AM
	 * @see		be.arnordhaenens.events.MovieEvent
	 * @see		flash.events.Event
	 **/
	public class MovieEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const TRAILER_CLICKED:String = "movieeventtrailerclicked";
		public static const WEBSITE_CLICKED:String = "movieeventwebsiteclicked";
		public static const GROUP_CLICKED:String = "movieeventgroupclicked";
		
		public static const EXIT_FULLSCREEN:String = "movieeventexitfullscreen";
		
		/**
		 * Constructor
		 **/
		public function MovieEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new MovieEvent(type, bubbles, cancelable);
		}
	}
}