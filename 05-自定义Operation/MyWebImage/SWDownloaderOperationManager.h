//
//  SWDownloaderOperationManager.h
//  05-自定义Operation
//
//  Created by swan on 2024/9/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SWDownloaderOperationManager : NSObject

/// 单例方法
+(instancetype)sharedManager;

- (void)downloadWithUrlString: (NSString *)urlString finishedBlock: (void(^)(UIImage *img))finishedBlock;

/// 取消操作
-(void)cancelOperation: (NSString *)urlString;
@end

NS_ASSUME_NONNULL_END
