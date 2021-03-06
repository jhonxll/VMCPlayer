package com.vmc.debug
{
	import flash.events.EventDispatcher;

	public class Logger extends EventDispatcher
	{
		
		private static const TYPE_INFO:Number = 0;
		private static const TYPE_WARN:Number = 1;
		private static const TYPE_ERROR:Number = 2;
		
		private static var logger:Logger = new Logger();
		
		public function Logger()
		{
		}
		
		public static function warn(tag:String,message:String):void{
			log(TYPE_WARN,tag,message);
		}
		
		public static function info(tag:String,message:String):void{
			log(TYPE_INFO,tag,message);
		}
		
		public static function error(tag:String,message:String):void{
			log(TYPE_ERROR,tag,message);
		}
		
		private static function log(type:Number,tag:String,message:String):void{
			trace(tag+"   ",message);
			var de:DebugEvent = new DebugEvent(DebugEvent.DEBUG_2_PRINT);
			de.info = tag+"   "+message;
//			de.info += "event="+de.toString();
//			de.info += "event.target="+de.target;
			logger.dispatchEvent(de);
		}
		
		public static function callback(func:Function):void{
//			logger.addEventListener(DebugEvent.DEBUG_2_PRINT,func);
			logger.addEventListener(DebugEvent.DEBUG_2_PRINT,func);
		}
	}
}