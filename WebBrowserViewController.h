//
//  WebBrowserViewController.h
//  arplanetclient
//
//  Created by arplanet on 2016/9/10.
//  Copyright © 2016年 joe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebBrowserViewController : UIViewController <UIWebViewDelegate> {
    UIWebView *webPage;
    UIToolbar* toolbar;
}
@property(nonatomic, strong) NSURL* URL;
-(id)initWithAddress:(NSString *)urlString;
-(id)initWithURL:(NSURL *)pageURL;

@end
