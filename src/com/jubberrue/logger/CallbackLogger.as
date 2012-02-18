package com.jubberrue.logger
{
	public class CallbackLogger extends LoggerImpl
	{
		private var callback:Function;
		
		public function CallbackLogger()
		{
			super();
		}
		
		public override function output(msg:String):void{
			callback(msg);
		}
		
		public function setCallback(callback:Function){
			this.callback = callback;
		}
		
		public function getCallback():Function{
			return this.callback;
		}
		
	}
}