package com.vmc.debug
{
	public class DebugFactory
	{
		public static const DEBUG_TYPE_COMMON:int = 0x001;
		public static const DEBUG_TYPE_VIDEO:int = 0x002;
		
		public function DebugFactory()
		{
		}
		
		public static function debug(type:int,info:String):void{
			if((type & DEBUG_TYPE_COMMON) == DEBUG_TYPE_COMMON){
				DebugCommon.getInstance().debug(info);
			}
		}
		
		public static function debugEnable(type:int,enabel:Boolean):void{
			
		}
	}
}