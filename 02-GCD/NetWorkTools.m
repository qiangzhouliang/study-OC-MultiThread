//
//  NetWorkTools.m
//  02-GCD - 单例方法
//
//  Created by swan on 2024/9/18.
//

#import "NetWorkTools.h"

@implementation NetWorkTools


+ (instancetype) sharedNetWorkTools{
    static id instance = nil;
    //线程同步，保证线程安全
    @synchronized (self) {
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    }
    return instance;

}

+ (instancetype) sharedNetWorkToolsOnce{
    static id instance = nil;
    static dispatch_once_t onceToken;
    // 只执行一次 dispatch_once本身就是线程安全的
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}

@end
