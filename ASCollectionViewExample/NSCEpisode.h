//
//  NSCEpisode.h
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/3/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCEpisode : NSObject

@property (strong, nonatomic) NSString *kImageURL;
@property (strong, nonatomic) NSString *kTitle;
@property (strong, nonatomic) NSString *kDescription;
@property (strong, nonatomic) NSString *kDominantColor;
@property (strong, nonatomic) NSString *kEpisodeType;
@property (strong, nonatomic) NSString *kVideoURL;

-(instancetype)initWithRandomPlaceholderEpisode;

@end
