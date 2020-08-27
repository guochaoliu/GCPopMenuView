//
//  GCPopMenuItem.h
//  GCObjectDemo
//
//  Created by yons on 2020/8/20.
//  Copyright © 2020 yons. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GCPopMenuItem : NSObject
/// title
@property (nonatomic, copy) NSString *title;
/// image
@property (nonatomic, strong) UIImage *image;
/// url
@property (nonatomic, strong) NSURL *imageUrl;
/// id
@property (nonatomic, copy) void(^block)(void);
/// 初始化
/// @param title title
/// @param image image
+ (instancetype)itemWithTitle:(NSString *)title image:(id _Nullable )image block:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
