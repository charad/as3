package be.arnordhaenens.events
{
	/**
	 * Imports
	 **/
	import flash.events.Event;
	
	/**
	 * Class	TwitterEvent
	 * @author	D'Haenens Arnor
	 * @since	Jul 27, 2011, at 6:11:31 PM
	 * @see		be.arnordhaenens.events.TwitterEvent
	 * @see		flash.events.Event
	 **/
	public class TwitterEvent extends Event
	{
		/**
		 * Variables
		 **/
		public static const LOAD_DATA:String = "twitterEventLoadData";
		public static const LOADED_FOLLOWERS:String = "twitterEventLoadedFollowers";
		public static const LOADED_TIMELINE:String = "twitterEventLoadedTimeline";
		
		public static const LOAD_FOLLOWER_TWEET:String = "twitterEventLoadFollowerTweet";
		public static const FOLLOWER_TWEET_REMOVED:String = "twitterEventFollowerTweetRemoved";
		
		public static const NEXT_TIMELINE_TWEET:String = "twitterEventNextTimelineTweet";
		public static const PREVIOUS_TIMELINE_TWEET:String = "twitterEventPreviousTimelineTweet";
		
		public var data:*;
		
		/**
		 * Constructor
		 **/
		public function TwitterEvent(type:String, data:*=null, bubbles:Boolean=true, cancelable:Boolean=false)
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
			return new TwitterEvent(type, data, bubbles, cancelable);
		}
	}
}