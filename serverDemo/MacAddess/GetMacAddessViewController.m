//
//  GetMacAddessViewController.m
//  serverDemo
//
//  Created by love on 2017/2/17.
//  Copyright © 2017年 love. All rights reserved.
//

#import "GetMacAddessViewController.h"

//#import <SystemConfiguration/SystemConfiguration.h>
//#import <NetworkExtension/NetworkExtension.h>
#import <SystemConfiguration/CaptiveNetwork.h>

//#import <ifaddrs.h>  //ip
//#import <arpa/inet.h>
//#import <net/if.h>
//
//
//#define IOS_CELLULAR    @"pdp_ip0"
//#define IOS_WIFI        @"en0"
//#define IOS_VPN         @"utun0"
//#define IP_ADDR_IPv4    @"ipv4"
//#define IP_ADDR_IPv6    @"ipv6"


@interface GetMacAddessViewController ()

@property (nonatomic, strong) UILabel *Namelabel;

@property (nonatomic, strong) UILabel *Addesslabel;


@end

@implementation GetMacAddessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(BackItem)];
    
    self.title = @"WiFi";

    [self setUI];
    
//    [self macAddess];
    
    [self getWifiName];

    
}

-(void)setUI{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250,30)];
    
    label.center = self.view.center;
    
    [self.view addSubview:label];
    self.Namelabel = label;
    
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250,30)];
    
    label1.center = CGPointMake(self.view.center.x, self.view.center.y * 0.8);
    
    [self.view addSubview:label1];
    
    self.Addesslabel = label1;
    
    
    
}

-(NSString*)macAddess{
    
    NSArray *ifs = CFBridgingRelease(CNCopySupportedInterfaces());
    id info = nil;
    for (NSString *ifname in ifs) {
        info = CFBridgingRelease(CNCopyCurrentNetworkInfo((CFStringRef)ifname));
        if (info && [info count]) {
            break;
        }
    }
    
    NSDictionary * dic = (NSDictionary*)info;
    NSString *ssid = [[dic objectForKey:@"SSID"] lowercaseString];
    NSString *bssid = [dic objectForKey:@"BSSID"];
    
    NSLog(@"ssid:%@, \nbssid:%@",ssid,bssid);
    
    return bssid;
}


//7.当前手机连接的WIFI名称(SSID)WIFI MAC地址(BSSID)
- (NSString *)getWifiName
{
    
    NSString *ssid = @"Not Found";
    NSString *macIp = @"Not Found";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            
            ssid = [dict valueForKey:@"SSID"];
            macIp = [dict valueForKey:@"BSSID"];
            
            
            NSLog(@"ssid:%@, \nbssid:%@",ssid,macIp);
        }
    }
    
    
    
    NSString *wifiName = nil;
    
    NSString *wifiAddress = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        
        wifiAddress = @"没有连接WiFi";
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            wifiAddress = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeyBSSID];
            
            NSLog(@"%ld",wifiAddress.length);
            
            //避免16进制双0时候获取到的Mac地址少一位
            wifiAddress = [wifiAddress stringByReplacingOccurrencesOfString:@":0:" withString:@":00:"];
            
            NSLog(@"%ld",wifiAddress.length);
            
            NSLog(@"WiFi名称:%@, \nMac地址:%@",wifiName,wifiAddress);
            
            self.Namelabel.text = [NSString stringWithFormat:@"WiFi名称：%@",wifiName];
            self.Addesslabel.text = [NSString stringWithFormat:@"MAC地址：%@",wifiAddress];
            
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)BackItem{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
