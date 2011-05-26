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

@end

@implementation UPApiAdapter

static NSString *MY_SERVER = @"http://localhost:58080/api";

static NSString *BOT_ID = @"fe64a45a9e346bff";

@synthesize delegate;

- (id)init {
  self = [super init];
  if (self) {
    NSString *urlString = [NSString stringWithFormat:@"%@/bot/user_credentials/%@", MY_SERVER, BOT_ID];
		[Seriously get:urlString handler:^(id body, NSHTTPURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"Error: %@", [error localizedDescription]);
      } else {
				userId = [[body objectForKey:@"user_id"] copy];
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
    NSString *urlString = [NSString stringWithFormat:@"%@/bot/respond/%@/%@/%@", MY_SERVER, BOT_ID, userId, message];
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

- (void)dealloc {
  [userId release];
  userId = nil;
      
  delegate = nil;
	[super dealloc]; 
}
@end
