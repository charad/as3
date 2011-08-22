/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 21, 2011, at 5:28:16 PM
 ********************************
 **/
package be.arnordhaenens.views.components.menu
{
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.greensock.TweenLite;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	MenuComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 21, 2011, at 5:28:16 PM
	 * @see		be.arnordhaenens.views.components.menu.MenuComponent
	 **/
	public class MenuComponent extends MenuMC
	{
		/**
		 * Variables
		 **/
		public var _grown:Boolean = false;
		
		private var _homescale:Number;
		private var _assscale:Number;
		private var _moviescale:Number;
		private var _fbscale:Number;
		private var _twitterscale:Number;
		private var _pictscale:Number;
		private var _contactscale:Number;
		
		/**
		 * Constructor
		 **/
		public function MenuComponent()
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
		 * Handle resize
		 **/
		public function handleResize():void
		{
			//set the position
			this.x = ((this.stage.stageWidth - 385) * .5) - 20;
			this.y = (this.stage.stageHeight - 359 - 30);
		}
		
		/**
		 * Show the menu
		 **/
		public function showMenu():void
		{
			//add enter frame event listener
			this.addEventListener(Event.ENTER_FRAME, handleEnterFrameGrow);
		}
		
		/**
		 * Hide menu
		 **/
		public function hideMenu():void
		{
			//hide menu items
			hideMenuItems();
			
			//add enter frame event listener
			this.addEventListener(Event.ENTER_FRAME, handleEnterFrameShrink);
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
		 **/
		private function setBasics():void
		{
			//set the size
			this.width = 385;
			this.height = 359;
			
			//set the position
			this.x = ((this.stage.stageWidth - 385) * .5) - 20;
			this.y = (this.stage.stageHeight - 359 - 30);
			
			//set the keyframes
			this.home.gotoAndStop(5);
			this.assignment.gotoAndStop(5);
			this.movies.gotoAndStop(5);
			this.facebook.gotoAndStop(5);
			this.twitter.gotoAndStop(5);
			this.picture.gotoAndStop(5);
			this.contact.gotoAndStop(5);
			
			//get the scale 			
			_homescale = this.home.scaleX;
			_assscale = this.assignment.scaleX;
			_moviescale = this.movies.scaleX;
			_fbscale = this.facebook.scaleX;
			_twitterscale = this.twitter.scaleX;
			_pictscale = this.picture.scaleX;
			_contactscale = this.contact.scaleX;
			
			//scale the menu items
			this.home.scaleX = this.home.scaleY = 0;
			this.assignment.scaleX = this.assignment.scaleY = 0;
			this.movies.scaleX = this.movies.scaleY = 0;
			this.facebook.scaleX = this.facebook.scaleY = 0;
			this.twitter.scaleX = this.twitter.scaleY = 0;
			this.picture.scaleX = this.picture.scaleY = 0;
			this.contact.scaleX = this.contact.scaleY = 0;
			
			//set the hit area
			this.assignment.hitArea = this.assignment.hit;
			this.movies.hitArea = this.movies.hit;
			this.picture.hitArea = this.picture.hit;
			this.contact.hitArea = this.contact.hit;
			
			//add drop shadow filter
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//add event listeners to the menu items
			this.home.addEventListener(MouseEvent.MOUSE_OVER, handleMenuItemMouseOver);
			this.home.addEventListener(MouseEvent.MOUSE_OUT, handleMenuItemMouseOut);
			this.home.addEventListener(MouseEvent.CLICK, handleMenuItemClick);
			
			this.assignment.addEventListener(MouseEvent.MOUSE_OVER, handleMenuItemMouseOver);
			this.assignment.addEventListener(MouseEvent.MOUSE_OUT, handleMenuItemMouseOut);
			this.assignment.addEventListener(MouseEvent.CLICK, handleMenuItemClick);
			
			this.movies.addEventListener(MouseEvent.MOUSE_OVER, handleMenuItemMouseOver);
			this.movies.addEventListener(MouseEvent.MOUSE_OUT, handleMenuItemMouseOut);
			this.movies.addEventListener(MouseEvent.CLICK, handleMenuItemClick);
			
			this.facebook.addEventListener(MouseEvent.MOUSE_OVER, handleMenuItemMouseOver);
			this.facebook.addEventListener(MouseEvent.MOUSE_OUT, handleMenuItemMouseOut);
			this.facebook.addEventListener(MouseEvent.CLICK, handleMenuItemClick);
			
			this.twitter.addEventListener(MouseEvent.MOUSE_OVER, handleMenuItemMouseOver);
			this.twitter.addEventListener(MouseEvent.MOUSE_OUT, handleMenuItemMouseOut);
			this.twitter.addEventListener(MouseEvent.CLICK, handleMenuItemClick);
			
			this.picture.addEventListener(MouseEvent.MOUSE_OVER, handleMenuItemMouseOver);
			this.picture.addEventListener(MouseEvent.MOUSE_OUT, handleMenuItemMouseOut);
			this.picture.addEventListener(MouseEvent.CLICK, handleMenuItemClick);
			
			this.contact.addEventListener(MouseEvent.MOUSE_OVER, handleMenuItemMouseOver);
			this.contact.addEventListener(MouseEvent.MOUSE_OUT, handleMenuItemMouseOut);
			this.contact.addEventListener(MouseEvent.CLICK, handleMenuItemClick);
			
			//setting the cursor properties
			this.home.buttonMode = true;
			this.assignment.buttonMode = true;
			this.movies.buttonMode = true;
			this.facebook.buttonMode = true;
			this.twitter.buttonMode = true;
			this.picture.buttonMode = true;
			this.contact.buttonMode = true;
		}
		
		/**
		 * Show the menu items
		 * 
		 * Tween the home menu button
		 * Tween the assigment button
		 * Tween the movies button
		 * Tween the facebook button
		 * Tween the twitter button
		 * Tween the picture button
		 * Tween the contact button
		 **/
		private function showMenuItems():void
		{
			//show home menu item
			TweenLite.to(this.home, .5,{scaleX:_homescale, scaleY:_homescale});
			
			//assigment button
			TweenLite.to(this.assignment, .5, {scaleX:_assscale, scaleY:_assscale});
			
			//movies button
			TweenLite.to(this.movies, .5, {scaleX:_moviescale, scaleY:_moviescale});
			
			//facebook button
			TweenLite.to(this.facebook, .5, {scaleX:_fbscale, scaleY:_fbscale});
			
			//twitter button
			TweenLite.to(this.twitter, .5, {scaleX:_twitterscale, scaleY:_twitterscale});
			
			//picture button
			TweenLite.to(this.picture, .5, {scaleX:_pictscale, scaleY:_pictscale});
			
			//contact button
			TweenLite.to(this.contact, .5, {scaleX:_contactscale, scaleY:_contactscale});
		}
		
		/**
		 * Hide the menu items
		 * 
		 * Tween the home menu button
		 * Tween the assigment button
		 * Tween the movies button
		 * Tween the facebook button
		 * Tween the twitter button
		 * Tween the picture button
		 * Tween the contact button
		 **/
		private function hideMenuItems():void
		{
			//show home menu item
			TweenLite.to(this.home, .5,{scaleX:0, scaleY:0});
			
			//assigment button
			TweenLite.to(this.assignment, .5, {scaleX:0, scaleY:0});
			
			//movies button
			TweenLite.to(this.movies, .5, {scaleX:0, scaleY:0});
			
			//facebook button
			TweenLite.to(this.facebook, .5, {scaleX:0, scaleY:0});
			
			//twitter button
			TweenLite.to(this.twitter, .5, {scaleX:0, scaleY:0});
			
			//picture button
			TweenLite.to(this.picture, .5, {scaleX:0, scaleY:0});
		
			//contact button
			TweenLite.to(this.contact, .5, {scaleX:0, scaleY:0});
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
		 * Add enter frame event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set the basics
			setBasics();
		}
		
		/**
		 * Handle Enter Frame for growing the tree / menu
		 * 
		 * Check the currentFrame
		 * If the currentFrame = 31, show the menu items
		 **/
		private function handleEnterFrameGrow(evt:Event):void
		{
			//check if currentFrame < 31
			//if so, go to the next frame
			if(this.currentFrame < 31)
				this.gotoAndStop(this.currentFrame + 1);
			
			//when currentFrame is equal to 31
			//display the menu items
			if(this.currentFrame == 31)
			{
				showMenuItems();
				this.removeEventListener(Event.ENTER_FRAME, handleEnterFrameGrow);
				this._grown = true;
			}
		}
		
		/**
		 * Handle Enter frame for shrinking the tree / menu
		 * 
		 * Hide the menu items
		 * Check the current frame
		 **/
		private function handleEnterFrameShrink(evt:Event):void
		{
			if(this.currentFrame > 1)
				this.gotoAndStop(this.currentFrame - 1);
			
			if(this.currentFrame == 1)
			{
				this.removeEventListener(Event.ENTER_FRAME, handleEnterFrameShrink);
				this._grown = false;
			}
		}
		
		/**
		 * Mouse Over menu item
		 **/
		private function handleMenuItemMouseOver(evt:MouseEvent):void
		{
			var mc:MovieClip = evt.currentTarget as MovieClip;
			mc.gotoAndStop(1);
		}
		
		/**
		 * Mouse Out menu item
		 **/
		private function handleMenuItemMouseOut(evt:MouseEvent):void
		{
			var mc:MovieClip = evt.currentTarget as MovieClip;
			mc.gotoAndStop(5);
		}
		
		/**
		 * Handle clicking on the menu item
		 * 
		 * Check the target
		 * Dispatch the right event dependent the target
		 **/
		private function handleMenuItemClick(evt:MouseEvent):void
		{
			switch(evt.currentTarget.name)
			{
				case "home":
					dispatchEvent(new MenuEvent(MenuEvent.HOME_CLICKED));
					break;
				
				case "assignment":
					dispatchEvent(new MenuEvent(MenuEvent.ASSIGNMENT_CLICKED));
					break;
				
				case "movies":
					dispatchEvent(new MenuEvent(MenuEvent.MOVIES_CLICKED));
					break;
				
				case "facebook":
					dispatchEvent(new MenuEvent(MenuEvent.FACEBOOK_CLICKED));
					break;
				
				case "twitter":
					dispatchEvent(new MenuEvent(MenuEvent.TWITTER_CLICKED));
					break;
				
				case "picture":
					dispatchEvent(new MenuEvent(MenuEvent.PICTURE_CLICKED));
					break;
				
				case "contact":
					dispatchEvent(new MenuEvent(MenuEvent.CONTACT_CLICKED));
					break;
			}
			
			//hide to menu
			this.hideMenu();
			
		
		}
	}
}