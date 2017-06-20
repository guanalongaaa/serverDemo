//
//  ResultListViewController.h
//  serverDemo
//
//  Created by love on 2017/2/22.
//  Copyright © 2017年 love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GALModel.h"
@interface ResultListViewController : UIViewController

@property (nonatomic, strong)NSArray *resultListArray;

@property (nonatomic, copy)void(^galListBlock)(GALModel *model);

@end
