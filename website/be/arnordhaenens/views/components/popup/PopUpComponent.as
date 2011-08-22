/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 4:48:58 PM
 ********************************
 **/
package be.arnordhaenens.views.components.popup
{
	import be.arnordhaenens.events.PopupEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.vimeo.api.VimeoPlayer;
	
	import fl.containers.UILoader;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	PopUpComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 20, 2011, at 4:48:58 PM
	 * @see		be.arnordhaenens.views.components.popup.PopUpComponent
	 **/
	public class PopUpComponent extends PopUpMC
	{
		/**
		 * Variables
		 **/
		private var _type:String;
		private var _url:String;
		
		private var _imageComponent:UILoader;
		private var _vimeoComponent:VimeoPlayer;
		private static const VIMEO_KEY:String = "8e8a715dbe83900180243df10f942ea5 ";
		
		private var _youtube:YoutubeComponent;
		
		/**
		 * Constructor
		 **/
		public function PopUpComponent(data:Array)
		{
			//set the values
			this._type = data[0];
			this._url = data[1];
			
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
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
		}
		
		public function destroyVideo():void
		{
			if(this._youtube != null)
			{
				this._youtube.player.destroy();
				this._youtube = null;
			}
			
			if(this._vimeoComponent != null)
			{
				this._vimeoComponent.destroy();
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
		 * Set the position
		 * Display media item
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//add filter dropshadow
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//check the media asset type
			switch(this._type)
			{
				case "youtube":
					displayYoutube();
					break;
				
				case "vimeo":
					displayVimeo();
					break;
				
				case "image":
					displayImage();
					break;
			}
			
			//add event listener to the close button
			//this.btnClose.addEventListener(MouseEvent.CLICK, handleBtnCloseClick);
			
			//bring menu to the front
			this.parent.addChild(this.parent.getChildByName("menu"));
		}
		
		/**
		 * Display youtube media asset
		 **/
		private function displayYoutube():void
		{
			this._youtube = new YoutubeComponent(this._url);
			this._youtube.addEventListener(PopupEvent.VIDEO_ENDED, handleVideoYoutubeEnded);
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
			
			if(this._url.indexOf("http://vimeo.com/") != -1)
			{
				id_video = int(this._url.slice(17, int.MAX_VALUE));
			}
			else if(this._url.indexOf("http://www.vimeo.com/") != -1)
			{
				id_video = int(this._url.slice(21, int.MAX_VALUE));
			}
			else
			{
				id_video = int(this._url);
			}
			
			//MonsterDebugger.trace(this, id_video);
			
			//create new instance
			this._vimeoComponent = new VimeoPlayer(VIMEO_KEY, id_video, 640, 360);
			
			//add event listener
			this._vimeoComponent.addEventListener("finish", handleVimeoFinished, false, 0, true);
			
			//add vimeo component to the view
			this.container.addChild(this._vimeoComponent);
		}
		
		/**
		 * Display image media asset
		 **/
		private function displayImage():void
		{
			//create new instance
			this._imageComponent = new UILoader();
			
			//set the width and height
			this._imageComponent.width = this.container.width;
			this._imageComponent.height = this.container.height;
			
			//set the position
			this._imageComponent.x = 0;
			this._imageComponent.y = 0;
			
			//set the properties
			this._imageComponent.maintainAspectRatio = true;
			this._imageComponent.scaleContent = true;
			this._imageComponent.autoLoad = true;
			this._imageComponent.enabled = true;
			this._imageComponent.visible = true;
			
			//add to the container
			this.container.addChild(this._imageComponent);
			
			//set the source
			this._imageComponent.source = this._url;
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init function 
		 * 
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
		 * Handle button close click
		 **/
		private function handleBtnCloseClick(evt:MouseEvent):void
		{
			if(this._youtube != null)
				this._youtube.player.destroy();
			
			if(this._vimeoComponent != null)
			{
				this._vimeoComponent.destroy();
				this._vimeoComponent = null;
			}
		}
		
		private function handleVideoYoutubeEnded(evt:PopupEvent):void
		{
			dispatchEvent(new PopupEvent(PopupEvent.VIDEO_ENDED));
		}
		
		private function handleVimeoFinished(evt:Event):void
		{
			dispatchEvent(new PopupEvent(PopupEvent.VIDEO_ENDED));
		}
	}
}