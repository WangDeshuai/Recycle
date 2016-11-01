//
//  CustomAlert.m
//  AlertBlock
//
//  Created by laoyu on 15/11/24.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "CustomAlert.h"
#import "UIView+SDAutoLayout.h"
@implementation CustomAlert

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTitle:(NSString*)title alerMessage:(NSString*)message canCleBtn:(NSString*)btnName1 otheBtn:(NSString*)btnName2{
    self=[super init];
    if (self) {
        
       
        
        UIImageView * imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 624/2, 360/2)];
        imageview.userInteractionEnabled=YES;
        imageview.image=[UIImage imageNamed:@"Prompt_bg"];
        [self addSubview:imageview];
        
        self.bounds = CGRectMake(0, 0, 624/2, 360/2);
       // self.backgroundColor=[UIColor whiteColor];
        UILabel * titleLabel =[UILabel new];
        UILabel * messageLable =[UILabel new];
        UIButton * canBtn =[UIButton new];
        UIButton * otherBtn =[UIButton new];
        canBtn.tag=0;
        otherBtn.tag=1;
        titleLabel.text=title;
        messageLable.text=message;//UIControlStateSelected
        [canBtn setTitle:btnName1 forState:UIControlStateNormal];
        [otherBtn setTitle:btnName2 forState:UIControlStateNormal];
        
        titleLabel.font=[UIFont systemFontOfSize:18];
        messageLable.font=[UIFont systemFontOfSize:14];
        messageLable.alpha=.7;
        canBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        otherBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        
        [otherBtn setTitleColor:[UIColor redColor] forState:0];
         [canBtn setTitleColor:[UIColor grayColor] forState:0];
        messageLable.textAlignment=1;
        titleLabel.textAlignment=1;
//        titleLabel.backgroundColor=[UIColor yellowColor];
//        messageLable.backgroundColor=[UIColor redColor];
//        canBtn.backgroundColor=[UIColor blueColor];
//        otherBtn.backgroundColor=[UIColor magentaColor];
        
        messageLable.adjustsFontSizeToFitWidth=YES;
//        otherBtn.layer.borderWidth=1;
//        canBtn.layer.borderWidth=1;
//        otherBtn.layer.borderColor=[[UIColor grayColor]CGColor];
//        canBtn.layer.borderColor=[[UIColor grayColor]CGColor];
//        otherBtn.clipsToBounds=YES;
//        canBtn.clipsToBounds=YES;
        
         [otherBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
         [canBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [imageview sd_addSubviews:@[titleLabel,messageLable,canBtn,otherBtn]];
        
        UIView * bb =imageview;
        
        
        titleLabel.sd_layout
        .topSpaceToView(bb,20)
        .centerXEqualToView(bb)
        .heightIs(30);
        //到时候换成高度自适应
        [titleLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
        
        messageLable.sd_layout
        .leftSpaceToView(bb,10)
        .rightSpaceToView(bb,10)
        .topSpaceToView(titleLabel,5)
        .heightIs(60);
        
        
        
        canBtn.sd_layout
        .bottomSpaceToView(bb,10)
        .leftSpaceToView(bb,10)
        .widthIs((bb.frame.size.width-20)/2)
        .heightIs(40);
        
        otherBtn.sd_layout
        .bottomSpaceToView(bb,10)
        .rightSpaceToView(bb,10)
        .widthIs((bb.frame.size.width-20)/2)
        .heightIs(40);
        
        
        
    }
    
    return self;
    
}














- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    //设置中心点
    self.center = window.center;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.5;
    view.tag=1000;
    //[window addSubview:view];
    [window addSubview:self];
    
}
-(void)dissmiss{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    [view removeFromSuperview];
    [self removeFromSuperview];
    
}


- (void)btnClick:(UIButton *)btn{
    //这中方式是要遵循代理
    //[_delegate1 clickBtnWithIndex:btn.tag];
    
    //block 的参数是int 类型，调用当然传一个int类型的数值
    int a =(int)btn.tag;
    self.clickBlock(a);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
