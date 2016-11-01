//
//  XiuGaiMessageVC.m
//  Recycle
//
//  Created by Macx on 16/6/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "XiuGaiMessageVC.h"
#import "HCCreateQRCode.h"
@interface XiuGaiMessageVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,retain)UITextField * textFiled;
@property(nonatomic,retain)NSMutableArray * keyArray;
@end

@implementation XiuGaiMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    [self.navigationItem setTitle:_titleName];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;

   
   
    //3  4  不能用
    _keyArray=[[NSMutableArray alloc]initWithObjects:@"us_face",@"Us_contact",@"Us_company",@"diqu1",@"dianhua",@"Us_email",@"Us_area",@"", nil];
    //NSLog(@"从%d界面来的",_indexRow);
    if (_indexRow==0) {
       //头像
        [self rightBtn];
      //  [self dioayongXiangCe];
        
    }else if (_indexRow==1){
        //姓名
        [self rightBtn];
        NSString* text =@"      请输入您的真实姓名";
        [self viewAndText:text];
    }else if (_indexRow==2){
        //公司名字
        [self rightBtn];
        NSString* text =@"      请输入您所在的公司名称";
        [self viewAndText:text];
    }else if (_indexRow==3){
        
    }else if (_indexRow==4){
        [self lianxiKeFu];
    }else if (_indexRow==5){
        [self rightBtn];
        NSString* text =@"      请输入您的电子邮箱";
        [self viewAndText:text];
    }else if (_indexRow==6){
        [self rightBtn];
        //主营业务
        NSString* text =@"      请输入您主营业务";
        [self viewAndText:text];
        
        
    }else if (_indexRow==7){
        [self erWeiMa];
    }
    
  
}


//商铺二维码
-(void)erWeiMa{
    
    self.view.backgroundColor=[UIColor whiteColor];
    UIView * bgview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO)];
    bgview.backgroundColor=[UIColor lightGrayColor];
   // bgview.alpha=.5;
    [self.view addSubview:bgview];
    
    
    NSMutableDictionary * dic = [self duquPlist];
    
    UIView * viewbg =[UIView new];
    viewbg.layer.cornerRadius=10;
    viewbg.clipsToBounds=YES;
    viewbg.backgroundColor=[UIColor whiteColor];
    [bgview sd_addSubviews:@[viewbg]];
    viewbg.sd_layout
    .centerXEqualToView(bgview)
    .topSpaceToView(bgview,50)
    .widthIs(KUAN-50);
    
   //头像
    UIImageView * headImage =[UIImageView new];
    [headImage sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"touxianga"]] placeholderImage:[UIImage imageNamed:@"头像"]];
    headImage.layer.cornerRadius=5;
    headImage.clipsToBounds=YES;
    [viewbg sd_addSubviews:@[headImage]];
    
    headImage.sd_layout
    .leftSpaceToView(viewbg,15)
    .topSpaceToView(viewbg,15)
    .widthIs(50)
    .heightIs(50);
    //名字
    UILabel * nameLabel =[UILabel new];
    nameLabel.text=[dic objectForKey:@"lianxiren"];
    nameLabel.font=[UIFont systemFontOfSize:15];
    [viewbg sd_addSubviews:@[nameLabel]];
    nameLabel.sd_layout
    .leftSpaceToView(headImage,10)
    .topEqualToView(headImage)
    .heightIs(25);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    //公司名字
    UILabel * comNameLabel =[UILabel new];
    comNameLabel.alpha=.7;
    comNameLabel.text=[dic objectForKey:@"gongsi"];
    comNameLabel.font=[UIFont systemFontOfSize:14];
    [viewbg sd_addSubviews:@[comNameLabel]];
    comNameLabel.sd_layout
    .leftEqualToView(nameLabel)
    .topSpaceToView(nameLabel,0)
    .heightIs(25);
    [comNameLabel setSingleLineAutoResizeWithMaxWidth:KUAN-100];
    //二维码
    NSString * str;
    if ([_model.vipClass intValue]>10) {
        str =[NSString stringWithFormat:@"http://%@.huishoushang.com/",_model.messageID];
    }else{
        str =[NSString stringWithFormat:@"%@%@/",FUWU,_model.messageID];
    }
    
    UIImageView * imagev =[UIImageView new];
    imagev.image=[HCCreateQRCode createQRCodeWithString:str ViewController:self];//_erWeiMaImage;
    [viewbg sd_addSubviews:@[imagev]];
    
    imagev.sd_layout
    .leftEqualToView(headImage)
    .topSpaceToView(headImage,10)
    .rightSpaceToView(viewbg,15)
    .heightEqualToWidth(1);
    
    [viewbg setupAutoHeightWithBottomView:imagev bottomMargin:15];
    
}

-(NSMutableDictionary*)duquPlist{
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
    //读取输出
    NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
   // NSLog(@"write data is :%@",writeData);
    return writeData;
}

-(void)rightBtn
{
    UIButton *fabu=[UIButton buttonWithType:UIButtonTypeCustom];
    [fabu setBackgroundImage:[UIImage imageNamed:@"保存save"] forState:0];
    fabu.frame=CGRectMake(KUAN-104/2-10,27, 104/2, 57/2);
    [fabu addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightBtn =[[UIBarButtonItem alloc]initWithCustomView:fabu];
    self.navigationItem.rightBarButtonItem=rightBtn;
    
    
}
-(void)viewAndText:(NSString*)text{
    
    _textFiled=[UITextField new];
    _textFiled.backgroundColor=[UIColor whiteColor];
    _textFiled.placeholder=text;
    _textFiled.font=[UIFont systemFontOfSize:15];
    _textFiled.layer.cornerRadius=5;
    _textFiled.clipsToBounds=YES;
    [self.view sd_addSubviews:@[_textFiled]];
    
    _textFiled.sd_layout
    .topSpaceToView(self.view,30)
    .leftSpaceToView(self.view,25)
    .rightSpaceToView(self.view,25)
    .heightIs(35);
    
}
//联系客服
-(void)lianxiKeFu{
    
    UILabel * phoneLabe =[UILabel new];
    UIButton * bodaBtn =[UIButton new];
    phoneLabe.font=[UIFont systemFontOfSize:16];
    phoneLabe.text=@"400-707-9877";
   [bodaBtn setBackgroundImage:[UIImage imageNamed:@"拨打客服电话"] forState:0];
    [bodaBtn setTitle:@"拨打客服电话" forState:0];
    [bodaBtn addTarget:self action:@selector(kefuPhone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view sd_addSubviews:@[phoneLabe,bodaBtn]];
    
    phoneLabe.sd_layout
    .topSpaceToView(self.view,50)
    .centerXEqualToView(self.view)
    .heightIs(20);
    [phoneLabe setSingleLineAutoResizeWithMaxWidth:KUAN];
    bodaBtn.sd_layout
    .topSpaceToView(phoneLabe,15)
    .centerXEqualToView(self.view)
    .heightIs(35)
    .widthIs(120);
    
}


-(void)kefuPhone:(UIButton*)btn{
    UIAlertController * alertView =[UIAlertController alertControllerWithTitle:@"是否拨打客服电话" message:@"400-707-9877" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Engine tellPhone:@"400-707-9877"];
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertView addAction:action2];
    [alertView addAction:action1];
    [self presentViewController:alertView animated:YES completion:nil];
}


//右上角保存按钮
-(void)save{
    
    NSString* token=[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSLog(@"点击了保存%@",_textFiled.text);
    [Engine xiuGaiMyMessageKey:token SuiJi:_textFiled.text Key:_keyArray[_indexRow] ShengCode:nil success:^(NSDictionary *dic) {
        NSString * ss =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
        if ([ss isEqualToString:@"1"]) {
            LoginModel * md =[[LoginModel alloc]initWithDic:[dic objectForKey:@"Item3"]];
            [_delegate refresh:md];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            NSLog(@"提示语:%@",[dic objectForKey:@"Item2"]);
        }
        
    } error:nil];
   
        [self saveMessagePlist:_textFiled.text];
    
 
}
-(void)saveMessagePlist:(NSString*)picUrl{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
    NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    if (_indexRow==2){
        [writeData setObject:picUrl forKey:@"gongsi"];
    }if (_indexRow==1) {
         [writeData setObject:picUrl forKey:@"lianxiren"];
    }
   
    [writeData writeToFile:plistPath atomically:YES];
    
}
////调用系统相册
//-(void)dioayongXiangCe
//{
//    UIImagePickerController * imagePicker =[UIImagePickerController new];
//    [imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:UIBarMetricsDefault];
//    [imagePicker.navigationController setTitle:@"头像"];
//   
//    imagePicker.delegate = self;
//    imagePicker.sourceType=UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    imagePicker.allowsEditing=YES;
//    [self presentViewController:imagePicker animated:YES completion:nil];
//}
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//}
//


-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
