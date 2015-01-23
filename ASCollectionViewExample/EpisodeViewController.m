//
//  EpisodeViewController.m
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/3/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import "EpisodeViewController.h"
#import "NSCEpisode.h"
#import "EpisodeNode.h"
#import "WebViewController.h"
#import "ScanCreditCardViewController.h"


#import <AsyncDisplayKit/AsyncDisplayKit.h>

#define IS_IPHONE_5_OR_GREATER  ([[UIScreen mainScreen] bounds].size.height >= 568)?TRUE:FALSE

static const CGFloat kCollectionViewOuterPaddingHeight = 20.0f;

@interface EpisodeViewController () <ASCollectionViewDataSource, ASCollectionViewDelegate, UIWebViewDelegate>

@property (strong, nonatomic) ASCollectionView *collectionView;
@property (strong, nonatomic) UIDynamicAnimator *dynamicAnimator;
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;


@end

@implementation EpisodeViewController

+ (instancetype)sharedInstance
{
    static EpisodeViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    if (!(self = [super init]))
        return nil;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[ASCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.asyncDataSource = self;
    _collectionView.asyncDelegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    CGRect collectionViewFrame = self.view.bounds;
    collectionViewFrame.origin.y = collectionViewFrame.size.height*1.35;
    collectionViewFrame.size.height = collectionViewFrame.size.height - kCollectionViewOuterPaddingHeight;
    _collectionView.frame = collectionViewFrame;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.collectionView];
}

- (void)viewWillLayoutSubviews
{
    CGRect collectionViewFrame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    collectionViewFrame.origin.y = collectionViewFrame.size.height*1.35;
    collectionViewFrame.size.height = collectionViewFrame.size.height - kCollectionViewOuterPaddingHeight;
    _collectionView.frame = collectionViewFrame;
    [self slideCollectionViewIn];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    [self slideCollectionViewIn];
}

- (void)slideCollectionViewIn
{
    CGRect frame = self.view.bounds;
    self.dynamicAnimator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.collectionView]];
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:UIEdgeInsetsMake(0, 0, frame.size.height - kCollectionViewOuterPaddingHeight, 0)];
    [self.dynamicAnimator addBehavior:collisionBehavior];
    
    self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.collectionView]];
    self.gravityBehavior.gravityDirection = CGVectorMake(0.0f, -1.0f);
    [self.dynamicAnimator addBehavior:_gravityBehavior];
}

- (ASCellNode *)collectionView:(ASCollectionView *)collectionView nodeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSCEpisode *episode = [[NSCEpisode alloc]initWithRandomPlaceholderEpisode];
    EpisodeNode *node = [[EpisodeNode alloc]initWithEpisode:episode];
    return node;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)loadURL:(NSURL*)URL
{
    WebViewController *webViewController = [[WebViewController alloc]initWithInitialURL:URL];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)loadScanCreditCardViewController
{
    ScanCreditCardViewController *scanCreditcardViewController = [[ScanCreditCardViewController alloc]init];
    [self.navigationController pushViewController:scanCreditcardViewController animated:YES];
}

@end
