//
//  KCContactTableViewController.h
//  serverDemo
//
//  Created by love on 2017/2/13.
//  Copyright © 2017年 love. All rights reserved.
//

#import <UIKit/UIKit.h>

/** * 定义一个协议作为代理 */
@protocol KCContactDelegate

//新增或修改联系人
-(void)editPersonWithFirstName:(NSString *)firstName lastName:(NSString *)lastName workNamber:(NSString *)workNamber;

//取消修改或新增
-(void)cancelEdit;

@end


@interface KCContactTableViewController : UITableViewController



@end
