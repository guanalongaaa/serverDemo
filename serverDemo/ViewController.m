//
//  ViewController.m
//  serverDemo
//
//  Created by love on 2017/2/10.
//  Copyright © 2017年 love. All rights reserved.
//

#define GALWIDTH  self.view.frame.size.width
#define GALHEIGHT self.view.frame.size.height

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#import "ViewController.h"
#import "KCSendEmailViewController.h"

#import "KCContactTableViewController.h"

#import "GetMacAddessViewController.h"

#import "LocationViewController.h"


@interface ViewController ()<UINavigationControllerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self buildMainView];
    
}

-(void)buildMainView
{
    
    NSArray * arr = @[@"打电话",@"打开微信",@"发送短信",@"通讯录",@"获取WiFi-MAC地址",@"百度地图"];
    
    for (NSInteger i = 0; i < arr.count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        button.frame = CGRectMake(0, 0, 200, 40);
        
        button.center = CGPointMake(GALWIDTH*0.5, GALHEIGHT*(0.2 + 0.1*i));
        
        button.tag = i+1;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button setTitle:arr[i] forState:UIControlStateNormal];
        
        [button setBackgroundColor: randomColor];
        
        [self.view addSubview:button];
    }
    
//    UIButton * bu = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    bu.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:bu];
    
    
}

-(void)buttonClick:(UIButton *)sender
{
   
    switch (sender.tag) {
        case 1:
        {
            [self button1];
        }
            
            break;
        case 2:
        {
            [self button2];
        }
            
            break;
        case 3:
        {
            [self button3];
        }
            
            break;
        case 4:
        {
            [self button4];
        }
            
            break;
        case 5:
        {
            [self button5];
        }
            
            break;
        
        case 6:
        {
            [self button6];
        }
            
            break;
            
        default:
            break;
    }
    
}

-(void)button1
{
    NSString *phoneNumber=@"0291008611";
    //     NSString *url=[NSString stringWithFormat:@"tel://%@",phoneNumber];//这种方式会直接拨打电话
    NSString *url=[NSString stringWithFormat:@"telprompt://%@",phoneNumber];//这种方式会提示用户确认是否拨打电话
    //    NSString *url=[NSString stringWithFormat:@"sms://%@",phoneNumber];//发送短信
    //    NSString *mailAddress=@"guanal@smartdot.com";
    //    NSString *url=[NSString stringWithFormat:@"mailto://%@",mailAddress];//发送邮件
//        NSString *url=@"http://blog.csdn.net/sinat_27310637";
    
    [self openUrl:url];
}

-(void)button2
{
    NSString *url=@"weixin://myparams";
    [self openUrl:url];

}

-(void)button3
{
    
    KCSendEmailViewController *control = [[KCSendEmailViewController alloc]init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:control];
    
//    ViewController *myVC = [[ViewController alloc]init];
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型为立方体动画
    animation.type = @"cube";//RippleEffect
    //设置动画时长
    animation.duration =0.5f;
    //设置运动的方向
    animation.subtype =kCATransitionFromRight;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:navigationController animated:NO completion:nil];

    
    
//    [self presentViewController:navigationController animated:YES completion:nil];
}

-(void)button4
{
    KCContactTableViewController *control = [[KCContactTableViewController alloc]init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:control];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

-(void)button5
{
    GetMacAddessViewController *control = [[GetMacAddessViewController alloc]init];
    
    
//    //UIModalTransitionStyleFlipHorizontal 翻转
//    
//    //UIModalTransitionStyleCoverVertical 底部滑出
//    
//    //UIModalTransitionStyleCrossDissolve 渐显
//    
//    //UIModalTransitionStylePartialCurl 翻页
//    
//    UIModalPresentationFullScreen = 0,
//    UIModalPresentationPageSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
//    UIModalPresentationFormSheet NS_ENUM_AVAILABLE_IOS(3_2) __TVOS_PROHIBITED,
//    UIModalPresentationCurrentContext NS_ENUM_AVAILABLE_IOS(3_2),
//    UIModalPresentationCustom NS_ENUM_AVAILABLE_IOS(7_0),
//    UIModalPresentationOverFullScreen NS_ENUM_AVAILABLE_IOS(8_0),
//    UIModalPresentationOverCurrentContext NS_ENUM_AVAILABLE_IOS(8_0),
//    UIModalPresentationPopover NS_ENUM_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED,
//    UIModalPresentationNone NS_ENUM_AVAILABLE_IOS(7_0) = -1,
    
//    control.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//    [self presentViewController:control animated:YES completion:nil];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:control];
    
    control.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:navigationController animated:YES completion:nil];

}


-(void)button6
{
    LocationViewController * location = [[LocationViewController alloc]init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:location];
    
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
    
    [self presentViewController:navigationController animated:YES completion:nil];

}



-(void)buttonClick2:(UIButton *)sender
{
    KCSendEmailViewController *control = [[KCSendEmailViewController alloc]init];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:control];
    [self presentViewController:navigationController animated:YES completion:nil];

//    [self.navigationController pushViewController:navigationController animated:YES];
    
//    [self.navigationController popToViewController:control animated:YES];
}






#pragma mark - 私有方法
-(void)openUrl:(NSString *)urlStr{
    //注意url中包含协议名称，iOS根据协议确定调用哪个应用，例如发送邮件是“sms://”其中“//”可以省略写成“sms:”(其他协议也是如此)
    NSURL *url=[NSURL URLWithString:urlStr];
    UIApplication *application=[UIApplication sharedApplication];
    
    
    if(![application canOpenURL:url]){
        NSLog(@"无法打开\"%@\"，请确保此应用已经正确安装.",url);
        return;
    }
    
    
//    [[UIApplication sharedApplication] openURL:url];
    [application openURL:url options:@{} completionHandler:^(BOOL success) {
        
        if (success) {
            NSLog(@"Opened url");
        }
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
