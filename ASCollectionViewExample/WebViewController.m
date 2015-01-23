//
//  WebViewController.m
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/3/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView* webView;

@end

@implementation WebViewController

- (instancetype)initWithInitialURL:(NSURL*)URL
{
    if (!(self = [super init]))
        return nil;
    _webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    _webView.delegate = self;
    _webView.frame = self.view.bounds;
    [_webView loadRequest:[NSURLRequest requestWithURL:URL]];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.webView];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_webView stopLoading];
}

- (void)viewWillLayoutSubviews
{
    self.webView.frame = self.view.bounds;
}


@end
