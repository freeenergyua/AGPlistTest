//
//  AppDelegate.m
//  AGPlistTest
//
//  Created by AG on 12/11/15.
//  Copyright © 2015 AG. All rights reserved.
//

#import "AppDelegate.h"
#import "AGMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *aDocumentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *aFilePath = [NSString stringWithFormat:@"%@/recipes.plist", aDocumentsDirectory];

    NSMutableArray *plistArray = [[NSMutableArray alloc] initWithContentsOfFile:aFilePath];
    NSLog(@"recipes.plist array %@",plistArray);
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *pathToFile = [mainBundle pathForResource:@"recipes" ofType:@"plist"];

    NSMutableDictionary *plistDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:pathToFile];
    [plistDictionary setValue:@"yes" forKey:@"title"];
    [plistDictionary writeToFile:pathToFile atomically:YES];
    NSString *value = [plistDictionary objectForKey:@"title"];
    NSLog(@"value is %@", value);
    
    
   //регистрирую Root plist
    [self registerDefaultsFromSettingsBundleWithPlist:@"Root"];
    
//    NSDictionary *defaultsSettings = @{kAutoUpdateKey : @YES,
//                               kTimeCookKey : @5,
//                               kFavoriteAlienKey : @"Vulcan",
//                               kServerURLKey : @"google.com",
//                                kServerPortNumberKey: @"8880"};
//    
//    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsSettings];
    

   return YES;
}

- (void)registerDefaultsFromSettingsBundleWithPlist:(NSString *)plist {
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    NSString *bundle = [NSString stringWithFormat:@"%@.plist",plist];
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:bundle]];
    NSArray *preferences = [settings objectForKey:@"Preference Items"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    //[defaultsToRegister release];
    
    //http://stackoverflow.com/questions/1431148/iphone-app-how-to-get-default-value-from-root-plist
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
