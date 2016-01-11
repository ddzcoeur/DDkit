//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDNetworkProxy.h"
#import "DDSocketProtocol.h"
#import "DDWebsocketImpl.h"
#import "DDRpcDecoderProtocol.h"
#import "DDRpcEncoderProtocol.h"
#import "DDRpcDecoderImpl.h"
#import "DDRpcEncoderImpl.h"
#import "DDRpcHBRequest.h"
#import "DDSocketConfig.h"


@interface DDNetworkProxy (){

}

@property (nonatomic, strong) id<DDSocketProtocol> socket;
@property (nonatomic, strong) DDSocketConfig *config;


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
        self.config = [DDSocketConfig new];
    }
    return self;
}

#pragma mark -Config method

- (void)setUrl:(NSString *)url{
    self.config.urlAddr = url;
}


#pragma mark -event method

- (void)send:(NSData *)data {
    if (_isConnected){
        DDRpcRequest *req = [DDRpcRequest new];
        id<DDRpcEncoderProtocol> encoder = [DDRpcEncoderImpl new];
        [encoder encodeRequest:req method:DDRpcDefine_Method_Request content:data];
        [self.socket sendRequest:req];
    } else{
        [self.socket reconnect];
    }
}

- (void)sendAck:(int)ackid{

}

- (void)sendHb{
    DDRpcHBRequest *hbRequest = [DDRpcHBRequest new];
    id<DDRpcEncoderProtocol> encoder = [DDRpcEncoderImpl new];
    NSString *token = self.config.token;
    NSData *tokenData = [token dataUsingEncoding:NSUTF8StringEncoding];
    [encoder encodeRequest:hbRequest method:DDRpcDefine_Method_Hb content:tokenData];
    [self.socket sendHbRequest:hbRequest];
}

- (void)connect {
    [self close];
    self.socket = [DDWebsocketImpl new];
    [self.socket setConnectUrl:self.config.urlAddr];
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
    // decode msg
    id<DDRpcDecoderProtocol> decoder = [DDRpcDecoderImpl new];
    @try {
        NSDictionary *dataDic = [decoder decodeFromData:msg];
        NSNumber *typeValue = [dataDic objectForKey:@"type"];
        if ([typeValue intValue] == RPCNOTIFREQUEST){
            //TODO send ack request
        } else if ([typeValue intValue] == RPCNOTIFREQUEST){
            //send content to app

            NSData *content = [dataDic objectForKey:@"content"];
            [[NSNotificationCenter defaultCenter]
                    postNotificationName:SocketNotif_Received object:content];
        } else if ([typeValue intValue] == RPCACKRESPONSE){

        } else if([typeValue intValue]==RPCRESPONSE){

        } else{
            //TODO post error
        }
    } @catch(NSException *ex){
        //TODO post error
        return;
    }
}

- (void)didReceivedHBMessage:(NSData *)msg {

}
@end