//
//  GCPopMenuItem.m
//  GCObjectDemo
//
//  Created by yons on 2020/8/20.
//  Copyright © 2020 yons. All rights reserved.
//

#import "GCPopMenuItem.h"

@implementation GCPopMenuItem
+ (instancetype)itemWithTitle:(NSString *)title image:(UIImage *_Nullable)image userinfo:(id _Nullable)userinfo{
    GCPopMenuItem *item = [[GCPopMenuItem alloc] init];
    item.title = title;
    item.image = image;
    item.userinfo = userinfo;
    return item;
}
@end
