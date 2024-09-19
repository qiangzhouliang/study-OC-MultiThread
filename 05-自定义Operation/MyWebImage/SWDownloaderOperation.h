//
//  SWDownloaderOperation.h
//  05-自定义Operation
//
//  Created by swan on 2024/9/18.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWDownloaderOperation : NSOperation

// 要下载图片的地址
@property (nonatomic, copy) NSString *urlString;
// 执行完成后，回调的block
@property (nonatomic, copy) void (^finishedBlock)(UIImage *img);

+(instancetype)downloaderOperationWithUrlString: (NSString *)urlString finishedBlock: (void(^)(UIImage *img))finishedBlock;
@end

NS_ASSUME_NONNULL_END
