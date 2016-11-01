//
//  GongableCell.m
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "GongableCell.h"

@implementation GongableCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _image1=[UIImageView new];
        _titleLab=[UILabel new];
        _priceLab=[UILabel new];
        _VIPlab =[UILabel new];
        _diquLab=[UILabel new];
        _timeLab=[UILabel new];
        _VIPlab.hidden=YES;
//        _image1.backgroundColor=[UIColor redColor];
//        _titleLab.backgroundColor=[UIColor yellowColor];
//        _priceLab.backgroundColor=[UIColor greenColor];
//        _VIPlab.backgroundColor=[UIColor blueColor];
//        _diquLab.backgroundColor=[UIColor magentaColor];
//        _timeLab.backgroundColor=[UIColor blackColor];
        
        _titleLab.font=[UIFont systemFontOfSize:15];
        _priceLab.font=[UIFont systemFontOfSize:13];
        _VIPlab.font=[UIFont systemFontOfSize:13];
        _diquLab.font=[UIFont systemFontOfSize:13];
        _timeLab.font=[UIFont systemFontOfSize:13];
        
        
        _VIPlab.textAlignment=NSTextAlignmentRight;
         _timeLab.textAlignment=NSTextAlignmentRight;
        _priceLab.textColor=[UIColor redColor];
        _VIPlab.textColor=[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
         _timeLab.textColor=[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
         _diquLab.textColor=[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
        [self.contentView sd_addSubviews:@[_image1,_titleLab,_priceLab,_VIPlab,_diquLab,_timeLab]];
       
        _image1.sd_layout
        .topSpaceToView(self.contentView,10)
        .leftSpaceToView(self.contentView,20)
        .widthIs(80)
        .heightIs(80);
        
        _titleLab.sd_layout
        .leftSpaceToView(_image1,15)
        .rightSpaceToView(self.contentView,10)
        .topSpaceToView(self.contentView,10)
        .heightIs(30);
//    
        _priceLab.sd_layout
        .topSpaceToView(_titleLab,5)
        .leftEqualToView(_titleLab)
        .heightIs(25);
        [_priceLab setSingleLineAutoResizeWithMaxWidth:KUAN];
        
        
        _VIPlab.sd_layout
        .topEqualToView(_priceLab)
        .rightEqualToView(_titleLab)
        .heightRatioToView(_priceLab,1);
        [_VIPlab setSingleLineAutoResizeWithMaxWidth:100];
        
        
        _diquLab.sd_layout
        .topSpaceToView(_VIPlab,10)
        .leftEqualToView(_priceLab)
        .widthIs(100)
        .heightRatioToView(_priceLab,1);
//
        _timeLab.sd_layout
        .topEqualToView(_diquLab)
        .rightEqualToView(_VIPlab)
        .widthRatioToView(_diquLab,1)
        .heightRatioToView(_diquLab,1);
        
        
    }
    return self;
}

-(void)setGmodel:(GongQiuModel *)gmodel
{
  
    _gmodel=gmodel;
    _titleLab.text=gmodel.titleName;
    _priceLab.text=gmodel.price;
    _VIPlab.text=gmodel.vip;
    _diquLab.text=gmodel.diqu;
    _timeLab.text=[Engine nsdateToTime:gmodel.time];//;
    [_image1 sd_setImageWithURL:[NSURL URLWithString:gmodel.imageUrl] placeholderImage:[UIImage imageNamed:@"pic"]];
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
