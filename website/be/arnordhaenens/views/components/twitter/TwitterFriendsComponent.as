/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 27, 2011, at 6:02:42 PM
 ********************************
 **/
package be.arnordhaenens.views.components.twitter
{
	import be.arnordhaenens.events.TwitterEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	TwitterFriendsComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 27, 2011, at 6:02:42 PM
	 * @see		be.arnordhaenens.views.components.twitter.TwitterFriendsComponent
	 **/
	public class TwitterFriendsComponent extends TwitterFriendsMC
	{
		/**
		 * Variables
		 **/
		private var _maxWidth:int;
		private var _loader:Loader;
		
		private var _thumbevents:Boolean = false;
		
		private var _lastX:int = 0;
		private var _lastY:int = 0;
		
		private var _lastXSlider:int = 0;
		
		/**
		 * Constructor
		 **/
		public function TwitterFriendsComponent()
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
			//resize friends
			_maxWidth = this.stage.stageWidth - this.parent.parent.getChildByName("arteveldelogo").width - 80 - 135;
			
			//set the slider
			this.slider.bufferBar.width = _maxWidth;
			this.slider.progress.x = 0;
			
			//set the mask and background
			//this.container.width = this._maxWidth;
			this.friendsmask.width = this._maxWidth;
			
			if(this.friendsmask.width >= this.container.width)
				this.slider.visible = false;
			else if(this.friendsmask.width <  this.container.width)
				this.slider.visible = true;
		}
		
		/**
		 * Add Follower image
		 **/
		public function loadFollower(_image:String, _name:String):void
		{
			//create new instance
			this._loader = new Loader();
			this._loader.name = _name;
			//add event listener
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleFollowerLoadComplete);
			//load the follower
			this._loader.load(new URLRequest(_image));
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
		 * Set the position
		 * Set the mask
		 * Get the max width
		 * Set the slider properties
		 * Set the mask and container properties
		 * Clear the background
		 **/
		private function setBasics():void
		{			
			//set the position
			this.x = 20;
			this.y = 10;
			
			//set the mask
			this.container.mask = this.friendsmask;
			
			//set the maximum width
			//this for the mask
			//slider
			_maxWidth = this.stage.stageWidth - this.parent.parent.getChildByName("arteveldelogo").width - 80 - 135;
			
			//set the slider
			this.slider.bufferBar.width = _maxWidth;
			this.slider.progress.x = 0;
			//this.slider.bufferBar.addEventListener(MouseEvent.CLICK, handleFriendsBarClick);
			this.slider.progress.addEventListener(MouseEvent.MOUSE_DOWN, handleThumbMouseDown);
			this.slider.progress.addEventListener(MouseEvent.MOUSE_UP, handleThumbMouseUp);
			
			//set the mask and background
			//this.container.width = this._maxWidth;
			this.friendsmask.width = this._maxWidth;
			
			//clear background
			this.container.background.alpha = 0;
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Handle added to stage
		 * 
		 * Init function
		 * Remove the event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
		}
		
		/**
		 * Handle friends bar click
		 **/
		private function handleFriendsBarClick(evt:MouseEvent):void
		{
			this.slider.progress.x = evt.localX;
		}
		
		/**
		 * Handle mouse down on the thumb
		 **/
		private function handleThumbMouseDown(evt:MouseEvent):void
		{
			if(!this._thumbevents)
			{
				this.slider.progress.addEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
				this.slider.progress.addEventListener(MouseEvent.MOUSE_OUT, handleThumbMouseOut);
				this._thumbevents = true;
			}
		}
		
		/**
		 * Handle mouse up on the thumb
		 **/
		private function handleThumbMouseUp(evt:MouseEvent):void
		{
			this.slider.progress.stopDrag();
			this.slider.progress.removeEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
			this.slider.progress.removeEventListener(MouseEvent.MOUSE_OUT, handleThumbMouseOut);
			this._thumbevents = false;
		}
		
		/**
		 * Handle drag when holding mouse button down on the slider
		 **/
		private function handleDrag(evt:MouseEvent):void
		{
			this.slider.progress.startDrag(false, new Rectangle(0,3.1,this.slider.bufferBar.width, 0));
						
			if(evt.target.x > this._lastXSlider)
			{
				this.container.x = 0 - (this.container.width - this.friendsmask.width) * (evt.target.x / this.slider.bufferBar.width);
			}
			else if(evt.target.x < this._lastXSlider)
			{
				this.container.x = 0 - (this.container.width - this.friendsmask.width) * (evt.target.x / this.slider.bufferBar.width) + 40;
				
			}
			
			this._lastXSlider = evt.target.x;
		}
		
		/**
		 * Handle mouse out of the progress indicator
		 **/
		private function handleThumbMouseOut(evt:MouseEvent):void
		{
			/*this.slider.progress.stopDrag();
			this.slider.progress.removeEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
			this.slider.progress.removeEventListener(MouseEvent.MOUSE_OUT, handleThumbMouseOut);
			this._thumbevents = false;*/
			this.parent.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		/**
		 * Handle Mouse up
		 **/
		private function handleMouseUp(evt:MouseEvent):void
		{
			this.slider.progress.stopDrag();
			this.slider.progress.removeEventListener(MouseEvent.MOUSE_MOVE, handleDrag);
			this.slider.progress.removeEventListener(MouseEvent.MOUSE_OUT, handleThumbMouseOut);
			this._thumbevents = false;
			
			this.parent.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
		}
		
		/**
		 * Handle Follower Loaded complete
		 **/
		private function handleFollowerLoadComplete(evt:Event):void
		{
			//MonsterDebugger.trace(this, evt);
			
			//grab the content
			var image:DisplayObject = evt.target.content as DisplayObject;
			
			//set the size
			var ra:Number = image.width / image.height;
			image.height = 25;
			image.width = image.height * ra;
			
			//create new movieclip object
			var mc:MovieClip = new MovieClip();
			mc.name = evt.target.loader.name + "," + evt.target.url;
			mc.buttonMode = true;
			mc.useHandCursor = true;
			mc.mouseChildren = false;
			
			//set the position
			mc.x = this._lastX;
			
			//set lastX
			this._lastX += image.width;
			
			//add event listener
			mc.addEventListener(MouseEvent.CLICK, handleFollowerClicked);
			
			//add the image to the movieclip
			mc.addChild(image);
			
			//add the image to the container
			this.container.addChild(mc);
			
			if(this.friendsmask.width >= this.container.width)
				this.slider.visible = false;
			else if(this.friendsmask.width <  this.container.width)
				this.slider.visible = true;
		}
		
		/**
		 * Handle Follower clicked
		 **/
		private function handleFollowerClicked(evt:MouseEvent):void
		{
			//MonsterDebugger.trace(this, evt.target);
			var name:String = evt.target.name;
			var followerArray:Array = name.split(",");
			
			dispatchEvent(new TwitterEvent(TwitterEvent.LOAD_FOLLOWER_TWEET, followerArray));
		}
	}
}