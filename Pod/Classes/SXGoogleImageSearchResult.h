//
//  SXGoogleImageSearchResult.h
//  Pods
//
//  Created by Xiao Xiao on 16/2/24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SXGoogleImageSearchResult : NSObject

@property (nonatomic, retain, readonly) UIImage *thumbnail;
@property (nonatomic, copy, readonly) NSURL *thumbnailURL;
@property (nonatomic, copy, readonly) NSURL *imageURL;

- (instancetype)initWithThumbnail:(UIImage *)thumbnail
                     thumbnailURL:(NSURL *)thumbnailURL
                         imageURL:(NSURL *)imageURL;
@end
