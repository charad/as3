/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 1:23:20 PM
 ********************************
 **/
package be.arnordhaenens.views.components.popup
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import fl.containers.UILoader;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ImagePopupComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 22, 2011, at 1:23:20 PM
	 * @see		be.arnordhaenens.views.components.popup.ImagePopupComponent
	 **/
	public class ImagePopupComponent extends PicturePopupMC
	{
		/**
		 * Variables
		 **/
		private var _data:*;
		private var _itemcount:int;
		
		private var _currentIndex:int = 0;
		
		private var _oldX:int;
		private var _image:UILoader;
		
		private var _containerInitialX:int;
		
		
		/**
		 * Constructor
		 **/
		public function ImagePopupComponent(data:*)
		{
			super();
			
			//set the data
			this._data = data;
			this._itemcount = this._data.length;
			
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
			this.x = (this.stage.stageWidth) * .5;
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
		 * Set the initial scale and alpha values
		 * Add event listeners to the button
		 * Set the mask
		 * Add drop shadow filter
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//set the initial scale
			//set the alpha
			this.scaleX = this.scaleY = 0;
			this.alpha = 0;
			
			//save the container x value
			this._containerInitialX = this.container.x;
			
			//add event listeners to the buttons
			this.btnClose.addEventListener(MouseEvent.CLICK, handleCloseButtonClick);
			this.btnNext.addEventListener(MouseEvent.CLICK, handleNextButtonClick);
			this.btnPrevious.addEventListener(MouseEvent.CLICK, handlePreviousButtonClick);	
			
			//set the mask
			this.container.mask = this.containermask;
			
			//add drop shadow filter
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//add the images
			addContent();
			
			//bring menu to the front
			this.parent.addChild(this.parent.getChildByName("menu"));
		}
		
		/**
		 * Add the image content to the container
		 **/
		private function addContent():void
		{
			//check the length of the data
			if(this._data.length == 1)
			{
				this.btnNext.visible = false;
				this.btnPrevious.visible = false;
			}
			
			for each (var item:Object in this._data) 
			{
				//create new instance of the UILoader
				this._image = new UILoader();
				this._image.width = 600;
				this._image.height = 354;
				this._image.x = this._oldX;
				this._image.y = 0;
				this._image.scaleContent = true;
				this._image.maintainAspectRatio = true;
				this._image.autoLoad = true;
				this._image.source = item.url;
				this.container.addChild(this._image);

				this._oldX += 600;
				//MonsterDebugger.trace(this, this._oldX);
			}
			
			//tween the component
			TweenLite.to(this, 1, {alpha:1, scaleX:1, scaleY:1});
		}
		
		/**
		 * Remove tween complete
		 **/
		private function removeTweenComplete():void
		{
			//remove the popup from it's component
			this.parent.removeChild(this);
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init function
		 * 
		 * Handle added tot the stage
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
		 * Handle close button click
		 **/
		private function handleCloseButtonClick(evt:MouseEvent):void
		{
			//Tween the popup
			TweenMax.to(this, .5, {scaleX:0, scaleY:0, blurFilter:{blurX:20, blurY:20}, onComplete:removeTweenComplete});
		}
		
		/**
		 * Handle next button click
		 **/
		private function handleNextButtonClick(evt:MouseEvent):void
		{
			//check the current index
			if(this._currentIndex + 1 <= (this._itemcount - 1))
				this._currentIndex += 1;
			else if(this._currentIndex + 1 > (this._itemcount - 1))
				this._currentIndex = 0;
			
			//tween the container
			TweenLite.to(this.container, .5, {x:(this._containerInitialX - (this._currentIndex * 600))});
		}
		
		/**
		 * Handle previous button click
		 **/
		private function handlePreviousButtonClick(evt:MouseEvent):void
		{
			//check the current index
			if(this._currentIndex - 1 >= 0)
				this._currentIndex -= 1;
			else if(this._currentIndex - 1 < 0)
				this._currentIndex = (this._itemcount - 1);
			
			//Tween the container
			TweenLite.to(this.container, .5, {x:(this._containerInitialX - (this._currentIndex * 600))});
		}
	}
}