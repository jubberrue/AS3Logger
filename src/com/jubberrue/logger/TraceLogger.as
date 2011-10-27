package com.jubberrue.logger
{
	public class TraceLogger extends LoggerImpl
	{
		public function TraceLogger()
		{
			super();
		}
		
		public override function output(msg:String):void 
		{
			trace(msg);
		}
	}
}