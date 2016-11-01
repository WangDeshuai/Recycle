//
//  ShenBianDianPuCell.m
//  Recycle
//
//  Created by Macx on 16/6/23.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShenBianDianPuCell.h"

@implementation ShenBianDianPuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)setUp{
    _titleNameLabel=[UILabel new];
    _image1=[UIImageView new];
    _image1.image=[UIImage imageNamed:@"leftImage"];
    _zhuYingLabel=[UILabel new];
    _titleNameLabel.font=[UIFont systemFontOfSize:14];
    _zhuYingLabel.font=[UIFont systemFontOfSize:13];
    _zhuYingLabel.textColor=[UIColor blackColor];
    _zhuYingLabel.alpha=.6;
    [self.contentView sd_addSubviews:@[_titleNameLabel,_zhuYingLabel,_image1]];
    UIView * bgView =self.contentView;
    _image1.sd_layout
    .leftSpaceToView(bgView,10)
    .centerYEqualToView(bgView)
    .widthIs(50/2)
    .heightIs(47/2);
    
    _titleNameLabel.sd_layout
    .topSpaceToView(bgView,5)
    .leftSpaceToView(_image1,10)
    .heightIs(20);
    [_titleNameLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _zhuYingLabel.sd_layout
    .leftEqualToView(_titleNameLabel)
    .topSpaceToView(_titleNameLabel,5)
    .heightRatioToView(_titleNameLabel,1)
    .rightSpaceToView(bgView,10);
    
}
-(void)setModel:(ShenBianDianPuModel *)model{
    _model=model;
    _titleNameLabel.text=model.titleName;
    _zhuYingLabel.text=model.zhuYingName;
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
