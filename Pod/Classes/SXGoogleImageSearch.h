//
//  SXGoogleImageSearch.h
//  Pods
//
//  Created by Xiao Xiao on 16/2/24.
//
//

#import <Foundation/Foundation.h>

@class SXGoogleImageSearch;

@protocol SXGoogleImageSearchDelegate <NSObject>

- (void)googleImageSearch:(SXGoogleImageSearch *)search didGetResults:(NSArray *)results;

@optional

- (void)googleImageSearch:(SXGoogleImageSearch *)search didFailLoadWithError:(NSError *)error;

@end

@interface SXGoogleImageSearch : NSObject

@property (nonatomic, weak) id<SXGoogleImageSearchDelegate> delegate;

+ (instancetype)sharedImageSearch;

- (void)setup;

- (void)query:(NSString *)key;

@end
