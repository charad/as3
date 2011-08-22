/**
 ********************************
 * Class Information
 * @author	D'Haenens Arnor
 * @since	Aug 17, 2011, at 3:54:40 PM
 ********************************
 **/
package be.arnordhaenens.models
{
	import be.arnordhaenens.events.FacebookEvent;
	
	import com.adobe.serialization.json.JSON;
	import com.facebook.graph.Facebook;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import nl.demonsters.debugger.MonsterDebugger;
	
	import org.robotlegs.mvcs.Actor;

	/**
	 * Imports
	 **/
	
	/**
	 * Class	FacebookModel
	 * @author	D'Haenens Arnor
	 * @since	@since	Aug 17, 2011, at 3:54:40 PM
	 * @see		be.arnordhaenens.models.FacebookModel
	 **/
	public class FacebookModel extends Actor
	{
		/**
		 * Variables
		 **/
		private static const GDM_ID:String = "72308406080";
		private static const FEED_METHOD:String = "feed";
		
		/**
		 * Constructor
		 **/
		public function FacebookModel()
		{
			super();
		}
		
		////
		////////////////////////////////
		// Public functions
		////////////////////////////////
		////
		
		/**
		 * Load the timeline
		 **/
		public function loadTimeline():void
		{
			var requestType:String = "GET";
			var params:Object = null;
			var method:String = "/" + GDM_ID + "/feed";
			
			//call the api function
			Facebook.api(method, onTimelineLoaded, params, requestType);
		}
		
		/**
		 * Load friends / followers
		 **/
		public function loadFollowers():void
		{
			var requestType:String = "GET";
			var params:Object = null;
			var method:String = "/" + GDM_ID + "/members";
			
			//call the api function
			Facebook.api(method, onMembersLoaded, params, requestType);
		}
		
		/**
		 * Load the photos
		 **/
		public function loadPhotos():void
		{
			var requestType:String = "GET";
			var params:Object = null;
			var method:String = "/" + GDM_ID + "/photos";
			
			//call the api function 
			Facebook.api(method, onPhotosLoaded, params, requestType);
		}
		
		/**
		 * Open message window
		 **/
		public function postMessage():void
		{
			//MonsterDebugger.trace(this, "trying to post message");
			
			/**
			 * NOTE
			 * 
			 * From July 12 2011 it's impossible to send a 'message' value
			 * So to say, prefilled text
			 * User has to have the freedom to choose it's own text
			 **/
			
			//set the data object
			var data:Object = {
								link:'http://arnor.be/nieuw',
								name:'Vernieuwde promosite GDM',
								picture:'http://arnor.be/nieuw/assets/originals/images/gdm.jpg', 
								description:'Ik heb zonet de nieuwe promosite van de richting Grafische en Digitale Media bezocht en het was heel leerrijk! Neem zelf ook een kijkje en kom meer te weten over deze richting.'
								};
			
			//call the ui
			//send the data
			//add the callback function
			Facebook.ui(FEED_METHOD, data, onFeedUiCallback); 
		}
		
		/**
		 * Log out from facebook
		 **/
		public function logoutFacebook():void
		{
			//call the graph api logout function
			Facebook.logout(onFacebookLogout);
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
		 * Create friends XML
		 **/
		private function createFriendsXML(data:*):void
		{
			var amount:int = data.length;
			var membersXML:XML = <items />;
			
			for(var i:int = 1;i<amount; i++)
			{
				var member:XML = <item />;
				var name:String = data[(i-1)].name;
				var id:String = data[(i-1)].id;
				
				member.@target = "_blank";
				member.@link = "http://www.facebook.com/profile.php?id=" + id; 
				member.appendChild(createCDATAMenuXML(name));
				
				//add member element to its parent
				membersXML.appendChild(member);
			}
			
			/*MonsterDebugger.trace(this, "MENU XML");*/
			//MonsterDebugger.trace(this, membersXML.toString());
			
			dispatch(new FacebookEvent(FacebookEvent.FRIENDS_LOADED, membersXML.toString()));
		}
		
		/**
		 * Create CDATA for in the menu xml
		 **/
		private function createCDATAMenuXML(name:String):String
		{
			var result:String = "<![CDATA[";
			
			var randomResult:Number = Math.random();
			
			if(0<randomResult && randomResult<= .33)
			{
				result += "<h>" + name + "</h>";
			}
			else if(randomResult>.33 && randomResult<=.66)
			{
				result += "<l>" + name + "</l>";
			}
			else if(.66>randomResult)
			{
				result += "<m>" + name + "</m>";
			}
			
						
			return  result + "]]>";
		}
		
		////
		////////////////////////////////
		// Private event handlers
		////////////////////////////////
		////
		
		/**
		 * When the timeline is loaded
		 **/
		private function onTimelineLoaded(result:Object,fail:Object):void
		{
			if(result)
				dispatch(new FacebookEvent(FacebookEvent.TIMELINE_LOADED, result));
			else
			{
				var failmessage:String = "Laden van user wall is mislukt";
				dispatch(new FacebookEvent(FacebookEvent.FAIL, failmessage));
			}
		}
		
		/**
		 * Friends loaded
		 **/
		private function onMembersLoaded(result:Object, fail:Object):void
		{
			if(result)
			{
				/*MonsterDebugger.trace(this, "FRIENDS RESULT");
				MonsterDebugger.trace(this, result);*/
				
				//dispatch data
				dispatch(new FacebookEvent(FacebookEvent.FRIENDS_LOADED, result));
				//createFriendsXML(result);
			}
			else
			{
				MonsterDebugger.trace(this, "FRIENDS LOAD FAILED");
				MonsterDebugger.trace(this, fail);
			}
		}
		
		/**
		 * Photos loaded
		 **/
		private function onPhotosLoaded(result:Object, fail:Object):void
		{
			if(result)
			{
				MonsterDebugger.trace(this, "PHOTOS RESULT");
				MonsterDebugger.trace(this, result);
				
				//dispatch event with the result as data
				dispatch(new FacebookEvent(FacebookEvent.PHOTOS_LOADED, result));
			}
			else
			{
				MonsterDebugger.trace(this, "FAILED");
				MonsterDebugger.trace(this, fail);
				dispatch(new FacebookEvent(FacebookEvent.FAIL, "Geen foto's kunnen laden"));
			}
		}
		
		/**
		 * Feed ui return
		 **/
		private function onFeedUiCallback(result:Object):void
		{						
			if(result != null)
			{
				if(result.post_id)
				{
					dispatch(new FacebookEvent(FacebookEvent.MESSAGE_DONE));
				}
				else if(result.error_code || result.error_code == 190)
				{
					dispatch(new FacebookEvent(FacebookEvent.MESSAGE_FAILED));
				}
				else
				{
					dispatch(new FacebookEvent(FacebookEvent.MESSAGE_FAILED));
				}
			}
		}
		
		/**
		 * Call back function for logging out of facebook
		 **/
		private function onFacebookLogout(result:Boolean):void
		{
			if(result)
			{
				dispatch(new FacebookEvent(FacebookEvent.LOGGED_OUT));
			}
			else if(!result)
			{
				dispatch(new FacebookEvent(FacebookEvent.LOGOUT_FAILED));
			}
		}
	}
}