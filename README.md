# HLViewTag
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/language-OC-orange.svg)
[![](https://img.shields.io/badge/email-haunew@yeah.net-blue.svg)](https://twitter.com/EyreFree777)

`view.tag`标记扩展，视图添加字符串标记`name`

### 基础方法
```objective-c
self.view.name = @"view";
self.view.tag = 100;
```
类似系统属性`tag`，可通过属性`name`寻找控件

### name浅寻找
```objective-c
-(UIView *)viewWithName:(NSString *)name;
```
类似系统方法`viewWithTag:`以该调用对象为根节点(包括自己)向下从子视图中遍历寻找以name命名的控件

注意：只能寻找该对象子视图中的name

### 深寻找
```objective-c
-(UIView *)viewDeepLoopWithName:(NSString *)name;
-(UIView *)viewDeepLoopWithTag:(NSUInteger)tag;
```
以该控件控制器的View为根节点(包括自己)向下从子视图中遍历寻找

可通过`name/tag`寻找祖先视图、兄弟视图、子视图、控制器的view

注意：
1. 使用深度寻找需要保证在该控制器下`name/tag`唯一，否则会随机寻找其中一个
2. 保证该对象添加到了控制器，否则查找不到，浅寻找没有该问题
3. 效率低

## example

```objective-c
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
```
