/*	Written by Josiah Wong : jo_b_there@hotmail.com

	Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
*/
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