/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 29, 2011, at 9:21:25 PM
 ********************************
 **/
package be.arnordhaenens.views.components.facebook
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.loaders.LoaderProgressComponent;
	
	import com.facebook.graph.Facebook;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * Class	FacebookView
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 29, 2011, at 9:21:25 PM
	 * @see		be.arnordhaenens.views.components.facebook.FacebookView
	 **/
	public class FacebookView extends MovieClip
	{
		/**
		 * Variables
		 **/
		private static const BACKGROUND:String = "assets/originals/images/background3.jpg";
		private var _background:DisplayObject;		
		
		private var _loader:Loader;
		private var _preloader:LoaderProgressComponent;
		private var _authenticateButton:FacebookAuthenticateMC;
		
		private var _title:FacebookTopTitleMC;
		private var _timelineMenu:FacebookTimelineMC = new FacebookTimelineMC();
		private var _friendsMenu:FacebookFriendsMC = new FacebookFriendsMC();
		private var _messageMenu:FacebookMessageMC = new FacebookMessageMC();
		private var _photosMenu:FacebookPhotosMC = new FacebookPhotosMC();
		private var _logoutMenu:FacebookLogoutMC = new FacebookLogoutMC();		
		
		private static const APP_ID:String = "260684753958336";
		
		/**
		 * Constructor
		 **/
		public function FacebookView()
		{
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
			//resize background
			var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
			this._background.width *= scale;
			this._background.height *= scale;
			
			//resize the menu
			resizeMenu();
			
			//check if authentication button diff from null
			//if so, check if this view contains the authentication button
			//if so, reposition the authentication button
			if(this._authenticateButton != null)
			{
				if(this.contains(this._authenticateButton))
				{
					//set the position of the authentication button
					this._authenticateButton.x = (this.stage.stageWidth - this._authenticateButton.width) * .5;
					this._authenticateButton.y = (this.stage.stageHeight - this._authenticateButton.height) * .5;
				}
			}
		}
		
		/**
		 * Create tag cloud friends
		 **/
		public function createTagCloud(data:*):void
		{
			MonsterDebugger.trace(this, "trying to create friends");
			
			//check the amount of friends
			//var amount:int = data.length();
		}
		
		/**
		 * After log out remove elements that don't matter
		 * 
		 * Remove the title
		 * Remove the menu items
		 **/
		public function clearStageAfterLogout():void
		{
			//remove the title
			TweenMax.to(this._title, 1, {alpha:0, blurFilter:{blurX:20, blurY:20}, onComplete:removeObject, onCompleteParams:[this._title]});
			
			//remove the menu items
			TweenMax.to(this._timelineMenu, 1, {alpha:0, blurFilter:{blurX:20, blurY:20}, onComplete:removeObject, onCompleteParams:[this._timelineMenu]});
			TweenMax.to(this._friendsMenu, 1, {alpha:0, blurFilter:{blurX:20, blurY:20}, onComplete:removeObject, onCompleteParams:[this._friendsMenu]});
			TweenMax.to(this._photosMenu, 1, {alpha:0, blurFilter:{blurX:20, blurY:20}, onComplete:removeObject, onCompleteParams:[this._photosMenu]});
			TweenMax.to(this._messageMenu, 1, {alpha:0, blurFilter:{blurX:20, blurY:20}, onComplete:removeObject, onCompleteParams:[this._messageMenu]});
			TweenMax.to(this._logoutMenu, 1, {alpha:0, blurFilter:{blurX:20, blurY:20}, onComplete:removeObject, onCompleteParams:[this._logoutMenu]});
			
			//after removal
			createAuthenticateButton();
		}
		
		////
		////////////////////////////////
		// Protected functions
		////////////////////////////////
		////
		
		/**
		 * Init facebook callback function
		 **/
		protected function onInit(result:Object, fail:Object):void
		{			
			if(result)
			{
				//user is already logged in
				//previous session exists
				initFacebookComponents();
				//MonsterDebugger.trace(this, "<!--RESULT FACEBOOK-->" + result);
				
				//dispatch event to get the user's accesstoken
				dispatchEvent(new FacebookEvent(FacebookEvent.GET_ACCES_TOKEN, [result.uid]));
			}
			else
			{
				//create the button where the user has to click on
				//to log in and grant the app acces
				createAuthenticateButton();
				MonsterDebugger.trace(this, "<!--FAIL FACEBOOK-->" + fail);
			}
		}
		
		/**
		 * Facebook callback function for logging in
		 **/
		protected function onLogin(result:Object, fail:Object):void
		{
			//MonsterDebugger.trace(this, "<!--ON FACEBOOK LOGIN-->", 0xFFFF00);
			if(result)
			{
				/*MonsterDebugger.trace(this, "succes login");
				MonsterDebugger.trace(this, result);*/
				
				PromositeDC.token = result.accessToken;
				PromositeDC.uid = result.uid;
				
				//dispatch event and send the data with it
				dispatchEvent(new FacebookEvent(FacebookEvent.SAVE_UID_TOKEN, [result.uid, result.accessToken]));
				
				removeAuthenticationButton();
				initFacebookComponents();
			}
			else
			{
				//show user login has failed
				MonsterDebugger.trace(this, "failed login");
				MonsterDebugger.trace(this, fail);
				
				//keep authentication button
				//show message / notification
			}
		}

		
		/**
		 * Set basics
		 **/
		private function setBasics():void
		{
			//create the background
			createBackground();
		}
		
		/**
		 * Create the background
		 **/
		private function createBackground():void
		{
			//create new instance preloader
			this._preloader = new LoaderProgressComponent();
			this._preloader.setInitialValues("laden facebook pagina...");
			this.addChild(this._preloader);
			
			//create new loader instance
			this._loader = new Loader();
			
			//add event listeners
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaderComplete);
			this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, handleLoaderProgress);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleError);
			
			//start loading
			this._loader.load(new URLRequest(BACKGROUND));
		}
		
		/**
		 * Bring the basics to the front
		 * 
		 * Bring the Arteveldehogeschool logo to the front
		 * Bring the footer to the front
		 * Bring the menu to the front
		 **/
		private function bringBasicsToFront():void
		{
			//bring logo to front
			this.parent.addChild(this.parent.getChildByName("arteveldelogo"));
			
			//bring footer to the front
			this.parent.addChild(this.parent.getChildByName("footer"));
			
			//bring menu to the front
			this.parent.addChild(this.parent.getChildByName("menu"));
		}
		
		/**
		 * Check if user is logged in into Facebook®
		 **/
		private function checkFacebookLogin():void
		{			
			//Init Facebook class
			Facebook.init(APP_ID, onInit);
		}
		
		/**
		 * Create the facebook components
		 **/
		private function initFacebookComponents():void
		{
			//MonsterDebugger.trace(this, "create facebook components");
			
			createTitle();
			createMenu();
			
			//load the timeline
			dispatchEvent(new FacebookEvent(FacebookEvent.LOAD_TIMELINE));
		}
		
		/**
		 * Create top title
		 **/
		private function createTitle():void
		{
			//create new instance
			this._title = new FacebookTopTitleMC();
			
			//set position
			this._title.x = 20;
			this._title.y = 4;
			
			//add filter
			this._title.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//add component to the view
			this.addChild(this._title);
		}
		
		/**
		 * Create the facebookMenu
		 **/
		private function createMenu():void
		{
			//calculate av. height
			var spaceAmount:Number = (this.stage.stageHeight - (this._title.height + 4) - this._timelineMenu.height - this._photosMenu.height - this._friendsMenu.height - this._messageMenu.height - this._logoutMenu.height - 110) / 4;
			
			//create the timeline component
			this._timelineMenu = new FacebookTimelineMC();
			this._timelineMenu.name = "timeline";
			this._timelineMenu.width = 50;
			this._timelineMenu.x = 20;
			this._timelineMenu.y = this._title.y + this._title.height + 40;
			this._timelineMenu.buttonMode = true;
			this._timelineMenu.useHandCursor = true;
			this._timelineMenu.filters = [ArnorFilterClass.createDropShadowFilter()];
			this._timelineMenu.addEventListener(MouseEvent.CLICK, handleFacebookMenuClick);
			this.addChild(this._timelineMenu);
			
			//create the photos component
			this._photosMenu = new FacebookPhotosMC();
			this._photosMenu.name = "photos";
			this._photosMenu.width = 50;
			this._photosMenu.x = 20;
			this._photosMenu.y = this._timelineMenu.y + this._timelineMenu.height + spaceAmount;
			this._photosMenu.buttonMode = true;
			this._photosMenu.useHandCursor = true;
			this._photosMenu.filters = [ArnorFilterClass.createDropShadowFilter()];
			this._photosMenu.addEventListener(MouseEvent.CLICK, handleFacebookMenuClick);
			this.addChild(this._photosMenu);
			
			//create the friends component
			this._friendsMenu = new FacebookFriendsMC();
			this._friendsMenu.name = "friends";
			this._friendsMenu.x = 20;
			this._friendsMenu.y = this._photosMenu.y + this._photosMenu.height + spaceAmount;
			this._friendsMenu.filters = [ArnorFilterClass.createDropShadowFilter()];
			this._friendsMenu.useHandCursor = true;
			this._friendsMenu.buttonMode = true;
			this._friendsMenu.mouseChildren = false;
			this._friendsMenu.addEventListener(MouseEvent.CLICK, handleFacebookMenuClick);
			this.addChild(this._friendsMenu);
			
			//create the message component
			this._messageMenu = new FacebookMessageMC();
			this._messageMenu.name = "message";
			this._messageMenu.x = 20;
			this._messageMenu.y = this._friendsMenu.y + this._friendsMenu.height + spaceAmount;
			this._messageMenu.filters = [ArnorFilterClass.createDropShadowFilter()];
			this._messageMenu.addEventListener(MouseEvent.CLICK, handleFacebookMenuClick);
			this._messageMenu.buttonMode = true;
			this._messageMenu.useHandCursor = true;
			this.addChild(this._messageMenu);
			
			//create the logout component
			this._logoutMenu = new FacebookLogoutMC();
			this._logoutMenu.name = "logout";
			this._logoutMenu.width = 50;
			this._logoutMenu.x = 20;
			this._logoutMenu.y = this._messageMenu.y + this._messageMenu.height + spaceAmount;
			this._logoutMenu.buttonMode = true;
			this._logoutMenu.useHandCursor = true;
			this._logoutMenu.filters = [ArnorFilterClass.createDropShadowFilter()];
			this._logoutMenu.addEventListener(MouseEvent.CLICK, handleFacebookMenuClick);
			this.addChild(this._logoutMenu);
			
		}
		
		/**
		 * Create the authenticate button
		 **/
		private function createAuthenticateButton():void
		{
			//create new instance
			this._authenticateButton = new FacebookAuthenticateMC();			
			
			//check if view contains authentication button
			if(!this.contains(this._authenticateButton))
			{
				//set the position
				this._authenticateButton.x = (this.stage.stageWidth - this._authenticateButton.width) * .5;
				this._authenticateButton.y = (this.stage.stageHeight - this._authenticateButton.height) * .5;
				
				//set the button mode
				this._authenticateButton.buttonMode = true;
				this._authenticateButton.useHandCursor = true;
				this._authenticateButton.mouseChildren = false;
				
				//add event listeners
				this._authenticateButton.addEventListener(MouseEvent.CLICK, handleAuthenticationButtonClick);
				
				//add the component to the view
				this.addChild(this._authenticateButton);
			}
		}
		
		/**
		 * Remove the authentication button
		 **/
		private function removeAuthenticationButton():void
		{
			//remove the authentication button from the stage
			TweenMax.to(this._authenticateButton, .5, {alpha:0, blurFilter:{blurX:20, blurY:20}, onComplete:handleAuthenticationRemoved});
		}
		
		/**
		 * When the authentication button is fully hidden
		 **/
		private function handleAuthenticationRemoved():void
		{
			//remove the authentication button from the view
			//set it to null
			this.removeChild(this._authenticateButton);
			this._authenticateButton = null;
		}
		
		/**
		 * Reposition menu
		 **/
		private function resizeMenu():void
		{
			//calculate the av. space
			var spaceAmount:Number = (this.stage.stageHeight - (this._title.height + 4) - this._timelineMenu.height - this._photosMenu.height - this._friendsMenu.height - this._messageMenu.height - this._logoutMenu.height - 110) / 4;
			
			//check if stage contains the menu
			if(this.contains(this._title))
			{
				this._timelineMenu.y = this._title.y + this._title.height + 40;
				this._photosMenu.y = this._timelineMenu.y + this._timelineMenu.height + spaceAmount;
				this._friendsMenu.y = this._photosMenu.y + this._photosMenu.height + spaceAmount;
				this._messageMenu.y = this._friendsMenu.y + this._friendsMenu.height + spaceAmount;
				this._logoutMenu.y = this._messageMenu.y + this._messageMenu.height + spaceAmount;
			}
		}
		
		/**
		 * Remove object after tween is complete
		 **/
		private function removeObject(object:*):void
		{
			//remove the object from it's parent
			object.parent.removeChild(object);
			object = null;
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
		 * 
		 * Remove event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//MonsterDebugger.trace(this, "init facebook");
			
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set basics
			setBasics();
		}
		
		private function handleLoaderComplete(evt:Event):void
		{
			//grab the content
			this._background = evt.target.content as DisplayObject;
			
			//set the size
			var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
			this._background.width *= scale;
			this._background.height *= scale;
			
			//position
			this._background.x = this._background.y = 0;
			
			//alpha
			this._background.alpha = 0;
			
			//add to the stage
			this.addChild(this._background);
			
			//Tween the background
			TweenLite.to(this._background, .5, {alpha:1});
			
			//bring the basic components to the front
			bringBasicsToFront();
			
			//check if user is logged in
			checkFacebookLogin();
		}
		
		private function handleLoaderProgress(evt:ProgressEvent):void
		{
			//percentage
			var perc:Number = evt.bytesLoaded / evt.bytesTotal;
			
			//update preloader
			this._preloader.updateLoader(perc);
		}
		
		private function handleError(evt:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, "error loading background facebook", 0xFF0000);
		}
		
		/**
		 * When users clicks on the authentication button
		 **/
		private function handleAuthenticationButtonClick(evt:MouseEvent):void
		{
			dispatchEvent(new FacebookEvent(FacebookEvent.AUTHENTICATION_CLICKED));
			
			//MonsterDebugger.trace(this, "clicked login button");
			
			//set the permissions of the application
			var opts:Object = {perms:"publish_stream, user_photos, user_photo_video_tags, user_about_me, user_relationships, user_relationship_details, user_birthday, user_hometown, user_status"};
			
			//login into facebook
			//add the options to the login request
			Facebook.login(onLogin, opts);
		}
		
		/**
		 * Handle facebook menu item click
		 **/
		private function handleFacebookMenuClick(evt:MouseEvent):void
		{
			switch(evt.target.name)
			{
				case "timeline":
					dispatchEvent(new FacebookEvent(FacebookEvent.LOAD_TIMELINE));
					break;
				
				case "photos":
					dispatchEvent(new FacebookEvent(FacebookEvent.EXIT_FULLSCREEN));
					navigateToURL(new URLRequest("http://www.facebook.com/group.php?gid=72308406080&v=photos"), "_blank");
					break;
				
				case "friends":
					dispatchEvent(new FacebookEvent(FacebookEvent.LOAD_FRIENDS));
					break;
				
				case "message":
					dispatchEvent(new FacebookEvent(FacebookEvent.MESSAGE));
					break;
				
				case "logout":
					dispatchEvent(new FacebookEvent(FacebookEvent.LOGOUT));
					break;
			}
		}
		
		/**
		 * Handle loaded tag cloud complete
		 **/
		private function handleLoadTagCloudComplete(evt:Event):void
		{
			this.addChild(evt.target.content);
		}
		
		private function handleLoaderProgressTagCloud(evt:ProgressEvent):void
		{
			MonsterDebugger.trace(this, evt.bytesLoaded / evt.bytesTotal);
		}
		
		private function handleErrorTagCloud(evt:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, evt.text, 0xFF0000);
		}
	}
}