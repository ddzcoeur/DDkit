//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DDScoketCallBack <NSObject>


- (void)didRequestSuccess:(NSData *)rspData;
- (void)onCallFail:(NSData *)rspData errorCode:(int)error;

@end