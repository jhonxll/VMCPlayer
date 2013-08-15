package com.vmc.player.rtmfp
{
	import com.vmc.debug.Logger;
	
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	public class RtmfpPlayer extends Video
	{
		private static const TAG:String = "RtmfpPlayer";
		
		private var _serverUrl:String = "";
		private var _connect2Peer:String ="";
		private var conn:NetConnection;
		private var stream:NetStream;
		private var _streamName:String;
		
		private var _state:Number = -1;
		private static const STATE_PLAY:Number = 0;
		private static const STATE_IDLE:Number = 1;
		private static const STATE_PAUSE:Number = 2;
		private static const STATE_BUFFERRING:Number = 3;
		private static const STATE_CONNECTED:Number = 4;
		private static const STATE_ERROR:Number = 5;
		
		
		public function RtmfpPlayer(width:int=320, height:int=240)
		{
			super(width, height);
		}
		
		public function get streamName():String
		{
			return _streamName;
		}

		public function set streamName(value:String):void
		{
			_streamName = value;
		}

		public function get state():Number
		{
			return _state;
		}

		public function set state(value:Number):void
		{
			_state = value;
		}

		public function get serverUrl():String
		{
			return _serverUrl;
		}

		public function set serverUrl(value:String):void
		{
			_serverUrl = value;
		}

		public function get connect2Peer():String
		{
			return _connect2Peer;
		}

		public function set connect2Peer(value:String):void
		{
			_connect2Peer = value;
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
			stream = new NetStream(conn, connect2Peer);
			stream.client = this;
			this.smoothing = true;
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			onNetStreamConnect();
		}
		
		private function onDisconnect():void{
			conn = null;
			stream = null;
		}
		
		private function doDisconnect():void{
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
		
		private function onPosting(message:Object):void{
			Logger.info(TAG,"onPosting---"+message.user+":"+message.text);
		}
		
		private function _onMetaData(info:Object):void{
			Logger.info(TAG,"_onMetaData---"+info.toString());
		}
		
		public function receiveSomeData(message:String):void{
			Logger.info(TAG,"receive "+message);
		}
		
		private function doResizeVideo():void{
			var width:Number = this.videoWidth;
			var height:Number = this.videoHeight;
			Logger.info(TAG,"doResizeVideo("+width+","+height+")");
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
				
				case "NetGroup.SendTo.Notify": 
				case "NetGroup.LocalCoverage.Notify": 
				case "NetGroup.Neighbor.Connect": 
				case "NetGroup.Neighbor.Disconnect":
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