//
//  ZiChanFaBuVC.m
//  Recycle
//
//  Created by Macx on 16/6/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZiChanFaBuVC.h"
#import "MyWeiZhiCell.h"
#import "CustomAlert.h"
#import "MyAddressVC.h"
#import "HangYeVC.h"
#import "ChengSeYouXiaoQiVC.h"
#import "SGImagePickerController.h"//相片选择
@interface ZiChanFaBuVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSString * chengSeText;//产品成色
    NSString * youxiaoSeText;//有效期
    NSString * hangYeText;//行业
    NSString *hangyeID;//行业id
    NSString * weizhiText;//我的位置
    NSString * codeText;//我的位置id
    UIScrollView * imageViewHeader1;
    NSIndexPath * indepath;
    UIScrollView * imageViewHeader;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSArray * array1;
@property(nonatomic,retain)NSArray * array2;
@property(nonatomic,retain)NSArray * array3;
@property(nonatomic,retain)NSMutableArray * array;
@property(nonatomic,retain)NSMutableArray * imageViewArr;//存放delete的方便移除
@property(nonatomic,retain)NSMutableArray * imageArr;
@property(nonatomic,retain)NSMutableArray * imageUrlArray;

@end

@implementation ZiChanFaBuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self danghang];
    // Do any additional setup after loading the view.
    [self starArray];
    [self.view addSubview:[self CreatTableview]];
    [self starImageArray];
    [self CreatBtn];
}
-(void)starArray{
    _array1=@[@"标       题",@"产品描述"];
    _array2=@[@"售       价",@"库       存",@"有  限  期"];
    _array3=@[@"所属行业",@"我的位置"];
    _array=[[NSMutableArray alloc]initWithObjects:_array1,_array2,_array3, nil];
    _imageUrlArray=[NSMutableArray new];
    _photoArray=[NSMutableArray new];
    _photoBtnArr=[NSMutableArray new];
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
//    UIButton * headerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//    [headerBtn setBackgroundImage:[UIImage imageNamed:@"照相机占位图"] forState:0];
//    [headerBtn addTarget:self action:@selector(lineImageClink:) forControlEvents:UIControlEventTouchUpInside];
//    CGFloat k =80 *KUAN/375;
//    CGFloat g =200*GAO/667;//这是整个bgview的高度
//    headerBtn.frame=CGRectMake(KUAN/2-k/2, g/2-k/2, k, k);
//    [_tableView addSubview:headerBtn];

    UIButton * rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(KUAN-47,27, 128/5, 128/5);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"相机01"] forState:0];
    [rightBtn addTarget:self action:@selector(lineImageClink:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * right =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItems=@[right];
    
}
-(void)lineImageClink:(UIButton*)btn{
    // NSLog(@"调用了系统相册");
    UIAlertController * actionView =[UIAlertController alertControllerWithTitle:@"" message:@"请选择照片来源" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (_photoArray.count<4) {
            // 先判断相机是否可用
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                // 把imagePicker.sourceType改为相机
                UIImagePickerController * imagePicker=[[UIImagePickerController alloc]init];
                imagePicker.delegate =self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }else
            {
                NSLog(@"相机不可用");
            }
            
        }else{
            NSLog(@"超过4个了");
            [WINDOW showHUDWithText:@"最大数4个" Type:ShowPhotoNo Enabled:YES];
        }
        
        
        
        
        
    }];
    UIAlertAction * action2 =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SGImagePickerController *picker = [[SGImagePickerController alloc] init];
        picker.maxCount = 4-_photoArray.count;
        if(picker.maxCount==0){
            [WINDOW showHUDWithText:@"最大数4个" Type:ShowPhotoNo Enabled:YES];
            return ;
        }
        [picker setDidFinishSelectImages:^(NSMutableArray *images)
         {
             
             imageViewHeader.contentSize=CGSizeMake(KUAN*images.count, 200*GAO/667);
             for (int i = 0; i<images.count; i++) {
                 UIImage * image =images[i];
                 [_photoArray addObject:image];//吧image添加到——imageArr
             }
             [self photoPaiXu:_photoArray];
         }];
        
        [self presentViewController:picker animated:YES completion:nil];
        
    }];
    UIAlertAction * action3 =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [actionView addAction:action];
    [actionView addAction:action2];
    [actionView addAction:action3];
    [self presentViewController:actionView animated:YES completion:nil];
    

    
    
}
//从修改界面过来的
-(void)starImageArray{
    if(_model){
        imageViewHeader.contentSize=CGSizeMake(KUAN*_model.imageArr.count, 200*GAO/667);
        for (int i = 0; i<_model.imageArr.count; i++) {
            UIImageView * imageview =[[UIImageView alloc]init];
            NSDictionary * dicc =_model.imageArr[i];
            imageview.frame=CGRectMake(KUAN*i, 0, KUAN, 200*GAO/667);
            [imageview sd_setImageWithURL:[NSURL URLWithString:[dicc objectForKey:@"pic_add"]] placeholderImage:[UIImage imageNamed:@"publicTou"]];
            
            [imageViewHeader addSubview:imageview];
        }
    }else{
        return;
    }
    
}

-(void)deleteClick:(UIButton*)btn{
    
  //  NSLog(@"你点击了第%lu张图",btn.tag);
    UIImageView* imagev=(UIImageView*)[btn superview];
    [_imageViewArr removeObject:btn];
    [imagev removeFromSuperview];
    [_photoArray removeObject:imagev.image];
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
    
//    NSLog(@"照片信息w>>%f", image.size.width);
//    NSLog(@"照片信息g>>%f", image.size.height);
    [_photoArray addObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self photoPaiXu:_photoArray];
    
}
-(void)photoPaiXu:(NSMutableArray*)array{
    _imageViewArr=[NSMutableArray new];
    for (int i = 0; i<array.count; i++)
    {
        NSLog(@"进来了没");
        imageViewHeader.contentSize=CGSizeMake(KUAN*array.count, 200*GAO/667);
        UIImageView * imageview =[[UIImageView alloc]init];
        imageview.userInteractionEnabled=YES;
        imageview.frame=CGRectMake(KUAN*i, 0, KUAN, 200*GAO/667);
        UIImage * image =array[i];
        imageview.image=image;
        
        UIButton * deleteBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        deleteBtn.tag=i;
        [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.frame=CGRectMake(imageview.frame.size.width-40, 10, 25, 25);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"删除(4)"] forState:0];
        
        //btn添加到数组中
        [imageview addSubview:deleteBtn];//把按钮添加到图片上
        [imageViewHeader addSubview:imageview];//把图片添加到表头上
        [_imageViewArr addObject:deleteBtn];
    }
    NSLog(@"btn个数%lu",_imageViewArr.count);
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
            if (_model) {
                cell.textFiled.text=_model.jianjieLab;
            }
        }
        
    }else if (indexPath.section==1)
    {
       
        if (indexPath.row==2) {
            //有效期
             cell.image1.hidden=NO;
             cell.titleNameLabel.hidden=NO;
             cell.titleNameLabel.text=[self stringText:youxiaoSeText Text2:@""];
        }else if(indexPath.row==1){
            cell.textFiled.hidden=NO;
            cell.taiLabel.hidden=NO;
            cell.textFiled.tag=4;
            if (_model) {
                cell.textFiled.text=_model.shuliangLab;
            }
            
        }else{
            cell.textFiled.hidden=NO;
            cell.yuanLabel.hidden=NO;
            cell.textFiled.tag=3;
            if (_model) {
                cell.textFiled.text=_model.jianjieLab;
            }
        }
        
    }else
    {
        cell.image1.hidden=NO;
        cell.titleNameLabel.hidden=NO;
        if (indexPath.row==0)
        {
          cell.titleNameLabel.text=[self stringText:hangYeText Text2:@""];
            if (_model) {
              //  cell.titleNameLabel.text=_model.hangYe;
            }
        }else
        {
          cell.titleNameLabel.text=[self stringText:weizhiText Text2:@""];
            if (_model) {
              //  cell.titleNameLabel.text=_model.diqu;
            }
        }
        
        
        
    }
    
    
    
    
    
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
    footView.backgroundColor=COLOR;
     footView.frame=CGRectMake(0, 20, KUAN, 60);
    UIButton * publicBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [publicBtn setBackgroundImage:[UIImage imageNamed:@"发布"] forState:0];
    publicBtn.frame=CGRectMake(30, 20,KUAN-60, 97/2);
    [publicBtn setTitle:@"发布" forState:0];
     [publicBtn addTarget:self action:@selector(publicMessage:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:publicBtn];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    
    __weak typeof(self)weakSelf=self;
    
    if (indexPath.section==1)
    {
        if (indexPath.row==2)
        {
            //有限期
             ChengSeYouXiaoQiVC * chengsevc =[ChengSeYouXiaoQiVC new];
            chengsevc.nameBlock=^(NSString*name,int tagg){
                if (tagg==1) {
                }else if (tagg==2){
                    youxiaoSeText=name;
                }else{
                }
                
                [weakSelf.tableView reloadData];
            };

             chengsevc.tagg=2;
             chengsevc.titleName=@"有效期";
            [self.navigationController pushViewController:chengsevc animated:YES];
        }
    }else if (indexPath.section==2)
    {
        if (indexPath.row==0)
        {//所属行业
            HangYeVC * hangye =[HangYeVC new];
            hangye.hangYeNameCidBlock=^(NSString*name,NSString*cid){
                hangYeText=name;
                hangyeID=cid;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:hangye animated:YES];
        }else
        {//我的位置
            MyAddressVC * weizhi =[MyAddressVC new];
            weizhi.cityNameCodeBlock=^(NSString*cityname,NSString*code){
                weizhiText=cityname;
                codeText=code;
                [weakSelf.tableView reloadData];
            };
            [self.navigationController pushViewController:weizhi animated:YES];
        }
    }




}

-(void)publicMessage:(UIButton*)btn{

     NSString * token= [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    if (_photoArray==nil || _photoArray.count==0)
    {
        //代表没有图片
        [self publicMMMessage:nil];
        
    }else{
        [WINDOW showHUDWithText:@"请稍后..." Type:0 Enabled:YES];

        for(UIImage * imageurl in _photoArray){
            
            UIImage * newImage =[Engine compressImageWith:imageurl width:imageurl.size.width height:imageurl.size.height];
            CGSize size =CGSizeMake(KUAN, KUAN * newImage.size.height/newImage.size.width);
            NSData *imgData=[Engine imageWithImage:newImage scaledToSize:size];;
            [self imageUrl:imgData tokenn:token];
        }
        
    }

    
    
    
}
//上传图片到服务器（第一步）
-(void)imageUrl:(NSData*)data tokenn:(NSString*)token{
        [Engine shangchuanTouXiang:data Key:token success:^(NSDictionary *dic) {
        [_imageUrlArray addObject:[dic objectForKey:@"Item2"]];
        
        if (_imageUrlArray.count==_photoArray.count)
        {
            [self publicMMMessage:_imageUrlArray];
            
        }
    } error:^(NSError *error) {
        
    }];
    
}
#pragma mark -- 发布
-(void)publicMMMessage:(NSMutableArray*)arr{
    NSString * token= [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    if (token==nil) {
        return;
    }
    //标题
    MyWeiZhiCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //产品描述
    MyWeiZhiCell *cell1 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    //售价
    MyWeiZhiCell *cell2 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    //库存
    MyWeiZhiCell *cell3 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    
    if (_xinXinID)
    {
        NSLog(@"标题%@",cell0.textFiled.text);
        NSLog(@"产品描述%@",cell1.textFiled.text);
        NSLog(@"售价%@",cell2.textFiled.text);
        NSLog(@"库存%@",cell3.textFiled.text);
        NSLog(@"有效期%@",youxiaoSeText);
        NSLog(@"所属行业%@,id=%@",hangYeText,hangyeID);
        NSLog(@"我的位置%@,id=%@",weizhiText,codeText);
        
        if ([cell0.textFiled.text isEqualToString:@""]||[cell1.textFiled.text isEqualToString:@""]||[cell2.textFiled.text isEqualToString:@""]||[cell3.textFiled.text isEqualToString:@""]||youxiaoSeText==nil ||hangyeID==nil ||codeText==nil) {
            [WINDOW showHUDWithText:@"请填写完信息" Type:ShowPhotoNo Enabled:YES];
        }else{
            [Engine xiuGaiZiChanKey:token XinXiID:_xinXinID BiaoTi:cell0.textFiled.text Cid:hangyeID GQProvid:codeText Content:cell1.textFiled.text YouXiaoQi:youxiaoSeText Price:cell2.textFiled.text ShuLiang:cell3.textFiled.text imgaeArr:arr success:^(NSDictionary *dic) {
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
        if ([cell0.textFiled.text isEqualToString:@""]||[cell1.textFiled.text isEqualToString:@""]||[cell2.textFiled.text isEqualToString:@""]||[cell3.textFiled.text isEqualToString:@""]||youxiaoSeText==nil ||hangyeID==nil ||codeText==nil) {
            [WINDOW showHUDWithText:@"请填写完信息" Type:ShowPhotoNo Enabled:YES];
        }else{
            
            //有效期为int类型
            [Engine fabuZiChaMessageToken:token BiaoTi:cell0.textFiled.text MiaoShu:cell1.textFiled.text Price:cell2.textFiled.text KuCun:cell3.textFiled.text YouXiaoQi:@"1" HangYeId:hangyeID MyWeiZhi:codeText  imgaeArr:arr success:^(NSDictionary *dic)
             {
                 [WINDOW showHUDWithText:@"请填写完信息" Type:ShowDismiss Enabled:YES];
                 NSString * item1 =[NSString stringWithFormat:@"%@",[dic objectForKey:@"Item1"]];
                 if ([item1 isEqualToString:@"1"])
                 {
                     [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoYes Enabled:YES];
                     [self.navigationController popViewControllerAnimated:YES];
                 }
                 else{
                    [WINDOW showHUDWithText:[dic objectForKey:@"Item2"] Type:ShowPhotoNo Enabled:YES];
                 }
                 
                 
             } error:nil];
            
        }
        
        NSLog(@"标题%@",cell0.textFiled.text);
        NSLog(@"产品描述%@",cell1.textFiled.text);
        NSLog(@"售价%@",cell2.textFiled.text);
        NSLog(@"库存%@",cell3.textFiled.text);
        NSLog(@"有效期%@",youxiaoSeText);
        NSLog(@"所属行业%@,id=%@",hangYeText,hangyeID);
        NSLog(@"我的位置%@,id=%@",weizhiText,codeText);
    }
    

    
    
    
    
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
            [self tableviewoffset:150];
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
        }
    }
    
//    
//    if (textField.tag==1) {
//        [_tableView setContentOffset:CGPointMake(0, 20) animated:YES];
//    }else if (textField.tag==2){
//        [_tableView setContentOffset:CGPointMake(0, 50) animated:YES];
//    }else if (textField.tag==3){
//        [_tableView setContentOffset:CGPointMake(0, 100) animated:YES];
//    }else if (textField.tag==4){
//        [_tableView setContentOffset:CGPointMake(0, 150) animated:YES];
//    }
    
    
    
}
-(void)tableviewoffset:(CGFloat)yy{
    
    [_tableView setContentOffset:CGPointMake(0, yy) animated:YES];
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
    if (_model) {
        [self.navigationItem setTitle:@"修改发布信息"];
    }
    [self.navigationItem setTitle:@"资产信息发布"];
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

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_tableView endEditing:YES];
}
@end
