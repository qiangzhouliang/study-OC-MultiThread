//
//  ViewController.m
//  03-调度组
//
//  Created by swan on 2024/9/18.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

// 下载三首歌曲，当歌曲都下载完毕，通知用户
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self demo1];
}

//演示调度组的基本使用
-(void)demo1{
    // 创建组
    dispatch_group_t group = dispatch_group_create();
    // 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    // 下载第一首
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第一首 %@", [NSThread currentThread]);
    });
    // 下载第2首
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第2首 %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:2.0];
    });
    // 下载第3首
    dispatch_group_async(group, queue, ^{
        NSLog(@"正在下载第3首 %@", [NSThread currentThread]);
    });
    // 当三个异步任务都执行完成，才执行
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"都下载完成了 %@", [NSThread currentThread]);
    });
}

@end
