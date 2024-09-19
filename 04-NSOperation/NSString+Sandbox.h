//
//  NSString+Sandbox.h
//  04-NSOperation
//
//  Created by swan on 2024/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Sandbox)
/// 获取缓存目录并拼接文件名
-(instancetype)appendCache;
/// 获取temp目录并拼接文件名
-(instancetype)appendTemp;
/// 获取Document目录并拼接文件名
-(instancetype)appendDocument;

@end

NS_ASSUME_NONNULL_END
