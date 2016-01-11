//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDSocketHelper.h"


@implementation DDSocketHelper {
    int _reqid;
}

+ (DDSocketHelper *)getInstance {
    static DDSocketHelper *helper;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        helper = [DDSocketHelper new];
    });
    return helper;
}

- (id)init {
    self = [super init];
    if (self){
        _reqid = 0;
    }
    return self;
}

- (int)getNextReqid {
    if (_reqid<10001){
        _reqid ++;
        return _reqid;
    } else{
        _reqid = 0;
        return _reqid;
    }
}

@end