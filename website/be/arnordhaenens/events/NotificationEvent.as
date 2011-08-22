package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	NotificationEvent
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 8:07:54 PM
	 * @see		be.arnordhaenens.events.NotificationEvent
	 * @see		flash.events.Event
	 **/
	public class NotificationEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const REMOVE_NOTIFICATION:String = "notificationeventremovenotification";
		
		/**
		 * Constructor
		 **/
		public function NotificationEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new NotificationEvent(type, bubbles, cancelable);
		}
	}
}