package com.vmc.debug
{
	public class DebugCommon extends DebugBase
	{
		public static const COMMONDEBUG:DebugCommon = null;
		
		public function DebugCommon()
		{
			this.type = DebugFactory.DEBUG_TYPE_COMMON;
		}
		
		public override function debug(info:String):void{
			if(this.enabel){
				trace(info);
			}
		}
		
		public static function getInstance():DebugCommon{
			if(!COMMONDEBUG){
				COMMONDEBUG = new DebugCommon(DebugFactory.DEBUG_TYPE_COMMON);
			}
			return COMMONDEBUG;
		}
	}
}