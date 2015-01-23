//
//  EpisodeNode.m
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/3/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import "EpisodeNode.h"
#import "EpisodeViewController.h"

#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>
#import <AsyncDisplayKit/ASHighlightOverlayLayer.h>

@import WebKit;

static const CGFloat kImageWidth = 200.0f;
static const CGFloat kImageHeight = 125.0f;
static const CGFloat kCellOuterPaddingHeight = 20.0f;
static const CGFloat kCellOuterPaddingWidth = 20.0f;
static const CGFloat kCellInnerPaddingHeight = 5.0f;
static NSString *kLinkAttributeName = @"EpisodeLinkAttributeName";
static NSString *kSubscribeAttributeName = @"SubscribeAttributeName";

@interface EpisodeNode () <ASTextNodeDelegate>
{
    
    ASDisplayNode *_dividerNode;
    ASNetworkImageNode *_imageNode;
    ASTextNode *_episodeTitleTextNode;
    ASTextNode *_episodeDescriptionTextNode;
    ASTextNode *_episodeVideoTextNode;
    
}
@end

@implementation EpisodeNode

-(instancetype)initWithEpisode:(NSCEpisode *)kEpisode
{
    if (!(self = [super init]))
    {
        return nil;
    }
    
    _dividerNode = [[ASDisplayNode alloc] init];
    _dividerNode.backgroundColor = [UIColor lightGrayColor];
    [self addSubnode:_dividerNode];
    
    _imageNode = [[ASNetworkImageNode alloc] init];
    _imageNode.backgroundColor = ASDisplayNodeDefaultPlaceholderColor();
    _imageNode.URL = [NSURL URLWithString:kEpisode.kImageURL];
    [self addSubnode:_imageNode];
    
    _episodeTitleTextNode = [[ASTextNode alloc]init];
    _episodeTitleTextNode.attributedString = [[NSAttributedString alloc] initWithString:kEpisode.kTitle
                                                                             attributes:[self episodeTitleTextStyle]];
    [self addSubnode:_episodeTitleTextNode];
    
    _episodeDescriptionTextNode = [[ASTextNode alloc]init];
    _episodeDescriptionTextNode.attributedString = [[NSAttributedString alloc] initWithString:kEpisode.kDescription
                                                                             attributes:[self episodeDescriptionTextStyle]];
    [self addSubnode:_episodeDescriptionTextNode];
    
    _episodeVideoTextNode = [[ASTextNode alloc]init];
    _episodeVideoTextNode.delegate = self;
    _episodeVideoTextNode.userInteractionEnabled = YES;
    _episodeVideoTextNode.linkAttributeNames = @[ kLinkAttributeName, kSubscribeAttributeName ];
    
    
    if ([kEpisode.kEpisodeType isEqualToString:@"paid"])
    {
        _episodeVideoTextNode.attributedString = [[NSMutableAttributedString alloc] initWithString:@"Subscribers Only."
                                                                                 attributes:[self paidVideoTextStyle]];
    }else if ([kEpisode.kEpisodeType isEqualToString:@"free"])
    {
        _episodeVideoTextNode.attributedString = [[NSMutableAttributedString alloc] initWithString:@"Play Video"
                                                                                 attributes:[self freeVideoTextStyleWithVideoURL:kEpisode.kVideoURL]];
    }
    [self addSubnode:_episodeVideoTextNode];
    return self;
}

- (NSDictionary *)episodeTitleTextStyle
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0f];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    UIColor *fontColor = [UIColor whiteColor];
    style.paragraphSpacing = 0.5 * font.lineHeight;
    style.hyphenationFactor = 1.0;
    
    return @{ NSFontAttributeName: font,
              NSForegroundColorAttributeName: fontColor,
              NSParagraphStyleAttributeName: style };
}


- (NSDictionary *)episodeDescriptionTextStyle
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:14.0f];
    UIColor *fontColor = [UIColor whiteColor];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.paragraphSpacing = 0.5 * font.lineHeight;
    style.hyphenationFactor = 1.0;
    
    return @{ NSFontAttributeName: font,
              NSForegroundColorAttributeName: fontColor,
              NSParagraphStyleAttributeName: style};
}

- (NSDictionary *)paidVideoTextStyle
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14.0f];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    UIColor *fontColor = [UIColor grayColor];
    style.paragraphSpacing = 0.5 * font.lineHeight;
    style.hyphenationFactor = 1.0;
    style.alignment = NSTextAlignmentCenter;
    return @{
             NSFontAttributeName: font,
             NSForegroundColorAttributeName: fontColor,
             NSParagraphStyleAttributeName: style,
             NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid | NSUnderlinePatternSolid),
             kSubscribeAttributeName: @"subscribe"
             };
}

- (NSDictionary *)freeVideoTextStyleWithVideoURL:(NSString*)kVideoURL
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:14.0f];
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    UIColor *fontColor = [UIColor whiteColor];
    style.paragraphSpacing = 0.5 * font.lineHeight;
    style.hyphenationFactor = 1.0;
    style.alignment = NSTextAlignmentCenter;
    
    return @{
              NSFontAttributeName: font,
              NSForegroundColorAttributeName: fontColor,
              NSParagraphStyleAttributeName: style,
              NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid | NSUnderlinePatternSolid),
              kLinkAttributeName: [NSURL URLWithString:kVideoURL],
              };
    
}


-(CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
    CGSize episodeTitleTextSize = [_episodeTitleTextNode measure:CGSizeMake(constrainedSize.width - 2 * kCellOuterPaddingWidth, constrainedSize.height)];
    CGSize episodeDescriptionTextSize = [_episodeDescriptionTextNode measure:CGSizeMake(constrainedSize.width - 2 * kCellOuterPaddingWidth, constrainedSize.height)];
    CGSize episodeVideoTextSize = [_episodeVideoTextNode measure:CGSizeMake(constrainedSize.width - 2 * kCellOuterPaddingWidth, constrainedSize.height)];
    CGFloat requiredHeight = kImageHeight + episodeTitleTextSize.height + episodeDescriptionTextSize.height + episodeVideoTextSize.height + 4* kCellInnerPaddingHeight + 2* kCellOuterPaddingHeight;
    return CGSizeMake(constrainedSize.width, requiredHeight);
}


- (void)layout
{
    CGFloat pixelHeight = 1.0f / [[UIScreen mainScreen] scale];
    _dividerNode.frame = CGRectMake(0.0f, 0.0f, self.calculatedSize.width, pixelHeight);
    
    _imageNode.frame = CGRectMake(self.calculatedSize.width/2 - kImageWidth/2, kCellOuterPaddingHeight, kImageWidth, kImageHeight);
    
    CGSize episodeTitleTextSize = _episodeTitleTextNode.calculatedSize;
    _episodeTitleTextNode.frame = CGRectMake(kCellOuterPaddingWidth, kCellOuterPaddingHeight + kImageHeight + kCellInnerPaddingHeight, episodeTitleTextSize.width, episodeTitleTextSize.height);
    
    CGSize episodeDescriptionTextSize = _episodeDescriptionTextNode.calculatedSize;
    _episodeDescriptionTextNode.frame = CGRectMake(CGRectGetMinX(_episodeTitleTextNode.frame), CGRectGetMaxY(_episodeTitleTextNode.frame) + kCellInnerPaddingHeight, episodeDescriptionTextSize.width, episodeDescriptionTextSize.height);
    
    CGSize episodeVideoTextSize = _episodeTitleTextNode.calculatedSize;
    _episodeVideoTextNode.frame = CGRectMake(kCellOuterPaddingWidth, CGRectGetMaxY(_episodeDescriptionTextNode.frame) + 3* kCellInnerPaddingHeight, CGRectGetWidth([UIScreen mainScreen].bounds) - kCellOuterPaddingWidth*2, episodeVideoTextSize.height);
    
    CGFloat extendY = roundf( (44.0f - episodeVideoTextSize.height) / 2.0f );
    _episodeVideoTextNode.hitTestSlop = UIEdgeInsetsMake(-extendY, 0.0f, -extendY, 0.0f);
    
    [self invalidateCalculatedSize];
    
}

- (void)didLoad
{
    self.layer.as_allowsHighlightDrawing = YES;
    [super didLoad];
}

- (BOOL)textNode:(ASTextNode *)richTextNode shouldHighlightLinkAttribute:(NSString *)attribute value:(id)value atPoint:(CGPoint)point
{
    return YES;
}


- (void)textNode:(ASTextNode *)richTextNode tappedLinkAttribute:(NSString *)attribute value:(NSURL *)URL atPoint:(CGPoint)point textRange:(NSRange)textRange
{
    if ([attribute isEqualToString:kLinkAttributeName]){
        EpisodeViewController *viewController = [EpisodeViewController sharedInstance];
        [viewController loadURL:URL];
    }else if ([attribute isEqualToString:kSubscribeAttributeName])
    {
        EpisodeViewController *viewController = [EpisodeViewController sharedInstance];
        [viewController loadScanCreditCardViewController];
    }
}



@end
