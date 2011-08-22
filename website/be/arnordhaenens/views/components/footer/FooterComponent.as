/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 10:21:21 PM
 ********************************
 **/
package be.arnordhaenens.views.components.footer
{
	
	import be.arnordhaenens.views.components.menu.MenuComponent;
	import be.arnordhaenens.views.components.menu.MenuLinkButton;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Imports
	 **/
	
	/**
	 * Class	FooterComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 19, 2011, at 10:21:21 PM
	 * @see		be.arnordhaenens.views.components.footer.FooterComponent
	 **/
	public class FooterComponent extends Sprite
	{
		/**
		 * Variables
		 **/
		public var background:Sprite;
		public var arnor:ArnorLogo;
		public var fullscreen:FullScreenButton;
		public var menulink:MenuLinkButton;		
		
		/**
		 * Constructor
		 **/
		public function FooterComponent()
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
		 * Handle stage / window resize
		 * 
		 * Adjust footer background
		 * Adjust arnor logo
		 * Adjust menu position
		 * Adjust volume controls
		 * Adjust fullscreen controls
		 **/
		public function handleResize():void
		{
			//adjust the background
			this.background.width = this.stage.stageWidth;
			this.background.y = this.stage.stageHeight - 30;
			
			//resize arnor
			this.arnor.handleResize();
			
			//resize fullscreen
			this.fullscreen.handleResize();
			
			//resize menu button
			this.menulink.handleResize();
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
		 * Create footer background
		 **/
		private function createBackground():void
		{
			//create new instance
			background = new Sprite();
			
			//fill the sprite
			background.graphics.beginFill(0x000000, .5);
			background.graphics.drawRect(0,0,this.stage.stageWidth, 30);
			background.graphics.endFill();
			
			//position
			background.x = 0;
			background.y = this.stage.stageHeight - background.height;
			
			//add sprite to the footer			
			this.addChild(background);
		}
		
		/**
		 * Create arnor.be logo
		 **/
		private function createArnor():void
		{
			//create new instance
			arnor = new ArnorLogo();

			//add logo to the footer
			this.addChild(arnor);
		}
		
		/**
		 * Create fullscreen button
		 **/
		private function createFullscreenButton():void
		{
			//create new instance
			fullscreen = new FullScreenButton();
			
			//add fullscreen to the footer
			this.addChild(fullscreen);
		}
		
		/**
		 * Create menu link
		 **/
		private function createMenuLink():void
		{
			//create new instance
			menulink = new MenuLinkButton();
			
			//add to the footer
			this.addChild(menulink);
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * When footer is added to the stage
		 * 
		 * Remove the event listener
		 * Create all the footer components
		 **/
		private function init(evt:Event):void
		{
			//remove the event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//create all the other footer components
			createBackground();
			createArnor();
			createFullscreenButton();	
			createMenuLink();
		}
	}
}