package com.vmc.player.rtmfp
{
	import flash.events.Event;
	
	public class VideoEvent extends Event
	{
		
		public static const SIZECHANGED:String = "sizechanged";
		
		public function VideoEvent(type:String)
		{
			super(type,true);
		}
	}
}