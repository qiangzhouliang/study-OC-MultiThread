//
//  SWDownloaderOperationManager.m
//  05-自定义Operation
//
//  Created by swan on 2024/9/18.
//

#import "SWDownloaderOperationManager.h"
#import "SWDownloaderOperation.h"
#import "NSString+Sandbox.h"
// 1. 管理全局下载操作
// 2. 管理全局的缓存

@interface SWDownloaderOperationManager ()

// 全局队列
@property (nonatomic, strong) NSOperationQueue *queue;
// 下载操作缓存池
@property (nonatomic, strong) NSMutableDictionary *opertaionCache;
// 图片缓存池
@property (nonatomic, strong) NSCache *imageCache;


@end

@implementation SWDownloaderOperationManager

/// 懒加载
- (NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return _queue;
}
-(NSMutableDictionary *)opertaionCache{
    if (_opertaionCache == nil) {
        _opertaionCache = [NSMutableDictionary dictionaryWithCapacity:4];
    }
    return _opertaionCache;
}
-(NSCache *)imageCache{
    if (_imageCache == nil) {
        _imageCache = [[NSCache alloc] init];
        //
        _imageCache.countLimit = 50;
    }
    return _imageCache;
}


+(instancetype)sharedManager{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });

    return instance;
}

// 1. 管理全局下载操作
- (void)downloadWithUrlString: (NSString *)urlString finishedBlock: (void(^)(UIImage *img))finishedBlock{
    // 断言
    NSAssert(finishedBlock != nil, @"finishedBlock 不能为 nil");
    // 判断 如果下载操作已经存在 退出
    if (self.opertaionCache[urlString]) {
        return;
    }
    // 判断图片是否有缓存
    if ([self checkImageCache:urlString]) {
        finishedBlock([self.imageCache objectForKey:urlString]);
        return;
    }

    SWDownloaderOperation *op = [SWDownloaderOperation downloaderOperationWithUrlString:urlString finishedBlock:^(UIImage * _Nonnull img) {

        // 回调
        finishedBlock(img);

        // 缓存图片
        [self.imageCache setObject:img forKey:urlString];

        // 下载完成 移出缓存的操作
        [self.opertaionCache removeObjectForKey:urlString];
    }];

    [self.queue addOperation:op];
    // 缓存下载操作
    self.opertaionCache[urlString] = op;
}

/// 取消操作
-(void)cancelOperation: (NSString *)urlString{
    if (!urlString) {
        return;
    }

    // 取消操作
    [self.opertaionCache[urlString] cancel];
    // 从缓存池删除操作
    [self.opertaionCache removeObjectForKey:urlString];
}

/// 检查是否有缓存（内存和沙盒缓存）
-(Boolean)checkImageCache: (NSString *)urlString{
    // 检测内存缓存
    if ([self.imageCache objectForKey:urlString]) {
        NSLog(@"从内存加载图片");
        return YES;
    }

    // 检查沙盒缓存
    UIImage *img = [UIImage imageWithContentsOfFile:[urlString appendCache]];
    if (img) {
        // 保存到内存中
        [self.imageCache setObject:img forKey:urlString];
        NSLog(@"从沙盒加载图片");
        return YES;
    }

    return NO;
}
@end
