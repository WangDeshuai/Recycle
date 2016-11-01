//
//  ZiXunViewController.m
//  Recycle
//
//  Created by Macx on 16/5/27.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZiXunViewController.h"
#import "TYTabButtonPagerController.h"
#import "ZiXunFenLeiModel.h"
#import "ZiXunTableView.h"
#import "ZiXunClassVC.h"
@interface ZiXunViewController ()<TYPagerControllerDataSource>
{
   //TYTabButtonPagerController *pagerController ;
}
@property (nonatomic,retain)NSMutableArray * titleNameArray;
@property (nonatomic,retain)NSMutableArray * classIdArray;
@property (nonatomic,retain)NSMutableArray * dataArray;
@property (nonatomic, strong) TYTabButtonPagerController *pagerController;

@end

@implementation ZiXunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //   self.automaticallyAdjustsScrollViewInsets = NO;
    [self daohangView];
    _titleNameArray=[NSMutableArray new];
    _classIdArray=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
    [self zixunfenlei];//获取资讯分类标题内容
    
    

   
    
}


-(void)zixunfenlei
{
    [Engine getZiFenLeisuccess:^(NSDictionary *dic) {
        
        NSArray * array =[dic objectForKey:@"Item3"];
        for (NSDictionary * dic in array) {
            
            ZiXunFenLeiModel * model1 =[[ZiXunFenLeiModel alloc]initWithDic:dic];
            [_titleNameArray addObject:model1.titleName];
            [_classIdArray addObject:model1.classID];
            [_dataArray addObject:model1];
        }
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
         [self addPagerController];
    } error:^(NSError *error) {
        
    }];
    
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _pagerController.view.frame = self.view.bounds;
}

- (void)addPagerController
{
   _pagerController = [[TYTabButtonPagerController alloc]init];
    
    _pagerController.dataSource = self;
    _pagerController.adjustStatusBarHeight = YES;
    //pagerController.cellWidth = 56;
    _pagerController.cellSpacing = 8;
    _pagerController.normalTextFont=[UIFont systemFontOfSize:13];
    _pagerController.selectedTextFont=[UIFont systemFontOfSize:15];
    _pagerController.pagerBarColor= [UIColor whiteColor];    _pagerController.barStyle = _variable ? TYPagerBarStyleProgressBounceView: TYPagerBarStyleProgressView;
    
    if (_showNavBar) {
        _pagerController.progressWidth = _variable ? 0 : 36;
    }
   
    _pagerController.view.frame = self.view.bounds;
    [self addChildViewController:_pagerController];
    [self.view addSubview:_pagerController.view];
  //  _pagerController = _pagerController;
   // [self scrollToRamdomIndex];
}

//- (void)scrollToRamdomIndex
//{
//    [_pagerController reloadData];
//   [_pagerController moveToControllerAtIndex:clssidd animated:YES];
//    
//}



#pragma mark - TYPagerControllerDataSource

- (NSInteger)numberOfControllersInPagerController
{
    return _titleNameArray.count;
}


- (NSString *)pagerController:(TYPagerController *)pagerController titleForIndex:(NSInteger)index
{
   
    
    return _titleNameArray[index];
    
}

- (UIViewController *)pagerController:(TYPagerController *)pagerController controllerForIndex:(NSInteger)index
{

    ZiXunTableView * vcc =[ZiXunTableView new];
    vcc.classID=_classIdArray[index];
    return vcc;
}



-(void)daohangView
{
    self.view.backgroundColor=COLOR;
   
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"资讯"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems=@[leftBtn];
    
    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(KUAN-47,27, 37/2, 37/2);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"sub_add(1)"] forState:0];
    [rightBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
   
    self.navigationItem.rightBarButtonItems=@[right];

    
}











-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtn{
    ZiXunClassVC * vc =[ZiXunClassVC new];
    vc.dataArray=_dataArray;
    vc.classidBlock=^(NSInteger clsssidd){
        [_pagerController reloadData];
         [_pagerController moveToControllerAtIndex:clsssidd animated:YES];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
