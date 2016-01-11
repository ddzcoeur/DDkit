//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDRpcEncoderImpl.h"
#import "DDSocketHelper.h"

@implementation DDRpcEncoderImpl {
}

- (void)encodeRequest:(DDRpcRequest *)request
               method:(NSString *)method
              content:(NSData *)content {

    if (!request){
        //TODO post error
    }
    if (method.length==0){
        //TODO post error
    }

    int reqid = [[DDSocketHelper getInstance] getNextReqid];
    [request requestWithReqid:reqid method:method content:content];

}

@end