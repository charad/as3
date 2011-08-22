/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 23, 2011, at 3:10:11 PM
 ********************************
 **/
package be.arnordhaenens.views.components.loaders
{
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	LoaderProgressComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 23, 2011, at 3:10:11 PM
	 * @see		be.arnordhaenens.views.components.loaders.LoaderProgressComponent
	 **/
	public class LoaderProgressComponent extends LoaderProgressMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function LoaderProgressComponent()
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
			this.x = this.stage.stageWidth;
			this.y = this.stage.stageHeight;
		}
		
		/**
		 * Set initial values
		 * 
		 * Set the message
		 * Set the start loading percentage
		 **/
		public function setInitialValues(message:String):void
		{
			this.txtMessage.text = message;
			this.txtPercentage.text = "00%";
		}
		
		/**
		 * Update the progress bar
		 * 
		 * Update the text (percentage)
		 * Update the loading bar  
		 **/
		public function updateLoader(perc:Number):void
		{
			this.txtPercentage.text = Math.round(perc) + "%";
			this.loadBar.gotoAndStop(Math.round(perc));
		}
		
		/**
		 * Remove the loader
		 **/
		public function removeLoader():void
		{
			TweenMax.to(this, .5, {alpha:0, blurFilter:{blurX:12, blurY:12}, onComplete:removeLoaderComplete});
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
		 * Set position
		 **/
		private function setPosition():void
		{
			this.x = this.stage.stageWidth * .5;
			this.y = this.stage.stageHeight * .5;
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init function
		 * 
		 * When added to the stage
		 * Remove the event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set position
			setPosition();
		}
		
		/**
		 * Tween remove loader complete
		 **/
		private function removeLoaderComplete():void
		{
			this.parent.removeChild(this);
		}
	}
}