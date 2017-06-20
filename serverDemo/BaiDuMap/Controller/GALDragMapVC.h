//
//  GALDragMapVC.h
//  serverDemo
//
//  Created by love on 2017/2/22.
//  Copyright © 2017年 love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultListViewController.h"

@interface GALDragMapVC : UIViewController


@property (nonatomic, strong)void(^galDrapMapBlock)(GALModel *model);

@end
