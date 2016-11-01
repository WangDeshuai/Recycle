//
//  PublicXiaoXiVC.m
//  Recycle
//
//  Created by Macx on 16/6/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PublicXiaoXiVC.h"
#import "MessageCell.h"
#import "Message.h"
@interface PublicXiaoXiVC ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    BOOL _isSelf;
}
@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,retain)NSMutableArray * messageArray;
@end

@implementation PublicXiaoXiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=COLOR;
    [self daohang];
  //  self.automaticallyAdjustsScrollViewInsets=YES;
    
    _messageArray=[[NSMutableArray alloc]init];
    _messageTF.delegate=self;
    [self sendBtnText];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardUpOrDown:) name:UIKeyboardWillChangeFrameNotification object:nil];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KUAN, GAO-45-64) style:UITableViewStylePlain];
    // 取消分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate  =self;
    _tableView.dataSource = self;
     UINib * nib = [UINib nibWithNibName:@"MessageCell" bundle:[NSBundle mainBundle]];
    [_tableView registerNib:nib forCellReuseIdentifier:@"Cell"];

    [self.view addSubview:_tableView];
}
#pragma  mark --  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  _messageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Message * message = _messageArray[indexPath.row];
    float height = [self getTextHeight:message.info];
    
    if (message.isSelf == YES) {
        
        // 需要根据字的多少计算label/bubbleView这个两个控件的高度
        
        // 自己发的消息,改变控件位置
        cell.HeaderView.frame = CGRectMake(KUAN-50, 25, 40, 40);
        cell.MessageLabel.frame = CGRectMake(KUAN-180-50, 25, 180, height+20);
        cell.BubbleView.frame = CGRectMake(KUAN-190-50, 25, 190, height+30);
        cell.DateLabel.frame=CGRectMake(0, 0, KUAN, 20);
        
    }else
    {
        // 别人发的消息
        cell.HeaderView.frame = CGRectMake(5, 25, 40, 40);
        cell.MessageLabel.frame = CGRectMake(55, 25, 180, height+20);
        cell.BubbleView.frame = CGRectMake(45, 25, 190, height+30);
        cell.DateLabel.frame=CGRectMake(0, 0, KUAN, 20);
    }
    
    cell.DateLabel.text = message.date;
    cell.MessageLabel.text = message.info;
    //cell.HeaderView.image = [UIImage imageNamed:message.headerImgName];
    [cell.HeaderView sd_setImageWithURL:[NSURL URLWithString:_headImage] placeholderImage:[UIImage imageNamed:@"头像"]];
    cell.HeaderView.layer.cornerRadius = 20;
    cell.HeaderView.clipsToBounds = YES;

    UIImage * oldImage = [UIImage imageNamed:message.bubbleImgName];
    UIImage * newImage = [oldImage stretchableImageWithLeftCapWidth:25 topCapHeight:20];
    cell.BubbleView.image = newImage;
    
    
    
    
    return cell;
}

//添加约束
-(void)sendBtnText//:(CGFloat)aa
{//,
    [_inPutView sd_addSubviews:@[_yuYinSend,_messageTF,_bgimage,_sendButton]];
     _inPutView.frame = CGRectMake(0,GAO-45-64, KUAN, 45);
    
    _bgimage.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(45)
    .bottomSpaceToView(self.view,0);
    
    _yuYinSend.sd_layout
    .leftSpaceToView(_inPutView,20)
    .widthEqualToHeight(40)
    .topSpaceToView(_inPutView,6);
    
    _sendButton.sd_layout
    .rightSpaceToView(_inPutView,10)
    .heightIs(30)
    .topSpaceToView(_inPutView,8)
    .widthIs(55);
    
    _messageTF.sd_layout
    .leftSpaceToView(_yuYinSend,10)
    .rightSpaceToView(_sendButton,10)
    .topSpaceToView(_inPutView,7)
    .heightIs(30);
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_messageTF resignFirstResponder];
}
#pragma mark -- 接收键盘通知调用方法
- (void)keyboardUpOrDown:(NSNotification *)notifition
{
    NSDictionary * dic = notifition.userInfo;
    //用NSValue来接收，因为它是坐标（结构体）
    NSValue * value = [dic objectForKey:UIKeyboardFrameEndUserInfoKey];
    //结构体转化为对象类型
    CGRect rect = [value CGRectValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.25];
    //_inPutView是view的坐标，因为文本框在view上
    NSLog(@"YYYY=%f",rect.origin.y);
    _inPutView.frame = CGRectMake(0,rect.origin.y-45-64, KUAN, 45);
    [self viewDidLayoutSubviews];
    //表的坐标
   _tableView.frame = CGRectMake(0, 0, KUAN, _inPutView.frame.origin.y);
    [UIView commitAnimations];
    // 如果数组中有东西,再滚动
    if (_messageArray.count > 0) {
        
        NSIndexPath * indexPath =[NSIndexPath indexPathForRow:_messageArray.count-1 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        
    }
    
}




-(void)viewDidLayoutSubviews{
//    _inPutView.frame = CGRectMake(0, 100, KUAN, 100);
//    _inPutView.backgroundColor=[UIColor redColor];
}

- (IBAction)senderBtn:(UIButton *)sender {
    if (_messageTF.text.length != 0)
    {
        _isSelf=YES;
        NSString *info = _messageTF.text;
         NSDate * nowDate =[NSDate date];
         NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
         NSString * dateStr = [formatter stringFromDate:nowDate];
          Message * message = [[Message alloc]initWithInfo:info isSelf:_isSelf headerImgName:_isSelf?_headImage:@"头像" bubbleImgName:_isSelf?@"bubbleSelf":@"bubble" date:dateStr];
        [_messageArray addObject:message];
        [self plistDuqu];
        _messageTF.text = nil;
         [_tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_messageArray.count-1 inSection:0];
        // 指定滚动到某一行
        // 滚到表的最后一行
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    if (_isSelf==NO) {
        //其他人来的消息
    }
    
    
    
    
    
//    _isSelf=YES;自己NO的话就是其他，默认是NO
     //_isSelf = !_isSelf;
    
}



-(void)daohang{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"导航"] forBarMetrics:3];
    [self.navigationItem setTitle:_titleName];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    UIButton * backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(5,27, 40/2, 40/2);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"arrow-left"] forState:0];
    [backBtn addTarget:self action:@selector(backWrite) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftBtn =[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=leftBtn;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)backWrite{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 计算cell的高度
    
    
    Message * message = _messageArray[indexPath.row];
    float height = [self getTextHeight:message.info];
    return height +80;
}

#pragma mark -- 根据文字计算大小
- (float)getTextHeight:(NSString *)string
{
    // constrained 强迫 ,束缚 ,限制
    // MAXFLOAT 最大的浮点型数
    // 计算一个固定宽度的或者固定高度的size
    CGSize size = [string sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(180, MAXFLOAT)];
    
    
    // ceilf 向上取整 ,参数有小数点,向上取一位整数
    // ceilf(3.4) 取到4
    // int a = 3.4; 取3 向下取整
    return ceilf(size.height);
}

#pragma mark -- plist文件的读取
-(void)plistDuqu{
    //获取路径对象
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
   NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"message.plist"];
    NSMutableDictionary *writeData=[[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
   // NSLog(@"write data is :%@",writeData);
    NSString *messageID=[writeData objectForKey:@"messageID"];
    NSString* userName =[writeData objectForKey:@"lianxiren"];
     NSString*phoneNumber  =[writeData objectForKey:@"shoujihao"];
    
    [self sendMessageMy:userName MessageID:messageID phoneNumber:phoneNumber];
    
}

//调用发送消息接口
-(void)sendMessageMy:(NSString*)mine MessageID:(NSString*)mineID phoneNumber:(NSString*)shojihao{
    //NSLog(@"留言用户ID%@",_whoMessageID);
    
    [Engine getLiuYanxxid:@"0" contact:mine handtel:shojihao content:_messageTF.text  type:@"4" uid:mineID ruid:_whoMessageID success:^(NSDictionary *dic) {
        NSLog(@"返回结果了");
    } error:nil];
    
    
}







#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 失去第一响应
    [textField resignFirstResponder];
    
    return YES;
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
