package com.vmc.player.rtmfp
{
	import com.vmc.debug.Logger;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class RtmfpPlayer extends Video
	{
		private static const TAG:String = "RtmfpPlayer";
		
		private var playUrl:String;
		private var serverUrl:String;
		private var connect2Peer:String;
		private var conn:NetConnection;
		private var stream:NetStream;
		private var streamName:String;
		private var autoPlay:Boolean = true;
		
		private var _state:Number = STATE_IDLE;
		private static const STATE_PLAY:Number = 0;
		private static const STATE_IDLE:Number = 1;
		private static const STATE_PAUSE:Number = 2;
		private static const STATE_BUFFERRING:Number = 3;
		private static const STATE_CONNECTED:Number = 4;
		private static const STATE_DISCONNECT:Number = 5;
		private static const STATE_ERROR:Number = 6;
		
		public static const EVENT_RESIZE_VIDEO:String = "resizevideo";
		
		public function RtmfpPlayer(width:int=320, height:int=240)
		{
			super(width, height);
		}
		
		public function setPlayUrl(url:String):void{
			playUrl = url;
			var strs:Array = url.split("|");
			serverUrl = strs[0];
			connect2Peer = strs[1];
			streamName = strs[2];
			if(autoPlay)
				play();
		}

		public function get state():Number
		{
			return _state;
		}

		public function set state(value:Number):void
		{
			_state = value;
		}

		public function isPlaying():Boolean{
			return state == STATE_PLAY;
		}

		public function connectServer():void{
			if(serverUrl == null || serverUrl.length == 0){
				throw new Error("I don't know which SERVER to connect!");
			}
			conn = new NetConnection();
			conn.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			conn.connect(serverUrl);
		}
		
		private function onConnect():void{
			Logger.info(TAG,"Connect to "+serverUrl+" successfully.");
			state = STATE_CONNECTED;
			stream = new NetStream(conn, connect2Peer);
			stream.client = this;
			this.smoothing = true;
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			
			if(autoPlay) 
				onNetStreamConnect();
		}
		
		private function onDisconnect():void{
			state = STATE_DISCONNECT;
			conn = null;
			stream = null;
		}
		
		private function doDisconnect():void{
			Logger.info(TAG,"doDisconnect---");
			if(conn)
				conn.close();
			if(stream)
				stream.close();
		}
		
		private function onNetStreamConnect():void{
			this.attachNetStream(stream);
			stream.play(streamName);
//			stream.bufferTime = 1.0;
		}
		
		private function onStreamStart():void{
			state = STATE_PLAY;
		}
		
		private function onStreamBufferring():void{
			state = STATE_BUFFERRING;
		}
		
		private function onPause():void{
			state = STATE_PAUSE;
		}
		
		private function onPosting(message:Object):void{
			Logger.info(TAG,"onPosting---"+message.user+":"+message.text);
		}
		
		private function _onMetaData(info:Object):void{
			Logger.info(TAG,"_onMetaData---"+info.toString());
		}
		
		public function receiveSomeData(message:String):void{
			Logger.info(TAG,"receive "+message);
//			Logger.info(TAG,"stream.currentFPS = "+stream.currentFPS);
		}
		
		private function doResizeVideo():void{
			var width:Number = this.videoWidth;
			var height:Number = this.videoHeight;
			Logger.info(TAG,"doResizeVideo("+width+","+height+")");
			var event:VideoEvent = new VideoEvent(VideoEvent.SIZECHANGED);
			this.dispatchEvent(event);
		}
		
		public function setAutoPlay(auto:Boolean):void{
			autoPlay = auto;
		}
		
		public function play():void{
			if(state == STATE_PAUSE){
				stream.resume();
			}
			else if(state == STATE_CONNECTED){
				stream.play(streamName);
			}
			else if(state == STATE_IDLE){
				connectServer();
			}
		}
		
		public function pause():void{
			if(state ==  STATE_PLAY){
				stream.pause();
				state = STATE_PAUSE;
			}
		}
		
		public function onError(error:String):void{
			state = STATE_ERROR;
			Logger.error(TAG,error);
		}
		
		private function netStatusHandler(e:NetStatusEvent):void
		{
			Logger.info(TAG,"netStatus: " + e.info.code);
			switch(e.info.code)
			{
				case "NetConnection.Connect.Success":
					onConnect();
					break;
				
				case "NetConnection.Connect.Closed":
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.Rejected":
				case "NetConnection.Connect.AppShutdown":
				case "NetConnection.Connect.InvalidApp":    
					onDisconnect();
					break;
				
				case "NetStream.Connect.Success": 
//					onNetStreamConnect();
					break;
				
				case "NetStream.Connect.Rejected": 
				case "NetStream.Connect.Failed": 
					doDisconnect();
					break;
				
				case "NetGroup.Connect.Success": 
//					onNetGroupConnect();
					break;
				
				case "NetGroup.Connect.Rejected": 
				case "NetGroup.Connect.Failed": 
					doDisconnect();
					break;
				
				case "NetGroup.Posting.Notify": 
					onPosting(e.info.message);
					break;
				
				case "NetStream.MulticastStream.Reset":
				case "NetStream.Buffer.Full":
					
					break;
				case "NetStream.Play.Reset":
					
					break;
				case "NetStream.Play.Start":
					onStreamStart();
					break;
				case "NetStream.Pause.Notify":
					
					break;
				case "NetGroup.SendTo.Notify": 
				case "NetGroup.LocalCoverage.Notify": 
				case "NetGroup.Neighbor.Connect": 
				case "NetGroup.Neighbor.Disconnect":
					break;
				case "NetGroup.MulticastStream.PublishNotify": 
					onNetStreamConnect();
					break;
				
				case "NetGroup.MulticastStream.UnpublishNotify": 
				case "NetGroup.Replication.Fetch.SendNotify": 
				case "NetGroup.Replication.Fetch.Failed": 
				case "NetGroup.Replication.Fetch.Result": 
				case "NetGroup.Replication.Request": 
				case "NetStream.Video.DimensionChange":
					doResizeVideo();
					break;
				default:
					break;
			}
		}
	}
	
}