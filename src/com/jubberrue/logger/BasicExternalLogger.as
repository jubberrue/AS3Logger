package com.jubberrue.logger
{
	
	import flash.external.ExternalInterface;

	
	public class BasicExternalLogger extends LoggerImpl {
		private var functionName:String = "appendLogMessage";
		public function BasicExternalLogger():void {
			
		}
		
		public override function output(msg:String):void 
		{
			if (ExternalInterface.available) {
				ExternalInterface.call( functionName + "('" + msg + "')");	
			}else {
				trace(msg);
			}
			
			
		}
		
		public function setFunctionName(functionName:String):void{
			this.functionName = functionName;
		}
		
		public function getFunctionName():String{
			return functionName;
		}
	}
}