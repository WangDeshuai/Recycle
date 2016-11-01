//
//  ZidingYiAlert.m
//  Recycle
//
//  Created by Macx on 16/7/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZidingYiAlert.h"
@interface ZidingYiAlert()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * name;
    NSString * phoneNumber;
    NSString * tell;
}
@property(nonatomic,retain)UITableView * tableView;
@end
@implementation ZidingYiAlert
- (id)initWithTitle:(NSString*)title alerMessage:(GongQiuXiangXiModel*)message canCleBtn:(NSString*)btnName1{
    self=[super init];
    if (self) {
        UIImageView * imageview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 606/2*KUAN/375, 385/2*GAO/667)];
        imageview.userInteractionEnabled=YES;
        imageview.image=[UIImage imageNamed:@"bg(3)"];
        [self addSubview:imageview];
         self.bounds = CGRectMake(0, 0, 606/2*KUAN/375, 385/2*GAO/667);
       
        UILabel * titleLabel =[UILabel new];
        //UILabel * messageLable =[UILabel new];
        UIButton * canBtn =[UIButton new];
        
        titleLabel.text=title;
      //  messageLable.text=message;//UIControlStateSelected
        [canBtn setTitle:btnName1 forState:UIControlStateNormal];
        canBtn.tag=1;
        titleLabel.font=[UIFont systemFontOfSize:18];
       // messageLable.font=[UIFont systemFontOfSize:14];
      //  messageLable.alpha=.7;
        canBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [canBtn setTitleColor:[UIColor whiteColor] forState:0];
        [canBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [canBtn setBackgroundImage:[UIImage imageNamed:@"bt-bg"] forState:0];
      //  messageLable.textAlignment=1;
        titleLabel.textAlignment=1;
     //   messageLable.adjustsFontSizeToFitWidth=YES;
        name=message.username;
        phoneNumber=message.handtel;
        tell=message.tell;
        self.tableView=[[UITableView alloc]init];
        self.tableView.dataSource=self;
        self.tableView.delegate=self;
        self.tableView.rowHeight=35;
        self.tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [imageview sd_addSubviews:@[titleLabel,canBtn,self.tableView]];
        
        UIView * bb =imageview;
        
        
        titleLabel.sd_layout
        .topSpaceToView(bb,20)
        .centerXEqualToView(bb)
        .heightIs(30);
        //到时候换成高度自适应
        [titleLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
        
        _tableView.sd_layout
        .leftSpaceToView(bb,10)
        .rightSpaceToView(bb,10)
        .topSpaceToView(titleLabel,5)
        .heightIs(70);
        
        
        
        canBtn.sd_layout
        .bottomSpaceToView(bb,15)
        .centerXEqualToView(bb)
        .widthIs(157/2)
        .heightIs(68/2);

        
        
    }
    
    return self;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * idd =@"Cell";
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:idd];
    }
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    cell.textLabel.font=[UIFont systemFontOfSize:15];
    if (indexPath.row==0) {
        cell.textLabel.text=name;
         cell.detailTextLabel.text=phoneNumber;
    }
    
   
   
   
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    [Engine tellPhone:phoneNumber];
    
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
    int a =(int)btn.tag;
    self.clickBlock(a);

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
