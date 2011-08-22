/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 26, 2011, at 4:51:50 PM
 ********************************
 **/
package be.arnordhaenens.views.components.twitter
{
	/**
	 * Imports
	 **/
	
	import com.flashandmath.dg.GUI.MovingClouds;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	/**
	 * Class	MovingCloudsComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 26, 2011, at 4:51:50 PM
	 * @see		be.arnordhaenens.views.components.twitter.MovingCloudsComponent
	 **/
	public class MovingCloudsComponent extends Sprite
	{
		/**
		 * Variables
		 **/
		private var _layer1:MovingClouds;
		private var _layer2:MovingClouds;
		
		/**
		 * Constructor
		 **/
		public function MovingCloudsComponent()
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
			//set the background color
			this.graphics.beginFill(0x1E4A95, 1);
			this.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			this.graphics.endFill();
			
			//handle the first layer
			this.removeChild(this._layer1);
			this._layer1 = null;
			this._layer1 = new MovingClouds(this.stage.stageWidth, this.stage.stageHeight, -2, 1);
			this.addChild(this._layer1);
			
			//handle the second layer
			this.removeChild(this._layer2);
			this._layer2 = null;
			this._layer2 = new MovingClouds(this.stage.stageWidth, this.stage.stageHeight, -1, 1);
			this.addChild(this._layer2);
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
			//set the position
			this.x = this.y = 0;
			
			//set the background color
			this.graphics.beginFill(0x1E4A95, 1);
			this.graphics.drawRect(0, 0, this.stage.stageWidth, this.stage.stageHeight);
			this.graphics.endFill();
			
			MonsterDebugger.trace(this, this.stage.fullScreenHeight);
			MonsterDebugger.trace(this, this.stage.fullScreenWidth);
			
			//set the first layer clouds
			this._layer1 = new MovingClouds(this.stage.stageWidth, this.stage.stageHeight, -2, 1);
			this._layer1.alpha = .4;
			
			//set the second layer of clouds
			this._layer2 = new MovingClouds(this.stage.stageWidth, this.stage.stageHeight, -1, .5);
			this._layer2.alpha = 1;
			
			//add the second layer
			this.addChild(this._layer2);
			this.addChild(this._layer1);
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
	}
}