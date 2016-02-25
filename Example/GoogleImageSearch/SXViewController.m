//
//  SXViewController.m
//  GoogleImageSearch
//
//  Created by seanxiaoxiao on 02/21/2016.
//  Copyright (c) 2016 seanxiaoxiao. All rights reserved.
//

#import "SXViewController.h"
#import <GoogleImageSearch/GoogleImageSearch-umbrella.h>

@interface SXViewController ()

@end

@implementation SXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[SXGoogleImageSearch sharedImageSearch] setup];
    [[SXGoogleImageSearch sharedImageSearch] query:@"sushi"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
