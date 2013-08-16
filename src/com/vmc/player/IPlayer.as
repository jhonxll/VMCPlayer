package com.vmc.player
{
	public interface IPlayer
	{
//		public static const EVENT_PLAYER_START:String = "start";
//		public static const EVENT_PLAYER_SEEK:String = "seek";
//		public static const EVENT_PLAYER_PAUSE:String = "pause";
//		public static const EVENT_PLAYER_STOP:String = "stop";
//		public static const EVENT_PLAYER_FULLSCREEN:String = "fullscreen";
//		public static const EVENT_PLAYER_SETVOLUME:String = "setvolume";
//		public static const EVENT_PLAYER_MUTE:String = "mute";
		
		function start():void;
		
		function seek(time:Number):void;
		
		function pause():void;
		
		function stop():void;
		
		function fullScreen(yes:Boolean):void;
		
		function setVolume(volume:int):void;
		
		function mute(yes:Boolean):void;
	}
}