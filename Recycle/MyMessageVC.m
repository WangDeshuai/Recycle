//
//  MyMessageVC.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyMessageVC.h"
#import "MyMessageCell.h"
#import "XiuGaiMessageVC.h"
#import "CityChooseVC.h"
@interface MyMessageVC ()<UITableViewDataSource,UITableViewDelegate,XiuGaiModelDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    CityChooseVC * cityVc;
    NSString * nameText;
    NSString * comperText;
    NSString * diquText;
    NSString * phoneText;
    NSString * emailText;
    NSString * zhuyingText;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * array1;//头像、姓名Label
@property(nonatomic,retain)NSMutableArray * array2;//头像、姓名Text
@end

@implementation MyMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:@"个人信息"];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
    _array1=[[NSMutableArray alloc]initWithObjects:@"头像",@"姓名",@"公司名称",@"地区",@"联系电话",@"电子邮箱",@"主营业务",@"商铺二维码", nil];
  
    
    // _array2=[[NSMutableArray alloc]initWithObjects:@"",_model.userName,_model.companyName,_model.diqu,_model.phoneNumber,_model.email,_model.zhuyingYeWu,@"",nil];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=COLOR;
    _tableView.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];

    [self.view addSubview:_tableView];
  
    
    UIButton * tuiChuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
   // tuiChuBtn.frame=CGRectMake(0, _tableView.frame.size.height-64-30, 283、2, 30);
    tuiChuBtn.center=CGPointMake(_tableView.center.x, _tableView.frame.size.height-64-30);
    tuiChuBtn.bounds=CGRectMake(0, 0, 449/2, 74/2);
    [tuiChuBtn addTarget:self action:@selector(tuichu) forControlEvents:UIControlEventTouchUpInside];
    [tuiChuBtn setBackgroundImage:[UIImage imageNamed:@"退出"] forState:0];
    
    [tuiChuBtn setTitle:@"退出登录" forState:0];
    [_tableView addSubview:tuiChuBtn];
  
    cityVc =[CityChooseVC new];
    __weak typeof (self)weakSelf=self;
    cityVc.citynameBlock=^(NSString*name,NSString*code,NSString*shengCode){
        diquText=name;
        [weakSelf shangChuan:code sheng:shengCode];
        [weakSelf.tableView reloadData];
    };
    
}//。。
-(void)shangChuan:(NSString*)code sheng:(NSString*)code2{
    
    NSString* token=[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
 //城市和省份必须同时上传，但是这就能选择一个
    [Engine xiuGaiMyMessageKey:token SuiJi:code Key:@"Us_city_id" ShengCode:code2 success:^(NSDictionary *dic) {
      //  NSLog(@"上传城市看看%@",dic);
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([ss isEqualToString:@"1"]) {
             NSLog(@"提示语:%@",[dic objectForKey:@"Item2"]);
           
        }else{
            NSLog(@"提示语:%@",[dic objectForKey:@"Item2"]);
        }
        
    } error:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array1.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyMessageCell * cell =[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell=[[MyMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.lab1.text=_array1[indexPath.row];
    if (indexPath.row==0) {
        //照相机
        cell.image1.hidden=NO;
        cell.image2.hidden=NO;
        cell.image1.layer.cornerRadius=83/4;
        cell.image1.clipsToBounds=YES;
        if (_xiTongimage==nil) {
            // NSLog(@"网络获取的图片%@",_model.picUrl);
            [cell.image1 sd_setImageWithURL:[NSURL URLWithString:_model.picUrl] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
        }else{
            cell.image1.image=_xiTongimage;
        }
       
    }else if (indexPath.row==1){
        cell.text=[self stringText:nameText Text2:_model.userName];
    }else if (indexPath.row==2){
        cell.text=[self stringText:comperText Text2:_model.companyName];
    }else if (indexPath.row==3){
        cell.text=[self stringText:diquText Text2:_model.diqu];
    }else if (indexPath.row==4){
        cell.text=[self stringText:phoneText Text2:_model.phoneNumber];
    }else if (indexPath.row==5){
        cell.text=[self stringText:emailText Text2:_model.email];
    }else if (indexPath.row==6){
        cell.text=[self stringText:zhuyingText Text2:_model.zhuyingYeWu];
    }else if (indexPath.row==7){
       //商铺二维码
        cell.image1.hidden=NO;
        cell.image1.image=[self erWeiMa];//[UIImage imageNamed:@"二维码"];
        cell.image1.frame=CGRectMake(KUAN-108/2-25, 10, 108/2, 108/2);
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
//生成二维码链接
-(UIImage*)erWeiMa{
    
    // 1. 实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2. 恢复滤镜的默认属性
    [filter setDefaults];
    //3.生成二维码的字符串
  //  NSLog(@"这是messige=%@",_model.messageID);
    NSString * str;
    if ([_model.vipClass intValue]>10) {
        str =[NSString stringWithFormat:@"http://%@.huishoushang.com/",_model.messageID];
    }else{
       str =[NSString stringWithFormat:@"%@%@/",FUWU,_model.messageID];
    }
    
    // 4. 将字符串转换成NSData
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    // 5. 通过KVO设置滤镜inputMessage数据
    [filter setValue:data forKey:@"inputMessage"];
    
    // 6. 获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 7. 将CIImage转换成UIImage，并放大显示
    return [UIImage imageWithCIImage:outputImage scale:20.0 orientation:UIImageOrientationUp];
    
}



//text1是从后面界面传过来的，text2是从上个界面过来的_model
-(NSString *)stringText:(NSString*)text1 Text2:(NSString*)text2{
    
    NSString * xx;
    if (text1) {
        xx=text1;
    }else{
        xx=text2;
    }
    
    return xx;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row==0) {
        [self dioayongXiangCe];
    }else if (indexPath.row==3){
       
        [self.navigationController pushViewController:cityVc animated:YES];
    }
    else{
        XiuGaiMessageVC * vc =[XiuGaiMessageVC new];
        vc.delegate=self;
        vc.titleName=_array1[indexPath.row];
        vc.indexRow=(int)indexPath.row;
        vc.model=_model;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}
#pragma mark --XiuGaiModelDelegate
-(void)refresh:(LoginModel *)model{
    _model=model;
    nameText=model.userName;
    comperText=model.companyName;
   // diquText=model.diqu;
   // phoneText=model.phoneNumber;
    emailText=model.email;
    zhuyingText=model.zhuyingYeWu;
    [_tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 54;
    }else if (indexPath.row==6){
        return 80;
    }else if (indexPath.row==7){
        return 80;
    }else{
        return 44;
    }
}
#pragma mark -- 退出
-(void)tuichu{
   
    //清楚uid（短信验证时候的uid）
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"uid"];
    
  //清除Token和日期
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"endtime"];
   //清除登录的messageID
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"messageid"];
//清楚二维码
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"二维码"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    //清楚plist文件
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
    DeleteSingleFile(plistPath);
    //回到上一界面
    [self.navigationController popViewControllerAnimated:YES];
}



BOOL DeleteSingleFile(NSString *filePath){
    NSError *err = nil;
    
    if (nil == filePath) {
        return NO;
    }
    
    NSFileManager *appFileManager = [NSFileManager defaultManager];
    
    if (![appFileManager fileExistsAtPath:filePath]) {
        return YES;
    }
    
    if (![appFileManager isDeletableFileAtPath:filePath]) {
        return NO;
    }
    
    return [appFileManager removeItemAtPath:filePath error:&err];
}







//
#pragma mark --调用系统相册
-(void)dioayongXiangCe
{
    UIImagePickerController * imagePicker =[UIImagePickerController new];
    [imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:UIBarMetricsDefault];
    
    imagePicker.delegate = self;
    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePicker.allowsEditing=YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    _xiTongimage = image;
    [_tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
     [self shangChanTouXiang:image];
    
}
//先调用上传图片，获得图片地址后，在把地址给服务器，上传头像
-(void)shangChanTouXiang:(UIImage*)image{
    NSData * imgData=  UIImageJPEGRepresentation(image, 0);
    NSString * ss =[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    UIAlertController * alerview =[UIAlertController alertControllerWithTitle:@"提示" message:@"正在保存,请稍后" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    [self presentViewController:alerview animated:YES completion:nil];
    
    [Engine shangchuanTouXiang:imgData Key:ss success:^(NSDictionary *dic) {
        //得到了图片的地址
        NSString * touxiangUrl =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item2"]];
       // NSLog(@"上传图片得到图片地址了%@",touxiangUrl);
        //在上传头像
        [self saveLogin:touxiangUrl alervieww:alerview actionn:action];
    } error:^(NSError *error) {
        
    }];

}
//上传头像
-(void)saveLogin:(NSString*)ss alervieww:(UIAlertController*)a actionn:(UIAlertAction*)b  {
    
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    [Engine xiuGaiMyMessageKey:token SuiJi:ss Key:@"us_face" ShengCode:nil success:^(NSDictionary *dic) {
        a.message=@"保存成功";
        [a addAction:b];
        if ([dic objectForKey:@"Item3"]==[NSNull null])
        {
            
            return ;
        }
        NSDictionary * dicc= [dic objectForKey:@"Item3"];
        [self saveMessagePlist:[dicc objectForKey:@"us_face"]];
       // NSLog(@"上传成功了");
       // NSLog(@"上传成功返回来的dic=%@",dic);
    } error:nil];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
#pragma mark--把个人信息存储到本地plist
-(void)saveMessagePlist:(NSString*)picUrl{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
    NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    [writeData setObject:picUrl forKey:@"touxianga"];
    [writeData writeToFile:plistPath atomically:YES];
    
}


//即将进入界面的时候缓存到本地
-(void)viewWillAppear:(BOOL)animated{
   // [self saveMessagePlist];
}






//返回
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
