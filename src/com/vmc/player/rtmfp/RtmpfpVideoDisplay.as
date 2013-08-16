package com.vmc.player.rtmfp
{
	import com.vmc.player.IPlayer;
	import mx.core.UIComponent;
	
	public class RtmpfpVideoDisplay extends UIComponent implements IPlayer
	{
		
		private var player:RtmfpPlayer;
		
		public function RtmpfpVideoDisplay()
		{
			super();
		}
		
		override protected function commitProperties():void
		{
			// TODO Auto Generated method stub
			super.commitProperties();
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			
			if(!player){
				player = new RtmfpPlayer();
				addChild(player);
			}
		}
		
		override protected function measure():void
		{
			// TODO Auto Generated method stub
			super.measure();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			// TODO Auto Generated method stub
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			graphics.clear();
			graphics.beginFill(0x00ff00, 0.5);
			graphics.drawRect(0, 0, unscaledWidth, unscaledWidth);
			
			if(player){
				player.width = unscaledWidth;
				player.height = unscaledHeight;
				
				player.x = 0;
				player.y = 0;
			}
		}
		
		public function start():void{
			
		}
		
		public function seek(time:Number):void{
			
		}
		
		public function pause():void{
			
		}
		
		public function stop():void{
			
		}
		
		public function fullScreen(yes:Boolean):void{
			
		}
		
		public function setVolume(volume:int):void{
			
		}
		
		public function mute(yes:Boolean):void{
			
		}
	}
}