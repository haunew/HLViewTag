//
//  ViewController.m
//  HLViewTagExample
//
//  Created by 刘昊 on 2019/11/27.
//  Copyright © 2019 刘昊. All rights reserved.
//

#import "ViewController.h"
#import "UIView+HLViewTag.h"
@interface ViewController ()
@property(nonatomic,weak)UILabel *lable;
@property(nonatomic,weak)UIImageView *img;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /**
     添加视图
     ****************************************************/
    UIView *baseView = [[UIView alloc] init];
    [self.view addSubview:baseView];
    self.view.name = @"mother";
    
    UIView *tagView = nil;
    
    for (NSInteger li = 0; li < 5; ++li) {
        UILabel *lable = [[UILabel alloc] init];
        [baseView addSubview:lable];
        if(li == 3){
            lable.name = @"lable";
            lable.tag = 105;
            _lable = lable;
        }
        if(li == 4){
            for (NSInteger ii = 0; ii < 10; ++ii) {
                UIImageView *img = [[UIImageView alloc] init];
                [lable addSubview:img];
                if(ii == 4){
                    img.name = @"img";
                    img.tag = 110;
                    _img = img;
                }
                if(ii == 6){
                    for (NSInteger bi = 0; bi < 15; ++bi) {
                        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                        [img addSubview:button];
                        if(bi == 13){
                            button.name = @"button";
                            button.tag = 115;
                        }
                    }
                }
                if(ii == 8){
                    tagView = img;
                }
            }
        }
    }
    /**
     viewWithName
     以该调用对象为根节点(包括自己)向下从子视图中遍历寻找以name命名的View
     ****************************************************/
    [self function1];
    /**
     viewDeepLoopWithTag
     以该视图控制器的View为根节点(包括自己)向下从子视图中遍历寻找Tag相等的View
     ****************************************************/
    [self function2:tagView];
    /**
     viewDeepLoopWithName
     以该视图控制器的View为根节点(包括自己)向下从子视图中遍历寻找以name命名的View
     ****************************************************/
    [self function3:tagView];
}
-(void)function1{
    NSLog(@"tag:%@",[self.view viewWithTag:115]);
    NSLog(@"name:%@",[self.view viewWithName:@"button"]);
    /**
     tag:<UIButton: 0x7fbffcc11ca0; frame = (0 0; 0 0); opaque = NO; tag = 115; layer = <CALayer: 0x600000dada80>>
     name:<UIButton: 0x7fbffcc11ca0; frame = (0 0; 0 0); opaque = NO; tag = 115; layer = <CALayer: 0x600000dada80>>
     */
}
-(void)function2:(UIView *)tagView{
    NSLog(@"lable:%@",self.lable);
    NSLog(@"DeepLoopTag:%@",[tagView viewDeepLoopWithTag:105]);
    NSLog(@"tag:%@",[tagView viewWithTag:105]);
    /**
     lable:<UILabel: 0x7f89d2618ed0; frame = (0 0; 0 0); userInteractionEnabled = NO; tag = 105; layer = <_UILabelLayer: 0x600000128910>>
     DeepLoopTag:<UILabel: 0x7f89d2618ed0; frame = (0 0; 0 0); userInteractionEnabled = NO; tag = 105; layer = <_UILabelLayer: 0x600000128910>>
     tag:(null)
     */
}
-(void)function3:(UIView *)tagView{
    NSLog(@"img:%@",self.img);
    NSLog(@"DeepLoopTag:%@",[tagView viewDeepLoopWithName:@"img"]);
    NSLog(@"name:%@",[tagView viewWithName:@"img"]);
    /**
     img:<UIImageView: 0x7ff72a4179d0; frame = (0 0; 0 0); userInteractionEnabled = NO; tag = 110; layer = <CALayer: 0x600000d0da60>>
     DeepLoopName:<UIImageView: 0x7ff72a4179d0; frame = (0 0; 0 0); userInteractionEnabled = NO; tag = 110; layer = <CALayer: 0x600000d0da60>>
     name:(null)
     */
}
@end
