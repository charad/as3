package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	FooterEvent
	 * @author	D'Haenens Arnor
	 * @since	Jul 21, 2011, at 12:04:07 PM
	 * @see		be.arnordhaenens.events.FooterEvent
	 * @see		flash.events.Event
	 **/
	public class FooterEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const ARNOR_CLICKED:String = "footerEventArnorClicked";
		public static const FULLSCREEN_CLICKED:String = "footerEventFullscreenclicked";
		public static const MENU_CLICKED:String = "footerEventMenuClicked";
		
		/**
		 * Constructor
		 **/
		public function FooterEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new FooterEvent(type, bubbles, cancelable);
		}
	}
}