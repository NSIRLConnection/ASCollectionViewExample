//
//  NSCEpisode.m
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/3/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import "NSCEpisode.h"

@implementation NSCEpisode

-(instancetype)initWithRandomPlaceholderEpisode
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    NSUInteger randomInteger = arc4random_uniform(5);
    
    switch (randomInteger) {
        case 0:
            self.kTitle = @"Cocoa Windows";
            self.kImageURL = @"https://nsscreencast.s3.amazonaws.com/150-cocoa-windows/150-cocoa-windows-poster@2x.png";
            self.kDescription = @"In this first episode covering OS X development, I cover how to manage windows, window controllers and xibs with Objective-C and Swift. There are lots of options (and opinions) here, so we follow some advice from Mike Ash's blog post on the topic.";
            self.kEpisodeType = @"paid";
            self.kDominantColor = @"#3A4050";
            self.kVideoURL = @"https://www.nsscreencast.com/api/episodes/150-cocoa-windows/play";
            break;
        case 1:
            self.kTitle = @"Xcode 5 Autolayout Improvements";
            self.kImageURL = @"https://nsscreencast.s3.amazonaws.com/087-xcode5-autolayout-improvements/087-xcode5-autolayout-improvements-poster@2x.png";
            self.kDescription = @"This week we have another free bonus video on the improvements that Xcode 5 brings to Autolayout. As something that has been quite obnoxious to work with in the past, many people dismissed auto layout when it was introduced to iOS 6. With these improvements it is much more friendly and dare I say... usable?";
            self.kEpisodeType = @"free";
            self.kDominantColor = @"#86B91B";
            self.kVideoURL = @"https://www.nsscreencast.com/api/episodes/87-xcode-5-autolayout-improvements/play";
            break;
        case 2:
            self.kTitle = @"How Bézier Paths Work";
            self.kImageURL = @"https://nsscreencast.s3.amazonaws.com/149-how-bezier-paths-work/149-how-bezier-paths-work-poster@2x.png";
            self.kDescription = @"Have you ever wondered how bezier paths work? What are the control points, and how exactly do they affect the line? In this episode we'll build our own visualization of how a bézier path is constructed to help understand it better.";
            self.kEpisodeType = @"paid";
            self.kDominantColor = @"#4F5050";
            self.kVideoURL = @"https://www.nsscreencast.com/api/episodes/149-how-bezier-paths-work/play";
            break;
        case 3:
            self.kTitle = @"Hello, iOS 7";
            self.kImageURL = @"https://nsscreencast.s3.amazonaws.com/085-hello-ios7/085-hello-ios7-poster@2x.png";
            self.kDescription = @"To celebrate the launch of iOS 7, here is a bonus free screencast covering a few of the concepts in iOS 7 such as the status bar behavior, tint color, and navigation bar transitions. We'll also take a look at Xcode 5 with a couple of the new features, including the integrated test runner.";
            self.kEpisodeType = @"free";
            self.kDominantColor = @"#1497f2";
            self.kVideoURL = @"https://www.nsscreencast.com/api/episodes/85-hello-ios-7/play";
            break;
        case 4:
            self.kTitle = @"Windows Azure Mobile Services Part 2";
            self.kImageURL = @"https://nsscreencast.s3.amazonaws.com/060-windows-azure-mobile-services-part-2/060-windows-azure-mobile-services-part-2-poster@2x.png";
            self.kDescription = @"We continue with our example chat application here and add the ability post a message, poll for updates, and receive push notifications. This episode utilizes a pod calles MessagesTableView controller to present an SMS like interface for the messages.";
            self.kEpisodeType = @"free";
            self.kDominantColor = @"#3C444F";
            self.kVideoURL = @"https://www.nsscreencast.com/api/episodes/60-windows-azure-mobile-services-part-2/play";
            break;
        default:
            NSLog (@"Integer out of range somehow, what the heck did you do? >:(");
            break;
    }

    return self;
}

@end
