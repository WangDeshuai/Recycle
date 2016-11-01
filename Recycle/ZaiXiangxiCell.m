//
//  ZaiXiangxiCell.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZaiXiangxiCell.h"

@implementation ZaiXiangxiCell
//PublicXiaoXiVC
- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lab1=[UILabel new];
        _lab1.font=[UIFont systemFontOfSize:15];
        _contentLab=[UILabel new];
        _contentLab.font=[UIFont systemFontOfSize:13];
        _contentLab.textColor=[UIColor colorWithRed:140/255.0 green:140/255.0 blue:140/255.0 alpha:1];
        
        _image1=[UIImageView new];
        _image1.hidden=YES;
        [self.contentView sd_addSubviews:@[_lab1,_contentLab,_image1]];
        _lab1.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView,15)
        .heightIs(30);
        [_lab1 setSingleLineAutoResizeWithMaxWidth:KUAN];
        _contentLab.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(_lab1,20)
        .rightSpaceToView(self.contentView,10)
        .autoHeightRatio(0);//高度到时候改为自适应
        
        _image1.sd_layout
        .topSpaceToView(self.contentView,7)
        .leftSpaceToView(_lab1,20)
        .widthIs(187/2)
        .heightIs(187/2);

        _image2=[UIImageView new];
        _image2.hidden=YES;
        [self.contentView sd_addSubviews:@[_image2]];
        _image2.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(_lab1,15)
        .widthIs(80)
        .heightIs(80);
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
