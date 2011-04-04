//
//  UPApiAdapter.h
//  instiBot
//
//  Created by Norman Rosner on 04.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UPApiAdapterDelegate;

@interface UPApiAdapter : NSObject {
	
  @private 
  NSString *userId;
  
  NSString *botId;
  
  NSString *server;

  id<UPApiAdapterDelegate> delegate;
}

@property (nonatomic, assign) id<UPApiAdapterDelegate> delegate;

@end
