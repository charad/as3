package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	FacebookEvent
	 * @author	D'Haenens Arnor
	 * @since	Aug 17, 2011, at 12:32:33 PM
	 * @see		be.arnordhaenens.events.FacebookEvent
	 * @see		flash.events.Event
	 **/
	public class FacebookEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const AUTHENTICATION_CLICKED:String = "facebookeventauthenticationclicked";
		
		public static const SAVE_UID_TOKEN:String = "facebookeventsaveuidtoken";
		public static const SAVED_UID_TOKEN:String = "facebookeventsaveduidtoken";
		
		public static const GET_ACCES_TOKEN:String = "facebookeventGetAccestoken";
		public static const ACCES_TOKEN_RETURN:String = "facebookeventaccestokenreturn";
		
		public static const LOGIN_FAILED:String = "facebookeventLoginfailed";
		
		public static const LOAD_TIMELINE:String = "facebookeventloadtimeline";
		public static const LOAD_FRIENDS:String = "facebookeventloadfriends";
		public static const LOAD_PHOTOS:String = "facebookeventloadphotos";
		public static const MESSAGE:String = "facebookeventmessage";
		public static const LOGOUT:String = "facebookeventlogout";
		
		public static const TIMELINE_LOADED:String = "facebookeventtimelineloaded";
		public static const PHOTOS_LOADED:String = "facebookeventphotosloaded";
		public static const FRIENDS_LOADED:String = "facebookeventFriendsloaded";
		public static const MESSAGE_DONE:String = "facebookeventMessagedone";
		public static const MESSAGE_FAILED:String = "facebookeventmessagefailed";
		public static const LOGGED_OUT:String = "facebookeventloggedout";
		public static const LOGOUT_FAILED:String = "facebookeventlogoutfailed";
		
		public static const FAIL:String = "facebookeventfail";
		
		public static const DISPLAY_FRIENDS:String = "facebookeventdisplayfriends";
		public static const DISPLAY_TIMELINE:String = "facebookeventdisplaytimeline";
		public static const DISPLAY_PHOTOS:String = "facebookeventdisplayphotos";
		
		public static const EXIT_FULLSCREEN:String = "facebookeventexitfullscreen";
		
		public var data:*;
		
		/**
		 * Constructor
		 **/
		public function FacebookEvent(type:String, data:*=null, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			//set the data
			this.data = data;
			
			//inherit
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new FacebookEvent(type, data, bubbles, cancelable);
		}
	}
}