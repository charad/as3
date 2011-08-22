/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 20, 2011, at 9:16:10 PM
 ********************************
 **/
package be.arnordhaenens.views.mediators.movies
{
	/**
	 * Imports
	 **/
	
	import be.arnordhaenens.events.ApplicationEvent;
	import be.arnordhaenens.events.MenuEvent;
	import be.arnordhaenens.events.MovieEvent;
	import be.arnordhaenens.events.PopupEvent;
	import be.arnordhaenens.filters.ArnorFilterClass;
	import be.arnordhaenens.views.components.movies.MovieView;
	
	import flash.events.Event;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * Class	MoviesMediator
	 * @author	D'Haenens Arnor
	 * @since	Aug 20, 2011, at 9:16:10 PM
	 * @see		be.arnordhaenens.views.mediators.movies.MoviesMediator
	 **/
	public class MoviesMediator extends Mediator
	{
		/**
		 * Variables
		 **/
		[Inject]public var view:MovieView;
		
		/**
		 * Constructor
		 **/
		public function MoviesMediator()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		/**
		 * Override onRegister
		 * 
		 * Dispatched when everything is constructed
		 * and is ready to interact with the application
		 **/
		override public function onRegister():void
		{
			//set the state
			PromositeDC.state = "movies";
			
			//map view listeners
			eventMap.mapListener(this.view, MovieEvent.GROUP_CLICKED, handleVimeoGroupClicked);
			eventMap.mapListener(this.view, MovieEvent.WEBSITE_CLICKED, handleOneMinuteWebsiteClicked);
			eventMap.mapListener(this.view, MovieEvent.TRAILER_CLICKED, handleOneMinuteTrailerClicked);
			eventMap.mapListener(this.view, PopupEvent.CREATE_POPUP, handlePopupCreate);
			
			//map context listeners
			eventMap.mapListener(eventDispatcher, ApplicationEvent.RESIZE, handleStageResize);
			
			eventMap.mapListener(eventDispatcher, MenuEvent.HOME_CLICKED, removeMovieView);
			eventMap.mapListener(eventDispatcher, MenuEvent.ASSIGNMENT_CLICKED, removeMovieView);
			eventMap.mapListener(eventDispatcher, MenuEvent.TWITTER_CLICKED, removeMovieView);
			eventMap.mapListener(eventDispatcher, MenuEvent.FACEBOOK_CLICKED, removeMovieView);
			eventMap.mapListener(eventDispatcher, MenuEvent.CONTACT_CLICKED, removeMovieView);
			eventMap.mapListener(eventDispatcher, MenuEvent.PICTURE_CLICKED, removeMovieView);
			
			eventMap.mapListener(eventDispatcher, PopupEvent.REMOVED_POPUP, handlePopupRemoved);
		}
		
		/**
		 * Override onRemove
		 * 
		 * Dispatched when just being deleted from the stage
		 * 
		 * Remove all mapping of events
		 * Remove all instances of this mediator and view
		 * 
		 * Limitation of memory / CPU use!!
		 * Important for mobile devices
		 **/
		override public function onRemove():void
		{
			eventMap.unmapListeners();
			
			mediatorMap.unmapView(MovieView);
			mediatorMap.removeMediatorByView(MovieView);
			
			//call the parent onremove function,
			//so that we won't forget something
			super.onRemove();
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
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * Handle the resize of the stage / window
		 * This for the components on the HOME-view
		 **/
		private function handleStageResize(evt:ApplicationEvent):void
		{
			this.view.handleResize();
		}
		
		/**
		 * Remove the view from it's parent
		 **/
		private function removeMovieView(evt:*):void
		{
			this.view.parent.removeChild(this.view);
		}
		
		/**
		 * Handle vimeo group clicked
		 **/
		private function handleVimeoGroupClicked(evt:MovieEvent):void
		{
			//dispatch event for exiting fullscreen
			dispatch(new MovieEvent(MovieEvent.EXIT_FULLSCREEN));
			
			//go to the website
			this.view.gotoVimeoGroup();
		}
		
		/**
		 * Handle one minute website clicked
		 **/
		private function handleOneMinuteWebsiteClicked(evt:MovieEvent):void
		{
			//dispatch event for exiting fullscreen
			dispatch(new MovieEvent(MovieEvent.EXIT_FULLSCREEN));
			
			//go to the website
			this.view.gotoOneMinuteWebsite();
		}
		
		/**
		 * Handle one minute trailer clicked
		 **/
		private function handleOneMinuteTrailerClicked(evt:MovieEvent):void
		{
			this.view.viewTrailerOneMinuteFestival();
		}
		
		/**
		 * Create the popup for displaying the trailer
		 **/
		private function handlePopupCreate(evt:PopupEvent):void
		{
			//dispatch the event
			dispatch(new PopupEvent(PopupEvent.CREATE_POPUP, evt.data));
			
			//add filter to the view
			this.view.filters = [ArnorFilterClass.createBlurFilter()];
		}
		
		/**
		 * Handle popup removed
		 **/
		private function handlePopupRemoved(evt:PopupEvent):void
		{
			//remove the blurfilter
			this.view.filters = [];
		}
	}
}