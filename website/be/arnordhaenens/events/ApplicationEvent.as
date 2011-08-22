package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	ApplicationEvent
	 * @author	D'Haenens Arnor
	 * @since	Jul 19, 2011, at 8:30:37 PM
	 * @see		be.arnordhaenens.events.ApplicationEvent
	 * @see		flash.events.Event
	 **/
	public class ApplicationEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const RESIZE:String = "applicationEventResize";
		public static const FULLSCREEN:String = "applicationEventFullScreen";
		public static const NORMAL:String = "applicationEventNormalScreen";
		
		/**
		 * Constructor
		 **/
		public function ApplicationEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new ApplicationEvent(type, bubbles, cancelable);
		}
	}
}