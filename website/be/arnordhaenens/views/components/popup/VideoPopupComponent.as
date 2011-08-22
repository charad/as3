/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 8:26:35 PM
 ********************************
 **/
package be.arnordhaenens.views.components.popup
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.vimeo.api.VimeoPlayer;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	VideoPopupComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 22, 2011, at 8:26:35 PM
	 * @see		be.arnordhaenens.views.components.popup.VideoPopupComponent
	 **/
	public class VideoPopupComponent extends VideoPopupMC
	{
		/**
		 * Variables
		 **/
		private static const VIMEO_KEY:String = "8e8a715dbe83900180243df10f942ea5 ";
		
		private var _vimeoComponent:VimeoPlayer;
		private var _youtube:YoutubeComponent;
		
		private var _data:Array;
		private var _dataLength:int;
		private var _currentIndex:int = -1;
		private var _currentObject:Object;
		
		/**
		 * Constructor
		 **/
		public function VideoPopupComponent(data:Array)
		{
			super();
			
			//set the data
			this._data = data;
			this._dataLength = this._data.length;
			
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
			//set the new position
			this.x = (this.stage.stageWidth) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
		}
		
		/**
		 * Destroy any video components
		 * All netstream objects will automatically be removed
		 **/
		public function destroyVideo():void
		{
			if(this._youtube != null)
			{
				//destroy netstream
				this._youtube.player.destroy();
				
				//remove the component
				this.content.container.removeChild(this._youtube);
				
				//set youtube to null
				this._youtube = null;
			}
			
			if(this._vimeoComponent != null)
			{
				//destroy the net object
				this._vimeoComponent.destroy();
				
				//remove the component
				this.content.container.removeChild(this._vimeoComponent);
				
				//set the component to null
				this._vimeoComponent = null;
			}
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
		 * Add filter
		 * Set the position
		 * Add event listeners
		 **/
		private function setBasics():void
		{
			//add drop shadow filter
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//set the position
			this.x = (this.stage.stageWidth) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//add event listeners
			if(this._dataLength > 1)
			{
				this.btnNext.addEventListener(MouseEvent.CLICK, handleNextClicked);
				this.btnPrevious.addEventListener(MouseEvent.CLICK, handlePreviousClicked);
			}
			else if(this._dataLength == 1)
			{
				this.btnNext.visible = false;
				this.btnPrevious.visible = false;
			}
			
			//update video
			updateVideo("next");
			
			//bring menu to the front
			this.parent.addChild(this.parent.getChildByName("menu"));
		}
		
		/**
		 * Update the video
		 **/
		private function updateVideo(direction:String):void
		{
			if(direction == "prev")
			{
				if(this._currentIndex - 1 >= 0)
					this._currentIndex -= 1;
				else if(this._currentIndex - 1 < 0)
					this._currentIndex = (this._dataLength - 1);
			}
			else if(direction == "next")
			{
				if(this._currentIndex + 1 <= (this._dataLength - 1))
					this._currentIndex += 1;
				else if(this._currentIndex + 1 > (this._dataLength - 1))
					this._currentIndex = 0;
			}
			
			//grab the current object
			this._currentObject = this._data[this._currentIndex];
			
			MonsterDebugger.trace(this, this._currentObject);
			
			//set the video
			setVideo();
		}
		
		/**
		 * Set the new video
		 **/
		private function setVideo():void
		{
			destroyVideo();
			
			//grab the video url of the current object
			var url:String = this._currentObject.url;
			
			//check the url
			if(url.indexOf("youtube.com") != -1)
				displayYoutube();
			else if(url.indexOf("vimeo.com") != -1)
				displayVimeo();
		}
		
		/**
		 * Display youtube media asset
		 **/
		private function displayYoutube():void
		{
			this._youtube = new YoutubeComponent(this._currentObject.url);
			//this._youtube.addEventListener(PopupEvent.VIDEO_ENDED, handleVideoYoutubeEnded);
			this.addChild(this._youtube);
			this._youtube.init();
		}
		
		/**
		 * Display vimeo media asset
		 **/
		private function displayVimeo():void
		{
			//video id
			var id_video:int;
			
			if(this._currentObject.url.indexOf("http://vimeo.com/") != -1)
			{
				id_video = int(this._currentObject.url.slice(17, int.MAX_VALUE));
			}
			else if(this._currentObject.url.indexOf("http://www.vimeo.com/") != -1)
			{
				id_video = int(this._currentObject.url.slice(21, int.MAX_VALUE));
			}
			else
			{
				id_video = int(this._currentObject.url);
			}
			
			//create new instance
			this._vimeoComponent = new VimeoPlayer(VIMEO_KEY, id_video, 640, 360);
			
			//add event listener
			//this._vimeoComponent.addEventListener("finish", handleVimeoFinished, false, 0, true);
			
			//add vimeo component to the view
			this.content.container.addChild(this._vimeoComponent);
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
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
		}
		
		/**
		 * Handle next clicked
		 **/
		private function handleNextClicked(evt:MouseEvent):void
		{
			updateVideo("next");
		}
		
		/**
		 * Handle previous clicked
		 **/
		private function handlePreviousClicked(evt:MouseEvent):void
		{
			updateVideo("prev");
		}
		
		/**
		 * Handle close clicked
		 **/
		private function handleCloseClicked(evt:MouseEvent):void
		{
			//hide the component
		}
	}
}