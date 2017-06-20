//
//  KCAddPersonViewController.h
//  serverDemo
//
//  Created by love on 2017/2/14.
//  Copyright © 2017年 love. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KCContactDelegate;

@interface KCAddPersonViewController : UIViewController

@property (assign ,nonatomic) NSInteger recordID;//通讯录记录id，如果ID不为0则代表修改否则认为是新增
@property (strong,nonatomic) NSString *firstNameText;
@property (strong,nonatomic) NSString *lastNameText;
@property (strong,nonatomic) NSString *workPhoneText;
@property (strong,nonatomic) NSString *iPhoneNum;

@property (strong,nonatomic) id<KCContactDelegate> delegate;


@end
