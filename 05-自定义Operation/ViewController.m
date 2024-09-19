//
//  ViewController.m
//  05-自定义Operation
//
//  Created by swan on 2024/9/18.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame= self.view.frame;
    [self.view addSubview:imageView];

    [imageView setImageUrlString:@"https://pic.rmb.bdstatic.com/bjh/events/672f7809f09c1976281e5a57fc0776fa.jpeg@h_1280"];


}


@end
