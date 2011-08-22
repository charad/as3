/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 22, 2011, at 7:25:08 PM
 ********************************
 **/
package be.arnordhaenens.views.components.assignments
{
	/**
	 * Imports
	 **/
	import be.arnordhaenens.events.AssignmentEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;

	
	
	/**
	 * Class	AssignmentInfoComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 22, 2011, at 7:25:08 PM
	 * @see		be.arnordhaenens.views.components.assignments.AssignmentInfoComponent
	 **/
	public class AssignmentInfoComponent extends PictureAssignmentInfoMC
	{
		/**
		 * Variables
		 **/
		private var _assignmentData:Array;
		private var _dataLength:int;
		private var _currentIndex:int;
		
		private var _currentAssignmentInfo:Object;
		private var _currentStudents:Object;
		private var _currentImages:Object;
		private var _currentVideos:Object;
		
		private var _currentLink:String;
		
		/**
		 * Constructor
		 **/
		public function AssignmentInfoComponent(data:Array)
		{
			super();
			
			//set the initial data
			this._assignmentData = data;
			this._dataLength = this._assignmentData.length;
			this._currentIndex = -1;
			
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
			//set the new position
			this.x = (this.stage.stageWidth) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
		}
		
		/**
		 * Tween the component
		 * Update the component
		 **/
		public function updateAssignment(direction:String):void
		{
			//Hide the component
			TweenMax.to(this, .5, {y:-(this.height), blurFilter:{blurX:20, blurY:20}, alpha:0, onComplete:hideTweenComplete, onCompleteParams:[direction]});			
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
		 * Set the dropshadow filter
		 * Add event listeners to the buttons
		 * 
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth) * .5;
			this.y = -(this.height);
			
			//set the filter
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//add event listeners to the buttons
			this.btnImages.addEventListener(MouseEvent.CLICK, handleImagesClicked);
			this.btnLink.addEventListener(MouseEvent.CLICK, handleLinkClicked);
			this.btnVideo.addEventListener(MouseEvent.CLICK, handleVideosClicked);
			
			//update assignment info
			updateAssignmentInfo("next");
		}
		
		/**
		 * Hide tween complete
		 **/
		private function hideTweenComplete(direction:String):void
		{
			//update the fields
			updateAssignmentInfo(direction);
		}
		
		/**
		 * Update the assignment info component
		 **/
		private function updateAssignmentInfo(direction:String):void
		{
			if(direction == "prev")
			{
				if(this._currentIndex - 1 >= 0)
				{
					this._currentIndex -= 1;
				}
				else if(this._currentIndex - 1 < 0)
				{
					this._currentIndex = this._dataLength - 1;
				}
			}
			else if(direction == "next")
			{
				if(this._currentIndex + 1 <= (this._dataLength-1))
				{
					this._currentIndex += 1;
				}
				else if(this._currentIndex + 1 > (this._dataLength - 1))
				{
					this._currentIndex = 0;
				}
			}
			
			//grab the current assignment
			this._currentAssignmentInfo = this._assignmentData[this._currentIndex]['info'];
			this._currentStudents = this._assignmentData[this._currentIndex]['students'];
			this._currentImages = this._assignmentData[this._currentIndex]['images'];
			this._currentVideos = this._assignmentData[this._currentIndex]['videos'];
			
			//set the information
			setInformation();
		}
		
		/**
		 * Fill in the text fields
		 * Handle display of the button (linkbutton)
		 **/
		private function setInformation():void
		{
			//reset the fields
			this.txtMessage.text = "";
			this.txtStudenten.text = "";
			this.txtTitle.text = "";
			this.btnImages.visible = true;
			this.btnLink.visible = true;
			this.btnVideo.visible = true;
			
			//set the basic information
			this.txtTitle.text = this._currentAssignmentInfo.name;
			this.txtMessage.text = this._currentAssignmentInfo.description;
			
			//check if the assignment has a link
			if(this._currentAssignmentInfo.url != null && this._currentAssignmentInfo.url != "")
			{
				this.btnLink.visible = true;
				this._currentLink = this._currentAssignmentInfo.url;
			}
			else
				this.btnLink.visible = false;
			
			//set the students
			if(this._currentStudents.length > 1)
			{
				var i:int = 1;
				for each (var student:* in this._currentStudents) 
				{
					if(i == 1)
						this.txtStudenten.text = student.firstname + " " + student.lastname;
					else
						this.txtStudenten.text = this.txtStudenten.text + ", " + student.firstname + " " + student.lastname;
					
					//increment i
					i++;
				}
			}
			else if(this._currentStudents.length == 1)
				this.txtStudenten.text = this._currentStudents[0].firstname + " " + this._currentStudents[0].lastname;
			else if(this._currentStudents.length == 0)
				this.txtStudenten.text = "Er zijn geen studenten aan deze opdracht toegevoegd";
			
			//set the images
			if(this._currentImages.length == 0)
				this.btnImages.visible = false;
			else
				this.btnImages.visible = true;
			
			//set the videos
			if(this._currentVideos.length == 0)
				this.btnVideo.visible = false;
			else 
				this.btnVideo.visible = true;			
			
			//after setting all the data
			//tween the element to it's good position
			TweenMax.to(this, 1, {y:(this.stage.stageHeight - this.height)*.5, alpha:1, blurFilter:{blurX:0, blurY:0}});
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
		 * Handle link button clicked
		 **/
		private function handleLinkClicked(evt:MouseEvent):void
		{
			//exit fullscreen
			dispatchEvent(new AssignmentEvent(AssignmentEvent.EXIT_FULLSCREEN));
			
			//navigate to the online place
			navigateToURL(new URLRequest(this._currentLink), "_blank");
		}
		
		/**
		 * Handle images clicked
		 **/
		private function handleImagesClicked(evt:MouseEvent):void
		{
			//display the images
			dispatchEvent(new AssignmentEvent(AssignmentEvent.DISPLAY_IMAGES, this._currentImages));
		}
		
		/**
		 * Handle videos clicked
		 **/
		private function handleVideosClicked(evt:MouseEvent):void
		{
			//display the videos
			dispatchEvent(new AssignmentEvent(AssignmentEvent.DISPLAY_VIDEOS, this._currentVideos));
		}
	}
}