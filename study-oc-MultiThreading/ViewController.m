//
//  ViewController.m
//  study-oc-MultiThreading
//
//  Created by swan on 2024/9/16.
//

#import "ViewController.h"
#import <pthread/pthread.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testNSThread];


}



// ----------------------------------------------------
-(void)testNSThread{
    // 方式1
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(demo:) object:@"zs"];
    [thread start];


    // 方式2
//    [NSThread detachNewThreadSelector:@selector(demo) toTarget:self withObject:nil];
}

/// 模拟耗时操作
-(void)demo: (NSString *)name{
    NSLog(@"begin %@ %@", name,[NSThread currentThread]);
}

-(void)testPthread{
    /// 第一个参数：线程编号的地址
    /// 第二个参数：线程的属性
    /// 第三个参数：void *  （*） （void *）
    /// int * 指向int类型的指针 void * 指向任何类型的指针 有点类似OC中的id
    /// 第四个参数：要执行的函数的参数
    ///
    /// 函数的返回值 int  0 是成功  非0 是失败

    pthread_t pthread; // 线程编号
    char *name = "ZS";
    int result = pthread_create(&pthread, NULL, testThread, name);
    if (result == 0) {
        NSLog(@"成功");
    } else {
        NSLog(@"失败");
    }
}

void *testThread(void *param){
    NSLog(@"hello %s %@",param, [NSThread currentThread]);
    return NULL;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 界面卡死（阻塞）
//    [self demo];

    // 在后台运行
//    [self performSelectorInBackground:@selector(demo) withObject:nil];
}
/// 模拟耗时操作
-(void)demo{
    NSLog(@"begin %@", [NSThread currentThread]);
    for (int i = 0; i < 10000000; i++) {
//        NSString *str = [NSString stringWithFormat:@"hello%d", i];
    }
    NSLog(@"end");
}


@end
