package com.vmc.ui
{
	import mx.core.UIComponent;
	import com.vmc.player.rtmfp.RtmfpPlayer;
	
	public class VmcVideoDisplay extends UIComponent
	{
		
		private player:RtmfpPlayer;
		private areaBtn:VideoAreaButton;
		
		public function VmcVideoDisplay()
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
		}
		
		
	}
}