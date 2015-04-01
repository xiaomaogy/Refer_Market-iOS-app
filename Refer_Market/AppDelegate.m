//
//  AppDelegate.m
//  testproject
//
//  Created by yuan gao on 3/3/15.
//  Copyright (c) 2015 yuan gao. All rights reserved.
//

#import "AppDelegate.h"
#import "Refer.h"
#import "ReferDatabase.h"
#import <FacebookSDK/FacebookSDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setPreferenceDefaults];
    [self checkAndCreateDatabase];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [FBLoginView class];
    [FBProfilePictureView class];
    return YES;
}

-(NSString *)GetDocumentDirectory{
    _fileMgr = [NSFileManager defaultManager];
    _homeDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    return _homeDir;
}

-(void) checkAndCreateDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *databasePath = [self.GetDocumentDirectory stringByAppendingPathComponent:@"savedrefer_list2.sqlite3"];
    success = [fileManager fileExistsAtPath:databasePath];
    if(success) {
        return;}
    else{
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"YOUR DATABASE NAME.sqlite"];
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    }
}

- (void)setPreferenceDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *initialLaunchTime=[NSString stringWithFormat:@"%@",[NSDate date]];
    [defaults setValue:initialLaunchTime forKey:@"launchDate"];
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
    [FBAppEvents activateApp];
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}




@end
