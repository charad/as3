package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	ContactFormEvent
	 * @author	D'Haenens Arnor
	 * @since	Jul 24, 2011, at 4:48:54 PM
	 * @see		be.arnordhaenens.events.ContactFormEvent
	 * @see		flash.events.Event
	 **/
	public class ContactFormEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const NOT_CORRECT_YET:String = "contactformeventnotcorrectyet";
		public static const SENDING_FORM:String = "contactformEventSendForm";
		public static const MAIL_SEND_FAILED:String ="contactformeventmailsendfailed";
		public static const MAIL_SEND_SUCCES:String = "contactformeventmailsendsucces";
		
		public var data:Array;
		
		/**
		 * Constructor
		 **/
		public function ContactFormEvent(type:String, data:Array=null, bubbles:Boolean=true, cancelable:Boolean=false)
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
			return new ContactFormEvent(type, data, bubbles, cancelable);
		}
	}
}