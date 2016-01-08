//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDRpcProtocol.h"


#define SocketNotif_Received @"socketnotif_receivedata"


@interface DDNetworkProxy : NSObject<DDRpcProtocol>

+ (DDNetworkProxy *)getInstance;

- (void)setUrl:(NSString *)url;
- (void)connect;
- (void)close;

- (void)send:(NSData *)data;


- (BOOL)isConnected;


@end