//
//  ScanCreditCardViewController.m
//  ASCollectionViewExample
//
//  Created by Michael Yau on 1/6/15.
//  Copyright (c) 2015 michaelyau. All rights reserved.
//

#import "ScanCreditCardViewController.h"

@interface ScanCreditCardViewController ()

@property (strong, nonatomic) UIButton *scanCardButton;

@end

@implementation ScanCreditCardViewController

- (instancetype)init
{
    if (!(self = [super init]))
        return nil;
    
    _scanCardButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _scanCardButton.tintColor = [UIColor whiteColor];
    [_scanCardButton addTarget:self action:@selector(scanCardTapped) forControlEvents:UIControlEventTouchUpInside];
    [_scanCardButton setTitle:@"Scan a card" forState:UIControlStateNormal];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scanCardButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [CardIOUtilities preload];
}

- (void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewWillLayoutSubviews
{
    [self.scanCardButton sizeToFit];
    self.scanCardButton.center = self.view.center;
}

- (void)scanCardTapped
{
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [self presentViewController:scanViewController animated:YES completion:nil];
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController
{
    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)scanViewController
{
    // The full card number is available as info.cardNumber, but don't log that!
    NSLog(@"Received card info. Number: %@, expiry: %02i/%i, cvv: %@.", info.redactedCardNumber, info.expiryMonth, info.expiryYear, info.cvv);
    // Use the card info...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
