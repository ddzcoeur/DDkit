//
// Created by Ayasofya on 16/1/6.
// Copyright (c) 2016 ddz. All rights reserved.
//

#import "DDSocketHelper.h"


@implementation DDSocketHelper {

}

+ (DDSocketHelper *)getInstance {
    static DDSocketHelper *helper;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        helper = [DDSocketHelper new];
    });
    return helper;
}

@end