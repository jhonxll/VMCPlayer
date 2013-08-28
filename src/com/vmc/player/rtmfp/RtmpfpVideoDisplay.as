package com.vmc.player.rtmfp
{
	import com.vmc.debug.Logger;
	import com.vmc.player.IPlayer;
	
	import flash.events.Event;
	
	import mx.core.UIComponent;
	
	public class RtmpfpVideoDisplay extends UIComponent implements IPlayer
	{
		private static const TAG:String = "RtmpfpVideoDisplay";
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
			Logger.info(TAG,"createChildren");
			this.addEventListener(VideoEvent.SIZECHANGED,onVideoSizeChanged);
		}
		
		override protected function measure():void
		{
			// TODO Auto Generated method stub
			super.measure();
		}
		
		private function onVideoSizeChanged(event:Event):void{
			Logger.info(TAG,"Rtmfpvideo's size has changed.");
			this.invalidateDisplayList();
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			// TODO Auto Generated method stub
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			graphics.clear();
			graphics.beginFill(0x000000, 0.5);
			graphics.drawRect(0, 0, unscaledWidth, unscaledWidth);
			
			if(player){
				
				var w = unscaledWidth;
				var h = unscaledHeight;
				// Video size.
				var vw:Number = player.videoWidth;
				var vh:Number = player.videoHeight;
				
				var px:Number = 0;
				var py:Number = 0;
				
				if (vw > 0 && vh > 0)
				{
					// 'maintainAspectRatio' is true but explicit width and height have
					// also been set.  Try to fit the video in the available space,
					// while maintaining the aspect ratio.
					
					var rw:Number = w / vw;
					var rh:Number = h / vh;
					
					if (rw < rh)
					{
						// Adjust height.
						h = w * vh / vw;
						py = (unscaledHeight - h) / 2;
					}
					else if (rh < rw)
					{
						// Adjust width.
						w = h * vw / vh;
						px = (unscaledWidth - w) / 2;
					}
				}
				
				player.x = px;
				player.y = py;
				
				player.width = w;
				player.height = h;
				
			}
		}
		
		public function setUrl(url:String):void{
			if(player)
				player.setPlayUrl(url);
			else{
				player = new RtmfpPlayer();
				addChild(player);
				player.setPlayUrl(url);
			}
		}
		
		public function start():void{
			
		}
		
		public function seek(time:Number):void{
			
		}
		
		public function pause():void{
			if(player)
				player.pause();
		}
		
		public function play():void{
			if(player)
				player.play();
		}
		
		public function isPlaying():Boolean{
			if(!player)
				throw new Error("There is no RtmfpVideoPlayer to get isPlaying.");
			return player.isPlaying();
			
		}
		
		public function stop():void{
			
		}
		
		public function setAutoPlay(auto:Boolean):void{
			if(player)
				player.setAutoPlay(auto);
		}
		
		public function fullScreen(yes:Boolean):void{
			
		}
		
		public function setVolume(volume:int):void{
			
		}
		
		public function mute(yes:Boolean):void{
			
		}
	}
}