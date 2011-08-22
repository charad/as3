/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 6:33:50 PM
 ********************************
 **/
package be.arnordhaenens.views.components.popup
{
	import be.arnordhaenens.events.PopupEvent;
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.Security;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	YoutubeComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 20, 2011, at 6:33:50 PM
	 * @see		be.arnordhaenens.views.components.popup.YoutubeComponent
	 **/
	public class YoutubeComponent extends Sprite
	{
		/**
		 * Variables
		 **/
		public var player:Object;
		
		private var loader:Loader;
		private var url:String;
		private var youtubeApiLoader:URLLoader;
		
		/**
		 * Constructor
		 **/
		public function YoutubeComponent(url:String)
		{
			Security.allowDomain("www.youtube.com");
			this.url = url;			
			
			MonsterDebugger.trace(this, "youtube component");
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Init function
		 **/
		public function init(evt:Event=null):void
		{
			//remove event listener
			//this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			setupYouTubeApiLoader();
			
			loader = new Loader();
			this.addChild(loader);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onLoaderInit);
			loader.load(new URLRequest("http://www.youtube.com/apiplayer?version=3"));
			
			//MonsterDebugger.trace(this, "init function");
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
		
		
		
		private function setupYouTubeApiLoader():void 
		{
			youtubeApiLoader = new URLLoader();
			youtubeApiLoader.addEventListener(IOErrorEvent.IO_ERROR, youtubeApiLoaderErrorHandler);
			youtubeApiLoader.addEventListener(Event.COMPLETE, youtubeApiLoaderCompleteHandler);
		}
		
		
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		private function youtubeApiLoaderCompleteHandler(event:Event):void 
		{
			var atomData:String = youtubeApiLoader.data;
			
			// Parse the YouTube API XML response and get the value of the
			// aspectRatio element.
			var atomXml:XML = new XML(atomData);
			var aspectRatios:XMLList = atomXml..*::aspectRatio;
			
			//isWidescreen = aspectRatios.toString() == WIDESCREEN_ASPECT_RATIO;
			
			//isQualityPopulated = false;
			// Cue up the video once we know whether it's widescreen.
			// Alternatively, you could start playing instead of cueing with
			// player.loadVideoById(videoIdTextInput.text);
			player.loadVideoByUrl(this.url);
			
			//MonsterDebugger.trace(this, "loading video by iurl");
		}
		
		/**
		 * On loader init
		 **/
		private function onLoaderInit(evt:Event):void 
		{
			//this.addChild(loader);
			loader.content.addEventListener("onReady", onPlayerReady);
			loader.content.addEventListener("onError", onPlayerError);
			loader.content.addEventListener("onStateChange", onPlayerStateChange);
			loader.content.addEventListener("onPlaybackQualityChange", onVideoPlaybackQualityChange);
		}
		
		private function onPlayerReady(event:Event):void 
		{
			// Event.data contains the event parameter, which is the Player API ID 
			/*MonsterDebugger.trace(this, "player ready");
			MonsterDebugger.trace(this, Object(event).data);*/
			
			// Once this event has been dispatched by the player, we can use
			// cueVideoById, loadVideoById, cueVideoByUrl and loadVideoByUrl
			// to load a particular YouTube video.
			player = loader.content;
			// Set appropriate player dimensions for your application
			player.setSize(640, 360);
			
			loadDefaultVideo();
		}
		
		private function loadDefaultVideo():void
		{
			var request:URLRequest = new URLRequest("http://gdata.youtube.com/feeds/api/videos/" +
				"1fMfWXpv8f8");
			
			var urlVariables:URLVariables = new URLVariables();
			urlVariables.v = "2";
			urlVariables.format = "5";
			request.data = urlVariables;
			
			try 
			{
				youtubeApiLoader.load(request);
				
				//MonsterDebugger.trace(this, "load request");
			} 
			catch (error:SecurityError) 
			{
				MonsterDebugger.trace(this, "A SecurityError occurred while loading: " + request.url);
			}
		}
		
		private function onPlayerError(event:Event):void 
		{
			// Event.data contains the event parameter, which is the error code
			MonsterDebugger.trace(this, "player error:");
				MonsterDebugger.trace(this, Object(event).data);
		}
		
		private function onPlayerStateChange(event:Event):void 
		{
			// Event.data contains the event parameter, which is the new player state
			/*MonsterDebugger.trace(this, "player state:");
			MonsterDebugger.trace(this,Object(event).data);*/
			
			switch(Object(event).data)
			{
				case 0:
					dispatchEvent(new PopupEvent(PopupEvent.VIDEO_ENDED));
					break;
			}
		}
		
		private function onVideoPlaybackQualityChange(event:Event):void 
		{
			// Event.data contains the event parameter, which is the new video quality
			MonsterDebugger.trace(this, "video quality:");
			MonsterDebugger.trace(this, Object(event).data);
		}
		
		private function youtubeApiLoaderErrorHandler(event:IOErrorEvent):void {
			MonsterDebugger.trace(this, "Error making YouTube API request: ");
			MonsterDebugger.trace(this, event);
		}
	}
}