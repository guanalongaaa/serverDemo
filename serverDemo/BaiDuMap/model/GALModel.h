//
//  GALModel.h
//  serverDemo
//
//  Created by love on 2017/2/22.
//  Copyright © 2017年 love. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GALModel : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *city;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,assign)double lat;
@property (nonatomic,assign)double lon;

@end
