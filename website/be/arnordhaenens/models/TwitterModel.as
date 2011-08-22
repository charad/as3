/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 27, 2011, at 6:16:37 PM
 ********************************
 **/
package be.arnordhaenens.models
{
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.TwitterEvent;
	
	import com.adobe.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.Security;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * Class	TwitterModel
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 27, 2011, at 6:16:37 PM
	 * @see		be.arnordhaenens.models.TwitterModel
	 **/
	public class TwitterModel extends Actor
	{
		/**
		 * Variables
		 **/
		private static const FOLLOWERS:String = "http://api.twitter.com/1/statuses/followers.json?screen_name=pbagdm&include_entities=true";
		private static const TIMELINE:String = "http://api.twitter.com/1/statuses/user_timeline.json?count=10&include_entities=true&screen_name=pbagdm";
		
		private var _loader:URLLoader;
		private var _request:URLRequest;
		
		/**
		 * Constructor
		 **/
		public function TwitterModel()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Load all the twitter data needed
		 **/
		public function loadTwitterData():void
		{			
			//load the followers
			this.loadFollowers();
			
			//load timeline
			this.loadTimeLine();			
		}
		
		////
		////////////////////////////////
		// Protected functions
		////////////////////////////////
		////
		
		////
		////////////////////////////////
		// Private functions
		////////////////////////////////
		////
		
		/**
		 * Load @pbagdm followers
		 **/
		private function loadFollowers():void
		{
			//create new instance
			_loader = new URLLoader();
			
			//add event listeners
			_loader.addEventListener(Event.COMPLETE, handleFollowersLoaded);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, handleIOErrorFollowers);
			
			//start loading
			_loader.load(new URLRequest(FOLLOWERS));
		}
		
		/**
		 * Load timeline @pbagdm
		 **/
		private function loadTimeLine():void
		{
			//create new instance loader
			this._loader = new URLLoader();
			
			//add event listeners
			this._loader.addEventListener(Event.COMPLETE, handleTimeLineLoaded);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, handleIOErrorTimeline);
			
			//start loading
			this._loader.load(new URLRequest(TIMELINE));
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Handle followers loaded complete
		 **/
		private function handleFollowersLoaded(evt:Event):void
		{	
			//result
			var result:String = evt.target.data;
			var arrayFollowers:Array = JSON.decode(result) as Array;
			
			//remove event listeners
			var urlLoader:URLLoader = evt.target as URLLoader;
			urlLoader.removeEventListener(Event.COMPLETE, handleFollowersLoaded);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, handleIOErrorFollowers);
			urlLoader = null;
			
			//dispatch event
			dispatch(new TwitterEvent(TwitterEvent.LOADED_FOLLOWERS, arrayFollowers));
		}
		
		/**
		 * Handle IO Error Followers
		 **/
		private function handleIOErrorFollowers(evt:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, "error loading followers");
		}
		
		/**
		 * Handle Timeline loaded
		 **/
		private function handleTimeLineLoaded(evt:Event):void
		{
			//result
			var result:String = evt.target.data;
			var arrayTimeLine:Array = JSON.decode(result) as Array;
			
			//remove event listeners
			var urlLoader:URLLoader = evt.target as URLLoader;
			urlLoader.removeEventListener(Event.COMPLETE, handleFollowersLoaded);
			urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, handleIOErrorFollowers);
			urlLoader = null;
			
			//dispatch event
			dispatch(new TwitterEvent(TwitterEvent.LOADED_TIMELINE, arrayTimeLine));
		}
		
		/**
		 * Handle IO Error timeline
		 **/
		private function handleIOErrorTimeline(evt:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, "error loading timeline");
		}
	}
}