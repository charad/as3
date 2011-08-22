/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 28, 2011, at 4:23:21 PM
 ********************************
 **/
package be.arnordhaenens.views.components.twitter
{
	import be.arnordhaenens.events.TwitterEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	TimelineTweetComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 28, 2011, at 4:23:21 PM
	 * @see		be.arnordhaenens.views.components.twitter.TimelineTweetComponent
	 **/
	public class TimelineTweetComponent extends PbaTweetMC
	{
		/**
		 * Variables
		 **/
		private var _tweetData:Object;
		private var _loader:Loader;
		private var _img:DisplayObject;
		
		private var _rightControl:RightControlMC;
		private var _leftControl:LeftControlMC;
		
		/**
		 * Constructor
		 **/
		public function TimelineTweetComponent(_data:Object)
		{
			//add event listener
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the data
			this._tweetData = _data;
			//MonsterDebugger.trace(this, this._tweetData);
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
			//set the position
			this.x = this.stage.stageWidth * .5;
			this.y = this.stage.stageHeight * .5;
			
			//set the position of the controls
			this._leftControl.y = (this.stage.stageHeight - this._leftControl.height) * .5;
			this._rightControl.x = this.stage.stageWidth - this._rightControl.width + 32  - 20;
			this._rightControl.y = (this.stage.stageHeight - this._rightControl.height) * .5;
		}
		
		/**
		 * Remove the element
		 **/
		public function removeElement():void
		{
			this.parent.removeChild(this.parent.getChildByName("leftcontrol"));
			this.parent.removeChild(this.parent.getChildByName("rightcontrol"));
			this.parent.removeChild(this);
		}
		
		/**
		 * Load next tweet
		 **/
		public function loadNextTweet(_data:Object):void
		{
			//set the data
			this._tweetData = _data;
			
			//Tween the component
			TweenMax.to(this, .5, {x:(this.stage.stageWidth * 2), blurFilter:{blurX:20, blurY:20}, onComplete:handleNextTweenComplete});
		}
		
		/**
		 * Load previous tweet
		 **/
		public function loadPreviousTweet(_data:Object):void
		{
			//set the data
			this._tweetData = _data;
			
			//Tween the component
			TweenMax.to(this, .5, {x:-(this.stage.stageWidth * 2), blurFilter:{blurX:20, blurY:20}, onComplete:handlPreviousTweenComplete});
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
		 * Set the basics
		 * 
		 * Hide initially
		 * Add DropShadow filter
		 * Set the position
		 * Hide the close button
		 * Load the image
		 * Set the content
		 **/
		private function setBasics():void
		{
			//hide
			this.alpha = 0;
			
			this.scaleX = 0;
			this.scaleY = 0;
			
			//add filter
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//set the position
			this.x = this.stage.stageWidth * .5;
			//this.x = - this.stage.stageWidth;
			this.y = this.stage.stageHeight* .5;
			
			//hide close button
			this.tweet.close.visible = false;
			
			//load the image
			loadUserImage();
			
			//set the content
			setData();
			
		}
		
		/**
		 * Load the users's profile image
		 **/
		private function loadUserImage():void
		{
			//create new instance loader
			this._loader = new Loader();
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleUserImageLoaded);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleIOErrorImageLoading);
			
			this._loader.load(new URLRequest(this._tweetData.user.profile_image_url));
		}
		
		/**
		 * Set the data for the tweet
		 **/
		private function setData():void
		{
			//create date and set the date
			var date:Date = new Date(this._tweetData.created_at);
			this.tweet.txtDate.text = date.getDate() + "/" + (date.getMonth()+1) + "/" + date.getFullYear();
			
			//set the text
			this.tweet.txtContent.text = this._tweetData.text;
			
			//set the username
			this.tweet.txtUser.text = "@" + "pbagdm";
		}
		
		/**
		 * Create the controls
		 **/
		private function createControls():void
		{
			//create left control
			//create new instance
			this._leftControl = new LeftControlMC();
			this._leftControl.name = "leftcontrol";
			this._leftControl.x = 20;
			this._leftControl.y = (this.stage.stageHeight - this._leftControl.height) * .5;
			this._leftControl.buttonMode = true;
			this._leftControl.mouseChildren = false;
			this._leftControl.useHandCursor = true;
			this._leftControl.addEventListener(MouseEvent.CLICK, handleLeftClick);
			this.parent.addChild(this._leftControl);
			
			//create right control
			this._rightControl = new RightControlMC();
			this._rightControl.name = "rightcontrol";
			this._rightControl.x = this.stage.stageWidth - this._rightControl.width + 32  - 20;
			this._rightControl.y = (this.stage.stageHeight - this._rightControl.height) * .5;
			this._rightControl.buttonMode = true;
			this._rightControl.mouseChildren = false;
			this._rightControl.useHandCursor = true;
			this._rightControl.addEventListener(MouseEvent.CLICK, handleRightClick);
			this.parent.addChild(this._rightControl);
		}
		
		/**
		 * Handle tween load next tweet complete
		 **/
		private function handleNextTweenComplete():void
		{
			//force the component to the other side of the stage
			this.x = -(this.stage.stageWidth * 2);
			
			//set the values of the tweet
			setData();
			
			//tween the component
			TweenLite.to(this, .5, {x:(this.stage.stageWidth * .5), blurFilter:{blurX:0, blurY:0}, ease:Sine.easeOut});
		}
		
		/**
		 * Handle tween load previous tweet complete
		 **/
		private function handlPreviousTweenComplete():void
		{
			//force the component to the other side of the stage
			this.x = this.stage.stageWidth * 2;
			
			//set the values of the tweet
			setData();
			
			//tween the component
			TweenLite.to(this, .5, {x:(this.stage.stageWidth * .5), blurFilter:{blurX:0, blurY:0}, ease:Sine.easeOut});
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
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
			
			//create controls
			createControls();
		}
		
		/**
		 * When the image is fully loaded
		 **/
		private function handleUserImageLoaded(evt:Event):void
		{
			//grab the loader's content
			this._img = evt.target.content as DisplayObject;
			
			//set the size
			var ra:Number = this._img.width / this._img.height;
			this._img.height = 80;
			this._img.width = this._img.height * ra;
			
			//set the position
			this._img.x = -245;
			this._img.y = this.tweet.txtUser.y;
			
			this.tweet.addChild(this._img);
			
			TweenLite.to(this, 1, {x:(this.stage.stageWidth)*.5, alpha:1, scaleX:1, scaleY:1});
		}
		
		/**
		 * Error loading the users' image
		 **/
		private function handleIOErrorImageLoading(evt:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, "io error loading image", 0xFF0000);
		}
		
		/**
		 * Handle left click
		 **/
		private function handleLeftClick(evt:MouseEvent):void
		{
			dispatchEvent(new TwitterEvent(TwitterEvent.PREVIOUS_TIMELINE_TWEET));
		}
		
		/**
		 * handle right click
		 **/
		private function handleRightClick(evt:MouseEvent):void
		{
			dispatchEvent(new TwitterEvent(TwitterEvent.NEXT_TIMELINE_TWEET));
		}
	}
}