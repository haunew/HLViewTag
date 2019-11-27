//
//  UIView+HLViewTag.m
//  HLViewTagExample
//
//  Created by 刘昊 on 2019/11/27.
//  Copyright © 2019 刘昊. All rights reserved.
//

#import "UIView+HLViewTag.h"
#import <objc/runtime.h>


@interface UIView (HLViewTagTool)
- (UIView *)zeroLevelView;
- (BOOL)verifyViewTag:(NSString *)viewTag;
- (UIView *)searchViewTag:(NSString *)viewTag;
- (UIView *)searchTag:(NSUInteger)tag;
@end

static const void *nameKey = &nameKey;

@implementation UIView (HLViewTag)
-(void)setName:(NSString *)name{
    objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
    return objc_getAssociatedObject(self, nameKey);
}
-(UIView *)viewWithName:(NSString *)name{
    if([self verifyViewTag:name]){
        if([self.name isEqualToString:name]){
            return self;
        }
        return [self searchViewTag:name];
    }
    return nil;
}
-(UIView *)viewDeepLoopWithName:(NSString *)name{
    UIView *zeroLevelView = [self zeroLevelView];
    if([self verifyViewTag:name] && zeroLevelView){
        if([zeroLevelView.name isEqualToString:name]){
            return zeroLevelView;
        }
        return [zeroLevelView searchViewTag:name];
    }
    return nil;
}
-(UIView *)viewDeepLoopWithTag:(NSUInteger)tag{
    UIView *zeroLevelView = [self zeroLevelView];
    if(tag != 0 && zeroLevelView){
        if(zeroLevelView.tag == tag){
            return zeroLevelView;
        }
        return [zeroLevelView searchTag:tag];
    }
    return nil;
}
@end

@implementation UIView (HLViewTagTool)
- (UIView *)zeroLevelView
{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            UIViewController *viewController = (UIViewController *)responder;
            return viewController.view;
        }
    }
    return nil;
}
- (UIView *)searchViewTag:(NSString *)viewTag{
    NSUInteger sIndex = 0;
    while (sIndex < self.subviews.count) {
        UIView *sView = [self.subviews objectAtIndex:sIndex++];
        if([sView.name isEqualToString:viewTag]){
            return sView;
        }
        UIView *dView = [sView searchViewTag:viewTag];
        if(dView != nil){
            return dView;
        }
    }
    return nil;
}
- (UIView *)searchTag:(NSUInteger)tag{
    NSUInteger sIndex = 0;
    while (sIndex < self.subviews.count) {
        UIView *sView = [self.subviews objectAtIndex:sIndex++];
        if(sView.tag == tag){
            return sView;
        }
        UIView *dView = [sView searchTag:tag];
        if(dView != nil){
            return dView;
        }
    }
    return nil;
}
- (BOOL)verifyViewTag:(NSString *)viewTag{
    return viewTag && [viewTag isKindOfClass:[NSString class]];
}
@end
