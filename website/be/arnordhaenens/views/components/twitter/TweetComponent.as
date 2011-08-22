/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 28, 2011, at 1:49:54 PM
 ********************************
 **/
package be.arnordhaenens.views.components.twitter
{
	import be.arnordhaenens.events.TwitterEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
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
	 * Class	TweetComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 28, 2011, at 1:49:54 PM
	 * @see		be.arnordhaenens.views.components.twitter.TweetComponent
	 **/
	public class TweetComponent extends TweetMC
	{
		/**
		 * Variables
		 **/
		private var _loader:Loader;
		private var _return:TwitterPbaNotificationMC;
		
		private var _followerData:Object;
		
		/**
		 * Constructor
		 **/
		public function TweetComponent(_data:Object)
		{
			//add event listener
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the data
			this._followerData = _data;
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Handle stage / window resize
		 **/
		public function handleResize():void
		{
			//set the position			
			this.x = this.stage.stageWidth * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//set the position return message
			var returnMessage:* = this.parent.getChildByName("return");
			returnMessage.x = this.stage.stageWidth - returnMessage.width - 20;
			returnMessage.y = this.stage.stageHeight - returnMessage.height - 30 - 20;
		}
		
		/**
		 * Remove
		 **/
		public function removeTweet():void
		{
			TweenMax.to(this, 1, {alpha:0, scaleX:0, scaleY:0, onComplete:handleRemoveTweet});
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
		 * Set basics
		 * 
		 * Set the position
		 * Set alpha
		 * Set close button properties
		 * Add event listener to the close button
		 **/
		private function setBasics():void
		{
			//add dropshadow filter to the component
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//set the position
			this.x = this.stage.stageWidth * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//set alpha
			this.alpha = 0;
			
			//set close button properties
			//add event listener to the close button
			this.close.buttonMode = true;
			this.close.useHandCursor = true;
			this.close.mouseChildren = false;
			this.close.addEventListener(MouseEvent.CLICK, handleReturn);
			
			//load the follower's profile image
			loadImageFollower(this._followerData.profile_image_url);
			
			//set the data 
			setTweetData();
			
			//set return message
			setReturn();
		}
		
		/**
		 * Load the image
		 **/
		private function loadImageFollower(imgURL:String):void
		{
			//create new instance loader
			this._loader = new Loader();
			
			//add event listeners to the loader
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaderComplete);
			this._loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handleIOErrorLoader);
			
			//load the url / image
			this._loader.load(new URLRequest(imgURL));
		}
		
		/**
		 * Set the basic data for the tweet
		 **/
		private function setTweetData():void
		{
			//set the name of the user
			this.txtUser.text = "@" + this._followerData.screen_name;
			
			var status:* = this._followerData.status;
			
			if(status != null)
			{
				//create date and set the date
				var date:Date = new Date(this._followerData.status.created_at);
				this.txtDate.text = date.getDate() + "/" + (date.getMonth()+1) + "/" + date.getFullYear();
				
				//set the content
				this.txtContent.text = this._followerData.status.text;
			}
			else if(status == null)
			{
				this.txtDate.text = "";
				this.txtContent.text = "Deze gebruiker heeft een beveiligd profiel.";
			}
		}
		
		/**
		 * Set return notification
		 **/
		private function setReturn():void
		{
			var returnMessage:* = this.parent.getChildByName("return");
			
			if(returnMessage == null)
			{
				//create new instance
				this._return = new TwitterPbaNotificationMC();
				this._return.name = "return";
				
				//set the position
				//this._return.x = this.stage.stageWidth - this._return.width - 20;
				this._return.x = this.stage.stageWidth * 2;
				this._return.y = this.stage.stageHeight - this._return.height - 30 - 20;
				
				//set the basics
				this._return.filters = [ArnorFilterClass.createDropShadowFilter()];
				this._return.buttonMode = true; 
				this._return.useHandCursor = true; 
				this._return.mouseChildren = false;
				this._return.addEventListener(MouseEvent.CLICK, handleReturn);
				this._return.speech.visible = false;
				
				//add to the view
				this.parent.addChild(this._return);
				
				//tween the element
				TweenMax.to(this._return, .75,{x:this.stage.stageWidth - this._return.width - 20, onComplete:showSpeech});
			}
		}
		
		private function showSpeech():void{this._return.speech.visible = true;}
		
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
		 * Remove the event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set basics
			setBasics();
		}
		
		/**
		 * Handle Loader Complete
		 **/
		private function handleLoaderComplete(evt:Event):void
		{
			//grab the content
			var img:DisplayObject = evt.target.content as DisplayObject;
			
			//grab the scale
			var scale:Number = img.width / img.height;
			img.height = 97.6;
			img.width = scale * img.height;
			
			//set the position
			img.x = -245;
			img.y = this.txtUser.y;
			
			//add the image to the tweet
			this.addChild(img);
			
			//show the tweet
			TweenLite.to(this, 1, {alpha:1});
		}
		
		/**
		 * Handle IO Error loading image follower
		 **/
		private function handleIOErrorLoader(evt:IOErrorEvent):void
		{
			MonsterDebugger.trace(this, "Error loading image follower", 0xFF0000);
		}
		
		/**
		 * Handle Close button Click
		 * 
		 * Remove the tweet
		 * Return to the timeline overview 
		 * Where the tweet is loaded where we left off
		 **/
		private function handleReturn(evt:MouseEvent):void
		{
			//grab return message
			var returnMessage:* = this.parent.getChildByName("return");
			if(returnMessage != null)
				TweenMax.to(returnMessage, 1, {alpha:0, x:(this.stage.stageWidth * 2), onComplete:removeReturn});
			
			//remove the tweet
			TweenMax.to(this, 1, {alpha:0, scaleX:0, scaleY:0, onComplete:handleRemoveTweet});
			
			returnMessage.speech.visible = false;
			returnMessage.scaleX = -1;
			
			
			//dispatch event
			dispatchEvent(new TwitterEvent(TwitterEvent.FOLLOWER_TWEET_REMOVED));
		}		
		
		private function handleRemoveTweet():void{this.parent.removeChild(this);}
		private function removeReturn():void{/*this.parent.removeChild(this.parent.getChildByName("return"));*/}
	}
}