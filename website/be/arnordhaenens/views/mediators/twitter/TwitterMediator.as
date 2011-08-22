/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 26, 2011, at 5:14:31 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.twitter
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.TwitterEvent;
	import be.arnordhaenens.views.components.twitter.TwitterView;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	TwitterMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 26, 2011, at 5:14:31 PM
	 * @see		be.arnordhaenens.views.mediators.twitter.TwitterMediator
	 **/
	public class TwitterMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:TwitterView;
		
		/**
		 * Constructor
		 **/
		public function TwitterMediator()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		/**
		 * Override onRegister
		 * 
		 * Dispatched when everything is constructed
		 * and is ready to interact with the application
		 **/
		override public function onRegister():void
		{
			//set the state
			PromositeDC.state = "twitter";
			
			//map view listeners
			eventMap.mapListener(this.view, TwitterEvent.LOAD_DATA, loadTwitterData);
			eventMap.mapListener(this.view, TwitterEvent.LOAD_FOLLOWER_TWEET, handleLoadFollowerTweet);
			eventMap.mapListener(this.view, TwitterEvent.FOLLOWER_TWEET_REMOVED, handleFollowerTweetRemoved);
			eventMap.mapListener(this.view, TwitterEvent.NEXT_TIMELINE_TWEET, handleNextTweet);
			eventMap.mapListener(this.view, TwitterEvent.PREVIOUS_TIMELINE_TWEET, handlePreviousTweet);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			eventMap.mapListener(eventDispatcher, TwitterEvent.LOADED_FOLLOWERS, handleTwitterFollowersLoaded);
			eventMap.mapListener(eventDispatcher, TwitterEvent.LOADED_TIMELINE, handleTwitterTimelineLoaded);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, removeTwitter);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, removeTwitter);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, removeTwitter);
			eventMap.mapListener(eventDispatcher, MenuEvent.FACEBOOK_CLICKED, removeTwitter);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, removeTwitter);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, removeTwitter);
		}
		
		/**
		 * Override onRemove
		 * 
		 * Dispatched when just being deleted from the stage
		 * 
		 * Remove all mapping of events
		 * Remove all instances of this mediator and view
		 * 
		 * Limitation of memory / CPU use!!
		 * Important for mobile devices
		 **/
		override public function onRemove():void
		{
			//unmap listeners
			eventMap.unmapListeners();
			
			//unmap view
			mediatorMap.unmapView(TwitterView);
			
			//remove mediator
			mediatorMap.removeMediatorByView(TwitterView);

			//call the parent onremove function,
			//so that we won't forget something
			super.onRemove();
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
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Handle the resize of the stage / window
		 * This for the components on the HOME-view
		 **/
		private function handleStageResize(evt:ApplicationEvent):void
		{
			//call the view's public method
			this.view.handleResize();
		}
		
		/**
		 * Remove the twitter view
		 **/
		private function removeTwitter(evt:MenuEvent):void
		{
			//call view's public function
			this.view.removeView();
		}
		
		/**
		 * Start loading the twitter data
		 **/
		private function loadTwitterData(evt:TwitterEvent):void
		{
			//dispatch event
			dispatch(new TwitterEvent(TwitterEvent.LOAD_DATA));
		}
		
		/**
		 * Handle twitter data loaded
		 **/
		private function handleTwitterFollowersLoaded(evt:TwitterEvent):void
		{
			//call public function
			this.view.createTwitterFollowers(evt.data);
		}
		
		/**
		 * Handle twitter timeline loaded
		 **/
		private function handleTwitterTimelineLoaded(evt:TwitterEvent):void
		{
			//call public function
			this.view.createTwitterTimeLine(evt.data);
		}
		
		/**
		 * Load follower tweet
		 **/
		private function handleLoadFollowerTweet(evt:TwitterEvent):void
		{
			//create the tweet
			this.view.createFollowerTweet(evt.data);
		}
		
		/**
		 * Handle follower tweet removed
		 **/
		private function handleFollowerTweetRemoved(evt:TwitterEvent):void
		{
			//call public function 
			this.view.createTimelineTweet();
		}
		
		/**
		 * Load the next tweet
		 **/
		private function handleNextTweet(evt:TwitterEvent):void
		{
			this.view.loadNextTweet();
		}
		
		/**
		 * Load the previous tweet
		 **/
		private function handlePreviousTweet(evt:TwitterEvent):void
		{
			this.view.loadPreviousTweet();
		}
	}
}