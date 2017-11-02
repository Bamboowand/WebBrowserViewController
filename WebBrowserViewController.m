//
//  WebBrowserViewController.m
//  arplanetclient
//
//  Created by arplanet on 2016/9/10.
//  Copyright © 2016年 joe. All rights reserved.
//

#import "WebBrowserViewController.h"

@interface WebBrowserViewController (){
    UIActivityIndicatorView *indicatorView;
}

@end

@implementation WebBrowserViewController
@synthesize URL;

#pragma mark - Life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLayout];

    NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
    [webPage loadRequest:request];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Init
-(id)initWithAddress:(NSString *)urlString{
    return [self initWithURL:[NSURL URLWithString:urlString]];
}

-(id)initWithURL:(NSURL *)pageURL{
    if(self=[super init]){
        self.URL = pageURL;
        
    }
    return self;
}

#pragma mark - Layout
-(void)initLayout{
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                                target:self
                                                                                action:@selector(goBack:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    int screenWidth = [UIScreen mainScreen].bounds.size.width;
    int screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, screenHeight - 44, screenWidth, 44)];
    toolbar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                           target:self
                                                                           action:nil];
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(backAction:)];
    
    UIBarButtonItem *nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(nextAction:)];
    
    UIBarButtonItem *refreshButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Refresh"
                                                                          style:UIBarButtonItemStylePlain
                                                                         target:self
                                                                         action:@selector(refreshAction:)];
    NSArray* items;
    items=[NSArray arrayWithObjects:backButtonItem, space, refreshButtonItem, space, nextButtonItem,nil];
    
    [toolbar setItems:items animated:YES];
    toolbar.translatesAutoresizingMaskIntoConstraints=NO;
    [self.view addSubview:toolbar];
    
    webPage =[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth)];
    //    self.videoView.backgroundColor=[UIColor colorWithRed:1 green:0.33 blue:0.40 alpha:1.0];
    webPage.translatesAutoresizingMaskIntoConstraints=NO;
    webPage.delegate=self;
    [self.view addSubview:webPage];
    
    indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [indicatorView startAnimating];
    indicatorView.center =webPage.center;
    [indicatorView setHidesWhenStopped:YES];
    [indicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:indicatorView];
    
    //Add button constraints
    NSMutableDictionary * viewDict = [NSMutableDictionary dictionaryWithObject:webPage forKey:@"WebPage"];
    [viewDict setObject:toolbar forKey:@"ToolBar"];
    [viewDict setObject:self.view forKey:@"Window"];
    //    [viewDict setObject:indicatorView forKey:@"indicatorView"];
    
    NSString *horizontalConstrainsParam1=@"H:|[WebPage]|";
    NSString *horizontalConstrainsParam2=@"H:|[ToolBar]|";
    NSString *verticalConstrainsParam=@"V:|[WebPage][ToolBar(44)]|";
    //    NSString *indicatorViewConstrainsV=@"V:|[indicatorView][toolBar(44)]|";
    //    NSString *indicatorViewConstrainsH=@"H:|[indicatorView]|";
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:horizontalConstrainsParam1
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewDict
                               ]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:horizontalConstrainsParam2
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewDict
                               ]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:verticalConstrainsParam
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:viewDict]];
}
#pragma mark -
#pragma mark - Button action
- (IBAction)backAction:(id)sender{
    [webPage goBack];
}

- (IBAction)nextAction:(id)sender{
    [webPage goForward];
}

- (IBAction)refreshAction:(id)sender{
    [webPage reload];
}

-(IBAction)goBack:(id)sender{
//    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion: NULL];
}
#pragma mark -
#pragma mark UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [indicatorView startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [indicatorView stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
