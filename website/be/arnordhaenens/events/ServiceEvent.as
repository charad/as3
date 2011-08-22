package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	ServiceEvent
	 * @author	D'Haenens Arnor
	 * @since	Jul 19, 2011, at 7:08:03 PM
	 * @see		be.arnordhaenens.events.ServiceEvent
	 * @see		flash.events.Event
	 **/
	public class ServiceEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const ACTIVATED:String = "serviceEventActivated";
		public static const DEACTIVATED:String = "serviceEventDeactivated";
		
		/**
		 * Constructor
		 **/
		public function ServiceEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new ServiceEvent(type, bubbles, cancelable);
		}
	}
}