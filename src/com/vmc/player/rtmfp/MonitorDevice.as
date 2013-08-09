package com.vmc.player.rtmfp
{
	public class MonitorDevice
	{
		private ownerName:String = "";
		private deviceName:String = "";
		private macAddress:String = "";
		private peerID:String = "";
		
		public function MonitorDevice()
		{
		}
		
		public function get ownerName():String{
			if(ownerName == null || ownerName.length == 0){
				throw new Error("The ownerName is null.");
			}
			return ownerName;
		}
		
		public function set ownerName(oname:String):void{
			ownerName = oname;
		}
		
		public function get deviceName():String{
			if(deviceName == null || deviceName.length == 0){
				throw new Error("The deviceName is null.");
			}
			return deviceName;
		}
		
		public function set deviceName(dName:String):void{
			deviceName = dName;
		}
	}
}