//
//  BaoJiaClassVC.m
//  Recycle
//
//  Created by Macx on 16/7/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "BaoJiaClassVC.h"
#import "BaoJiaModel.h"
@interface BaoJiaClassVC ()
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation BaoJiaClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self daohangView];
    _dataArray=[[NSMutableArray alloc]init];
    [self jieXiClassData];
}
-(void)jieXiClassData{
    [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
    [Engine baoJiaClassCid:@"-1" success:^(NSDictionary *dic) {
        NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([item1 isEqualToString:@"1"]) {
            [WINDOW showHUDWithText:@"加载成功" Type:ShowPhotoYes Enabled:YES];
            NSArray * item3 =[dic objectForKey:@"Item3"];
            for (NSDictionary * dicc in item3)
            {
                BaoJiaModel * md =[[BaoJiaModel alloc]initWithBaoJiaClass:dicc];
                [_dataArray addObject:md];
                
            }
            [self buttonSheJi:_dataArray];
            
        }
        
        
    } error:^(NSError *error) {
        [WINDOW showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
    }];
}

-(void)buttonSheJi:(NSMutableArray*)arr
{
    //间隔
    CGFloat x =5;
    CGFloat y =0;
    for (int i =0 ; i<arr.count; i++)
    {
         BaoJiaModel * model1 =arr[i];
        CGFloat  titleWidth= [Engine getWidthWithFontSize:15 height:30 string:model1.btnName];
       // NSLog(@">>>%f",titleWidth);
        CGFloat c =i%4;
        CGFloat d =i/4;
        CGFloat a ;//=(KUAN-x*5)/4;
        CGFloat b;
        if (titleWidth>90) {
             a =KUAN/4+35;
             b =(KUAN-x*5)/7;
        }else{
             a =(KUAN-x*5)/4;
             b =(KUAN-x*5)/7;
        }
        
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:@"搜索btn"] forState:0];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
         btn.frame=CGRectMake(5+(a+x)*c, 20+(y+b)*d, a, b);
        [btn setTitle:model1.btnName forState:0];
        [btn addTarget:self action:@selector(btnClink:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=i;
        [btn setTitleColor:[UIColor blackColor] forState:0];
         [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5 , 0, 5)];
        [self.view addSubview:btn];
    }
   
}
-(void)btnClink:(UIButton*)btn{
    BaoJiaModel * model1=_dataArray[btn.tag];
     self.CidBlock(model1.messageCid);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)daohangView
{
    self.view.backgroundColor=COLOR;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"报价"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems=@[leftBtn];
    
    
    
    
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
