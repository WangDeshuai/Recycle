//
//  ShengJiTeQuanVC.m
//  Recycle
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShengJiTeQuanVC.h"
#import "ShengJiTeQuanCell.h"
#import "FuWuXiangqingVC.h"
#import "FuKuanStayVC.h"
#import "VipQuanXianModel.h"
@interface ShengJiTeQuanVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UIImageView * imageview;
    UIButton * btnFuWu;
    UIButton * btnYear;
    NSInteger tagg;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * array1;
@property(nonatomic,retain)NSMutableArray * sixImageArray;
@property(nonatomic,retain)NSMutableArray * imageArr;
@end

@implementation ShengJiTeQuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangtiao];
    
    _array1=[[NSMutableArray alloc]initWithObjects:@"  海量商机",@"【暴利】宣传",@"  私人秘书", nil];
//    _imageArr=[[NSMutableArray alloc]initWithObjects:@"0te1",@"0te2",@"0te3", nil];
    
    _sixImageArray=[NSMutableArray new];
   [self picImageData];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_tableView];
  

    for (int i = 0; i<2; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor=[UIColor whiteColor];
        btn.frame=CGRectMake(0+(KUAN/2)*i, GAO-50-64, KUAN/2, 50);
        if (i==0) {
            [btn setTitle:@"付款方式" forState:0];
        }else{
             [btn setTitle:@"联系购买" forState:0];
        }
        [btn setTitleColor:[UIColor redColor] forState:0];
        btn.tag=i;
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_tableView addSubview:btn];
    }
    


}

-(void)picImageData{
    [Engine shengJiTeQuanYeMiansuccess:^(NSDictionary *dic) {
        if ([dic objectForKey:@"Item3"]==[NSNull null]) {
            return ;
        }
        NSArray * arr =[dic objectForKey:@"Item3"];
        for (NSDictionary * dicc in arr)
        {
            VipQuanXianModel * model =[[VipQuanXianModel alloc]initWithShengJiTeQuanDic:dicc];
            [_sixImageArray addObject:model];
        }
        [self headView];
    } error:^(NSError *error) {
        
    }];
}

-(void)headView
{
   
    //NSLog(@"图片>>%lu",_sixImageArray.count);
     VipQuanXianModel * md=_sixImageArray[0];
    UIView * view =[UIView new];
    view.frame=CGRectMake(0, 0, KUAN, 244);
    //背景图
    UIImageView * headview =[UIImageView new];
    headview.userInteractionEnabled=YES;
    headview.image=[UIImage imageNamed:@"背景图"];
    headview.frame=CGRectMake(0, 0, KUAN, 200);
    headview.backgroundColor=[UIColor whiteColor];
    [view addSubview:headview];
 
    
    //背景中间图片
    imageview =[UIImageView new];
    [imageview sd_setImageWithURL:[NSURL URLWithString:md.sixpic] placeholderImage:[UIImage imageNamed:@"钻0"]];
    //imageview.image=[UIImage imageNamed:@"钻0"];
    [headview sd_addSubviews:@[imageview]];
    imageview.sd_layout
    .centerXEqualToView(_tableView)
    .centerYIs(80)
    .widthIs(84)
    .heightIs(70);
    //6个钻石
    CGFloat x = 84/2;
    CGFloat y = 70/2;
    CGFloat a =(KUAN-x*6)/7;
    for (int i = 0; i<6; i++) {
        VipQuanXianModel * model=_sixImageArray[i];
       // NSLog(@">>>model=%@",model.sixpic);
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.sixpic] forState:0];
        button.frame=CGRectMake(a+(x+a)*i, 150, x, y);
        button.tag=i;
        [button addTarget:self action:@selector(Zuanbutton:) forControlEvents:UIControlEventTouchUpInside];
        [headview addSubview:button];
        
    }
    
    btnFuWu =[UIButton buttonWithType:UIButtonTypeCustom];
    btnFuWu.backgroundColor=[UIColor whiteColor];
    btnFuWu.alpha=.7;
    btnFuWu.titleLabel.font=[UIFont systemFontOfSize:14];
    NSString * fuwu =[NSString stringWithFormat:@"服务费用:%@",md.Money];
    [btnFuWu setTitle:fuwu forState:0];
    [btnFuWu setTitleColor:[UIColor blackColor] forState:0];
    btnFuWu.frame=CGRectMake(0, 200, KUAN/2, 44);
    [view addSubview:btnFuWu];
    
     btnYear =[UIButton buttonWithType:UIButtonTypeCustom];
    btnYear.backgroundColor=[UIColor whiteColor];
    
    btnYear.alpha=.7;
    btnYear.titleLabel.font=[UIFont systemFontOfSize:14];
    NSString * youxianqi = [NSString stringWithFormat:@"有效期:%@",md.year];
    [btnYear setTitle:youxianqi forState:0];
    [btnYear setTitleColor:[UIColor blackColor] forState:0];
    btnYear.frame=CGRectMake(KUAN/2, 200, KUAN/2, 44);
    [view addSubview:btnYear];

    
    _tableView.tableHeaderView=view;//=[self headView];
    
   // return view;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _array1.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShengJiTeQuanCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[ShengJiTeQuanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.lab.text=_array1[indexPath.row];
    [self frameZuoBiao:indexPath Cell:cell];
    return cell;
    
}

-(void)frameZuoBiao:(NSIndexPath*)indexPath Cell:(ShengJiTeQuanCell*)cell
{
    NSString * nameImage =[NSString stringWithFormat:@"%lute%lu",tagg,indexPath.row+1];
    cell.image1.image=[UIImage imageNamed:nameImage];
    [cell sd_addSubviews:@[ cell.image1]];
    if (indexPath.row==0) {
        cell.image1.sd_layout
        .topSpaceToView(cell,7)
        .leftSpaceToView(cell,35)
        .widthIs(29/2)
        .heightIs(46/2);
    }else if (indexPath.row==1){
        cell.image1.sd_layout
        .topSpaceToView(cell,9)
        .leftSpaceToView(cell,35)
        .widthIs(42/2)
        .heightIs(44/2);
    }else if (indexPath.row==2){
        cell.image1.sd_layout
        .topSpaceToView(cell,7)
        .leftSpaceToView(cell,35)
        .widthIs(35/2)
        .heightIs(46/2);
        
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FuWuXiangqingVC * vc  =[FuWuXiangqingVC new];
    vc.number=indexPath.row;
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)Zuanbutton:(UIButton*)btn
{
     VipQuanXianModel * model=_sixImageArray[btn.tag];
    [imageview sd_setImageWithURL:[NSURL URLWithString:model.sixpic] placeholderImage:[UIImage imageNamed:@"钻0"]];
   NSString * fuwu =[NSString stringWithFormat:@"服务费用:%@",model.Money];
    NSString * youxianqi = [NSString stringWithFormat:@"有效期:%@",model.year];
    [btnFuWu setTitle:fuwu forState:0];
    [btnYear setTitle:youxianqi forState:0];
    tagg=btn.tag;
    //NSLog(@"butag>>>%lu",btn.tag);
    [_tableView reloadData];
}


-(void)btn:(UIButton*)btn
{
    if (btn.tag==0) {
        FuKuanStayVC * vc =[FuKuanStayVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //联系方式
        UIAlertController * alertView =[UIAlertController alertControllerWithTitle:@"是否拨打客服电话" message:@"400-700-9877" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [Engine tellPhone:@"400-700-9877"];
        }];
        UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertView addAction:action2];
        [alertView addAction:action1];
        [self presentViewController:alertView animated:YES completion:nil];
    }



}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)daohangtiao{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"升级权限"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
}
@end
