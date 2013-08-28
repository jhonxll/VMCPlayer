package com.vmc.debug
{
	import flash.events.Event;
	
	public class DebugEvent extends Event
	{
		public static const DEBUG_2_PRINT:String = "print";
		public var info:String = null;
		
		public function DebugEvent(type:String)
		{
			super(DEBUG_2_PRINT,true);
		}
	}
}