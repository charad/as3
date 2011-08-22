/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 21, 2011, at 8:51:35 AM
 ********************************
 **/
package be.arnordhaenens.views.components.movies
{
	import be.arnordhaenens.events.MovieEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	MovieOptionsComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 21, 2011, at 8:51:35 AM
	 * @see		be.arnordhaenens.views.components.movies.MovieOptionsComponent
	 **/
	public class MovieOptionsComponent extends MovieOptionsMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function MovieOptionsComponent()
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
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
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
		 * Set the button mode for the buttons
		 * Add event listeners to the buttons
		 * Add shadow
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//set the button modes
			this.vimeo.btnView.buttonMode = true;
			this.vimeo.btnView.useHandCursor = true;
			this.vimeo.btnView.mouseChildren = false;
			
			this.one_minute.btnTrailer.buttonMode = true;
			this.one_minute.btnTrailer.useHandCursor = true;
			this.one_minute.btnTrailer.mouseChildren = false;
			
			this.one_minute.btnWebsite.buttonMode = true;
			this.one_minute.btnWebsite.useHandCursor = true;
			this.one_minute.btnWebsite.mouseChildren = false;
			
			//add event listeners
			this.vimeo.btnView.addEventListener(MouseEvent.CLICK, handleVimeoGroupClicked);
			this.one_minute.btnWebsite.addEventListener(MouseEvent.CLICK, handleOneMinuteWebsiteClicked);
			this.one_minute.btnTrailer.addEventListener(MouseEvent.CLICK, handleOneMinuteTrailerClicked);
			
			this.vimeo.btnView.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOverButton);
			this.vimeo.btnView.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOutButton);
			this.one_minute.btnWebsite.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOverButton);
			this.one_minute.btnWebsite.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOutButton);
			this.one_minute.btnTrailer.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOverButton);
			this.one_minute.btnTrailer.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOutButton);
			
			//add dropshadow filter
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
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
		 * Handle mouse over button
		 **/
		private function handleMouseOverButton(evt:MouseEvent):void
		{			
			//grab the target
			var mc:MovieClip = evt.currentTarget as MovieClip;
			
			//go to the desired keyframe
			mc.gotoAndStop(5);
		}
		
		/**
		 * Handle mouse out button
		 **/
		private function handleMouseOutButton(evt:MouseEvent):void
		{
			//grab the target
			var mc:MovieClip = evt.currentTarget as MovieClip;
			
			//go to the desired keyframe
			mc.gotoAndStop(1);
		}
		
		/**
		 * Handle vimeo group clicked
		 **/
		private function handleVimeoGroupClicked(evt:MouseEvent):void
		{
			dispatchEvent(new MovieEvent(MovieEvent.GROUP_CLICKED));
		}
		
		/**
		 * Handle one minute festival website clicked
		 **/
		private function handleOneMinuteWebsiteClicked(evt:MouseEvent):void
		{
			dispatchEvent(new MovieEvent(MovieEvent.WEBSITE_CLICKED));
		}
		
		/**
		 * Handle one minute trailer clicked
		 **/
		private function handleOneMinuteTrailerClicked(evt:MouseEvent):void
		{
			dispatchEvent(new MovieEvent(MovieEvent.TRAILER_CLICKED));
		}
	}
}