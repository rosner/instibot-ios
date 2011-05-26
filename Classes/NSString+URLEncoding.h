//
//  NSString+URLEncoding.h
//  instiBot
//
//  Created by Norman Rosner on 05.04.11.
//  Copyright 2011 Norman Rosner. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (URLEncoding)

+ (NSString *)stringByURLEncoding:(NSString *)stringToBeEncoded;

@end
