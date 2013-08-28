package com.vmc.ui
{
	import flash.display.Bitmap;
	import mx.core.UIComponent;
	import spark.components.Image;
	import com.vmc.debug.Logger;
	
	
	public class VideoAreaButton extends UIComponent
	{
		private static const TAG:String = "VideoAreaButton";
		
		public static const STATE_PLAY:Number = 1;
		public static const STATE_PAUSE:Number = 0;
		
		
		[Bindable]
		[Embed(source="../../../../assets/images/pause.png")] 
		var pausePath:Class;  
		
		[Bindable]
		[Embed(source="../../../../assets/images/play.png")] 
		var playPath:Class;  
		
		var imgPlay:Image;
		var imgPause:Image;
		private var _state:Number = STATE_PAUSE;
		
		public function VideoAreaButton()
		{
			super();
		}
		
		public function get state():Number
		{
			return _state;
		}

		public function set state(value:Number):void
		{
			_state = value;
			this.invalidateDisplayList();
		}
		
		override protected function commitProperties():void
		{
			// TODO Auto Generated method stub
			super.commitProperties();
			
		}
		
		public function show(en:Boolean):void{
			if(this.visible != en){
				this.visible = en;
			}
			this.invalidateDisplayList();
		}
		
		override protected function createChildren():void
		{
			// TODO Auto Generated method stub
			super.createChildren();
			
			imgPlay = new Image();
			imgPause = new Image();
			imgPlay.source = playPath;
			imgPause.source = pausePath;
			addChild(imgPlay);
			addChild(imgPause);
			
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
			graphics.beginFill(0x000000, 0.2);
			graphics.drawRect(0, 0, unscaledWidth, unscaledWidth);
			
			var image:Image
			if(state == STATE_PLAY){
				image = imgPlay;
				imgPlay.visible = true;
				imgPause.visible = false;
			}
			else{
				image = imgPause;
				imgPlay.visible = false;
				imgPause.visible = true;
			}
			
			image.setActualSize(128,128);
			image.x = (unscaledWidth - image.width)/2;
			image.y = (unscaledHeight - image.height)/2;
		}
		
		private function printSize():void{
			Logger.info(TAG,"width="+width+",height="+height);
			Logger.info(TAG,"scaleX="+this.scaleX+",scaleY="+scaleY);
		}
	}
}