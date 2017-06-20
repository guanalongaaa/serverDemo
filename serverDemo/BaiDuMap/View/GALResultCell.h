//
//  GALResultCell.h
//  serverDemo
//
//  Created by love on 2017/2/22.
//  Copyright © 2017年 love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GALModel.h"
@interface GALResultCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@property (nonatomic, strong)GALModel *model;
@end
