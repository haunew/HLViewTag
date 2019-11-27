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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *lable = [[UILabel alloc] init];
    lable.name = @"name";
    [self.view addSubview:lable];
    UIView *tagView = nil;
    for (NSInteger i = 0; i < 5; ++i) {
        UIView *view = [[UIView alloc] init];
        
        [self.view addSubview:view];
        if(i == 3){
            for (NSInteger i = 0; i < 10; ++i) {
                UIView *view2 = [[UIView alloc] init];
                [view addSubview:view2];
                if(i == 3){
                    tagView = view2;
                }
                if(i ==7){
                    for (NSInteger i = 0; i < 15; ++i) {
                        UIView *view3 = [[UIView alloc] init];
                        [view2 addSubview:view3];
                        if(i == 11){
                            view3.name = @"liuhao";
                            NSLog(@"%@",view3);
                        }
                    }
                }
                
            }
        }
    }
    NSLog(@"%@",[tagView viewDeepLoopWithName:@"liuhao"]);
    [self add];
}
-(void)add{
    NSLog(@"%@",[self.view viewWithName:@"liuhao"]);
}

@end
