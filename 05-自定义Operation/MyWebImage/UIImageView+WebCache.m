//
//  UIImageView+WebCache.m
//  05-自定义Operation
//
//  Created by swan on 2024/9/18.
//

#import "UIImageView+WebCache.h"
#import "SWDownloaderOperationManager.h"
#import <objc/runtime.h>

@interface UIImageView ()

// 记录当前点击的图片的地址
@property (nonatomic, copy) NSString *currentURLString;

@end

@implementation UIImageView (WebCache)

// 在分类中增加属性，必须自己写属性的getter和setter方法
-(NSString *)currentURLString{
    return objc_getAssociatedObject(self, "currentURLString");
}

-(void)setCurrentURLString:(NSString *)currentURLString{
    //可以在运行期间给某个对象增加属性
    // 关联对象
    objc_setAssociatedObject(self, "currentURLString", currentURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setImageUrlString: (NSString *)urlString{
    //判断当前点击的图片地址，和上一次图片的地址，是否一样，如果不一样，取消上一次操作
    if (![urlString isEqualToString:self.currentURLString]) {
        // 取消上一次操作
        [[SWDownloaderOperationManager sharedManager] cancelOperation:urlString];
    }

    // 记录当前点击图片的地址
    self.currentURLString = urlString;

    [[SWDownloaderOperationManager sharedManager] downloadWithUrlString:urlString finishedBlock:^(UIImage * _Nonnull img) {
        self.image = img;
    }];
}

@end
