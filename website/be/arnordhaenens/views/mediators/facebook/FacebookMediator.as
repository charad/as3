/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 29, 2011, at 9:21:08 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.facebook
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.PopupEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.facebook.FacebookView;
	
	import flash.events.Event;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	FacebookMediator
	 * @author	D'Haenens Arnor
	 * @since	Jul 29, 2011, at 9:21:08 PM
	 * @see		be.arnordhaenens.views.mediators.FacebookMediator
	 **/
	public class FacebookMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:FacebookView;
		
		/**
		 * Constructor
		 **/
		public function FacebookMediator()
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
			//set the current state
			PromositeDC.state = "facebook";
			
			//map view listeners
			eventMap.mapListener(this.view, FacebookEvent.AUTHENTICATION_CLICKED, handleAuthenticationClicked);
			eventMap.mapListener(this.view, FacebookEvent.EXIT_FULLSCREEN, handleExitFullScreen);
			
			eventMap.mapListener(this.view, FacebookEvent.SAVE_UID_TOKEN, saveFacebookUidToken);
			eventMap.mapListener(this.view, FacebookEvent.GET_ACCES_TOKEN, getFacebookToken);
			
			eventMap.mapListener(this.view, FacebookEvent.LOAD_TIMELINE, loadFacebookTimeline);
			eventMap.mapListener(eventDispatcher, FacebookEvent.TIMELINE_LOADED, handleTimelineLoaded);
			
			//eventMap.mapListener(this.view, FacebookEvent.LOAD_PHOTOS, loadFacebookPhotos);
			eventMap.mapListener(this.view, FacebookEvent.LOAD_FRIENDS, loadFacebookFriends);
			eventMap.mapListener(this.view, FacebookEvent.MESSAGE, sendFacebookMessage);
			eventMap.mapListener(this.view, FacebookEvent.LOGOUT, logoutFacebook);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			eventMap.mapListener(eventDispatcher, FacebookEvent.SAVED_UID_TOKEN, handleUidTokenSaved);
			eventMap.mapListener(eventDispatcher, FacebookEvent.ACCES_TOKEN_RETURN, handleReturnAccessToken);
			
			eventMap.mapListener(eventDispatcher, FacebookEvent.PHOTOS_LOADED, handlePhotosLoaded);
			eventMap.mapListener(eventDispatcher, FacebookEvent.FRIENDS_LOADED, handleFriendsLoaded);
			eventMap.mapListener(eventDispatcher, FacebookEvent.LOGGED_OUT, handleLoggedOut);
			
			//menu item clicked
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, removeFacebookView);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, removeFacebookView);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, removeFacebookView);
			eventMap.mapListener(eventDispatcher, MenuEvent.MOVIES_CLICKED, removeFacebookView);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, removeFacebookView);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, removeFacebookView);
			
			//popup
			eventMap.mapListener(eventDispatcher, PopupEvent.CREATE_POPUP, handlePopupCreate);
			eventMap.mapListener(eventDispatcher, PopupEvent.REMOVED_POPUP, handlePopupRemoved);
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
			//unmap all the listeners
			eventMap.unmapListeners();
			
			//unmap the mediator
			mediatorMap.unmapView(FacebookView);
			
			//remove mediator
			mediatorMap.removeMediatorByView(FacebookView);
			
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
			this.view.handleResize();
		}
		
		/**
		 * Remove the facebook view
		 **/
		private function removeFacebookView(evt:MenuEvent):void
		{
			//remove view from it's parent
			this.view.parent.removeChild(this.view);
		}
		
		/**
		 * Handle authentication clicked
		 **/
		private function handleAuthenticationClicked(evt:FacebookEvent):void
		{
			dispatch(new FacebookEvent(FacebookEvent.AUTHENTICATION_CLICKED));
		}
		
		/**
		 * Exit fullscreen
		 **/
		private function handleExitFullScreen(evt:FacebookEvent):void
		{
			dispatch(new FacebookEvent(FacebookEvent.EXIT_FULLSCREEN));
		}
		
		/**
		 * Save the User ID and the access token to the database
		 **/
		private function saveFacebookUidToken(evt:FacebookEvent):void
		{
			//dispatch event
			//send it to the context
			dispatch(new FacebookEvent(FacebookEvent.SAVE_UID_TOKEN, evt.data));
		}
		
		/**
		 * Get the access token for a given uid
		 **/
		private function getFacebookToken(evt:FacebookEvent):void
		{
			//dispatch & send to context
			dispatch(new FacebookEvent(FacebookEvent.GET_ACCES_TOKEN, evt.data));
		}
		
		/**
		 * Handle Uid and token saved
		 **/
		private function handleUidTokenSaved(evt:FacebookEvent):void
		{
			MonsterDebugger.trace(this, "shizzle saved");
		}
		
		/**
		 * Handle the return of the get access token function
		 **/
		private function handleReturnAccessToken(evt:FacebookEvent):void
		{
			//save the token so it can be accessed
			PromositeDC.token = evt.data[0];
		}
		
		/**
		 * Load facebook timeline
		 **/
		private function loadFacebookTimeline(evt:FacebookEvent):void
		{	
			if(this.contextView.getChildByName("post") == null)
				dispatch(new FacebookEvent(FacebookEvent.LOAD_TIMELINE));
		}
		
		/**
		 * Load photos
		 **/
		private function loadFacebookPhotos(evt:FacebookEvent):void
		{
			dispatch(new FacebookEvent(FacebookEvent.LOAD_PHOTOS));
		}
		
		/**
		 * Load friends
		 **/
		private function loadFacebookFriends(evt:FacebookEvent):void
		{
			if(this.contextView.getChildByName("friends") == null)
				dispatch(new FacebookEvent(FacebookEvent.LOAD_FRIENDS));
		}
		
		/**
		 * Send message
		 **/
		private function sendFacebookMessage(evt:FacebookEvent):void
		{
			dispatch(new FacebookEvent(FacebookEvent.MESSAGE));
		}
		
		/**
		 * Logout facebook
		 **/
		private function logoutFacebook(evt:FacebookEvent):void
		{
			dispatch(new FacebookEvent(FacebookEvent.LOGOUT));
		}
		
		/**
		 * Handle timeline loaded
		 **/
		private function handleTimelineLoaded(evt:FacebookEvent):void
		{
			/*MonsterDebugger.trace(this, "<!--FACEBOOK MEDIATOR TIMELINE LOADED-->");
			MonsterDebugger.trace(this, evt.data);*/
			dispatch(new FacebookEvent(FacebookEvent.DISPLAY_TIMELINE, evt.data));
		}
		
		/**
		 * Handle friends loaded
		 **/
		private function handleFriendsLoaded(evt:FacebookEvent):void
		{
			//MonsterDebugger.trace(this, "<!--FACEBOOK MEDIATOR FRIENDS LOADED-->");
			//this.view.createTagCloud(evt.data);
			dispatch(new FacebookEvent(FacebookEvent.DISPLAY_FRIENDS, evt.data));
		}
		
		/**
		 * Handle photos loaded complete
		 **/
		private function handlePhotosLoaded(evt:FacebookEvent):void
		{
			//dispatch event for creating the photo's component
			//set the data
			dispatch(new FacebookEvent(FacebookEvent.DISPLAY_PHOTOS, evt.data));
		}
		
		/**
		 * Handle logged out facebook
		 **/
		private function handleLoggedOut(evt:FacebookEvent):void
		{
			//remove the menu and top
			//display authentication button
			this.view.clearStageAfterLogout();
		}
		
		/**
		 * Handle creation of popup
		 **/
		private function handlePopupCreate(evt:PopupEvent):void
		{
			//set a blur filter over the view
			this.view.filters = [ArnorFilterClass.createBlurFilter()];
		}
		
		/**
		 * handle the removal of the popup
		 **/
		private function handlePopupRemoved(evt:PopupEvent):void
		{
			//remove the blur filter
			this.view.filters = [];
		}
	}
}