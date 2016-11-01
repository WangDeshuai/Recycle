//
//  RiLiDate.m
//  RiLiFengZhuang
//
//  Created by Macx on 16/6/23.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "RiLiDate.h"
#import "SZCalendarCell.h"
#import "UIColor+ZXLazy.h"

@interface  RiLiDate()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIButton * leftBtn;
    UIButton * rightBtn;
    NSString * shiText;
    NSString * fenText;
    NSString * miaoText;
    NSInteger index;//变颜色用
    NSString * nian;
    NSString * yue;
    NSString * ri;
}
@property(nonatomic,retain)UICollectionView * collectionView;
@property(nonatomic,retain)NSArray *weekDayArray;
@property(nonatomic,retain)UILabel * titleLabel;
@property (nonatomic , strong) UIView *mask;
@property(nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation RiLiDate
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        index=10000;
        shiText=@"0";
        fenText=@"0";
        miaoText=@"0";
        [self starArray];
        [self collectionViewCreat];
    }
    
    return self;
}
-(void)starArray{
    _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    _dataArray=[NSMutableArray new];
}
- (void)setDate:(NSDate *)date
{
    _date = date;//
    [_titleLabel setText:[NSString stringWithFormat:@"%li-%.2ld",(long)[self year:date],(long)[self month:date]]];
    [_collectionView reloadData];
}
-(void)collectionViewCreat{
    //SZCalendarPicker
    UIView * bgView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    bgView.backgroundColor=[UIColor colorWithHexString:@"#15cc9c"];

    [self addSubview:bgView];
    leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(15, 7, 25, 25);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"bt_previous"] forState:0];
    rightBtn.frame=CGRectMake(self.frame.size.width-45, 7, 25, 25);
    [leftBtn addTarget:self action:@selector(leftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"bt_next"] forState:0];
    [bgView addSubview:leftBtn];
    [bgView addSubview:rightBtn];
    _titleLabel=[[UILabel alloc]init];
    _titleLabel.center=bgView.center;
    _titleLabel.textAlignment=1;
    _titleLabel.bounds=CGRectMake(0, 0, 100, 30);
    _titleLabel.textColor=[UIColor whiteColor];
  //  _titleLabel.backgroundColor=[UIColor redColor];
    [self addSubview:_titleLabel];
    
    UICollectionViewFlowLayout * layout =[[UICollectionViewFlowLayout alloc]init];
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height-100) collectionViewLayout:layout];
    CGFloat itemWidth = _collectionView.frame.size.width / 7;
    CGFloat itemHeight = _collectionView.frame.size.height / 7;
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
     _collectionView.backgroundColor=[UIColor whiteColor];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    [self addSubview:_collectionView];
    [self.collectionView registerClass:[SZCalendarCell class] forCellWithReuseIdentifier:@"Cell"];
    [self CreatArr];
    [self CreatPickView];
    
}
-(void)CreatPickView{
    UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0,self.collectionView.frame.size.height+50, self.frame.size.width, 50)];
    pickerView.backgroundColor = [UIColor whiteColor];
    // dataSource 数据源代理
    pickerView.dataSource = self;
    // 如果代理方法实现了,但是没显示出来数据,检查代理设置了没
    // delegate 代理协议方法
    pickerView.delegate =self;
    [self addSubview:pickerView];
}
-(void)CreatArr{
    
    NSMutableArray *firstArray=[NSMutableArray new];
     NSMutableArray *secondArray=[NSMutableArray new];
     NSMutableArray *thirdAarry=[NSMutableArray new];
    for (int i =0; i<24; i++) {
        
        if (i<10) {
            NSString *shi=[NSString stringWithFormat:@"0%d",i];
            [firstArray addObject:shi];
        }else{
            NSString *shi=[NSString stringWithFormat:@"%d",i];
            [firstArray addObject:shi];
        }
        
        
       
    }
    for (int i =0; i<60; i++) {
        if (i<10) {
            NSString * fen1 =[NSString stringWithFormat:@"0%d",i];
            [secondArray addObject:fen1];
        }else{
            NSString *fen=[NSString stringWithFormat:@"%d",i];
            [secondArray addObject:fen];
        }
        
    }
    for (int i =0; i<60; i++) {
        
        if (i<10) {
            NSString *miao=[NSString stringWithFormat:@"0%d",i];
            [thirdAarry addObject:miao];
        }else{
            NSString *miao=[NSString stringWithFormat:@"%d",i];
            [thirdAarry addObject:miao];
        }
       
    }
    
    
    

    _dataArray = [[NSMutableArray alloc]initWithObjects:firstArray,secondArray,thirdAarry, nil];
}

// 设置picker有几个区域
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    // 通过返回值设置picker的区域个数
    return _dataArray.count;
}
// 设置pickerView每个区有几行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // 根据区号取出对应的小数组
    NSArray * array = _dataArray[component];
    // 返回对应小数组的元素个数
    return array.count;
    
}
#pragma mark -- UIPickerViewDelegate
// 设置每一行标题的方法,添加到view上时,调用这个方法
// 滑动pickerView的时候也会调用这个方法
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    // 根据区号取出对应的小数组
    NSArray * array = [_dataArray objectAtIndex:component];
    // 根据行号取出对应的title
    NSString * str = [array objectAtIndex:row];
    
    // 返回title
    return str;
}


// 选择某一行之后会调用这个方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component==0) {
        shiText = _dataArray[component][row];
    }else if (component==1){
        fenText= _dataArray[component][row];
    }else{
        miaoText = _dataArray[component][row];
    }
     self.dateBlock(nian,yue,ri,shiText,fenText,miaoText);
    
  //  NSLog(@"%@年%@月%@日%@%@%@",nian,yue,ri,shiText,fenText,miaoText);
}












#pragma -mark collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _weekDayArray.count;
    } else {
        return 42;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#15cc9c"]];

    }else{
        
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        if (i < firstWeekday) {
            [cell.dateLabel setText:@""];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            [cell.dateLabel setText:@""];
        }else{
            day = i - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%li",(long)day]];
            [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
            //this month
            if ([_today isEqualToDate:_date]) {
                if (day == [self day:_date]) {
                    [cell.dateLabel setTextColor:[UIColor redColor]];
                } else if (day >[self day:_date]) {
                    [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#6f6f6f"]];
                }
                //将序排序也就是不可点击的时候 颜色
            } else if ([_today compare:_date] == NSOrderedDescending) {
                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#cbcbcb"]];
            }
            
            if (index==indexPath.row)
            {
                [cell.dateLabel setTextColor:[UIColor colorWithHexString:@"#4898eb"]];
            }
            
        }
    }
    
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    index=indexPath.row;
   //根据获取当前年月
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    //获取到具体的是几号
    NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    [self.collectionView reloadData];
//    NSLog(@"%lu",day);
//    NSLog(@"%ld-%ld",(long)[comp year],(long)[comp month]);
    
     nian  =[NSString stringWithFormat:@"%lu",[comp year]];
    if([comp month]<10){
        yue=[NSString stringWithFormat:@"0%lu",[comp month]];
    }else{
        yue  =[NSString stringWithFormat:@"%lu",[comp month]];
    }
    if (day<10) {
        ri  =[NSString stringWithFormat:@"0%lu",day];
    }else{
        ri  =[NSString stringWithFormat:@"%lu",day];
    }
    
    
    // ri  =[NSString stringWithFormat:@"%lu",day];
   
}
//在今天之前的日期是不能点击的
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [self totaldaysInMonth:_date];
        NSInteger firstWeekday = [self firstWeekdayInThisMonth:_date];
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            //点击的几这个day就是几
            day = i - firstWeekday + 1;
            
            //this month
            if ([_today isEqualToDate:_date])
            {
                //如果点击这个大于当天的日期，这是可以被选择的
                if (day >= [self day:_date])
                {
                    return YES;
                }
                //升序进行排序是可以点击
            } else if ([_today compare:_date] == NSOrderedAscending)
            {
                return YES;
            }
        }
    }
    return NO;
}





//网上翻页
-(void)leftBtn:(UIButton*)btn{
    
    //这特么动画找了半天才找到  草
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.date = [self lastMonth:self.date];
    } completion:nil];
    index=1000;
    [self.collectionView reloadData];
}
//下翻页
-(void)rightBtn:(UIButton*)btn{
    index=1000;
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.date = [self nextMonth:self.date];
    } completion:nil];
    [self.collectionView reloadData];
}
////收齐动画效果
//- (void)hide
//{
//    self.transform = CGAffineTransformTranslate(self.transform, 0, - self.frame.size.height);
//    [UIView animateWithDuration:0.5 animations:^(void) {
//        self.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL isFinished) {
//        //[self customInterface];
//    }];
//}

//每个月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}
//每周的第一天是星期几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}


- (NSInteger)month:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}

- (NSInteger)year:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
//下个月的天数
- (NSDate*)nextMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
//上个月的天数
- (NSDate *)lastMonth:(NSDate *)date{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
