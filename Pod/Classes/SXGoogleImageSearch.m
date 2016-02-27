//
//  SXGoogleImageSearch.m
//  Pods
//
//  Created by Xiao Xiao on 16/2/24.
//
//

#import "SXGoogleImageSearch.h"
#import "SXGoogleImageSearchResult.h"

static NSString *kErrorDomain = @"GoogleImageSearchError";

@interface SXGoogleImageSearch()<UIWebViewDelegate>

@end

@implementation SXGoogleImageSearch {
    UIWebView *_dummyWebView;
}

+ (instancetype)sharedImageSearch
{
    static SXGoogleImageSearch *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SXGoogleImageSearch new];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _dummyWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _dummyWebView.delegate = self;
    }
    return self;
}

- (void)setup
{
    [_dummyWebView removeFromSuperview];
    UIView * topView = [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
    [topView addSubview:_dummyWebView];
}

- (void)query:(NSString *)key
{
    NSString *trimmedKey = [key stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSURL *queryURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.google.com/search?um=1&newwindow=1&es_sm=91&authuser=0&tbm=isch&sa=1&q=%@&oq=%@", trimmedKey, trimmedKey]];
    NSURLRequest *request = [NSURLRequest requestWithURL:queryURL];
    [_dummyWebView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *rawResults = [_dummyWebView stringByEvaluatingJavaScriptFromString:[self _imageParseScript]];
    NSArray *results = [self _parseWebViewResults:rawResults];
    [self.delegate googleImageSearch:self didGetResults:results];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(googleImageSearch:didFailLoadWithError:)]) {
        NSError *error = [NSError errorWithDomain:kErrorDomain code:-1 userInfo:nil];
        [self.delegate googleImageSearch:self didFailLoadWithError:error];
    }
}

- (NSString *)_imageParseScript
{
    return
        @"function parseBase64Str(rawStr) {" \
            @"if (rawStr.indexOf('data:image/jpeg;base64,') == 0) {" \
                @"return 'data:image/jpeg;base64,'.length;"\
            @"} else if (rawStr.indexOf('data:image/png;base64,') == 0) {" \
                @"return 'data:image/png;base64,'.length;" \
            @"} else {" \
                @"return -1;" \
            @"}" \
        @"}" \
        @"function parseImage() {" \
            @"var imageNodes = document.getElementsByClassName('rg_i');" \
            @"var results = [];" \
            @"for (var i = 0; i < imageNodes.length; i++) {" \
                @"if (imageNodes[i].src != null && imageNodes[i].src.length > 0) {" \
                    @"var googleImageURL = imageNodes[i].parentElement.href;" \
                    @"var query = googleImageURL.split('?')[1];" \
                    @"var params = query.split('&');" \
                    @"var attrs = {};" \
                    @"for (var j = 0; j < params.length; j++) {" \
                        @"var pair = params[j].split('=');" \
                        @"attrs[pair[0]] = pair[1];" \
                    @"}" \
                    @"results.push(attrs['imgurl']);" \
                    @"var imageSrc = imageNodes[i].src;" \
                    @"var offset = parseBase64Str(imageSrc);" \
                    @"results.push(imageNodes[i].src.substring(offset));" \
                @"}" \
            @"}" \
            @"return results.join('***');" \
        @"}" \
        @"parseImage();";
}

- (NSArray *)_parseWebViewResults:(NSString *)rawResult
{
    NSMutableArray *results = [NSMutableArray new];
    NSArray *elements = [rawResult componentsSeparatedByString:@"***"];
    if ([elements count] == 1) {
        return nil;
    }
    for (NSUInteger i = 0; i < [elements count]; i += 2) {
        NSURL *imageURL = [NSURL URLWithString:elements[i]];
        NSString *thumbnailSrc = elements[i + 1];
        if ([thumbnailSrc hasPrefix:@"http"]) {
            [results addObject:[[SXGoogleImageSearchResult alloc] initWithThumbnail:nil
                                                                       thumbnailURL:[NSURL URLWithString:thumbnailSrc]
                                                                           imageURL:imageURL]];
        } else {
            NSData *thumbnailData = [[NSData alloc] initWithBase64EncodedString:thumbnailSrc options:0];
            [results addObject:[[SXGoogleImageSearchResult alloc] initWithThumbnail:[[UIImage alloc] initWithData:thumbnailData]
                                                                      thumbnailURL:nil
                                                                          imageURL:imageURL]];
        }
    }
    return results;
}

@end
