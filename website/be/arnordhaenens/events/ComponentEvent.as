package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	ComponentEvent
	 * @author	D'Haenens Arnor
	 * @since	Jul 23, 2011, at 5:39:16 PM
	 * @see		be.arnordhaenens.events.ComponentEvent
	 * @see		flash.events.Event
	 **/
	public class ComponentEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const REMOVED:String = "componentEventRemoved";
		
		/**
		 * Constructor
		 **/
		public function ComponentEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new ComponentEvent(type, bubbles, cancelable);
		}
	}
}