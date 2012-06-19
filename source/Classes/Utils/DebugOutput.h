/*
 * ###
 * PHR_IphoneNative
 * %%
 * Copyright (C) 1999 - 2012 Photon Infotech Inc.
 * %%
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ###
 */
/************************************************************************
 * DebugOutput.h
 *
 * Definitions for DebugOutput class
 ************************************************************************/

// Enable debug (debug) wrapper code?
#define MINI_DEBUG					0	// Must be 0 for production code, may be 1 when other DEBUG is set to 0 for less output
#define DEBUG						0	// Must be 0 for production code
#define JS_DEBUG					0	// Must be 0 for production code

#define TEMPORARY_BYPASS			0	// Just for R&D - Do not ship with this around shipping code

// Show full path of filename?
#define DBG_SHOW_FULLPATH			NO

// Values or limits
#define DBG_STR_DISPLAY_LIMIT		512	// length of strings to show in debug log (was 400)

#if DEBUG

#define logToServer(format,...) [[DebugOutput sharedDebug] outputToServer: (format), ##__VA_ARGS__]
#define debug(format,...) [[DebugOutput sharedDebug] outputWithFileName:__FILE__ functionName:__PRETTY_FUNCTION__ lineNumber:__LINE__ input:(format), ##__VA_ARGS__]
#define debugtext(format,...) [[DebugOutput sharedDebug] outputBlockText:(format)]
#define debugmemstats(msgstr) [[DebugOutput sharedDebug] outputMemoryStatistics:__FILE__ functionName:__PRETTY_FUNCTION__ lineNumber:__LINE__ input:(msgstr)]
#define debug2(p1,p2,p3,format,...) [[DebugOutput sharedDebug] outputWithFileName:p1 functionName:p2 lineNumber:p3 input:(format), ##__VA_ARGS__]

@interface DebugOutput : NSObject
{
}
+ (DebugOutput *) sharedDebug;
-(void)outputToServer:(NSString*)input,...;
-(void)outputWithFileName:(char*)fileName functionName:(const char*)functionName lineNumber:(int)lineNumber input:(NSString*)input, ...;
-(void)outputBlockText:(NSString*)input, ...;
-(void)outputMemoryStatistics:(char*)fileName functionName:(const char*)functionName lineNumber:(int)lineNumber input:(NSString*)input;
@end

#else
#define debug(format,...) 
#define debugmemstats(msgstr) 
#endif

#if DEBUG
	#define mini_dbg	debug
#else
	#if MINI_DEBUG
		#define mini_dbg	NSLog
	#else
		#define mini_dbg
	#endif
#endif
