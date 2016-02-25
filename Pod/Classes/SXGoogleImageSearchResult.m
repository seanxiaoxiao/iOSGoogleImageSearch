//
//  SXGoogleImageSearchResult.m
//  Pods
//
//  Created by Xiao Xiao on 16/2/24.
//
//

#import "SXGoogleImageSearchResult.h"

@implementation SXGoogleImageSearchResult

- (instancetype)initWithThumbnail:(UIImage *)thumbnail
                     thumbnailURL:(NSURL *)thumbnailURL
                         imageURL:(NSURL *)imageURL
{
    if (self = [super init]) {
        _thumbnail = thumbnail;
        _thumbnailURL = [thumbnailURL copy];
        _imageURL = [imageURL copy];
    }
    return self;
}

@end
