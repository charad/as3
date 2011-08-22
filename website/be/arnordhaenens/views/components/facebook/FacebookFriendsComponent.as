/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 18, 2011, at 4:36:07 PM
 ********************************
 **/
package be.arnordhaenens.views.components.facebook
{
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.EaseLookup;
	import com.greensock.easing.Sine;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	FacebookFriendsComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 18, 2011, at 4:36:07 PM
	 * @see		be.arnordhaenens.views.components.facebook.FacebookFriendsComponent
	 **/
	public class FacebookFriendsComponent extends FacebookFriendsContainerMC 
	{
		/**
		 * Variables
		 **/
		private var _friends:Array;
		private var _friendsAmount:int;
		
		private static const AMOUNT_FRIENDS_DISPLAY:int = 15;
		private static const PICTURE_LOACATION:String = "http://graph.facebook.com/";
		private static const PICTURE_TYPE:String = "?type=large";
		private var _last_friend_display:int = 0;
		
		/**
		 * Constructor
		 **/
		public function FacebookFriendsComponent(dataFriends:*)
		{
			//save the data
			this._friends = dataFriends as Array;
			this._friendsAmount = this._friends.length;
			
			MonsterDebugger.trace(this, "VRIENDEN ");
			MonsterDebugger.trace(this, _friends);
			
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
		 * Set the positions
		 * Set the masks
		 * Add event listeners to the buttons
		 **/
		private function setBasics():void
		{			
			this.parent.addChild(this.parent.getChildByName("menu"));
			
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//set the masks
			this.contentcontainer.mask = this.contentcontainermask;
			
			//set the button mode for the next button
			this.btnNext.buttonMode = true;
			this.btnNext.useHandCursor = true;
			this.btnNext.mouseChildren = false;
			
			//set the button mode for the previous button
			this.btnPrevious.buttonMode = true;
			this.btnPrevious.useHandCursor = true;
			this.btnPrevious.mouseChildren = false;
			
			//add event listeners to the buttons
			this.btnNext.addEventListener(MouseEvent.CLICK, handleNextClicked);
			this.btnPrevious.addEventListener(MouseEvent.CLICK, handlePreviousClicked);
			
			for(var i:int=0;i<15;i++)
			{
				var obj:FriendMC = this.contentcontainer.getChildByName(("friend" + (i+1)).toString()) as FriendMC;
				obj.filters = [ArnorFilterClass.createDropShadowFilter(), ArnorFilterClass.createBWFilter()];
			}
			
			this.addEventListener(MouseEvent.MOUSE_OVER, handleMouseOverMember);
			this.addEventListener(MouseEvent.MOUSE_OUT, handleMouseOutMember);
			
			//create the first 15 friends
			createFriends("next");
		}
		
		/**
		 * Create friends
		 **/
		private function createFriends(direction:String):void
		{
			var childName:String;
			var friendItem:FriendMC;
			
			if(direction == "prev")
			{
				if(this._last_friend_display - AMOUNT_FRIENDS_DISPLAY >= 0)
				{
					for(var j:int = 0; j< AMOUNT_FRIENDS_DISPLAY; j++)
					{
						//create child name
						childName = "friend" + (AMOUNT_FRIENDS_DISPLAY - j);
						
						//update friend item
						updateFriendItem(childName, this._friends[(this._last_friend_display)].id);
							
						//decrement
						this._last_friend_display -= 1;						
					}
				}
				else if(this._last_friend_display - AMOUNT_FRIENDS_DISPLAY < 0)
				{
					//calculate the difference
					var dif:int = -(this._last_friend_display - AMOUNT_FRIENDS_DISPLAY);
					
					var part_one:int = this._last_friend_display;
					
					if(part_one != 0)
					{
						for(var k:int = 0; k<part_one; k++)
						{
							//create child name
							childName = "friend" + (AMOUNT_FRIENDS_DISPLAY - k);
							
							//update friend item
							updateFriendItem(childName, this._friends[(this._last_friend_display)].id);
							
							//decrement
							this._last_friend_display -= 1;
						}
					}
					
					//set the last friend display to the last possible friend (starting from the back)
					this._last_friend_display = this._friendsAmount - 1;
										
					//calculate the amount of friends
					//we have to display 
					//starting from the max amount of friends
					var part_two:int = dif;
					
					for(var m:int = 0; m<part_two; m++)
					{
						//create the child name
						childName = "friend" + (AMOUNT_FRIENDS_DISPLAY - part_one - m);
						
						//update friend item
						updateFriendItem(childName, this._friends[(this._last_friend_display)].id);
																		
						//decrement
						this._last_friend_display -= 1;
					}
				}
			}
			else if(direction == "next")
			{
				if(this._last_friend_display + AMOUNT_FRIENDS_DISPLAY <= (this._friendsAmount - 1))
				{
					for( var i:int = 0; i< AMOUNT_FRIENDS_DISPLAY; i++)
					{
						//create the childname
						childName = "friend" + (i + 1);
						
						//udpate friend item
						updateFriendItem(childName, this._friends[(this._last_friend_display)].id);
						
						//increment 
						this._last_friend_display += 1;
					}
				}
				else if(this._last_friend_display + AMOUNT_FRIENDS_DISPLAY > (this._friendsAmount - 1))
				{
					//calculate the amount of friends 'too many'
					var dif_plus:int = (this._last_friend_display + AMOUNT_FRIENDS_DISPLAY) - this._friendsAmount;
					
					//calculate the amount of friends to be displayed
					//untill we reach the max amount of friends
					var plus_one:int = (AMOUNT_FRIENDS_DISPLAY - 1) - dif_plus;
					
					for(var l:int = 0; l< plus_one; l++)
					{
						//create the childname
						childName = "friend" + (l+1);
						
						//update friend item
						updateFriendItem(childName, this._friends[(this._last_friend_display)].id);
						
						//increment
						this._last_friend_display += 1;
					}
					
					//reset the last friends display
					this._last_friend_display = 0;
					
					//calculate the amount of friends to be displayed
					//starting from the beginning
					var plus_two:int = dif_plus;
					
					for(var n:int = 0; n<plus_two; n++)
					{
						//create the childname
						childName = "friend" + plus_one + (n+1);
						
						//update the friend item
						updateFriendItem(childName, this._friends[(this._last_friend_display)].id);
						
						//increment
						this._last_friend_display += 1;
					}
				}
			}
		}
		
		/**
		 * Update friend item
		 * 
		 * Grab the item
		 * Set the source of the UILoader
		 * Save the id to hidden textfield
		 **/
		private function updateFriendItem(childname:String, id:String):void
		{			
			var obj:FriendMC = this.contentcontainer.getChildByName(childname) as FriendMC;
			obj.imagecontainer.source = PICTURE_LOACATION + id + "/picture" + PICTURE_TYPE;
			obj.txtID.text = id;
		}
		
		/**
		 * Right tween complete
		 * 
		 * Place element left and tween it to the correct position
		 **/
		private function rightTweenComplete():void
		{
			//set the container position
			this.contentcontainer.x = -(this.width)*2;
			
			//create friends display
			createFriends("next");
			
			//Tween to element to it's correct position
			TweenLite.to(this.contentcontainer, .5, {x:this.contentcontainermask.x});
		}
		
		/**
		 * Left tween complete
		 * 
		 * Place element right and tween it to the correct position
		 **/
		private function leftTweenComplete():void
		{
			//set the container position
			this.contentcontainer.x = this.stage.stageWidth + (this.width * 2);
			
			//create friends
			createFriends("prev");
			
			//Tween to element to it's correct position
			TweenLite.to(this.contentcontainer, .5, {x:this.contentcontainermask.x});			
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
		 * Handle next button clicked
		 **/
		private function handleNextClicked(evt:MouseEvent):void
		{
			TweenMax.to(this.contentcontainer, 1, {x:(this.stage.stageWidth + this.width)*2, ease:Sine.easeOut, onComplete:rightTweenComplete});
		}
		
		/**
		 * Handle Previous button clicked
		 **/
		private function handlePreviousClicked(evt:MouseEvent):void
		{
			TweenMax.to(this.contentcontainer, 1, {x:-(this.width)*2, ease:Sine.easeOut, onComplete:leftTweenComplete});
		}
		
		/**
		 * Handle mouse out member
		 **/
		private function handleMouseOutMember(evt:MouseEvent):void
		{
			if(evt.target.parent.parent.name == "imagecontainer")
			{
				var obj:FriendMC = evt.target.parent.parent.parent as FriendMC;
				obj.filters = [ArnorFilterClass.createDropShadowFilter(), ArnorFilterClass.createBWFilter()];
			}
		}
		
		/**
		 * Handle mouse over member
		 **/
		private function handleMouseOverMember(evt:MouseEvent):void
		{
			if(evt.target.parent.parent.name == "imagecontainer")
			{
				var obj:FriendMC = evt.target.parent.parent.parent as FriendMC;
				obj.filters = null;
				obj.filters = [ArnorFilterClass.createDropShadowFilter()];
				
			}
		}
	}
}