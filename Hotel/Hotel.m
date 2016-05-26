//
//  Hotel.m
//  Hotel
//
//  Created by Phuong on 2/11/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "Hotel.h"

@implementation Hotel

@synthesize name = _name;
@synthesize price = _price;

+ (NSDictionary*)elementToPropertyMappings {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"name", @"name",
            @"price",@"price",
            nil];
}

@end
