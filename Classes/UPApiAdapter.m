//
//  UPApiAdapter.m
//  instiBot
//
//  Created by Norman Rosner on 04.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPApiAdapter.h"
#import "UPApiAdapterDelegate.h"
#import "Seriously.h"
#import "UPMessagesViewController.h"

@interface UPApiAdapter ()

//- (void)requestUserCredentialsForBotId:(NSString *)theBotId;

- (NSString *)stringForApi:(NSString *)methodName;

@property (nonatomic, readonly) NSString *server;

@property (nonatomic, readonly) NSString *botId;

@property (nonatomic, readonly) NSString *context;

@property (readonly) NSUInteger port;

@end

@implementation UPApiAdapter

@synthesize server, botId, port, context;

@synthesize delegate;

- (id)init {
  self = [super init];
  if (self) {    
    NSString *urlString = [self stringForApi:@"user_credentials"];
    NSLog(@"request: %@", urlString);
		[Seriously get:urlString handler:^(id body, NSHTTPURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
      } else if ( [body isKindOfClass:[NSDictionary class]] ){
        if ( [body objectForKey:@"user_id"] ) {
          userId = [[body objectForKey:@"user_id"] copy];
        }
        if (delegate && [delegate respondsToSelector:@selector(apiAdapterIsReady:)]) {
					[delegate apiAdapterIsReady:self]; 
        }
      }
    }];
  }
  return self;
}

- (void)reuqestResponseForMessage:(NSString *)message {
  if (userId) {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/%@",
                           [self stringForApi:@"respond"],
                           userId,
                           message
                           ];
    NSLog(@"request: %@", urlString);
    [Seriously get:urlString handler:^(id body, NSHTTPURLResponse *response, NSError *error) {
      if (error) {
//				NSLog(@"%@", [error localizedDescription]); 
      } else {
        // create a new reversed array of responses that the delegate understands
        NSArray *responses = [body objectForKey:@"responses"];
        NSMutableArray *simplifiedResponses = [[NSMutableArray alloc] initWithCapacity:[responses count] * 2.0];
        
        for (NSDictionary *qaPair in [responses reverseObjectEnumerator]) {
          NSString *question = [qaPair objectForKey:UPUserKey];
          NSString *answer = [qaPair objectForKey:UPBotKey];
          
          [simplifiedResponses addObject:[NSDictionary dictionaryWithObject:question forKey:UPUserKey]];
          [simplifiedResponses addObject:[NSDictionary dictionaryWithObject:answer forKey:UPBotKey]];
        }
        
        if (delegate && [delegate respondsToSelector:@selector(apiAdapter:didReceiveBotResponses:)]) {
					[delegate apiAdapter:self didReceiveBotResponses:simplifiedResponses]; 
        }
        [simplifiedResponses release];
      }
    }];
  }
}

- (NSString *)server {
  return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UPHostname"];
}

- (NSString *)botId {
  NSString *_botId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UPBotId"];
  if ( !_botId ) {
    _botId = @"";
  }
  return _botId;
}

- (NSString *)context {
  NSString *_context = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UPContext"];
  if ( !_context ) {
    _context = @"";
  }
  return _context;
}

- (NSUInteger )port {
  NSNumber *_port = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UPPort"];
  
  NSUInteger portAsInt = ( !_port ) ? 80 : [_port intValue];
  return portAsInt ;
}

- (NSString *)stringForApi:(NSString *)methodName {
  NSString *thePort = [NSString stringWithFormat:@":%d", self.port];
  NSString *theContext = ( !self.context ) ? [NSString stringWithFormat:@"/%@/", self.context] : @"";
  
  NSString *urlString = [NSString stringWithFormat:@"%@%@%@/api/bot/%@/%@", 
                         self.server, 
                         thePort, 
                         theContext, 
                         methodName,
                         self.botId];
  return urlString;
}

- (void)dealloc {
  [userId release];
  userId = nil;
      
  delegate = nil;
	[super dealloc]; 
}
@end
