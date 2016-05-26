//
//  Hotel.h
//  Hotel
//
//  Created by Phuong on 2/11/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hotel : NSObject{
    NSString* _name;
    NSString* _price;
}

@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* price;

@end
