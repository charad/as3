/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 26, 2011, at 4:43:15 PM
 ********************************
 **/
package be.arnordhaenens.views.components.twitter
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.TwitterEvent;
	import be.arnordhaenens.views.components.loaders.LoaderProgressComponent;
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Video;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	
	import nl.demonsters.debugger.MonsterDebugger;

	
	
	/**
	 * Class	TwitterView
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 26, 2011, at 4:43:15 PM
	 * @see		be.arnordhaenens.views.components.twitter.TwitterView
	 **/
	public class TwitterView extends Sprite
	{
		/**
		 * Variables
		 **/
		private static const CLOUD_BACKGROUND:String = "assets/originals/images/cloud_background.jpg";
		private static const CLOUD_VIDEO:String = "assets/originals/video/clouds.mp4";
		
		private var _video:Video;
		private var _loader:Loader;
		private var _preloader:LoaderProgressComponent;
		private var _background:DisplayObject;
		
		private var _twitterFriends:TwitterFriendsComponent;
		private var _followersSource:Array;
		private var _timelineSource:Array;
		private var _lastTweetTimeline:int = 0;
		
		private var _tweetFollower:TweetComponent;
		private var _tweetTimeLine:TimelineTweetComponent;
		
		/**
		 * Constructor
		 **/
		public function TwitterView()
		{
			Security.allowDomain("twitter.com");
			
			//add event listener
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Handle resize stage / window
		 **/
		public function handleResize():void
		{
			//reposition the preloader (if added to the stage)
			if(this.contains(this._preloader))
				this._preloader.handleResize();
			
			//resize the background (if added to the stage)
			if(this.contains(this._background))
			{
				var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
				this._background.width *= scale;
				this._background.height *= scale;
			}
			
			//check if view contains friends
			if(this.contains(this._twitterFriends))
				this._twitterFriends.handleResize();
			
			//check if contains tweet
			if(this._tweetFollower != null)
				if(this.contains(this._tweetFollower))
					this._tweetFollower.handleResize();
			
			//check if contains timelineTweet
			if(this._tweetTimeLine != null)
				if(this.contains(this._tweetTimeLine))
					this._tweetTimeLine.handleResize();
		}
		
		/**
		 * Remove the Twitter view component
		 **/
		public function removeView():void
		{
			this.parent.removeChild(this);
		}
		
		/**
		 * Create the twitter page
		 **/
		public function createTwitterPage():void
		{
			//create the twitter friends component
			//create new instance
			this._twitterFriends = new TwitterFriendsComponent();
			
			//add instance twitter friends to the view
			this.addChild(this._twitterFriends);
		}
		
		/**
		 * Create twitter friends
		 **/
		public function createTwitterFollowers(source:Array):void
		{
			//set the source
			this._followersSource = source;
			
			for each(var follower:Object in this._followersSource)
			{
				var imgURL:String = follower.profile_image_url;
				var name:String = follower.screen_name;
				
				//create new follower
				this._twitterFriends.loadFollower(imgURL, name);
			}
		}
		
		/**
		 * Create twitter timeline
		 **/
		public function createTwitterTimeLine(source:Array):void
		{
			//set the source
			this._timelineSource = source;
			//MonsterDebugger.trace(this, this._timelineSource);
			
			createTimelineTweet();
		}
		
		/**
		 * Load / Create follower tweet
		 **/
		public function createFollowerTweet(_data:*):void
		{
			if(this._tweetTimeLine != null)
				if(this.contains(this._tweetTimeLine))
					this._tweetTimeLine.removeElement();
			
			if(this._tweetFollower != null)
			{
				if(this.contains(this._tweetFollower))
					this._tweetFollower.removeTweet();
			}
			
			var followerData:Array = _data as Array;
			
			//get the variables
			var name:String = followerData[0];
			
			var i:int = 0;
			var index:int;
			for each(var follower:Object in this._followersSource)
			{
				if(follower.screen_name == name)
				{
					index = i;
					break;
				}
				else
					i++
			}
			
			//create new instance tweet component
			this._tweetFollower = new TweetComponent(this._followersSource[index]);
			
			//add the component to the stage
			this.addChild(this._tweetFollower);
		}
		
		/**
		 * Create timeline tweet
		 **/
		public function createTimelineTweet():void
		{
			//create new instance
			this._tweetTimeLine = new TimelineTweetComponent(this._timelineSource[this._lastTweetTimeline]);
			
			//add to the view
			this.addChild(this._tweetTimeLine);
		}
		
		/**
		 * Load next tweet
		 **/
		public function loadNextTweet():void
		{
			if((this._lastTweetTimeline + 1) <= (this._timelineSource.length - 1))
			{
				//increment the index
				this._lastTweetTimeline++;
			}
			else if((this._lastTweetTimeline + 1) > (this._timelineSource.length - 1))
			{
				//reset the index
				this._lastTweetTimeline = 0;
			}
			
			//load the tweet
			this._tweetTimeLine.loadNextTweet(this._timelineSource[this._lastTweetTimeline]);
		}
		
		/**
		 * Load previous tweet
		 **/
		public function loadPreviousTweet():void
		{
			if((this._lastTweetTimeline - 1) >= 0)
			{
				//decrement the index
				this._lastTweetTimeline--;
			}
			else if((this._lastTweetTimeline - 1) < 0)
			{
				//set the index to the max value
				this._lastTweetTimeline = this._timelineSource.length - 1;
			}
			
			//load the tweet
			this._tweetTimeLine.loadPreviousTweet(this._timelineSource[this._lastTweetTimeline]);
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
		 * Bring basic components back to the front
		 **/
		private function bringBasicsToFront():void
		{
			//bring artevelde logo back to the front
			this.parent.addChild(this.parent.getChildByName("arteveldelogo"));
			
			//bring footer back to front
			this.parent.addChild(this.parent.getChildByName("footer"));
			
			//bring menu back to the front
			this.parent.addChild(this.parent.getChildByName("menu"));
		}
		
		/**
		 * Create the background loader
		 **/
		private function createBackgroundLoader():void
		{
			//create new instance from the preloader
			this._preloader = new LoaderProgressComponent();
			//set the initial values
			this._preloader.setInitialValues("laden van de achtergrond...");
			//add preloader to the stage
			this.addChild(_preloader);
			
			//create new instance loader component
			this._loader = new Loader();
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaderComplete);
			this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, handleLoaderProgress);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleLoaderIOError);
			//start loading
			this._loader.load(new URLRequest(CLOUD_BACKGROUND));
		}
		
		/**
		 * Create the background
		 **/
		private function createBackground(_ob:DisplayObject):void
		{
			//set the display object
			this._background = _ob;
			
			//set the size
			var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
			this._background.width *= scale;
			this._background.height *= scale;
			
			//set the position
			this._background.x = this._background.y = 0;
			
			//set the alpha value
			this._background.alpha = 0;
			
			//add background to the view
			this.addChild(this._background);
			
			//tween the background
			TweenLite.to(this._background, .5, {alpha:1});
		}
		
		/**
		 * Start loading the twitter data
		 **/
		private function startLoadingTwitterData():void
		{
			//dispatch event for loading the twitter data
			dispatchEvent(new TwitterEvent(TwitterEvent.LOAD_DATA));
		}
		

		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init function 
		 * 
		 * Handle added to the stage
		 * Remove the event listener
		 * Create the cloud background
		 **/
		private function init(evt:Event):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//create preloader
			createBackgroundLoader();
		}
		
		/**
		 * Handle Loader progress
		 **/
		private function handleLoaderProgress(evt:ProgressEvent):void
		{
			//update the preloader
			var perc:Number = evt.bytesLoaded / evt.bytesTotal;
			
			//update the preloader
			this._preloader.updateLoader(perc);
		}
		
		/**
		 * Handle Loader complete
		 **/
		private function handleLoaderComplete(evt:Event):void
		{
			//create the background
			createBackground(evt.target.content);
			
			//remove the preloader
			this._preloader.removeLoader();
			
			//bring basic components to the front
			bringBasicsToFront();
			
			//start loading the data
			startLoadingTwitterData();
			createTwitterPage();
			
			//unmap listeners loader
			this._loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, handleLoaderIOError);
			this._loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, handleLoaderComplete);
			this._loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, handleLoaderProgress);
		}
		
		/**
		 * Handle IO Error Loader
		 **/
		private function handleLoaderIOError(evt:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, evt);
		}
	}
}