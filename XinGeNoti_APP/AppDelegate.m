//
//  AppDelegate.m
//  XinGeNoti_APP
//
//  Created by langyue on 16/8/9.
//  Copyright © 2016年 langyue. All rights reserved.
//

#import "AppDelegate.h"
#import "XGPush.h"
#import "XGSetting.h"



@interface AppDelegate ()

@end

@implementation AppDelegate



-(void)registerPushForIOS8{


    //Types
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;


    //Actions
    UIMutableUserNotificationAction * acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"ACCEPT_IDENTIFIER";
    acceptAction.title = @"Accept";

    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    acceptAction.destructive = false;
    acceptAction.authenticationRequired = NO;

    //Categories
    UIMutableUserNotificationCategory * inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
    inviteCategory.identifier = @"INVITE_CATEGORY";
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
    [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];


    NSSet * categories = [NSSet setWithObjects:inviteCategory, nil];


    UIUserNotificationSettings * mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];


}


-(void)registerPush{


    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.




    //ACCESS ID 2200214680


    //应用包名 com.xingenoti.demo

    //ACCESS KEY IP4518X6DANI


    //SECRET KEY -1




    [XGPush startApp:2200214680 appKey:@"IP4518X6DANI"];
    [XGPush handleLaunching:launchOptions];

    float sysVer = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (sysVer < 8) {
        [self registerPush];
    }else{
        [self registerPushForIOS8];
    }

    [XGPush setAccount:@"123"];




    return YES;
}



-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{

    [XGPush localNotificationAtFrontEnd:notification userInfoKey:@"clockID" userInfoValue:@"myid"];


    [XGPush delLocalNotification:notification];


}





#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{



}



-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    if ([identifier isEqualToString:@"ACCEPT_IDENTIFIER"]) {
        NSLog(@"ACCEPT_IDENTIFIER is clicked");
    }
    completionHandler();
}

#endif





-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{


    void (^successBlock)(void) = ^(void){

        NSLog(@"【XGPush Demo】 register successBlock");

    };


    void (^errorBlock)(void) = ^(void){

        NSLog(@"[XGPush Demo] register errorBlock");

    };


    NSString * deviceTokenStr = [XGPush registerDevice:deviceToken successCallback:successBlock errorCallback:errorBlock];





}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    NSString * str = [NSString stringWithFormat:@"Error: %@",error];
    NSLog(@"[XGPush Demo]%@",str);

}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{


    [XGPush handleReceiveNotification:userInfo];


}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
