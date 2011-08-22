package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	MenuEvent
	 * @author	D'Haenens Arnor
	 * @since	Jul 21, 2011, at 9:10:00 PM
	 * @see		be.arnordhaenens.events.MenuEvent
	 * @see		flash.events.Event
	 **/
	public class MenuEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const MENU_CLICKED:String = "menuEventMenuButtonClicked";
		
		public static const HOME_CLICKED:String = "menuEventHomeClicked";
		public static const ASSIGNMENT_CLICKED:String = "menuEventAssignmentClicked";
		public static const MOVIES_CLICKED:String = "menuEventMoviesClicked";
		public static const FACEBOOK_CLICKED:String = "menuEventFacebookClicked";
		public static const TWITTER_CLICKED:String = "menuEventTwitterClicked";
		public static const PICTURE_CLICKED:String = "menuEventPictureClicked";
		public static const CONTACT_CLICKED:String = "menuEventContactClicked";
		
		/**
		 * Constructor
		 **/
		public function MenuEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Override clone
		 * Return a new instance
		 **/
		override public function clone():Event
		{
			return new MenuEvent(type, bubbles, cancelable);
		}
	}
}