package com.vmc.ui
{
	import com.vmc.player.IPlayer;
	import com.vmc.player.PlayerFactory;
	import com.vmc.player.rtmfp.RtmfpPlayer;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.core.UIComponent;
	
	public class VmcVideoDisplay extends UIComponent
	{
		
		private var player:IPlayer;
		private var areaBtn:VideoAreaButton;
		private var autoPlay:Boolean;
		private var showPersist:Boolean = false;
		
		public function VmcVideoDisplay(autop:Boolean = true)
		{
			super();
			autoPlay = autop;
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
			
//			if(!player && (connect2Url!= null){
//				player = PlayerFactory.createPlayer(connect2Url);
//				this.addChild(player);
//			}
			
			if(!areaBtn){
				areaBtn = new VideoAreaButton();
				this.addChild(areaBtn);
				areaBtn.visible = false;
			}
			
			this.addEventListener(MouseEvent.MOUSE_OVER,showControl);
			this.addEventListener(MouseEvent.MOUSE_OUT,hideControl);
			this.addEventListener(MouseEvent.CLICK,togglePlayPause);
		}
		
		public function setUrl(url:String):void{
			if(!player && url!= null){
				player = PlayerFactory.createPlayer(url);
				player.setAutoPlay(autoPlay);
				player.setUrl(url);
				this.addChildAt(player as DisplayObject,0);
			}
		}
		
		public function setAutoPlay(auto:Boolean):void{
			if(!player) throw new Error("There is IPlayer to setAudoPlay.");
			else player.setAutoPlay(auto);
		}
		
		internal function showControl(event:MouseEvent):void{
			if(areaBtn){
				areaBtn.show(true);
			}
		}
		
		internal function hideControl(event:MouseEvent):void{
			if(areaBtn && !showPersist){
				areaBtn.show(false);
			}
		}
		
		internal function togglePlayPause(event:MouseEvent):void{
			if(!player) throw new Error("There is IPlayer to togglePlayPause.");
			if(player.isPlaying()){
				player.pause();
				showPersist = true;
				areaBtn.state = VideoAreaButton.STATE_PLAY;
			}
			else{
				player.play();
				showPersist = false;
				areaBtn.state = VideoAreaButton.STATE_PAUSE;
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
			
			if(player){
				var uiPlayer:UIComponent = player as UIComponent;
				uiPlayer.x = 0;
				uiPlayer.y = 0;
				uiPlayer.setActualSize(unscaledWidth,unscaledHeight);
			}
			
			if(areaBtn){
				var uiControl:UIComponent = areaBtn as UIComponent;
				uiControl.x = 0;
				uiControl.y = 0;
				uiControl.setActualSize(unscaledWidth,unscaledHeight);
			}
			
		}
		
		
	}
}