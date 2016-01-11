//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDWebsocketImpl.h"
#import "DDRpcRequest.h"
#import "DDRpcHBRequest.h"
#import "NSString+DDSubString.h"

#define DDSocketQueueSpecific "com.ddzkit.websocketqueue"

@interface DDWebsocketImpl(){
    dispatch_queue_t _socketQueue;
}

@property (nonatomic, strong) NSString *mUrlAddr;
@property (nonatomic, weak) id<DDRpcProtocol>rpcDelegate;
@property (nonatomic, strong) SRWebSocket *webSocket;
@property (nonatomic) int timeout;

@end

@implementation DDWebsocketImpl {

}

- (id)init {
    self = [super init];
    if (self){
        self.timeout = 10;
        _socketQueue = dispatch_queue_create(DDSocketQueueSpecific,DISPATCH_QUEUE_SERIAL);
        dispatch_queue_set_specific(_socketQueue,DDSocketQueueSpecific,DDSocketQueueSpecific,NULL);
    }
    return self;
}

- (void)setConnectUrl:(NSString *)url {
    self.mUrlAddr = url;


    if(self.webSocket){
        self.webSocket.delegate = nil;
        [self.webSocket close];
    }

    NSString *urlStr = [NSString stringWithFormat:@"%@",url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];

    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:request protocols:nil allowsUntrustedSSLCertificates:YES];
    [self.webSocket setDelegateDispatchQueue:_socketQueue];
    [self.webSocket setDelegate:self];

}

- (void)setConnectTimeOut:(int)timeOutValue {
    self.timeout = timeOutValue;
}

- (void)setRpcDel:(id <DDRpcProtocol>)del {
    if (del){
        self.rpcDelegate = del;
    }

}

- (void)open {
    if(self.webSocket){
        [self.webSocket open];
    }
}

- (void)close {
    if(self.webSocket){
        [self.webSocket close];
    }
}

- (void)reconnect {
    if(self.webSocket){
        self.webSocket.delegate = nil;
        [self.webSocket close];
    }

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL
            URLWithString:[NSString
                    stringWithFormat:@"%@",self.mUrlAddr]]];
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:request protocols:nil allowsUntrustedSSLCertificates:YES];
    [self.webSocket setDelegateDispatchQueue:_socketQueue];
    [self.webSocket setDelegate:self];
}

- (void)sendRequest:(DDRpcRequest *)req {
    NSData *data = [req convertToData];
    if (self.webSocket){
        [self.webSocket send:data];
    }
}

- (void)sendHbRequest:(DDRpcHBRequest *)req {
    NSData *pingData = [req convertToData];
    if (self.webSocket){
        [self.webSocket sendPing:pingData];
    }
}


#pragma mark -SRDelegate
- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    NSString *url = [webSocket.url absoluteString];
    NSArray *urlArray = [url separateWithString:@":"];
    NSString *port = [urlArray lastObject];
    NSString *subhost = [url substringWithString:port];
    NSString *host = [subhost substringToIndex:subhost.length-1];
    if (self.rpcDelegate && [self.rpcDelegate
            respondsToSelector:@selector(didConnectToHost:port:)]){
        [self.rpcDelegate didConnectToHost:host port:port];
    }

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSString *url = [webSocket.url absoluteString];
    NSArray *urlArray = [url separateWithString:@":"];
    NSString *port = [urlArray lastObject];
    NSString *subhost = [url substringWithString:port];
    NSString *host = [subhost substringToIndex:subhost.length-1];
    if (self.rpcDelegate && [self.rpcDelegate
            respondsToSelector:@selector(didFailConnectToHost:port:andError:)]){
        [self.rpcDelegate didFailConnectToHost:host port:port andError:error];
    }
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    if (self.rpcDelegate && [self.rpcDelegate respondsToSelector:@selector(didReceivedMessage:)]){
        if ([message isKindOfClass:[NSString class]]){
            NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
            [self.rpcDelegate didReceivedMessage:data];
        } else if ([message isKindOfClass:[NSData class]]){
            [self.rpcDelegate didReceivedMessage:message];
        }
    }
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    if ([webSocket.url isEqual:self.webSocket.url]){
        [self.webSocket close];
    }
    NSLog(@"WebSocket closed");

}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"Websocket received pong");
    if ([self.rpcDelegate respondsToSelector:@selector(didReceivedHBMessage:)]){
        [self.rpcDelegate didReceivedHBMessage:pongPayload];
    }
}


@end