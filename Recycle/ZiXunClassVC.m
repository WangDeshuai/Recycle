//
//  ZiXunClassVC.m
//  Recycle
//
//  Created by Macx on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZiXunClassVC.h"
#import "ZiXunFenLeiCell.h"
#import "ReuserView.h"
@interface ZiXunClassVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
     NSInteger kk;
}
@property(nonatomic,retain)UICollectionView *colectionView;
@property(nonatomic,retain)NSMutableArray *dataUpArray;
@property(nonatomic,retain)NSMutableArray *dataDownArray;
@property(nonatomic,retain)NSMutableArray *dataUpClassID;
@property(nonatomic,retain)NSMutableArray *dataDownClassID;
@end

@implementation ZiXunClassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self daohangView];
    NSString * ss =[[NSUserDefaults standardUserDefaults] objectForKey:@"red"];
    if (ss==nil) {
        kk=100000;
    }else{
        kk= [ss intValue];
    }
    
    _dataUpArray=[NSMutableArray new];
    _dataDownArray=[NSMutableArray new];
    _dataUpClassID=[NSMutableArray new];
    _dataDownClassID=[NSMutableArray new];
    [self dataArrayCreat];
    [self collerviewCreat];
}

//数据源创建
-(void)dataArrayCreat{
    
    for (ZiXunFenLeiModel * md in _dataArray)
    {
        NSString * bcid =[NSString stringWithFormat:@"%@",md.nbcID];
        if ([bcid isEqualToString:@"1"]) {
            //这是下面的数据
           // NSLog(@"等于1的%@",md.classID);
            [_dataDownArray addObject:md.titleName];
            [_dataDownClassID addObject:md.classID];
        }else{
            //这是上面的数据
            [_dataUpArray addObject:md.titleName];
            [_dataUpClassID addObject:md.classID];
        }
        
        [_colectionView reloadData];
    }
   
    
}



//collectionView创建
-(void)collerviewCreat{
    
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    
     //item大小
     CGFloat a=(KUAN-3)/4;
     layout.itemSize = CGSizeMake(a, a/2.5);
    // 行间距
     layout.minimumLineSpacing = 1;
    // 列间距
     layout.minimumInteritemSpacing = 1;
    // 视图的四个边距离父视图四个边的距离
     layout.sectionInset = UIEdgeInsetsMake(0, 0, 0,0);
     
    
    self.colectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) collectionViewLayout:layout];
    self.colectionView.delegate=self;
    self.colectionView.dataSource=self;
   
    [self.view addSubview:self.colectionView];
    self.colectionView.backgroundColor=[UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:.7];
    [self.colectionView registerClass:[ZiXunFenLeiCell class] forCellWithReuseIdentifier:@"Cell"];
    //注册的是区头
    [self.colectionView registerClass:[ReuserView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return _dataUpArray.count;
    }else{
        return _dataDownArray.count;
    }
   
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ZiXunFenLeiCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];//[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    cell.titlelabel.backgroundColor =[UIColor whiteColor];// [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
    
    if (indexPath.section==0) {
        cell.titlelabel.text=_dataUpArray[indexPath.row];
        if (kk==indexPath.row) {
            cell.titlelabel.backgroundColor=[UIColor redColor];
        }
    }else{
         cell.titlelabel.text=_dataDownArray[indexPath.row];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    kk=indexPath.row;
    NSString * ss =[NSString stringWithFormat:@"%lu",indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:ss forKey:@"red"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.colectionView reloadData];
    NSString * name;
    
    if(indexPath.section==0){
        name=_dataUpArray[indexPath.row];
    }else{
         name=_dataDownArray[indexPath.row];
    }
    for (int i = 0; i<_dataArray.count; i++)
    {
        ZiXunFenLeiModel * md =_dataArray[i];
        if ([md.titleName isEqualToString:name])
        {
             self.classidBlock(i);
        }
        
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


//区头
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ReuserView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    if (indexPath.section==0) {
        header.label.text=@"热门分类";
    }else{
        header.label.text=@"行业新闻";
    }
    return header;
    
}
//区头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(KUAN, 40);
}






-(void)daohangView
{
    self.view.backgroundColor=COLOR;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"资讯分类"];
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
