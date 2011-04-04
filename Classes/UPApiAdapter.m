//
//  UPApiAdapter.m
//  instiBot
//
//  Created by Norman Rosner on 04.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import "UPApiAdapter.h"
#import "UPApiAdapterDelegate.h"

@implementation UPApiAdapter

@synthesize delegate;

- (id)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (void)dealloc {
  [userId release];
  userId = nil;
  
  [botId release];
  botId = nil;
  
  [server release];
  server = nil;
  
  delegate = nil;
	[super dealloc]; 
}
@end
