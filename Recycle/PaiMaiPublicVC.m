//
//  PaiMaiPublicVC.m
//  Recycle
//
//  Created by Macx on 16/6/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PaiMaiPublicVC.h"
#import "MyWeiZhiCell.h"
#import "CustomAlert.h"
#import "MyAddressVC.h"
#import "ChengSeYouXiaoQiVC.h"
#import "SGImagePickerController.h"//相片选择
#import "RiLiDate.h"
@interface PaiMaiPublicVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSString * weizhiText;//我的位置
    NSString * codeText;//我的位置id
    NSString * hangYeText;//行业
    NSString *hangyeID;//行业id
    UIScrollView * imageViewHeader;
    UIView * bgview;//变灰色的
    RiLiDate * riliDate;
    NSString * paiMaiText;//开始日期
    NSString * jieZhiText;//截止日期
    
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSArray * array1;
@property(nonatomic,retain)NSArray * array2;
@property(nonatomic,retain)NSArray * array3;
@property(nonatomic,retain)NSMutableArray * array;
@property(nonatomic,retain)NSMutableArray *imageViewArr;
@end

@implementation PaiMaiPublicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self danghang];
    [self starArray];
    [self.view addSubview:[self CreatTableview]];
    [self CreatBtn];
    bgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO+100)];
    bgview.backgroundColor=[UIColor grayColor];
    bgview.alpha=.8;
   
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [bgview addGestureRecognizer:tap];
    
}
-(void)starArray{
    _array1=@[@"标       题",@"产品描述"];
    _array2=@[@"联  系  人",@"联系电话",@"保  证  金",@"拍卖开始日期",@"拍卖截止日期",@"拍卖地址"];
    _array3=@[@"拍卖类别",@"所在地区"];
    _array=[[NSMutableArray alloc]initWithObjects:_array1,_array2,_array3, nil];
    
   
}
-(UITableView*)CreatTableview{
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-64) style:UITableViewStylePlain];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.backgroundColor=COLOR;
    self.tableView.tableHeaderView=[self uiview];
    self.tableView.tableFooterView=[self footView];
    [_tableView setContentInset:UIEdgeInsetsMake(0, 0, 70, 0)];
    return self.tableView;
}
-(void)CreatBtn{


//    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    rightBtn.frame=CGRectMake(KUAN-47,27, 57/3, 57/3);
//    [rightBtn setBackgroundImage:[UIImage imageNamed:@"加号(1)"] forState:0];
//    [rightBtn addTarget:self action:@selector(lineImageClink:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
   // self.navigationItem.rightBarButtonItems=@[right];
    
}
-(void)lineImageClink:(UIButton*)btn{
    NSString * str;
    static int a=0;
    a++;
    if (a==1) {
        str=@"别点了不让你发布";
    }else if (a==2){
         str=@"别点了,说了不让你发布";
    }else if (a==3){
        str=@"你大爷的！别点了,都说了不让你发布";
    }else if (a==4){
        str=@"卧槽,你还点，你在点一下试试";
    }else if (a==5){
        str=@"哎呦，在点你不是人😄";
    }else{
        str=@"🐦不是人,不是人,不是人!!!✈️";
    }
    
    UIAlertController * actionview =[UIAlertController alertControllerWithTitle:@"温馨提示" message:str preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"听话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"不听话" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [actionview addAction:action];
    [actionview addAction:action2];
    [self presentViewController:actionview animated:YES completion:nil];
//拍卖现在不允许发布图片注释掉了
//    // NSLog(@"调用了系统相册");
//    SGImagePickerController *picker = [[SGImagePickerController alloc] init];
//    picker.maxCount = 4;
//    
//    [picker setDidFinishSelectImages:^(NSMutableArray *images) {
//        imageViewHeader.contentSize=CGSizeMake(KUAN*images.count, 200*GAO/667);
//        for (int i = 0; i<images.count; i++) {
//            UIImageView * imageview =[[UIImageView alloc]init];
//            UIButton * deleteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//            deleteBtn.tag=i;
//            imageview.frame=CGRectMake(KUAN*i, 0, KUAN, 200*GAO/667);
//            imageview.userInteractionEnabled=YES;
//            // deleteBtn.frame=CGRectMake(KUAN*i+(KUAN-35), 0, 35, 35);
//            UIImage * image =images[i];
//            imageview.image=image;
//            [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
//            [deleteBtn setBackgroundImage:[UIImage imageNamed:@"删除(4)"] forState:0];
//            deleteBtn.frame=CGRectMake(imageview.frame.size.width-40, 0, 25, 25);
//            [_imageViewArr addObject:deleteBtn];
//            [imageview addSubview:deleteBtn];
//            [imageViewHeader addSubview:imageview];
//            
//        }
//        //NSLog(@"图%@",images);
//    }];
//    
//    [self presentViewController:picker animated:YES completion:nil];
    
    
}

-(void)deleteClick:(UIButton*)btn{
    
    //  NSLog(@"你点击了第%lu张图",btn.tag);
    UIImageView* imagev=(UIImageView*)[btn superview];
    [imagev removeFromSuperview];
    [_imageViewArr removeObject:btn];
    for (int i =0; i<_imageViewArr.count; i++)
    {
        imageViewHeader.contentSize=CGSizeMake(KUAN*_imageViewArr.count, 200*GAO/667);
        UIButton * button =_imageViewArr[i];
        UIImageView* otherImage=(UIImageView*)[button superview];
        button.tag=i;
        [button addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        otherImage.frame=CGRectMake(KUAN*i, 0, KUAN, 200*GAO/667);
        [imageViewHeader addSubview:otherImage];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _array.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr =_array[section];
    return arr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * idd =@"Cell";
    MyWeiZhiCell * cell =[tableView dequeueReusableCellWithIdentifier:idd];
    if (!cell) {
        cell=[[MyWeiZhiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idd];
    }
    cell.label.text=_array[indexPath.section][indexPath.row];
    cell.textFiled.delegate=self;
    if (indexPath.section==0)
    {
        cell.textFiled.hidden=NO;
        if (indexPath.row==0)
        {
            cell.textFiled.placeholder=@"请输入信息发布的标题";
            cell.textFiled.tag=1;
            if (_model) {
                cell.textFiled.text=_model.titleName;
            }
        }else
        {
            cell.textFiled.placeholder=@"请输入产品的相关信息";
            cell.textFiled.tag=2;
            if(_model){
                cell.textFiled.text=_model.jianjieLab;
            }
        }
        
    }else if (indexPath.section==1)
    {
        cell.textFiled.hidden=NO;
        if (indexPath.row==0) {
            cell.textFiled.placeholder=@"请输入姓名";
             cell.textFiled.tag=3;
            if(_model){
                cell.textFiled.text=_model.username;
            }
        }else if(indexPath.row==1){
            cell.textFiled.placeholder=@"请输入手机号";
             cell.textFiled.tag=4;
            if(_model){
                cell.textFiled.text=_model.phoneNumber;
            }
        }else if(indexPath.row==2){
            cell.textFiled.placeholder=@"请输入金额";
             cell.textFiled.tag=5;
            if(_model){
                cell.textFiled.text=_model.price;
            }
            cell.yuanLabel.hidden=NO;
        }else if(indexPath.row==3){
            cell.textFiled.hidden=YES;
            cell.titleNameLabel.hidden=NO;
            cell.titleNameLabel.text=[self stringText:paiMaiText Text2:@""];
            if (_model) {
               // cell.titleNameLabel.text=_model.starDate;
            }
        }else if(indexPath.row==4){
            cell.textFiled.hidden=YES;
            cell.titleNameLabel.hidden=NO;
            cell.titleNameLabel.text=[self stringText:jieZhiText Text2:@""];
            if (_model) {
              //  cell.titleNameLabel.text=_model.endDate;
            }
        }else if(indexPath.row==5){
            cell.textFiled.layer.borderWidth=1;
            cell.textFiled.layer.borderColor=[COLOR CGColor];
             cell.textFiled.tag=6;
            if (_model) {
                cell.textFiled.text=_model.address;
                
            }
            
        }
        
        
    }else
    {
        cell.image1.hidden=NO;
        cell.titleNameLabel.hidden=NO;
        if (indexPath.row==0)
        {
            //拍卖类别
             cell.titleNameLabel.text=[self stringText:hangYeText Text2:@""];
            if (_model) {
                //cell.titleNameLabel.text=_model.hangYe;
            }
        }else
        {
            //我的位置
             cell.titleNameLabel.text=[self stringText:weizhiText Text2:@""];
            if (_model) {
              //  cell.titleNameLabel.text=_model.diqu;
            }
            
        }
        
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(NSString *)stringText:(NSString*)text1 Text2:(NSString*)text2{
    
    NSString * xx;
    if (text1) {
        xx=text1;
    }else{
        xx=text2;
    }
    
    return xx;
}
-(UIView*)uiview
{
    imageViewHeader=nil;
    if (imageViewHeader==nil) {
        imageViewHeader=[UIScrollView new];
        imageViewHeader.backgroundColor=COLOR;
        imageViewHeader.contentSize=CGSizeMake(KUAN, 200*GAO/667);
        imageViewHeader.pagingEnabled=YES;
        UIImageView * image1 =[UIImageView new];
        image1.userInteractionEnabled=YES;
        image1.image=[UIImage imageNamed:@"publicTou"];
        
        
        
        [imageViewHeader sd_addSubviews:@[image1]];
        imageViewHeader.sd_layout
        .topSpaceToView(self.view,64)
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .heightIs(200*GAO/667);
        
        image1.sd_layout
        .topSpaceToView(imageViewHeader,0)
        .leftSpaceToView(imageViewHeader,0)
        .rightSpaceToView(imageViewHeader,0)
        .bottomSpaceToView(imageViewHeader,0);
        
        
        
    }
    return imageViewHeader;
}
-(UIView*)footView
{
    UIView * footView =[UIView new];
    footView.frame=CGRectMake(0, 20, KUAN, 60);
    footView.backgroundColor=COLOR;
    UIButton * publicBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [publicBtn setBackgroundImage:[UIImage imageNamed:@"发布"] forState:0];
    publicBtn.frame=CGRectMake(30, 15,KUAN-60, 97/2);
    [publicBtn addTarget:self action:@selector(publicMessage:) forControlEvents:UIControlEventTouchUpInside];
    [publicBtn setTitle:@"发布" forState:0];
    
    [footView addSubview:publicBtn];
    return footView;
}

-(void)publicMessage:(UIButton*)btn{
    NSString * token =[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    
    
    //标题
    MyWeiZhiCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //产品描述
    MyWeiZhiCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
  
    //联系人
    MyWeiZhiCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    //联系电话
    MyWeiZhiCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    //保证金
    MyWeiZhiCell *cell4 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    //paiMaiText   jieZhiText
    //拍卖地址
     MyWeiZhiCell *cell5 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
   
    if (_xinXinID)
    {
        NSLog(@"标题%@",cell0.textFiled.text);
        NSLog(@"产品描述%@",cell1.textFiled.text);
        NSLog(@"联系人%@",cell2.textFiled.text);
        NSLog(@"联系电话%@",cell3.textFiled.text);
        NSLog(@"保证金%@",cell4.textFiled.text);
        NSLog(@"拍卖开始日期%@",paiMaiText);
        NSLog(@"结束日期%@",jieZhiText);
        NSLog(@"拍卖地址%@",cell5.textFiled.text);
        NSLog(@"拍卖类别%@,id=%@",hangYeText,hangyeID);
        NSLog(@"我的位置%@,id=%@",weizhiText,codeText);
        NSLog(@"公司的名字是,%@",[self getGongSiName]);
        if ([cell0.textFiled.text isEqualToString:@""]||[cell1.textFiled.text isEqualToString:@""]||[cell2.textFiled.text isEqualToString:@""]||[cell3.textFiled.text isEqualToString:@""]||hangyeID==nil ||codeText==nil || [cell5.textFiled.text isEqualToString:@""] || paiMaiText==nil || jieZhiText==nil){
            [WINDOW showHUDWithText:@"请把信息补充完整" Type:ShowPhotoNo Enabled:YES];
            
        }else{
            [Engine xiuGaiPaiMaiKey:token XinXiID:_xinXinID BiaoTi:cell0.textFiled.text Cid:hangyeID GQProvid:codeText Content:cell1.textFiled.text StarTime:paiMaiText EndTime:jieZhiText ComperName:[self getGongSiName] People:cell2.textFiled.text Address:cell5.textFiled.text PhoneNumber:cell3.textFiled.text success:^(NSDictionary *dic) {
                NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
                if ([item1 isEqualToString:@"1"]) {
                    [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
                }
            } error:^(NSError *error) {
                
            }];
        }
        
        
        
    }else
    {
        if ([cell0.textFiled.text isEqualToString:@""]||[cell1.textFiled.text isEqualToString:@""]||[cell2.textFiled.text isEqualToString:@""]||[cell3.textFiled.text isEqualToString:@""]||[cell4.textFiled.text isEqualToString:@""]||hangyeID==nil ||codeText==nil || [cell5.textFiled.text isEqualToString:@""] || paiMaiText==nil || jieZhiText==nil) {
            [WINDOW showHUDWithText:@"请把信息补充完整" Type:ShowPhotoNo Enabled:YES];
            
        }else{
            [WINDOW showHUDWithText:@"发布中请稍后..." Type:0 Enabled:YES];
            [Engine fabuPaiMaiToken:token BiaoTi:cell0.textFiled.text MiaoShu:cell1.textFiled.text LianXiRen:cell2.textFiled.text LianXiDianHua:cell3.textFiled.text BaoZhengjin:cell4.textFiled.text StarDate:paiMaiText EndDate:jieZhiText Address:cell5.textFiled.text ClassBie:hangyeID DiQu:codeText Commper:[self getGongSiName] success:^(NSDictionary *dic) {
                
                NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
                if ([item1 isEqualToString:@"1"]) {
                    [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
                }
                
                
            } error:^(NSError *error) {
                [WINDOW showHUDWithText:@"网络超时请重新发布" Type:ShowPhotoNo Enabled:YES];
            }];
            
        }

        
    }
    
    
    
    

    
    
    
    
    
    NSLog(@"标题%@",cell0.textFiled.text);
    NSLog(@"产品描述%@",cell1.textFiled.text);
    NSLog(@"联系人%@",cell2.textFiled.text);
    NSLog(@"联系电话%@",cell3.textFiled.text);
    NSLog(@"保证金%@",cell4.textFiled.text);
    NSLog(@"拍卖开始日期%@",paiMaiText);
    NSLog(@"结束日期%@",jieZhiText);
    NSLog(@"拍卖地址%@",cell5.textFiled.text);
    NSLog(@"拍卖类别%@,id=%@",hangYeText,hangyeID);
    NSLog(@"我的位置%@,id=%@",weizhiText,codeText);
    NSLog(@"公司的名字是,%@",[self getGongSiName]);
}


-(NSString*)getGongSiName{
    
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
    //读取输出
      NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    //NSLog(@"write data is :%@",writeData);
    
    NSString * conmper=[writeData objectForKey:@"gongsi"];
    return conmper;
    
}




-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf=self;
    if(indexPath.section==2)
    {
        
        if (indexPath.row==0)
        {
            //拍卖类别
//             NSLog(@"点击了拍卖类别");
            ChengSeYouXiaoQiVC * chengsevc =[ChengSeYouXiaoQiVC new];
            chengsevc.tagg=3;
            chengsevc.titleName=@"拍卖类别";
            chengsevc.nameBlock=^(NSString*name,int tagg){
                hangYeText=name;
                hangyeID=[NSString stringWithFormat:@"%d",tagg];
                [weakSelf.tableView reloadData];
            };

            [self.navigationController pushViewController:chengsevc animated:YES];
        }else
        {
            //所在地区
            MyAddressVC * weizhi =[MyAddressVC new];
            weizhi.titleName=@"我的位置";
            weizhi.cityNameCodeBlock=^(NSString*cityname,NSString*code){
                weizhiText=cityname;
                codeText=code;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:weizhi animated:YES];
           
        }
    }else if (indexPath.section==1)
    {
        if (indexPath.row==3)
        {
            //拍卖开始日期
            [self.view addSubview:bgview];
            riliDate =[[RiLiDate alloc]initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 350*GAO/667)];
            riliDate.today=[NSDate date];//把今天的日期传过去
            riliDate.date= riliDate.today;
            
            riliDate.dateBlock=^(NSString*year,NSString*mone,NSString*daty,NSString*shi,NSString*fen,NSString*miao){
               
                paiMaiText=[NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,mone,daty,shi,fen,miao];
                
                 [weakSelf.tableView reloadData];
            };
            [self.view addSubview:riliDate];
            
        }else if (indexPath.row==4)
        {
            //拍卖开始日期
            [self.view addSubview:bgview];
            riliDate =[[RiLiDate alloc]initWithFrame:CGRectMake(30, 100, self.view.frame.size.width-60, 350*GAO/667)];
            riliDate.today=[NSDate date];//把今天的日期传过去
            riliDate.date= riliDate.today;
            
            riliDate.dateBlock=^(NSString*year,NSString*mone,NSString*daty,NSString*shi,NSString*fen,NSString*miao){
                
                jieZhiText=[NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,mone,daty,shi,fen,miao];
                
                [weakSelf.tableView reloadData];
            };
            [self.view addSubview:riliDate];
        }
        
        
    }


}

-(void)dissmiss{
    
    [bgview removeFromSuperview];
    [riliDate removeFromSuperview];
}
-(void)tap{
    [self dissmiss];
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
-(void)danghang{
    self.view.backgroundColor=COLOR;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:@"拍卖发布"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItems=@[leftBtn];
}
-(void)backWrite{
    //[self.navigationController popViewControllerAnimated:YES];
    CustomAlert * alert =[[CustomAlert alloc]initWithTitle:@"提示" alerMessage:@"正在发布,是否退出?" canCleBtn:@"取消" otheBtn:@"确定"];
    alert.frame=CGRectMake(KUAN/2- 624/4, 0, 624/2, 360/2);
    [UIView animateWithDuration:0.5 animations:^{
        alert.frame=CGRectMake(KUAN/2- 624/4, GAO/2- 360/4, 624/2, 360/2);
    } completion:nil];
    alert.delegate=self;
    __weak CustomAlert * weakSelf =alert;
    alert.clickBlock = ^(int index){
        if (index==0) {
            
            [weakSelf dissmiss];
        }else{
            [weakSelf dissmiss];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    };
    
    [alert show];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (KUAN==320&&GAO==480) {
        if (textField.tag==1) {
            [self tableviewoffset:40];
        }else if (textField.tag==2){
            [self tableviewoffset:100];
        }else if (textField.tag==3){
            [self tableviewoffset:150];
        }else if (textField.tag==4){
            [self tableviewoffset:200];
        }else if (textField.tag==5){
            [self tableviewoffset:250];
        }else if (textField.tag==6){
            [self tableviewoffset:400];
        }
    }
    else{
        if (textField.tag==1) {
            [self tableviewoffset:20];
        }else if (textField.tag==2){
            [self tableviewoffset:50];
        }else if (textField.tag==3){
            [self tableviewoffset:100];
        }else if (textField.tag==4){
            [self tableviewoffset:150];
        }else if (textField.tag==5){
            [self tableviewoffset:200];
        }else if (textField.tag==6){
            [self tableviewoffset:250];
        }
    }


}
-(void)tableviewoffset:(CGFloat)yy{
    
    [_tableView setContentOffset:CGPointMake(0, yy) animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_tableView endEditing:YES];
}
@end
