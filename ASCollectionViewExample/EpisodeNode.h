//
//  EpisodeNode.h
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/3/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import "NSCEpisode.h"
#import <AsyncDisplayKit/AsyncDisplayKit.h>

@interface EpisodeNode : ASCellNode

- (instancetype)initWithEpisode:(NSCEpisode*)kEpisode;

@end
