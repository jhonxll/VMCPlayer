package com.vmc.player.rtmfp
{
	import flash.media.Video;
	
	
	public class RtmfpPlayer extends Video
	{
		private serverUrl:String = "";
		private connect2Peer:String ="";
		
		
		public function RtmfpPlayer(width:int=320, height:int=240)
		{
			super(width, height);
		}
		
		
	}
}