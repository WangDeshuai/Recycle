//
//  ZongHeVC.m
//  Recycle
//
//  Created by Macx on 16/6/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZongHeVC.h"
#import "FirstModel.h"
@interface ZongHeVC (){
    UIScrollView * _bgScrollview;
}
@property(nonatomic,retain)NSMutableArray* dataArray;
@property(nonatomic,retain)UIButton* lastBtn;
@end

@implementation ZongHeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangView];
    _bgScrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    _bgScrollview.backgroundColor=COLOR;
    if (KUAN==320&&GAO==480) {
        _bgScrollview.contentSize=CGSizeMake(KUAN, GAO+100);
    }else{
         _bgScrollview.contentSize=CGSizeMake(0, 0);
    }
    [self.view addSubview:_bgScrollview];
    _dataArray=[NSMutableArray new];
    [self dataArr];
}


-(void)dataArr{
    [WINDOW showHUDWithText:@"数据加载中..." Type:ShowLoading Enabled:YES];
    [Engine HuoQuFirstHangYeMessageType:@"1" success:^(NSDictionary *dic) {
       [WINDOW showHUDWithText:@"加载成功" Type:ShowDismiss Enabled:YES];
        NSArray * array =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in array ) {
            FirstModel * model1 =[[FirstModel alloc]initWithDic:dicc];
            [_dataArray addObject:model1];
        }
        [self mokuai:_dataArray];
       
    } error:^(NSError *error) {
        [WINDOW showHUDWithText:@"网络超时" Type:ShowPhotoNo Enabled:YES];
    }];

}





-(void)mokuai:(NSMutableArray*)arr
{
    //间隔
    CGFloat x =5;
    CGFloat y =0;
    
    //大小
    CGFloat a =(KUAN-x*5)/4;
    CGFloat b =(KUAN-x*5)/7;
    
    
    for (int i =0 ; i<arr.count; i++) {
        FirstModel * model1 =_dataArray[i];
        
        CGFloat c =i%4;
        CGFloat d =i/4;
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
       [btn setBackgroundImage:[UIImage imageNamed:@"搜索btn"] forState:0];
        btn.frame=CGRectMake(5+(a+x)*c, 20+(y+b)*d, a, b);
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [btn setTitle:model1.Onename forState:0];
        btn.tag=i;
        btn.titleLabel.adjustsFontSizeToFitWidth=YES;
        [btn addTarget:self action:@selector(buttonClink:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
         [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5 , 0, 5)];
        _lastBtn=btn;
        [_bgScrollview addSubview:btn];
    }
    
}


-(void)buttonClink:(UIButton*)btn{
    
    _lastBtn.selected=NO;
    btn.selected=YES;
    _lastBtn=btn;
     FirstModel * model1 =_dataArray[btn.tag];
     self.CidBlock(model1.Cid);
     [self.navigationController popViewControllerAnimated:YES];
}







-(void)daohangView
{
    self.view.backgroundColor=COLOR;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"选择行业"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"123" forKey:@"key1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.navigationItem.leftBarButtonItems=@[leftBtn];
    
}
-(void)backWrite{
    [[NSUserDefaults standardUserDefaults]setObject:@"123" forKey:@"key1"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.navigationController popViewControllerAnimated:YES];
  //  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
