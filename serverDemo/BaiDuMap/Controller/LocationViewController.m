//
//  LocationViewController.m
//  serverDemo
//
//  Created by love on 2017/2/22.
//  Copyright © 2017年 love. All rights reserved.
//

#import "LocationViewController.h"
#import "GALDragMapVC.h"
@interface LocationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *longitudeAndLatitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"百度定位";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItem)];
    
}

- (IBAction)selectedLocation:(UIButton *)sender {
    
    GALDragMapVC * galVC = [[GALDragMapVC alloc]init];
    [self.navigationController pushViewController:galVC animated:YES];
    
    __weak LocationViewController *weakSelf = self;
    [galVC setGalDrapMapBlock:^(GALModel *model) {
        weakSelf.longitudeAndLatitudeLabel.text = [NSString stringWithFormat:@"地理坐标:\n%lf,%lf",model.lat,model.lon];
        
        weakSelf.detailAddressLabel.text = [NSString stringWithFormat:@"地理位置:\n%@    \n%@ ",model.name,model.address];//model.city,
    }];
    
    
}



-(void)backItem{
    
    
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型为立方体动画
    animation.type = @"Push";//RippleEffect
    //设置动画时长
    animation.duration =0.5f;
    //设置运动的方向
    animation.subtype =kCATransitionFromRight;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
