//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDRpcProtocol.h"

@class DDRpcReuqest;

@protocol DDSocketProtocol <NSObject>

- (void)setRpcDel:(id<DDRpcProtocol>)del;

- (void)setConnectUrl:(NSString *)url andPort:(NSString *)port;


- (void)open;

- (void)close;

- (void)sendRequest:(DDRpcReuqest *)req;

@optional
- (void)reconnect;

- (void)setConnectTimeOut:(int)timeOutValue;

@end