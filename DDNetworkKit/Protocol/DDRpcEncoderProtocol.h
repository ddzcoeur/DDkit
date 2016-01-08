//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDRpcRequest.h"

@protocol DDRpcEncoderProtocol <NSObject>


- (void)encodeRequest:(DDRpcRequest *)request method:(NSString *)method content:(NSData *)content;

@end