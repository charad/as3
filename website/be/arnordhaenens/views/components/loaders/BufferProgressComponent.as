/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 23, 2011, at 11:49:17 AM
 ********************************
 **/
package be.arnordhaenens.views.components.loaders
{
	import flash.events.Event;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	BufferProgressComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 23, 2011, at 11:49:17 AM
	 * @see		be.arnordhaenens.views.components.loaders.BufferProgressComponent
	 **/
	public class BufferProgressComponent extends ProgressBarMC
	{
		/**
		 * Variables
		 **/
		private var _maxWidth:int;
		private var _bufferPerc:Number;
		private var _progressPerc:Number;
		
		/**
		 * Constructor
		 **/
		public function BufferProgressComponent()
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
		 * Update the buffer bar
		 **/
		public function updateBufferBar(bytesLoaded:uint, bytesTotal:uint):void
		{
			this._bufferPerc = bytesLoaded / bytesTotal;
			this.bufferBar.width = this._maxWidth * this._bufferPerc;
			
			/*MonsterDebugger.trace(this, "buffer perc: " + perc);
			MonsterDebugger.trace(this, this.bufferBar.width);*/
		}
		
		/**
		 * Update the progress indicator
		 **/
		public function updateProgressIndicator(duration:Number, past:Number):void
		{
			this._progressPerc = past / duration;
			this.progress.x = this._maxWidth * this._progressPerc;
		}
		
		/**
		 * Handle resize stage / window
		 **/
		public function handleResize():void
		{
			//get the max size
			this._maxWidth = this.stage.stageWidth - 53 - 20 - 40;
			
			//set the buffer
			this.bufferBar.width = this._maxWidth * this._bufferPerc;
			
			//set the progress
			this.progress.x = this._maxWidth * this._progressPerc;
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
		 * Get the maximum buffer bar size
		 * Set the size
		 * Set the progress indicator position
		 * Set the position
		 **/
		private function setBasics():void
		{
			//get the max size
			this._maxWidth = this.stage.stageWidth - 53 - 20 - 40;
			//MonsterDebugger.trace(this, this._maxWidth);
			
			this.progress.scaleX = this.progress.scaleY = .01;
			
			//set the size
			this.bufferBar.width = 0;
			
			//progress indicator position
			this.progress.x = 0;
			
			//set the position
			this.x = this.y = 0;
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init function
		 * 
		 * Handle added to stage
		 * Remove event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
		}
	}
}