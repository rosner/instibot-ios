//
//  UPApiAdapterDelegate.h
//  instiBot
//
//  Created by Norman Rosner on 04.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UPApiAdapter;

@protocol UPApiAdapterDelegate <NSObject>


@optional

- (void)apiAdapterIsReady:(UPApiAdapter *)apiAdapter;

- (void)apiAdapter:(UPApiAdapter *)apiAdapter didReceiveBotResponses:(NSArray *)responses;

@end
