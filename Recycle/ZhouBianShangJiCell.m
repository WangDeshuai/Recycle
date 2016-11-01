//
//  ZhouBianShangJiCell.m
//  Recycle
//
//  Created by Macx on 16/5/31.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZhouBianShangJiCell.h"

@implementation ZhouBianShangJiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    _image1=[UIImageView new];
    _timeLab=[UILabel new];
    _titleLab=[UILabel new];
    _priceLab=[UILabel new];
    _diquLab=[UILabel new];
    
    _titleLab.font=[UIFont systemFontOfSize:15];
    _diquLab.font=[UIFont systemFontOfSize:13];
    _timeLab.font=[UIFont systemFontOfSize:13];
    _priceLab.font=[UIFont systemFontOfSize:14];
    _diquLab.alpha=.6;
    _timeLab.alpha=.6;
    _priceLab.textColor=[UIColor redColor];
    
    _titleLab.text=@"上海回收机床";
    _diquLab.text=@"河北-邢台";
    _timeLab.text=@"2016-4-26";
    _priceLab.text=@"￥5000";
    _image1.image=[UIImage imageNamed:@"pic"];
    [self.contentView sd_addSubviews:@[_image1,_timeLab,_titleLab,_priceLab,_diquLab]];
    
    UIView * bgView =self.contentView;
   
    _image1.sd_layout
    .topSpaceToView(bgView,10)
    .leftSpaceToView(bgView,5)
    .widthIs(80)
    .heightIs(80);
    
    _titleLab.sd_layout
    .leftSpaceToView(_image1,10)
    .topSpaceToView(bgView,20)
    .heightIs(20);
    [_titleLab setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _diquLab.sd_layout
    .leftEqualToView(_titleLab)
    .topSpaceToView(_titleLab,10)
    .heightIs(15);
    [_diquLab setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _timeLab.sd_layout
    .leftEqualToView(_titleLab)
    .topSpaceToView(_diquLab,5)
    .heightIs(15);
    [_timeLab setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    
    _priceLab.sd_layout
    .rightSpaceToView(bgView,20)
    .heightIs(20)
    .topEqualToView(_timeLab);
    [_priceLab setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    
}

-(void)setFrame:(CGRect)frame
{
    
    frame.origin.y+=10;
    frame.size.height-=10;
    frame.origin.x+=0;
    frame.size.width-=0;
    [super setFrame:frame ];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
