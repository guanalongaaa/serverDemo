//
//  GALResultCell.m
//  serverDemo
//
//  Created by love on 2017/2/22.
//  Copyright © 2017年 love. All rights reserved.
//

#import "GALResultCell.h"

@implementation GALResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(GALModel *)model
{
    _model = model;
    self.nameLabel.text = model.name;
    self.addressLabel.text = [NSString stringWithFormat:@"%@", model.address];//model.city,
}

@end
