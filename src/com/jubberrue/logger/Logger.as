/*	Written by Josiah Wong : jo_b_there@hotmail.com

	Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
*/
package com.jubberrue.logger
{
	
	public interface Logger {
		function debug(msg:String):void;
		function info(msg:String):void;
		function warn(msg:String):void;
		function error(msg:String):void;
		function fatal(msg:String):void;
		function setLevel(level:int):void;
		function getLevel():int;
		function output(msg:String):void;
	}
}