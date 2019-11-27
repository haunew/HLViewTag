//
//  UIView+HLViewTag.h
//  HLViewTagExample
//
//  Created by 刘昊 on 2019/11/27.
//  Copyright © 2019 刘昊. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HLViewTag)
@property (nonatomic, copy) NSString *name;
-(UIView *)viewWithName:(NSString *)name;
-(UIView *)viewDeepLoopWithName:(NSString *)name;
-(UIView *)viewDeepLoopWithTag:(NSUInteger)tag;
@end

NS_ASSUME_NONNULL_END
