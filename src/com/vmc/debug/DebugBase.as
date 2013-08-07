package com.vmc.debug
{
	public class DebugBase
	{
		internal var type:int;
		internal var enabel:Boolean =true;
		
		public function DebugBase()
		{
		}
		
		public function debug(info:String):void{
			
		}
		
		public function enabelDebug(en:Boolean):void{
			enabel = en;
		}
	}
}