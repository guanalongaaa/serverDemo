//
//  AppDelegate.h
//  serverDemo
//
//  Created by love on 2017/2/10.
//  Copyright © 2017年 love. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapView.h>

static NSString *appKey = @"145ea9ab7e55ee1f78bb347e";
static NSString *channel = @"Publish channel";
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

{
    BMKMapManager* _mapManager;
}

@property (strong, nonatomic) UIWindow *window;


@end

