/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 20, 2011, at 11:00:47 PM
 ********************************
 **/
package be.arnordhaenens.views.components.footer
{
	import be.arnordhaenens.events.FooterEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	FullScreenButton
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 20, 2011, at 11:00:47 PM
	 * @see		be.arnordhaenens.views.components.footer.FullScreenButton
	 **/
	public class FullScreenButton extends FullscreenMC
	{
		/**
		 * Variables
		 **/
		
		/**
		 * Constructor
		 **/
		public function FullScreenButton()
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
		 * Handle stage / window resize
		 **/
		public function handleResize():void
		{
			//set the position
			this.x = this.stage.stageWidth - this.width - 20;
			this.y = this.stage.stageHeight - this.height - ((30 - this.height)*.5);
			
			//if the stage has displayState == "normal"
			//force the mc to go to and stop at keyframe 1
			if(this.stage.displayState == "normal")
				this.gotoAndStop(1);
		}
		
		/**
		 * Handle clicked
		 * 
		 * Goto and stop at keyframe 1 or 5
		 * Normal or fullscreen state
		 **/
		public function handleClicked():void
		{
			//check the current keyframe
			//dependent the result, 
			//go to and stop at keyframe 1 or 5
			
			if(this.currentFrame == 1)
			{
				if(PromositeDC.state != "contact")
					gotoAndStop(5);
			}
			else if(this.currentFrame == 5)
				gotoAndStop(1);
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
		 * Set the size
		 * Set the position
		 * Goto and stop at first keyframe
		 **/
		private function setBasics():void
		{
			//set the size
			this.width = 38;
			this.height = 20;
			
			//set the position
			this.x = this.stage.stageWidth - this.width - 20;
			this.y = this.stage.stageHeight - this.height - ((30 - this.height)*.5);
			
			//set the cursor
			this.useHandCursor = true;
			this.mouseChildren = false;
			
			//set the keyframe
			this.gotoAndStop(1);
			
			//add event listener
			this.addEventListener(MouseEvent.CLICK, handleClick);
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
		 * 
		 * Remove the event listener
		 * Set the basics
		 **/
		private function init(evt:Event):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
		}
		
		/**
		 * Handle fullscreen button clicked
		 * 
		 * Dispatch event
		 **/
		private function handleClick(evt:MouseEvent):void
		{
			//dispatch event
			dispatchEvent(new FooterEvent(FooterEvent.FULLSCREEN_CLICKED));
		}
	}
}