/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 8:52:20 PM
 ********************************
 **/
package be.arnordhaenens.views.components.movies
{
	import be.arnordhaenens.events.PopupEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.loaders.LoaderProgressComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	MovieView
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 20, 2011, at 8:52:20 PM
	 * @see		be.arnordhaenens.views.components.movies.MovieView
	 **/
	public class MovieView extends Sprite
	{
		/**
		 * Variables
		 **/
		private var _backgroundLoader:LoaderProgressComponent;
		private var _loader:Loader;
		private var _background:DisplayObject;
		private var _messageSet:Boolean = false;
		
		private var _movieoptions:MovieOptionsComponent;
		
		private static const BACKGROUND:String = "assets/originals/images/bgFilming.jpg";
		private static const VIMEO_GROUP:String = "http://vimeo.com/groups/producemmp";
		private static const ONE_MINUTE_FESTIVAL_WEBSITE:String = "http://www.oneminutefestival.be/";
		private static const TRAILER_ID:String = "22967638";
		
		/**
		 * Constructor
		 **/
		public function MovieView()
		{
			super();
			
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
			//check if the view contains the background
			if(this._background != null)
			{
				if(this.contains(this._background))
				{
					//get the scale
					var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
					
					//set the width and height
					this._background.width *= scale;
					this._background.height *= scale;
				}
			}
			
			//check if view contains movie options
			if(this._movieoptions != null)
			{
				if(this.contains(this._movieoptions))
					this._movieoptions.handleResize();					
			}
		}
		
		/**
		 * Goto vimeo group
		 **/
		public function gotoVimeoGroup():void
		{
			//navigate to the url
			navigateToURL(new URLRequest(VIMEO_GROUP), "_blank");
		}
		
		/**
		 * Goto one minute website
		 **/
		public function gotoOneMinuteWebsite():void
		{
			//navigate to the url
			navigateToURL(new URLRequest(ONE_MINUTE_FESTIVAL_WEBSITE), "_blank");
		}
		
		/**
		 * View the one minute festival trailer
		 **/
		public function viewTrailerOneMinuteFestival():void
		{
			dispatchEvent(new PopupEvent(PopupEvent.CREATE_POPUP, ["vimeo", TRAILER_ID]));
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
		 **/
		private function setBasics():void
		{
			//creating background
			createBackground();
		}
		
		/**
		 * Create the background for the view
		 **/
		private function createBackground():void
		{
			//create new instance
			this._backgroundLoader = new LoaderProgressComponent();
			
			//add to stage
			this.addChild(this._backgroundLoader);
			
			//create new loader instance
			this._loader = new Loader();
			this._loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, handleLoaderProgress);
			this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleLoaderComplete);
			this._loader.load(new URLRequest(BACKGROUND));
		}
		
		/**
		 * Create Movie options component
		 **/
		private function createMovieOptions():void
		{
			//create new instance
			this._movieoptions = new MovieOptionsComponent();
			
			//add to the view
			this.addChild(this._movieoptions);
		}
		
		/**
		 * Display the background
		 **/
		private function showBackground(display:DisplayObject):void
		{
			//set the background
			this._background = display;
			//add black - white filter to the background
			this._background.filters = [ArnorFilterClass.createBWFilter()];
			
			//adjust the size
			var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
			this._background.width *= scale;
			this._background.height *= scale;
			
			//add background to the view
			this.addChild(this._background);
			
			//creating movie options
			createMovieOptions();
			
			//bring footer, menu and arteveldelogo to front
			this.parent.addChild(this.parent.getChildByName("footer"));
			this.parent.addChild(this.parent.getChildByName("menu"));
			this.parent.addChild(this.parent.getChildByName("arteveldelogo"));
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
		 **/
		private function init(evt:Event=null):void
		{
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
		}
		
		/**
		 * Handle Loader Progress
		 **/
		private function handleLoaderProgress(evt:ProgressEvent):void
		{
			if(!this._messageSet)
			{
				//set the basic values for the loader
				this._backgroundLoader.setInitialValues("loading background...");
				
				this._messageSet = true;
			}
			
			//calculate percentage
			var perc:Number = evt.bytesLoaded / evt.bytesTotal;
			
			//update the loader
			this._backgroundLoader.updateLoader(perc);	
			
			//MonsterDebugger.trace(this, "loader progress");
		}
		
		/**
		 * Handle Loader Complete
		 **/
		private function handleLoaderComplete(evt:Event):void
		{
			/*MonsterDebugger.trace(this, "loader complete");
			MonsterDebugger.trace(this, evt);*/
			
			//remove the loader
			this._backgroundLoader.removeLoader();
			
			//create the background
			showBackground(evt.target.content);
		}
	}
}