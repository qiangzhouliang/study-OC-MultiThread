//
//  NetWorkTools.h
//  02-GCD
//
//  Created by swan on 2024/9/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkTools : NSObject

+ (instancetype) sharedNetWorkTools;

+ (instancetype) sharedNetWorkToolsOnce;

@end

NS_ASSUME_NONNULL_END
