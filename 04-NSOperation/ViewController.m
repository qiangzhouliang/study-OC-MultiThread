//
//  ViewController.m
//  04-NSOperation
//
//  Created by swan on 2024/9/18.
//

#import "ViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface ViewController ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ViewController

/// 懒加载
- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc]init];
    }
    return _queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self 线程间通信];
//    [self 最大并发数];
//    [self 操作优先级];
//    [self 操作依赖];
    UIImageView *imageView = [[UIImageView alloc]init];
    NSURL *url = [NSURL URLWithString:@"https://pic.rmb.bdstatic.com/bjh/events/672f7809f09c1976281e5a57fc0776fa.jpeg@h_1280"];
    [imageView sd_setImageWithURL:url];
    imageView.frame= self.view.frame;
//    [imageView sizeToFit];
    [self.view addSubview:imageView];
}

-(void)操作依赖{
    // 操作1 - 下载
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载 %@", [NSThread currentThread]);
    }];
    // 操作2 - 解压
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"解压 %@", [NSThread currentThread]);
    }];
    // 操作3 - 升级完成
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"升级完成 %@", [NSThread currentThread]);
    }];
    // 设置操作间依赖
    [op2 addDependency:op1];
    [op3 addDependency:op2];

    [self.queue addOperations:@[op1, op2] waitUntilFinished:NO];
    // 依赖关系可以跨队列执行
    [[NSOperationQueue mainQueue] addOperation:op3];

}

-(void)操作优先级{
    // 操作1
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"op1 %d", i);
        }
    }];
    // 设置优先级最高
    op1.qualityOfService = NSQualityOfServiceUserInteractive;
    [self.queue addOperation:op1];
    [op1 setCompletionBlock:^{
        NSLog(@"op1 执行完成");
    }];

    // 操作2
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 10; i++) {
            NSLog(@"op2 %d", i);
        }
    }];
    // 设置优先级最低
    op2.qualityOfService = NSQualityOfServiceBackground;
    [self.queue addOperation:op2];
    [op2 setCompletionBlock:^{
        NSLog(@"op2 执行完成");
    }];

}

-(void)最大并发数{
    // 设置最大并发数（并不是线程数）
    self.queue.maxConcurrentOperationCount = 2;

    for (int i = 0; i < 20; i++) {
        [self.queue addOperationWithBlock:^{
            [NSThread sleepForTimeInterval:2.0];
            NSLog(@"hello %d %@", i, [NSThread currentThread]);
        }];
    }

}

-(void)线程间通信{
    [self.queue addOperationWithBlock:^{
        // 异步下载图片
        NSLog(@"异步下载图片%@", [NSThread currentThread]);

        // 线程间通信，回到主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"下载成功，更新UI %@", [NSThread currentThread]);
        }];

    }];
}

// -----------------------------------
/// NSInvocationOperation
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //创建操作
////    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
////    [op start]; // 不开启线程
//
//    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(demo) object:nil];
//    // 创建队列
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//
//    // 把操作添加到队列中
//    [queue addOperation:op];
//}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //创建操作
//    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"hello %@", [NSThread currentThread]);
//    }];

    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        NSLog(@"hello %@", [NSThread currentThread]);
    }];

    // 把操作添加到队列中
//    [queue addOperation:op];
}


-(void)demo{
    NSLog(@"hello %@", [NSThread currentThread]);
}

@end
