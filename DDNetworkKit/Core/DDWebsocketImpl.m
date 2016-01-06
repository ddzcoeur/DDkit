//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDWebsocketImpl.h"
#import "DDRpcReuqest.h"
#import "NSString+DDSubString.h"

@interface DDWebsocketImpl()

@property (nonatomic, strong) NSString *mUrlAddr;
@property (nonatomic, strong) NSString *mPort;
@property (nonatomic, weak) id<DDRpcProtocol>rpcDel;
@property (nonatomic, strong) SRWebSocket *webSocket;
@property (nonatomic) int timeout;

@end

@implementation DDWebsocketImpl {

}

- (id)init {
    self = [super init];
    if (self){
        self.timeout = 10;
    }
    return self;
}

- (void)setConnectUrl:(NSString *)url andPort:(NSString *)port {
    self.mUrlAddr = url;
    self.mPort = port;

    if(self.webSocket){
        self.webSocket.delegate = nil;
        [self.webSocket close];
    }

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@:%@",url,port]]];

    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:request protocols:nil allowsUntrustedSSLCertificates:YES];
    [self.webSocket setDelegate:self];

}

- (void)setConnectTimeOut:(int)timeOutValue {
    self.timeout = timeOutValue;
}

- (void)setRpcDel:(id <DDRpcProtocol>)del {
    self.rpcDel = del;
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

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@:%@",self.mUrlAddr,self.mPort]]];

    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:request protocols:nil allowsUntrustedSSLCertificates:YES];
    [self.webSocket setDelegate:self];
}

- (void)sendRequest:(DDRpcReuqest *)req {
    NSData *data = [req convertToData];
    if (self.webSocket){
        [self.webSocket send:data];
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
    if (self.rpcDel && [self.rpcDel respondsToSelector:@selector(didConnectToHost:port:)]){
        [self.rpcDel didConnectToHost:host port:port];
    }

}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSString *url = [webSocket.url absoluteString];
    NSArray *urlArray = [url separateWithString:@":"];
    NSString *port = [urlArray lastObject];
    NSString *subhost = [url substringWithString:port];
    NSString *host = [subhost substringToIndex:subhost.length-1];
    if (self.rpcDel && [self.rpcDel respondsToSelector:@selector(didFailConnectToHost:port:andError:)]){
        [self.rpcDel didFailConnectToHost:host port:port andError:error];
    }
    self.webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"Received \"%@\"", message);

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
}


@end