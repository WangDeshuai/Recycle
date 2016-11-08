//
//  MyMessageCell.m
//  Recycle
//
//  Created by mac on 16/5/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyMessageCell.h"

@implementation MyMessageCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
        _lab1=[UILabel new];
        _lab1.font=[UIFont systemFontOfSize:15];
        _image1=[UIImageView new];
        _image1.hidden=YES;
        _image2=[UIImageView new];
        _image2.image=[UIImage imageNamed:@"下边按钮"];
        _image2.hidden=YES;
        [self.contentView sd_addSubviews:@[_lab1,_image1,_image2]];
        _lab1.sd_layout
        .leftSpaceToView(self.contentView ,15)
        .topSpaceToView(self.contentView,10)
        .heightIs(30);
        [_lab1 setSingleLineAutoResizeWithMaxWidth:100];
        _image1.sd_layout
        .rightSpaceToView(self.contentView,50)
        .topEqualToView(_lab1)
        .heightIs(83/2)
        .widthIs(83/2);
       
        _image2.sd_layout
        .rightSpaceToView(self.contentView,25)
        .topSpaceToView(self.contentView,45/2)
        .heightIs(15)
        .widthIs(9);
        
        
    }
    return self;
}
-(void)setup{
    _titleNameLabel=[UILabel new];
     _titleNameLabel.alpha=.7;
    _titleNameLabel.textAlignment=NSTextAlignmentRight;
    _titleNameLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView sd_addSubviews:@[_titleNameLabel]];
   
    _titleNameLabel.sd_layout
    .rightSpaceToView(self.contentView,25)
    .topSpaceToView(self.contentView,12)
    .autoHeightRatio(0);//换成高度自适应
    [_titleNameLabel setSingleLineAutoResizeWithMaxWidth:375];
}
-(void)setText:(NSString *)text{
    _text=text;
    _titleNameLabel.text=text;
}
-(void)setModel:(LoginModel *)model{
    _model=model;
    
  //  _titleNameLabel.text=model.
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
