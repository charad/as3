/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 9:36:39 PM
 ********************************
 **/
package be.arnordhaenens.views.components.pictures
{
	import be.arnordhaenens.events.PictureEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.loaders.LoaderProgressComponent;
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	PictureView
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 20, 2011, at 9:36:39 PM
	 * @see		be.arnordhaenens.views.components.pictures.PictureView
	 **/
	public class PictureView extends Sprite
	{
		/**
		 * Variables
		 **/
		private var _backgroundLoader:LoaderProgressComponent;
		private var _loader:Loader;
		private var _background:DisplayObject;
		private var _assignmentdisplay:PictureAssignmentInfoComponent;
		private var _nextButton:NextAssignmentMC;
		private var _previousButton:PreviousAssignmentMC;
		
		private var _messageSet:Boolean = false;
		
		private static const BACKGROUND:String = "assets/originals/images/bgPhoto.jpg";
		
		
		
		/**
		 * Constructor
		 **/
		public function PictureView()
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
			
			//check if the assignment display diff from null
			if(this._assignmentdisplay != null)
			{
				//if so check if the view contains the assignment display
				if(this.contains(this._assignmentdisplay))
				{
					//if so, reposition
					this._assignmentdisplay.handleResize();
				}
			}
			
			//check if the next button diff from null
			if(this._nextButton != null)
			{
				if(this.contains(this._nextButton))
				{
					//reposition the next button
					this._nextButton.x = (this.stage.stageWidth - this._nextButton.width) - 50;
					this._nextButton.y = (this.stage.stageHeight - this._nextButton.height) * .5;
					
					//reposition the previous button
					this._previousButton.x = 50;
					this._previousButton.y = (this.stage.stageHeight - this._previousButton.height) * .5;
				}
			}
		}
		
		/**
		 * Assignments loaded
		 * 
		 * Create new instance of the assignment component
		 * Update the info component
		 **/
		public function handleAssignmentsLoaded(data:*):void
		{
			//create new instance for the assignment display
			this._assignmentdisplay = new PictureAssignmentInfoComponent(data);
			this.addChild(this._assignmentdisplay);
			
			//check if the length diff from 0
			if(data.length > 1)
			{
				//adding the next button
				this._nextButton = new NextAssignmentMC();
				this._nextButton.addEventListener(MouseEvent.CLICK, handleNextClicked);
				this._nextButton.filters = [ArnorFilterClass.createDropShadowFilter()];
				this._nextButton.x = (this.stage.stageWidth - this._nextButton.width - 50);
				this._nextButton.y = (this.stage.stageHeight - this._nextButton.height) * .5;
				this._nextButton.alpha = 0;
				this.addChild(this._nextButton);
				TweenLite.to(this._nextButton, .5, {alpha:1});
				
				//adding the previous button
				this._previousButton = new PreviousAssignmentMC();
				this._previousButton.addEventListener(MouseEvent.CLICK, handlePreviousClicked);
				this._previousButton.filters = [ArnorFilterClass.createDropShadowFilter()];
				this._previousButton.x = 50;
				this._previousButton.y = (this.stage.stageHeight - this._previousButton.height) * .5;
				this._previousButton.alpha = 0;
				this.addChild(this._previousButton);
				TweenLite.to(this._previousButton, .5, {alpha:1});
			}
		}
		
		/**
		 * Disble the buttons
		 **/
		public function disableButtons():void
		{
			if(this._assignmentdisplay != null)
				this._assignmentdisplay.enabled = false;
			
			if(this._nextButton != null)
			{
				this._nextButton.removeEventListener(MouseEvent.CLICK, handleNextClicked);
				this._previousButton.removeEventListener(MouseEvent.CLICK, handlePreviousClicked);
			}
		}
		
		/**
		 * Enable buttons
		 **/
		public function enableButtons():void
		{
			if(this._assignmentdisplay != null)
				this._assignmentdisplay.enabled = true;
			
			if(this._nextButton != null)
			{
				this._nextButton.addEventListener(MouseEvent.CLICK, handleNextClicked);
				this._previousButton.addEventListener(MouseEvent.CLICK, handlePreviousClicked);
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
		 **/
		private function setBasics():void
		{
			//create the background
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
		 * Display the background
		 **/
		private function showBackground(display:DisplayObject):void
		{
			//set the background
			this._background = display;
			
			//adjust the size
			var scale:Number = Math.max((this.stage.stageWidth / this._background.width), (this.stage.stageHeight / this._background.height));
			this._background.width *= scale;
			this._background.height *= scale;
			
			//dispatch event for loading the assignments
			dispatchEvent(new PictureEvent(PictureEvent.LOAD_PICTURE_ASSIGNMENTS));
			
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
		 * handle added to the stage
		 * remove the event listener
		 * set the basics
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
			//remove the loader
			this._backgroundLoader.removeLoader();			
			
			//create the background
			showBackground(evt.target.content);
		}
		
		/**
		 * Handle next button clicked
		 **/
		private function handleNextClicked(evt:MouseEvent):void
		{
			//update the assignments
			this._assignmentdisplay.updateAssignment("next");
		}
		
		/**
		 * Handle previous button clicked
		 **/
		private function handlePreviousClicked(evt:MouseEvent):void
		{
			//update the assignment
			this._assignmentdisplay.updateAssignment("prev");
		}
	}
}