//
//  GCPopMenuItem.m
//  GCObjectDemo
//
//  Created by yons on 2020/8/20.
//  Copyright © 2020 yons. All rights reserved.
//

#import "GCPopMenuItem.h"

@implementation GCPopMenuItem
+ (instancetype)itemWithTitle:(NSString *)title image:(id _Nullable )image block:(void(^)(void))block{
    GCPopMenuItem *item = [[GCPopMenuItem alloc] init];
    item.title = title;
    if ([image isKindOfClass:[UIImage class]]) {
        item.image = image;
    }else{
        item.imageUrl = image;
    }
    item.block = block;
    return item;
}
@end
