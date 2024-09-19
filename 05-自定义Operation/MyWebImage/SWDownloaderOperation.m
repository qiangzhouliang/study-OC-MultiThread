//
//  SWDownloaderOperation.m
//  05-自定义Operation
//
//  Created by swan on 2024/9/18.
//

#import "SWDownloaderOperation.h"
#import "NSString+Sandbox.h"

@implementation SWDownloaderOperation

+(instancetype)downloaderOperationWithUrlString: (NSString *)urlString finishedBlock: (void(^)(UIImage *img))finishedBlock{
    SWDownloaderOperation *op = [[SWDownloaderOperation alloc] init];
    op.urlString = urlString;
    op.finishedBlock = finishedBlock;
    return op;
}

- (void)main{
    @autoreleasepool {
        // 断言
        NSAssert(self.finishedBlock != nil, @"finishedBlock 不能为 nil");

        // 下载网络图片
        NSURL *url = [NSURL URLWithString:self.urlString];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *img = [UIImage imageWithData:data];
        // 缓存到沙盒中
        if (img) {
            [data writeToFile:[self.urlString appendCache] atomically:YES];
        }

        // 判断是否被取消  取消正在执行的操作
        if (self.isCancelled) {
            return;
        }

        NSLog(@"下载图片 %@  %@", self.urlString, [NSThread currentThread]);

        // 假设图片下载完成
        // 回到主线程跟新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.finishedBlock(img);
        }];
    }
}
@end
