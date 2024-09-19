//
//  ViewController.m
//  01-消息循环
//
//  Created by swan on 2024/9/18.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    NSTimer *time = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(demo) userInfo:nil repeats:YES];
//    // 把定时器添加到 消息循环中
//    [[NSRunLoop currentRunLoop] addTimer:time forMode:NSRunLoopCommonModes];

    // 消息循环是在一个指定的模式下运行的，设置的输入事件也需要指定一个模式默认的模式NSDefaultRunLoopMode，消息循环的模式必须和输入事件的模式匹配才会执行
    //UITrackingRunLoopMode 当滚动scrollView的时候，消息循环的模式自动改变

    // --------------------子线程消息循环
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo) object:nil];
    [thread start];

    // 往子线程的消息循环中添加输入源
    [self performSelector:@selector(demo1) onThread:thread withObject:nil waitUntilDone:NO];

}

-(void)demo{
    NSLog(@"hello");
    // 开启子线程的消息循环，如果开启，消息循环一直运行
    // 当消息循环中没有添加输入事件，消息循环会立即结束
//    [[NSRunLoop currentRunLoop] run];

    // 2秒之后 消息循环会结束
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    NSLog(@"end");
}

-(void)demo1{
    NSLog(@"I'm running on runloop");
}


@end
