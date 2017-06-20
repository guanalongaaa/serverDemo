//
//  KCSendEmailViewController.m
//  serverDemo
//
//  Created by love on 2017/2/10.
//  Copyright © 2017年 love. All rights reserved.
//

#import "KCSendEmailViewController.h"
#import <MessageUI/MessageUI.h>
#import "ViewController.h"

#define GALWIDTH  self.view.frame.size.width
#define GALHEIGHT self.view.frame.size.height

@interface KCSendEmailViewController ()<MFMessageComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *telNumber;
@property (weak, nonatomic) IBOutlet UITextField *body;
@property (weak, nonatomic) IBOutlet UITextField *subject;
@property (weak, nonatomic) IBOutlet UITextField *attachments;
- (IBAction)sendMessage:(UIButton *)sender;

@end

@implementation KCSendEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"SendMail";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backItem)];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    
    
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button2.frame = CGRectMake(0, 0, 200, 40);
    
    button2.center = CGPointMake(GALWIDTH*0.5, GALHEIGHT*0.7);
    
    [button2 addTarget:self action:@selector(buttonClick2:) forControlEvents:UIControlEventTouchUpInside];
    
    [button2 setTitle:@"发送短信" forState:UIControlStateNormal];
    
    [button2 setBackgroundColor:[UIColor yellowColor]];
    
//    [self.view addSubview:button2];

 

}



- (IBAction)sendMessage:(UIButton *)sender {
    
    if([MFMessageComposeViewController canSendText]){
        MFMessageComposeViewController *messageController=[[MFMessageComposeViewController alloc]init];
        //收件人
        messageController.recipients=[self.telNumber.text componentsSeparatedByString:@","];
        //信息正文
        messageController.body=self.body.text;
        //设置代理,注意这里不是delegate而是messageComposeDelegate
        messageController.messageComposeDelegate=self;
        //如果运行商支持主题
        if([MFMessageComposeViewController canSendSubject]){
            messageController.subject=self.subject.text;
        }
        //如果运行商支持附件
        if ([MFMessageComposeViewController canSendAttachments]) {
            /*第一种方法*/
            //messageController.attachments=...;
            
            /*第二种方法*/
//            NSArray *attachments= [self.attachments.text componentsSeparatedByString:@","];
//            if (attachments.count>0) {
//                [attachments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    NSString *path=[[NSBundle mainBundle]pathForResource:obj ofType:nil];
//                    NSURL *url=[NSURL fileURLWithPath:path];
//                    [messageController addAttachmentURL:url withAlternateFilename:obj];
//                }];
//            }
            
            /*第三种方法*/
            // NSString *path=[[NSBundle mainBundle]pathForResource:@"photo.jpg" ofType:nil];
            // NSURL *url=[NSURL fileURLWithPath:path];
            // NSData *data=[NSData dataWithContentsOfURL:url];
            /** * attatchData:文件数据 * uti:统一类型标识，标识具体文件类型，详情查看：帮助文档中System-Declared Uniform Type Identifiers * fileName:展现给用户看的文件名称 */
            // [messageController addAttachmentData:data typeIdentifier:@"public.image" filename:@"photo.jpg"];
        }
        [self presentViewController:messageController animated:YES completion:nil];
    }
    
    
}


#pragma mark - MFMessageComposeViewController代理方法
//发送完成，不管成功与否
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"发送成功.");
            break;
        case MessageComposeResultCancelled:
            NSLog(@"取消发送.");
            break;
        default:
            NSLog(@"发送失败.");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)buttonClick2:(UIButton *)sender
{
    ViewController *control = [[ViewController alloc]init];
    
    //    [self presentViewController:control animated:YES completion:^{
    //
    //    }];
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:control];
    [self presentViewController:navigationController animated:YES completion:nil];
    
    //    [self.navigationController pushViewController:navigationController animated:YES];
    
    //    [self.navigationController popToViewController:control animated:YES];
}




- (void)backItem{
    
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型为立方体动画
    animation.type = @"cube";//RippleEffect
    //设置动画时长
    animation.duration =0.5f;
    //设置运动的方向
    animation.subtype =kCATransitionFromLeft;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
