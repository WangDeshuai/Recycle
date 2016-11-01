//
//  MyInformationCell.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyInformationCell.h"
@interface MyInformationCell ()
@property(nonatomic,retain)UILabel * titleLab;
@property(nonatomic,retain)UILabel *label2;
@property(nonatomic,retain)UILabel * timeLab;
@end

@implementation MyInformationCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLab=[UILabel new];
        _titleLab.font=[UIFont systemFontOfSize:15];
        
        _label2=[UILabel new];
        _label2.font=[UIFont systemFontOfSize:13];
        _label2.textColor=[UIColor blackColor];
        _label2.alpha=.6;
        
        _timeLab=[UILabel new];
        _timeLab.font=[UIFont systemFontOfSize:13];
        _timeLab.textColor=[UIColor blackColor];
        _timeLab.alpha=.6;
        _timeLab.textAlignment=2;
//        _titleLab.backgroundColor=[UIColor redColor];
//        _label2.backgroundColor=[UIColor greenColor];
//        _timeLab.backgroundColor=[UIColor yellowColor];
        [self.contentView sd_addSubviews:@[_titleLab,_label2,_timeLab]];
        _titleLab.sd_layout
        .topSpaceToView(self.contentView,10)
        .leftSpaceToView(self.contentView,30)
        .rightSpaceToView(self.contentView,30)
        .heightIs(30);
        
        _label2.sd_layout
        .topSpaceToView(_titleLab,8)
        .leftEqualToView(_titleLab)
        .widthIs(100)
        .heightIs(20);
        
        _timeLab.sd_layout
        .topEqualToView(_label2)
        .rightSpaceToView(self.contentView,10)
        .widthRatioToView(_label2,1)
        .heightRatioToView(_label2,1);
        
    }
    return self;
}


-(void)setPp:(People *)pp{
    _pp=pp;
    _titleLab.text=pp.titleName;
    _timeLab.text=pp.timeSc;
    _label2.text=pp.gongQiu;
    
}

-(void)setZujiModel:(MyZuJi *)zujiModel{
    _zujiModel=zujiModel;
    _titleLab.text=zujiModel.titlename;
    _timeLab.text=zujiModel.publictime;
    _label2.text= [self gongQiu:zujiModel.gongqiu];
    
    
}

-(NSString*)gongQiu:(NSString*)ss{
    NSMutableDictionary * dic =[NSMutableDictionary new];
    [dic setObject:@"供应" forKey:@"0"];
    [dic setObject:@"求购" forKey:@"1"];
    [dic setObject:@"资产处置" forKey:@"2"];
    [dic setObject:@"拍卖" forKey:@"3"];
    
    NSString * name =[dic objectForKey:ss];
    return name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
