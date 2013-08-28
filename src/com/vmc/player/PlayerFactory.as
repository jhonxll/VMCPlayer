package com.vmc.player
{
	import com.vmc.player.rtmfp.RtmpfpVideoDisplay;

	public class PlayerFactory
	{
		
		public function PlayerFactory()
		{
		}
		
		public static function createPlayer(url:String):IPlayer{
			var protocol:String = url.substring(0,url.indexOf(":",0));
			var player:IPlayer;
			if(protocol.localeCompare("rtmfp") == 0){
				player = new RtmpfpVideoDisplay();
			}
			else if(protocol.localeCompare("rtmp")==0){
				
			}
			return player;
		}
	}
}