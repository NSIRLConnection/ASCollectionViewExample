//
//  EpisodeViewController.h
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/3/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EpisodeViewController : UIViewController

+ (instancetype)sharedInstance;

- (void)loadURL:(NSURL*)URL;
- (void)loadScanCreditCardViewController;

@end
