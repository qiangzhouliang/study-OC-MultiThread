//
//  ViewController.m
//  02-GCD
//
//  Created by swan on 2024/9/18.
//

#import "ViewController.h"
#import "NetWorkTools.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self demo7];

    
}

/**********主队列*********/
/// 主队列，同步执行  --- 主线程上执行才会死锁
/// 同步执行：会等着第一个任务执行完成，才会继续往后执行
-(void)demo5{
    // 主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    for (int i = 0; i < 10; i++) {
        // 死锁
        dispatch_sync(queue, ^{
            NSLog(@"hello  %d %@", i,[NSThread currentThread]);
        });
    }

}
/// 解决死锁问题
-(void)demo7{
    // 主队列
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 10; i++) {
            // 死锁
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"hello  %d %@", i,[NSThread currentThread]);
            });
        }
    });
}

/// 主队列，异步执行  主线程  任务是按顺序执行
/// 主队列的特点：先执行完主线程上的代码，才会执行主队列中的任务
-(void)demo6{
    // 并行队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"hello  %d %@", i,[NSThread currentThread]);
        });
    }

}

/**********并行队列*********/
/// 并行队列，同步执行 不开启线程  任务是按顺序执行
-(void)demo3{
    // 并行队列
    dispatch_queue_t queue = dispatch_queue_create("SW", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"hello  %d %@", i,[NSThread currentThread]);
        });
    }

}

/// 并行队列，异步执行 开启多个线程  无序执行
-(void)demo4{
    // 并行队列
    dispatch_queue_t queue = dispatch_queue_create("SW", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"hello  %d %@", i,[NSThread currentThread]);
        });
    }

}

/**********串行队列*********/

/// 串行队列，同步执行 不开启线程,任务是按顺序执行
-(void)demo1{
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("SW", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"hello  %d %@", i,[NSThread currentThread]);
        });
    }

}

/// 串行队列，异步执行 开启新线程（1个），任务是有序执行
-(void)demo2{
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("SW", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"hello  %d %@", i,[NSThread currentThread]);
        });
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

//    // 1. 创建队列
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//
//    // 2. 创建任务
//    dispatch_block_t task = ^{
//        NSLog(@"hello %@", [NSThread currentThread]);
//    };
//
//    // 3. 异步执行
//    dispatch_async(queue, task);

    // 简化写法
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"hello %@", [NSThread currentThread]);
        dispatch_sync(dispatch_get_main_queue(), ^{

        });
    });
}


@end
