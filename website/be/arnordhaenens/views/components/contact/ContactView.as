/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 23, 2011, at 2:45:37 PM
 ********************************
 **/
package be.arnordhaenens.views.components.contact
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.loaders.LoaderProgressComponent;
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ContactView
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 23, 2011, at 2:45:37 PM
	 * @see		be.arnordhaenens.views.components.contact.ContactView
	 **/
	public class ContactView extends Sprite
	{
		/**
		 * Variables
		 **/
		private static const BACKGROUND:String = "assets/originals/images/grass.jpg";
		
		private var _contactform:ContactFormComponent;
		private var _backgroundLoader:LoaderProgressComponent;
		private var _loader:Loader;
		
		private var _background:DisplayObject;
		
		private var _messageSet:Boolean = false;
		
		
		/**
		 * Constructor
		 **/
		public function ContactView()
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
			//check if the view contains the background loader
			if(this.contains(this._backgroundLoader))
				this._backgroundLoader.handleResize();
			
			//check if the view contains the contact form
			if(this.contains(this._contactform))
				this._contactform.handleResize();
			
			//check if the view contains the background
			if(this.contains(this._background))
			{
				//get the scale
				var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
				
				//set the width and height
				this._background.width *= scale;
				this._background.height *= scale;
			}
		}		
		
		/**
		 * Set blur filter
		 **/
		public function setBlurFilter():void
		{
			this.filters = [ArnorFilterClass.createBlurFilter()];
		}
		
		/**
		 * Remove the blur filter
		 **/
		public function removeBlurFilter():void
		{
			this.filters = [];
		}
		
		/**
		 * Reset the contact form after the mail has been send
		 **/
		public function resetContactform():void
		{
			//reset the form
			this._contactform.resetFormAfterSendMail();
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
			
		}
		
		/**
		 * Create contact form
		 **/
		private function createContactForm():void
		{
			//create new instance
			this._contactform = new ContactFormComponent();
			this._contactform.alpha = 0;
			
			//add to the view
			this.addChild(this._contactform);
			TweenLite.to(this._contactform, 1, {alpha:1});
		}
		
		/**
		 * Create background
		 **/
		private function loadBackground():void
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
		 * Create the background
		 **/
		private function createBackground(display:DisplayObject):void
		{
			//set the background
			this._background = display;
			
			//adjust the size
			var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
			this._background.width *= scale;
			this._background.height *= scale;
			
			//add background to the view
			this.addChild(this._background);
			
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
		 * When view is added to the stage
		 * Remove the event listener
		 * Set the basics
		 * Create contact form
		 **/
		private function init(evt:Event=null):void
		{
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
			
			//create background
			loadBackground();
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
			createBackground(evt.target.content);
			
			//create the contactform
			createContactForm();
		}
	}
}