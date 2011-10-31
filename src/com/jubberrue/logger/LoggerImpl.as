/*	Written by Josiah Wong : jo_b_there@hotmail.com

	Licensed under the MIT (http://www.opensource.org/licenses/mit-license.php)
*/
package com.jubberrue.logger
{	
	import flash.utils.Dictionary;
	
	public class LoggerImpl implements Logger {
		//logging levels
		public static const NONE:int = 0;	//00000
		public static const DEBUG:int = 1;	//00001
		public static const INFO:int = 2;	//00010
		public static const WARN:int = 4;	//00100
		public static const ERROR:int = 8;	//01000
		public static const FATAL:int = 16;	//10000
		
		//setup rules for each logging level
		private static const DEBUG_RULE:int = DEBUG | INFO | WARN | ERROR | FATAL;
		private static const INFO_RULE:int = INFO | WARN | ERROR | FATAL;
		private static const WARN_RULE:int = WARN | ERROR | FATAL;
		private static const ERROR_RULE:int = ERROR | FATAL;
		private static const FATAL_RULE:int = FATAL;
		private static var loggerRules:Dictionary = new Dictionary();
		
		private static var loggers : Array = new Array();
		private static var defaultLogger:Logger;
		private static var defaultLoggerId:Class;
		private var loggingLevel : int = DEBUG;
		
		
		init();
		private static function init():void{
			loggerRules[DEBUG] = DEBUG_RULE;
			loggerRules[INFO] = INFO_RULE;
			loggerRules[WARN] = WARN_RULE;
			loggerRules[ERROR] = ERROR_RULE;
			loggerRules[FATAL] = FATAL_RULE;
		}
		
		/*@TODO setup logger selection functionality
		 * */
		public static function getLogger(id:Class = null):Logger {
				if (loggers.length == 0) {
					addLogger(BasicExternalLogger, new BasicExternalLogger());
					addLogger(TraceLogger, new TraceLogger());
				}
				
				var logger:Logger;
				
				if(id == null){
					logger = getDefaultLogger();
				}else{
					logger = loggers[id];
					
					if(logger == null){
						logger = getDefaultLogger();
						logger.error("Log id : " + id + " does not exist");
					}
				}
				
				return logger;
		}
		
		final public function debug(msg:String):void {
			if (isCorrectLevel(DEBUG)) {
				writeLog(msg, "DEBUG");
			}
		}
		
		final public function info(msg:String):void {
			if (isCorrectLevel(INFO)) {
				writeLog(msg, "INFO");
			}
		}
		
		final public function warn(msg:String):void {
			if (isCorrectLevel(WARN)) {
				writeLog(msg, "WARN");
			}
		}
		
		final public function error(msg:String):void {
			if (isCorrectLevel(ERROR)) {
				writeLog(msg, "ERROR");
			}
		}
		
		final public function fatal(msg:String):void {
			if (isCorrectLevel(FATAL)) {
				writeLog(msg, "FATAL");
			}
		}
		
		/**
		 * Determines if at the current logging level should the logger output the message that is from the target level
		 * @param	targetLevel : logging level
		 * @return boolean
		 */
		private function isCorrectLevel(targetLevel:int):Boolean {
			var currentLevel:int = getLevel();
			var rule:int = getLoggingRule(currentLevel);
			
			if (targetLevel & rule && currentLevel != NONE) {
				return true;
			}else {
				return false;
			}
		}
		
		private function writeLog(msg:String, type:String):void {
			output(formatMessage(msg, type));
		}
		
		private function formatMessage(msg:String, type:String):String {
			var date:Date = new Date();
			var dateString:String = date.toString();
			
			return dateString + "  [" + type + "] : " + msg;
		}
		
		/*Override this method when creating a new logger.
		 * */
		public function output(msg:String):void {
			trace(msg);
		}
		
		public function setLevel(level:int):void {
			this.loggingLevel = level;
		}
		
		public function getLevel():int {
			return this.loggingLevel;
		}
		
		private function getLoggingRule(level:int):int {
			return loggerRules[level];
		}
		
		public static function addLogger(key:Object, logger:Logger):void {
			loggers[key] = logger;
		}
		
		public static function setDefaultLoggerId(logId:Class):void{
			if(logId != null){
				defaultLoggerId = logId;
				defaultLogger = null;
			}
			
		}
		
		private static function setDefaultLogger(defLog:Logger):void{
			defaultLogger  = defLog;
		}
		
		private static function getDefaultLogger():Logger{
			if(defaultLogger != null){
				return defaultLogger;
			}
			
			if(defaultLoggerId != null){
				setDefaultLogger(getLogger(defaultLoggerId));
			}
			
			if(defaultLogger == null){
				setDefaultLogger(getLogger(TraceLogger));
			}
			
			return defaultLogger;
			
		}
	}
}