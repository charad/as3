/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Jul 23, 2011, at 2:58:14 PM
 ********************************
 **/
package be.arnordhaenens.views.components.contact
{
	import be.arnordhaenens.events.ContactFormEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.validation.ArnorValidation;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import nl.demonsters.debugger.MonsterDebugger;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	ContactFormComponent
	 * @author	D'Haenens Arnor
	 * @since	@since	Jul 23, 2011, at 2:58:14 PM
	 * @see		be.arnordhaenens.views.components.contact.ContactFormComponent
	 **/
	public class ContactFormComponent extends ContactFormMC
	{
		/**
		 * Variables
		 **/
		private static const NAAM_BASE:String = "Vul hier uw naam in";
		private static const VOORNAAM_BASE:String = "Vul hier uw voornaam in";
		private static const MAIL_BASE:String = "Vul hier uw e-mailadres in";
		private static const BOODSCHAP_BASE:String = "Vul hier uw boodschap in";
		
		/**
		 * Constructor
		 **/
		public function ContactFormComponent()
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
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
		}
		
		/**
		 * Reset the form after mail has been send
		 * Show message
		 **/
		public function resetFormAfterSendMail():void
		{
			//reset the fields to their basic values
			this.naam.input.txtInput.text = NAAM_BASE;
			this.voornaam.input.txtInput.text = VOORNAAM_BASE;
			this.mail.input.txtInput.text = MAIL_BASE;
			this.boodschap.input.txtInput.text = BOODSCHAP_BASE;
			
			//reset the validation mc's 
			this.naam.validation.gotoAndStop(5);
			this.voornaam.validation.gotoAndStop(5);
			this.mail.validation.gotoAndStop(5);
			this.boodschap.validation.gotoAndStop(5);
			
			//hide the validation mc's
			this.naam.validation.visible = false;
			this.voornaam.validation.visible = false;
			this.mail.validation.visible = false;
			this.boodschap.validation.visible = false;
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
		 * Hide the validation elements
		 * Set the label values
		 * Set the input field values
		 * Add event listeners to the components	
		 * Background visibility
		 * Validators
		 **/
		private function setBasics():void
		{
			//set the position
			this.x = (this.stage.stageWidth - this.width) * .5;
			this.y = (this.stage.stageHeight - this.height) * .5;
			
			//background visibility
			this.background.visible = false;
			
			//set values to the labels
			this.naam.label.txtLabel.text = "Naam";
			this.voornaam.label.txtLabel.text = "Voornaam";
			this.mail.label.txtLabel.text = "E-mail";
			this.boodschap.label.txtLabel.text = "Boodschap";
			
			//set values to the input fields
			this.naam.input.txtInput.text = NAAM_BASE;
			this.voornaam.input.txtInput.text = VOORNAAM_BASE;
			this.mail.input.txtInput.text = MAIL_BASE;
			this.boodschap.input.txtInput.text = BOODSCHAP_BASE;
			
			//add event listeners to the components
			this.naam.input.txtInput.addEventListener(FocusEvent.FOCUS_IN, handleTextFocusIn);
			this.naam.input.txtInput.addEventListener(FocusEvent.FOCUS_OUT, handleTextFocusOut);
			this.voornaam.input.txtInput.addEventListener(FocusEvent.FOCUS_IN, handleTextFocusIn);
			this.voornaam.input.txtInput.addEventListener(FocusEvent.FOCUS_OUT, handleTextFocusOut);
			this.boodschap.input.txtInput.addEventListener(FocusEvent.FOCUS_IN, handleTextFocusIn);
			this.boodschap.input.txtInput.addEventListener(FocusEvent.FOCUS_OUT, handleTextFocusOut);
			this.mail.input.txtInput.addEventListener(FocusEvent.FOCUS_IN, handleMailFocusIn);
			this.mail.input.txtInput.addEventListener(FocusEvent.FOCUS_OUT, handleMailFocusOut);
			
			//hide the validation elements
			this.naam.validation.visible = false;
			this.voornaam.validation.visible = false;
			this.mail.validation.visible = false;
			this.boodschap.validation.visible = false;
			
			//goto and stop @ keyframe 0 for the submit
			//set the properties for the submit mc
			this.submit.icon.gotoAndStop(0);		
			this.submit.useHandCursor = true;
			this.submit.mouseChildren = false;
			this.submit.addEventListener(MouseEvent.CLICK, handleSubmitClick);
		}
		
		/**
		 * Set validation
		 **/
		private function setValidation():void
		{
			
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Init function
		 * 
		 * Remove the event listener
		 * Set the basics
		 **/
		private function init(evt:Event=null):void
		{
			//remove event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			//set basics
			setBasics();
		}
		
		/**
		 * Focus in text input
		 **/
		private function handleTextFocusIn(evt:FocusEvent):void
		{
			//get the input
			var inputText:String = evt.target.text;
			var clearInput:Boolean = false;
			
			switch(evt.target.parent.parent.name)
			{
				case "naam":
					if(inputText == NAAM_BASE)
						clearInput = true;
					break;
				
				case "voornaam":
					if(inputText == VOORNAAM_BASE)
						clearInput = true;
					break;
				
				case "boodschap":
					if(inputText == BOODSCHAP_BASE)
						clearInput = true;
					break;
			}
			
			if(clearInput)
				evt.target.text = "";
		}
		
		/**
		 * Focus out text input
		 **/
		private function handleTextFocusOut(evt:FocusEvent):void
		{
			var base:MovieClip = evt.target.parent.parent as MovieClip;
			
			var inputText:String = evt.target.text;
			var checkText:Boolean = false;
						
			if(evt.target.text.length != 0)
			{
				switch(base.name)
				{
					case "naam":
						if(inputText != NAAM_BASE)
							checkText = true;
						this.naam.validation.gotoAndStop(1);
						break;
					
					case "voornaam":
						if(inputText != VOORNAAM_BASE)
							checkText = true;
						this.voornaam.validation.gotoAndStop(1);
						break;
					
					case "boodschap":
						if(inputText != BOODSCHAP_BASE)
							checkText = true;
						this.boodschap.validation.gotoAndStop(1);
						break;
				}
			}
			else
			{
				switch(base.name)
				{
					case "naam":
						evt.target.text = NAAM_BASE;
						break;
					
					case "voornaam":
						evt.target.text = VOORNAAM_BASE;
						break;
					
					case "boodschap":
						evt.target.text = BOODSCHAP_BASE;
						break;
				}
			}
		}
		
		/**
		 * Focus in mail
		 **/
		private function handleMailFocusIn(evt:FocusEvent):void
		{
			if(this.mail.input.txtInput.text == MAIL_BASE)
				this.mail.input.txtInput.text = "";
		}
		
		/**
		 * Focus out mail
		 **/
		private function handleMailFocusOut(evt:FocusEvent):void
		{
			var count:int = this.mail.input.txtInput.text.replace(" ", "").length;
			
			if(count == 0)
				this.mail.input.txtInput.text = MAIL_BASE;
			else if(count != 0)
			{
				//get the validation result
				var result:Boolean = ArnorValidation.validateMail(this.mail.input.txtInput.text);
				
				//set the validation mc visible
				this.mail.validation.visible = true;
				
				if(result == true)
					this.mail.validation.gotoAndStop(1);
				else if(result == false)
					this.mail.validation.gotoAndStop(5);
			}
		}
		
		/**
		 * Handle submit click
		 * 
		 * Validate the form
		 * Check if every field is valid
		 **/
		private function handleSubmitClick(evt:MouseEvent):void
		{
			//MonsterDebugger.trace(this, "contactform submit clicked");
			if(this.naam.input.txtInput.text == NAAM_BASE)
				this.naam.validation.gotoAndStop(5);
			
			if(this.voornaam.input.txtInput.text == VOORNAAM_BASE)
				this.voornaam.validation.gotoAndStop(5);
			
			if(this.boodschap.input.txtInput.text == BOODSCHAP_BASE)
				this.boodschap.validation.gotoAndStop(5);
			
			if(
				this.naam.validation.currentFrame == 5 ||
				this.voornaam.validation.currentFrame == 5 ||
				this.mail.validation.currentFrame == 5 ||
				this.boodschap.validation.currentFrame == 5)
			{
				dispatchEvent(new ContactFormEvent(ContactFormEvent.NOT_CORRECT_YET));
			}
			else
			{
				var _naam:String = this.naam.input.txtInput.text;
				var _voornaam:String = this.voornaam.input.txtInput.text;
				var _mail:String = this.mail.input.txtInput.text;
				var _boodschap:String = this.boodschap.input.txtInput.text;
				
				dispatchEvent(new ContactFormEvent(ContactFormEvent.SENDING_FORM, [_naam, _voornaam, _mail, _boodschap]));
			}
		}
	}
}