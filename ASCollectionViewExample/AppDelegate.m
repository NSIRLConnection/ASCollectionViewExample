//
//  AppDelegate.m
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/3/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import "AppDelegate.h"
#import "EpisodeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setNavigationBarAppearance];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[EpisodeViewController sharedInstance]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)setNavigationBarAppearance
{

    [[UINavigationBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    UIFont * font = [UIFont boldSystemFontOfSize:14.0f];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          font, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
}

@end
