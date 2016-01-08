//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDNetworkProxy.h"
#import "DDSocketProtocol.h"
#import "DDWebsocketImpl.h"



@interface DDNetworkProxy (){

}

@property (nonatomic, strong) id<DDSocketProtocol> socket;
@property (nonatomic, strong) NSString *urlAddr;


@end

@implementation DDNetworkProxy {
    BOOL _isConnected;
}

+ (DDNetworkProxy *)getInstance {
    static DDNetworkProxy *proxy;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        proxy = [DDNetworkProxy new];
    });
    return proxy;
}

- (instancetype)init {
    self = [super init];
    if (self){
        _isConnected = NO;
    }
    return self;
}

#pragma mark -Config method

- (void)setUrl:(NSString *)url{
    self.urlAddr = url;
}


#pragma mark -event method

- (void)send:(NSData *)data {

}

- (void)connect {
    [self close];

    self.socket = [DDWebsocketImpl new];
    [self.socket setConnectUrl:self.urlAddr];
    [self.socket setRpcDel:self];
    [self.socket open];
}

- (void)close {
    if (self.socket){
        [self.socket close];
        [self.socket setRpcDel:nil];
    }
}

#pragma mark -DDRpcProtocol

- (void)didConnectToHost:(NSString *)hostAddr port:(NSString *)port {
    _isConnected = YES;
}

- (void)didFailConnectToHost:(NSString *)hostAddr port:(NSString *)port andError:(NSError *)error {
    _isConnected = NO;
}

- (void)didCloseConnectToHost:(NSString *)hostAddr port:(NSString *)port {
    _isConnected = NO;
}

- (void)didReceivedMessage:(NSData *)msg {
    [[NSNotificationCenter defaultCenter] postNotificationName:SocketNotif_Received object:msg];
}
@end