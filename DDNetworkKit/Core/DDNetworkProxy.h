//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDRpcProtocol.h"


#define SocketNotif_Received @"socketnotif_receivedata"
#define SocketNotif_Connect_Connected @"socket_connected"
#define SocketNotif_Connect_Close @"socket_connect_close"
#define SocketNotif_Connect_Succ @"socket_connect_succ"
#define SocketNotif_Connect_Fail @"socket_connect_fail"


@interface DDNetworkProxy : NSObject<DDRpcProtocol>

+ (DDNetworkProxy *)getInstance;

- (void)setUrl:(NSString *)url;
- (void)connect;
- (void)close;

- (void)send:(NSData *)data;


- (BOOL)isConnected;


@end