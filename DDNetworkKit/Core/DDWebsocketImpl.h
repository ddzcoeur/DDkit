//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket/SRWebSocket.h>
#import "DDSocketProtocol.h"

@interface DDWebsocketImpl : NSObject <DDSocketProtocol,SRWebSocketDelegate>

@end