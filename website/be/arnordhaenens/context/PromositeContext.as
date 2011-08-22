/**
 ****************************************************************
 * Class	PromositeContext
 * @author	D'Haenens Arnor
 * @since	Jul 19, 2011, at 7:08:03 PM
 * 
 * Deze klasse wordt gebruikt als de context.
 * Dit is de 'hub' die de verschillende elementen
 * met elkaar zal verbinden.
 ****************************************************************
 **/
package be.arnordhaenens.context
{
	/**
	 * Imports
	 **/
	import be.arnordhaenens.controllers.assignments.AssignmentCreatorCommand;
	import be.arnordhaenens.controllers.assignments.AssignmentDisplayImagesCommand;
	import be.arnordhaenens.controllers.assignments.AssignmentDisplayVideosCommand;
	import be.arnordhaenens.controllers.assignments.LoadAssignmentsCommand;
	import be.arnordhaenens.controllers.contact.ContactCreatorCommand;
	import be.arnordhaenens.controllers.facebook.FacebookCreatorCommand;
	import be.arnordhaenens.controllers.facebook.FacebookLogoutCommand;
	import be.arnordhaenens.controllers.facebook.FacebookLogoutFailedCommand;
	import be.arnordhaenens.controllers.facebook.friends.FacebookCreateFriendsCommand;
	import be.arnordhaenens.controllers.facebook.friends.FacebookLoadFriendsCommand;
	import be.arnordhaenens.controllers.facebook.message.FacebookMessageFailedCommand;
	import be.arnordhaenens.controllers.facebook.message.FacebookMessageSendCommand;
	import be.arnordhaenens.controllers.facebook.message.FacebookPostMessageCommand;
	import be.arnordhaenens.controllers.facebook.photos.FacebookDisplayPhotosCommand;
	import be.arnordhaenens.controllers.facebook.photos.FacebookLoadPhotosCommand;
	import be.arnordhaenens.controllers.facebook.timeline.FacebookDisplayTimelineCommand;
	import be.arnordhaenens.controllers.facebook.timeline.FacebookLoadTimelineCommand;
	import be.arnordhaenens.controllers.facebook.token.FacebookGetTokenCommand;
	import be.arnordhaenens.controllers.facebook.token.FacebookSaveUidTokenCommand;
	import be.arnordhaenens.controllers.home.HomeCreatorCommand;
	import be.arnordhaenens.controllers.movies.MovieCreatorCommand;
	import be.arnordhaenens.controllers.notifications.FormIncorrectNotificationCommand;
	import be.arnordhaenens.controllers.notifications.FormSendFailedCommand;
	import be.arnordhaenens.controllers.notifications.SendContactFormCommand;
	import be.arnordhaenens.controllers.notifications.SendNotificationCommand;
	import be.arnordhaenens.controllers.notifications.SendingContactFormCommand;
	import be.arnordhaenens.controllers.pictures.DisplayImagesCommand;
	import be.arnordhaenens.controllers.pictures.LoadPictureAssignmentsCommand;
	import be.arnordhaenens.controllers.pictures.LoadPicturesCommand;
	import be.arnordhaenens.controllers.pictures.PictureCreatorCommand;
	import be.arnordhaenens.controllers.popup.PopupCreatorCommand;
	import be.arnordhaenens.controllers.startup.ArteveldeLogoCreatorCommand;
	import be.arnordhaenens.controllers.startup.FooterCreatorCommand;
	import be.arnordhaenens.controllers.startup.MenuCreatorCommand;
	import be.arnordhaenens.controllers.startup.PrepareBackendConnectionCommand;
	import be.arnordhaenens.controllers.twitter.TwitterCreatorCommand;
	import be.arnordhaenens.controllers.twitter.TwitterLoadDataCommand;
	import be.arnordhaenens.events.AssignmentEvent;
	import be.arnordhaenens.events.ContactFormEvent;
	import be.arnordhaenens.events.FacebookEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.PictureEvent;
	import be.arnordhaenens.events.PopupEvent;
	import be.arnordhaenens.events.TwitterEvent;
	import be.arnordhaenens.models.FacebookModel;
	import be.arnordhaenens.models.TwitterModel;
	import be.arnordhaenens.services.AssignmentService;
	import be.arnordhaenens.services.ContactFormService;
	import be.arnordhaenens.services.FacebookService;
	import be.arnordhaenens.services.HelloService;
	import be.arnordhaenens.services.PictureAssignmentService;
	import be.arnordhaenens.views.components.home.HomeView;
	import be.arnordhaenens.views.mediators.ApplicationMediator;
	import be.arnordhaenens.views.mediators.home.HomeMediator;
	
	import flash.display.DisplayObjectContainer;
	
	import org.robotlegs.mvcs.Context;
	
	/**
	 * Class	PromositeContext.as
	 * @author	D'Haenens Arnor
	 * @since	Jul 19, 2011, at 7:08:03 PM
	 * @see		org.robotlegs.mvcs.Context
	 **/
	public class PromositeContext extends Context
	{
		/**
		 * Variables
		 **/
		public var state:String;
		
		/**
		 * Constructor
		 **/
		public function PromositeContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
		}
		
		/**
		 * Override startup method
		 * 
		 * Mapping the injectors
		 * Mapping the views
		 * Mapping the controllers
		 * Mapping the services
		 **/
		override public function startup():void
		{
			//map the injectors
			
			//map the services
			injector.mapSingleton(HelloService);
			injector.mapSingleton(ContactFormService);
			injector.mapSingleton(FacebookService);
			injector.mapSingleton(PictureAssignmentService);
			injector.mapSingleton(AssignmentService);
			
			//map the models
			injector.mapSingleton(TwitterModel);
			injector.mapSingleton(FacebookModel);
			
			//map the views
			mediatorMap.mapView(PromositeDC, ApplicationMediator);
			
			//execute controllers
			commandMap.execute(ArteveldeLogoCreatorCommand);
			commandMap.execute(FooterCreatorCommand);
			commandMap.execute(MenuCreatorCommand);
			commandMap.execute(HomeCreatorCommand);
			commandMap.execute(PrepareBackendConnectionCommand);
			
			//map the controllers
			commandMap.mapEvent(MenuEvent.CONTACT_CLICKED, ContactCreatorCommand);
			commandMap.mapEvent(MenuEvent.HOME_CLICKED, HomeCreatorCommand);
			commandMap.mapEvent(MenuEvent.TWITTER_CLICKED, TwitterCreatorCommand);
			commandMap.mapEvent(MenuEvent.FACEBOOK_CLICKED, FacebookCreatorCommand);
			commandMap.mapEvent(MenuEvent.MOVIES_CLICKED, MovieCreatorCommand);
			commandMap.mapEvent(MenuEvent.ASSIGNMENT_CLICKED, AssignmentCreatorCommand);
			commandMap.mapEvent(MenuEvent.PICTURE_CLICKED, PictureCreatorCommand);
			
			//controllers contact
			commandMap.mapEvent(ContactFormEvent.SENDING_FORM, SendContactFormCommand);//this command sends the form
			//these create the notifications
			commandMap.mapEvent(ContactFormEvent.SENDING_FORM, SendingContactFormCommand);
			commandMap.mapEvent(ContactFormEvent.MAIL_SEND_SUCCES, SendNotificationCommand);
			commandMap.mapEvent(ContactFormEvent.MAIL_SEND_FAILED, FormSendFailedCommand);
			commandMap.mapEvent(ContactFormEvent.NOT_CORRECT_YET, FormIncorrectNotificationCommand);
			
			//controllers twitter
			commandMap.mapEvent(TwitterEvent.LOAD_DATA, TwitterLoadDataCommand);
			
			//controllers facebook
			commandMap.mapEvent(FacebookEvent.SAVE_UID_TOKEN, FacebookSaveUidTokenCommand);
			commandMap.mapEvent(FacebookEvent.GET_ACCES_TOKEN, FacebookGetTokenCommand);
			
			commandMap.mapEvent(FacebookEvent.LOAD_TIMELINE, FacebookLoadTimelineCommand);
			commandMap.mapEvent(FacebookEvent.DISPLAY_TIMELINE, FacebookDisplayTimelineCommand);
			
			commandMap.mapEvent(FacebookEvent.LOAD_FRIENDS, FacebookLoadFriendsCommand);
			commandMap.mapEvent(FacebookEvent.DISPLAY_FRIENDS, FacebookCreateFriendsCommand);
			
			commandMap.mapEvent(FacebookEvent.LOAD_PHOTOS, FacebookLoadPhotosCommand);
			commandMap.mapEvent(FacebookEvent.DISPLAY_PHOTOS, FacebookDisplayPhotosCommand);
			
			commandMap.mapEvent(FacebookEvent.MESSAGE, FacebookPostMessageCommand);
			commandMap.mapEvent(FacebookEvent.MESSAGE_DONE, FacebookMessageSendCommand);
			commandMap.mapEvent(FacebookEvent.MESSAGE_FAILED, FacebookMessageFailedCommand);
			
			commandMap.mapEvent(FacebookEvent.LOGOUT, FacebookLogoutCommand);
			commandMap.mapEvent(FacebookEvent.LOGOUT_FAILED, FacebookLogoutFailedCommand);
			
			//controllers popup
			commandMap.mapEvent(PopupEvent.CREATE_POPUP, PopupCreatorCommand);
			
			//controllers pictures command
			commandMap.mapEvent(PictureEvent.LOAD_PICTURE_ASSIGNMENTS, LoadPictureAssignmentsCommand);
			commandMap.mapEvent(PictureEvent.DISPLAY_IMAGES, DisplayImagesCommand);
			
			//controllers assignment
			commandMap.mapEvent(AssignmentEvent.LOAD_ASSIGNMENTS, LoadAssignmentsCommand);
			commandMap.mapEvent(AssignmentEvent.DISPLAY_IMAGES, AssignmentDisplayImagesCommand);
			commandMap.mapEvent(AssignmentEvent.DISPLAY_VIDEOS, AssignmentDisplayVideosCommand);
		}
	}
}