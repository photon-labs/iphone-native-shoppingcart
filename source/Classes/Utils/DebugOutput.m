/************************************************************************
* DebugOutput.m
*
* Singleton class for wrapping debug messages, adding functionality
* for displaying filename and line numbers. Also includes configuration
* options to "turn off" all debug (debug) messages
************************************************************************/
#import "DebugOutput.h"
#if DEBUG

@implementation DebugOutput

static DebugOutput *sharedDebugInstance = nil;

/*---------------------------------------------------------------------*/
+ (DebugOutput *) sharedDebug
{
  @synchronized(self)
  {
    if (sharedDebugInstance == nil)
    {
      [[self alloc] init];
    }  
  }
  return sharedDebugInstance;
}

/*---------------------------------------------------------------------*/
+ (id) allocWithZone:(NSZone *) zone
{
  @synchronized(self)
  {
    if (sharedDebugInstance == nil)
    {
      sharedDebugInstance = [super allocWithZone:zone];
      return sharedDebugInstance;
    }
  }
  return nil;
}

/*---------------------------------------------------------------------*/
- (id)copyWithZone:(NSZone *)zone
{
  return self;
}

/*---------------------------------------------------------------------*/
- (id)retain
{  
  return self;
}

/*---------------------------------------------------------------------*/
- (void)release
{
  // No action required...
}

/*---------------------------------------------------------------------*/
- (unsigned)retainCount
{
  return UINT_MAX;  // An object that cannot be released
}

/*---------------------------------------------------------------------*/
- (id)autorelease
{ 
  return self;
}

/*---------------------------------------------------------------------*/
+(NSString*)trimString:(NSString*)input length:(int)length
{
	if ([input length] > length) {
		return [NSString stringWithFormat:@"%@...", [input substringToIndex:length-3]];
	}
	return input;
}

/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -*/
+(NSString*)trimMiddleString:(NSString*)input length:(int)length
{
	if ([input length] > length) {
		int front = length/2;
		int end = length-front-3;
		return [NSString stringWithFormat:@"%@...%@", 
					[input substringToIndex:front], 
					[input substringFromIndex:[input length]-end]];
	}
	return input;
}
/*---------------------------------------------------------------------*/
-(void)outputWithFileName:(char*)fileName functionName:(const char*)functionName lineNumber:(int)lineNumber input:(NSString*)input, ...
{
	va_list argList;
	NSString *filePath, *formatStr;

	// Build the path string
	filePath = [NSString stringWithCString:fileName encoding:NSUTF8StringEncoding];

	// Process arguments, resulting in a format string
	va_start(argList, input);
	formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
	va_end(argList);
	
	NSString *functionNameStr = [DebugOutput 
									trimString:[NSString stringWithCString:functionName encoding:NSUTF8StringEncoding]
									length: 58];	// was 45, also changed below -- Narayanan, 08/12/2009
  
	filePath = [DebugOutput 
				 trimMiddleString:(DBG_SHOW_FULLPATH) ? filePath : [filePath lastPathComponent]
				 length: 38];
	
	filePath = [NSString stringWithFormat:@"%@:%d", filePath, lineNumber];
	
	// Call NSLog, prepending the filename and line number
	NSLog(@"%-60s %-40s    %@", [functionNameStr UTF8String], [filePath UTF8String], formatStr);
	
	[formatStr release];
}

-(void)outputToServer: (NSString*)input,...
{
	va_list argList;

	NSString *formatStr;
	
	va_start(argList, input);
	formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
	va_end(argList);
	
	//send log to logging server......
	/*
	[[ConnectionManager sharedConnections] serviceCallWithURL:kServerLogger 
													 httpBody:formatStr
												   httpMethod:@"POST" 
											   callBackTarget:nil 
											 callBackSelector:nil 
												   callBackID:[[ConnectionManager sharedConnections] getCallbackID]];*/
	
	
}
/*---------------------------------------------------------------------*/
-(void)outputBlockText:(NSString*)input, ...
{
	va_list argList;
	NSString *formatStr;
	
	// Process arguments, resulting in a format string
	va_start(argList, input);
	formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
	va_end(argList);
	
	NSString *divLine = @"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$";
	
	NSLog(@"          |%@|",divLine);
	for (int i = 0; i < [formatStr length]; i++)
		{
		if ((i % [divLine length]) == 0)
			{
			NSString *str1 = [NSString stringWithFormat:@"%@",[formatStr substringFromIndex:i]];
			NSString *str2 = [str1 substringToIndex:([str1 length] > [divLine length]) ? [divLine length] : [str1 length]];
			NSLog(@"          |%@|",str2);
			}
		}
	NSLog(@"          |%@|",divLine);
	
	[formatStr release];
}

/*---------------------------------------------------------------------*/
#pragma mark -
/*---------------------------------------------------------------------*/
-(void)outputMemoryStatistics:(char*)fileName functionName:(const char*)functionName lineNumber:(int)lineNumber input:(NSString*)input
	{
	debug2(fileName,functionName,lineNumber,@" ");
	debug2(fileName,functionName,lineNumber,@"        |#### MEMORY STATISTICS #################################");
	debug2(fileName,functionName,lineNumber,@"        | Message: %@",input);
	
//	NSURLCache		*myURLCache = [NSURLCache sharedURLCache];
//	
//	debug2(fileName,functionName,lineNumber,@"        |::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
//	debug2(fileName,functionName,lineNumber,@"        | currentDiskUsage           = %d",[myURLCache currentDiskUsage]);
//	debug2(fileName,functionName,lineNumber,@"        | diskCapacity               = %d",[myURLCache diskCapacity]);
//	debug2(fileName,functionName,lineNumber,@"        |");
//	debug2(fileName,functionName,lineNumber,@"        | currentMemoryUsage         = %d",[myURLCache currentMemoryUsage]);
//	debug2(fileName,functionName,lineNumber,@"        | memoryCapacity             = %d",[myURLCache memoryCapacity]);
	
	NSProcessInfo	*myProcessInfo = [NSProcessInfo processInfo];
	NSUInteger		myRealMemoryAvailable = NSRealMemoryAvailable();
	
	debug2(fileName,functionName,lineNumber,@"        |::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
	debug2(fileName,functionName,lineNumber,@"        | processIdentifier          = %d",[myProcessInfo processIdentifier]);
	debug2(fileName,functionName,lineNumber,@"        | processName                = '%@'",[myProcessInfo processName]);
	debug2(fileName,functionName,lineNumber,@"        |");
	debug2(fileName,functionName,lineNumber,@"        | globallyUniqueString       = '%@'",[myProcessInfo globallyUniqueString]);
	debug2(fileName,functionName,lineNumber,@"        |");
	debug2(fileName,functionName,lineNumber,@"        | NSRealMemoryAvailable()    = %d",myRealMemoryAvailable);
	debug2(fileName,functionName,lineNumber,@"        |########################################################");
	}

@end

#endif