//
//  SXViewController.m
//  GoogleImageSearch
//
//  Created by seanxiaoxiao on 02/21/2016.
//  Copyright (c) 2016 seanxiaoxiao. All rights reserved.
//

#import "SXViewController.h"
#import <GoogleImageSearch/GoogleImageSearch-umbrella.h>

@interface ImageSearchResultCell : UICollectionViewCell

@property (nonatomic, retain) UIImage *thumbnail;

@end

@implementation ImageSearchResultCell {
    UIImageView *_thumbnailView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _thumbnailView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_thumbnailView];
    }
    return self;
}

- (void)setThumbnail:(UIImage *)thumbnail
{
    _thumbnailView.image = thumbnail;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _thumbnailView.frame = self.bounds;
}

@end

static NSString *kCellIdentifier = @"kCellIdentifier";

@interface SXViewController () <SXGoogleImageSearchDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation SXViewController {
    UICollectionView *_collectionView;
    NSArray *_results;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[SXGoogleImageSearch sharedImageSearch] setup];
    [SXGoogleImageSearch sharedImageSearch].delegate = self;
    [[SXGoogleImageSearch sharedImageSearch] query:@"sushi"];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[ImageSearchResultCell class] forCellWithReuseIdentifier:kCellIdentifier];
}

- (void)viewWillLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _collectionView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height - 20);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)googleImageSearch:(SXGoogleImageSearch *)search didGetResults:(NSArray *)results
{
    _results = results;
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_results count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageSearchResultCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ImageSearchResultCell alloc] initWithFrame:CGRectZero];
    }
    SXGoogleImageSearchResult *result = _results[indexPath.row];
    cell.thumbnail = result.thumbnail;
    return cell;
}

@end
