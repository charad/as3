/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 21, 2011, at 9:06:43 PM
 ********************************
 **/
package be.arnordhaenens.views.components.pictures
{
	import be.arnordhaenens.events.PictureEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.plugins.BlurFilterPlugin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	PictureAssignmentInfoComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 21, 2011, at 9:06:43 PM
	 * @see		be.arnordhaenens.views.components.pictures.PictureAssignmentInfoComponent
	 **/
	public class PictureAssignmentInfoComponent extends PictureAssignmentInfoMC
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
		
		private var _currentLink:String;
		
		/**
		 * Constructor
		 **/
		public function PictureAssignmentInfoComponent(data:Array)
		{
			super();
			
			//set the initial data
			this._assignmentData = data;
			this._dataLength = this._assignmentData.length;
			this._currentIndex = -1;
			
			//hide the video button
			this.btnVideo.visible = false;
			
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
		 * Add event listeners to the buttons
		 * Add drop shadow filter
		 * Display the first text
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth) * .5;
			this.y = -(this.height);
			
			//add event listeners to the buttons			
			this.btnLink.addEventListener(MouseEvent.CLICK, handleLinkClicked);
			this.btnImages.addEventListener(MouseEvent.CLICK, handleImagesClicked);
			
			//add drop shadow filter
			this.filters = [ArnorFilterClass.createDropShadowFilter()];
			
			//update the assignment view
			updateAssignmentInfo("next");
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
			
			//set the basic information
			this.txtTitle.text = this._currentAssignmentInfo.name;
			this.txtMessage.text = this._currentAssignmentInfo.description;
			
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
			
			
			//after setting all the data
			//tween the element to it's good position
			TweenMax.to(this, 1, {y:(this.stage.stageHeight - this.height)*.5, alpha:1, blurFilter:{blurX:0, blurY:0}});
		}
		
		/**
		 * Hide tween complete
		 **/
		private function hideTweenComplete(direction:String):void
		{
			//update the fields
			updateAssignmentInfo(direction);
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
			//remove event listener
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
			dispatchEvent(new PictureEvent(PictureEvent.EXIT_FULLSCREEN));
			
			//navigate to the online place
			navigateToURL(new URLRequest(this._currentLink), "_blank");
		}
		
		/**
		 * Handle images clicked
		 **/
		private function handleImagesClicked(evt:MouseEvent):void
		{
			//display the images
			dispatchEvent(new PictureEvent(PictureEvent.DISPLAY_IMAGES, this._currentImages));
		}
	}
}