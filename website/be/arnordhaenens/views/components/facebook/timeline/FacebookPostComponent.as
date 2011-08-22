/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 19, 2011, at 11:08:28 PM
 ********************************
 **/
package be.arnordhaenens.views.components.facebook.timeline
{
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.events.PopupEvent;
	
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	FacebookPostComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 19, 2011, at 11:08:28 PM
	 * @see		be.arnordhaenens.views.components.facebook.timeline.FacebookPostComponent
	 **/
	public class FacebookPostComponent extends FacebookPostMC
	{
		/**
		 * Variables
		 **/
		private var _data:Array;
		private var _dataLength:int;
		private var _currentObject:Object;
		private var _currentIndex:int = -1;
		
		private var _image:String;
		private var _video:String;
		private var _link:String;
		
		private var _postid:String;
		private var _message:String;
		private var _date:String;
		private var _dateConverted:Date;
		
		private var _fromName:String;
		private var _fromID:String;
		
		private static const PAGE_ID:String = "72308406080";
		private static const PICTURE_LINK:String = "http://www.facebook.com/photo.php?fbid=";
		
		/**
		 * Constructor
		 **/
		public function FacebookPostComponent(data:Array)
		{
			//'save' the data
			//get the lenght
			this._data = data;
			this._dataLength = this._data.length;
			
			//add event listener
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
			MonsterDebugger.trace(this, "post component");
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
			this.x = ((this.stage.stageWidth  - this.width)*.5) + 50;
			this.y = (this.stage.stageHeight - this.height) * .5;
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
		 * Add event listeners to the buttons
		 * Set the visibility of the buttons
		 * Load the first text
		 **/
		private function setBasics():void
		{
			this.parent.addChild(this.parent.getChildByName("menu"));
			
			//set the position
			//top right position
			this.x = this.stage.stageWidth;
			this.y = 0;
			
			//set the alpha to 0
			this.alpha = 0;
			
			//hide the fields
			this.txtFrom.visible = false;
			this.txtDate.visible = false;
			this.txtMessage.visible = false;
			this.txtFigure.visible = false;
			this.btnPost.visible = false;
			this.btnNext.visible = false;
			this.btnPrevious.visible = false;
			this.btnImage.visible = false;
			this.btnLink.visible = false;
			this.btnVideo.visible = false;
			
			//add event listeners to the buttons
			this.btnImage.addEventListener(MouseEvent.CLICK, handleImageButtonClicked);
			this.btnLink.addEventListener(MouseEvent.CLICK, handleLinkButtonClicked);
			this.btnNext.addEventListener(MouseEvent.CLICK, handleNextClicked);
			this.btnPost.addEventListener(MouseEvent.CLICK, handleViewPostButtonClicked);
			this.btnPrevious.addEventListener(MouseEvent.CLICK, handlePreviousButtonClicked);
			this.btnVideo.addEventListener(MouseEvent.CLICK, handleVideoButtonClicked);
			
			//Tween the post
			TweenMax.to(this, .5, {x:(((this.stage.stageWidth  - this.width)*.5) + 50), y:((this.stage.stageHeight - this.height) * .5), alpha:1, onComplete:handleDisplayTweenComplete});
		}
		
		/**
		 * Hanle display tween complete
		 **/
		private function handleDisplayTweenComplete():void
		{
			//display first post
			displayPost("next");
		}
		
		/**
		 * Display a given post
		 * 
		 * Grab the user
		 * Grab the message (if message is available)
		 * Grab the image
		 * Grab the video
		 **/
		private function displayPost(direction:String):void
		{		
			if(txtDate.visible)
			{
				//hide the fields
				this.txtFrom.visible = false;
				this.txtDate.visible = false;
				this.txtMessage.visible = false;
				this.txtFigure.visible = false;
				this.btnPost.visible = false;
				this.btnImage.visible = false;
				this.btnLink.visible = false;
				this.btnVideo.visible = false;
			}
			
			this.txtLoading.visible = true;
			
			//show buttons
			this.btnNext.visible = true;
			this.btnPrevious.visible = true;
			
			//reset the values
			this._postid = "";
			this._fromID = "";
			this._fromName = "";
			this._message = "";
			this._image = "";
			this._video = "";
			this._link = "";
			this._date = "";
			this._currentObject = null;
			
			//check if user want's to view the previous or the next post
			if(direction == "next")
			{
				if((this._currentIndex + 1) <= (this._dataLength - 1))
				{
					//set the current index
					this._currentIndex += 1;
				}
				else if((this._currentIndex + 1) > (this._dataLength - 1))
				{
					//set the new index
					this._currentIndex = 0;
				}
			}
			else if(direction == "prev")
			{
				if((this._currentIndex - 1) >= 0)
				{
					this._currentIndex -= 1;
				}
				else if((this._currentIndex - 1) < 0)
				{
					this._currentIndex = (this._dataLength - 1);
				}
			}
			
			//grab the object from the array
			this._currentObject = this._data[this._currentIndex];
			
			MonsterDebugger.trace(this, this._currentObject);
			
			//check if object contains the right / desired data
			this._postid = this._currentObject.id;
			this._date = returnDateString(this._currentObject.updated_time);
			//set the date text field
			this.txtDate.text = this._date;
			
			//get the user information
			this._fromName = this._currentObject.from.name;
			this._fromID = this._currentObject.from.id;
			//set the username text field
			this.txtFrom.text = "[ " + this._fromName + " ]";
			
			//check if user has given an extra message with the post
			if(this._currentObject.message != null)
				this._message = this._currentObject.message;
			else
				this._message = "De gebruiker heeft geen extra boodschap meegegeven voor deze post";
			
			//set the message text field
			this.txtMessage.text = this._message;
			
			//check if the post contains an external link
			if(this._currentObject.link != null)
			{
				this._link = this._currentObject.link;
				this.btnLink.visible = true;
			}
			
			//check if the post contains a picture / image
			if(this._currentObject.picture != null)
			{
				//this._image = this._currentObject.picture;
				this._image = this._currentObject.object_id
				this.btnImage.visible = true;
			}
			
			//check if the post has type of video
			//if so, check if it is an youtube or vimeo link
			//if so, save the source link
			if(this._currentObject.type=="video")
			{
				if(this._currentObject.source.indexOf("youtube") != -1 || this._currentObject.indexOf("vimeo") != -1)
				{
					this._video = this._currentObject.source;
					this.btnVideo.visible = true;
				}
			}
			
			//hide loading
			this.txtLoading.visible = false;
			
			//show the fields
			this.txtFrom.visible = true;
			this.txtDate.visible = true;
			this.txtMessage.visible = true;
			this.txtFigure.visible = true;
			this.btnPost.visible = true;
		}
		
		/**
		 * Return date string
		 **/
		private function returnDateString(dateRaw:String):String
		{
			//set the variable
			var date:String;
			
			//create the variables
			var dagen:String;
			var maand:String;
			var jaar:String;
			var uren:String;
			var minuten:String;
			
			//set the values for the date
			jaar = dateRaw.slice(0, 4);
			maand = dateRaw.slice(5,7);
			dagen = dateRaw.slice(8, 10);
			
			//set the values for the time
			uren = dateRaw.slice(11, 13);
			minuten = dateRaw.slice(14,16);
			
			//compose the date string from the individual elements
			date = dagen + "/" + maand + "/" + jaar + " om " + uren + ":" + minuten;
			
			//return the converted date
			return date;
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init function
		 * 
		 * Remove event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set basics
			setBasics();
		}
		
		/**
		 * Handle image button clicked
		 **/
		private function handleImageButtonClicked(evt:MouseEvent):void
		{
			//exit fullscreen
			dispatchEvent(new FacebookEvent(FacebookEvent.EXIT_FULLSCREEN));
			
			//navigate to the page
			navigateToURL(new URLRequest(PICTURE_LINK + this._image), "_blank");
		}
		
		/**
		 * Handle Video button clicked
		 **/
		private function handleVideoButtonClicked(evt:MouseEvent):void
		{
			var type:String = "";
			
			if(this._video.indexOf("youtube") != -1)
				type = "youtube";
			else if(this._video.indexOf("vimeo") != -1)
				type = "vimeo";
			
			//dispatch event
			//create new popup
			dispatchEvent(new PopupEvent(PopupEvent.CREATE_POPUP, [type, this._video]));
		}
		
		/**
		 * Handle link button clicked
		 **/
		 private function handleLinkButtonClicked(evt:MouseEvent):void
		 {
			//exit the full screen
			 dispatchEvent(new FacebookEvent(FacebookEvent.EXIT_FULLSCREEN));
			 
			 //navigate to the external link
			 navigateToURL(new URLRequest(this._link), "_blank");
		 }
		 
		 /**
		 * Handle next post button clicked
		 **/
		 private function handleNextClicked(evt:MouseEvent):void
		 {
			 //get the next post
			 displayPost("next");
		 }
		 
		 /**
		 * Handle previous post button clicked
		 **/
		 private function handlePreviousButtonClicked(evt:MouseEvent):void
		 {
			 //display the previous post
			 displayPost("prev");
		 }
		 
		 /**
		 * Handle view full post clicked
		 **/
		 private function handleViewPostButtonClicked(evt:MouseEvent):void
		 {
			 //exit fullscreen
			 dispatchEvent(new FacebookEvent(FacebookEvent.EXIT_FULLSCREEN));
			 
			 //navigate to the facebook page with the given url
			 navigateToURL(new URLRequest("http://facebook.com/group.php?gid=" + PAGE_ID + "&v=wall"), "_blank");
		 }
	}
}