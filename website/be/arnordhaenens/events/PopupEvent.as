package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	PopupEvent
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 4:47:35 PM
	 * @see		be.arnordhaenens.events.PopupEvent
	 * @see		flash.events.Event
	 **/
	public class PopupEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const CREATE_POPUP:String = "popupeventcreatepopup";
		public static const REMOVED_POPUP:String = "popupeventremovedpopup";
		
		public static const VIDEO_ENDED:String = "videoenededpopup";
		
		public var data:Array;
		
		/**
		 * Constructor
		 **/
		public function PopupEvent(type:String, _data:Array=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			this.data = _data;
			
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new PopupEvent(type, data, bubbles, cancelable);
		}
	}
}