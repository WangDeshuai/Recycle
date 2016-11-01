//
//  MyWeiZhiCell.m
//  Recycle
//
//  Created by Macx on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyWeiZhiCell.h"

@implementation MyWeiZhiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self setupView];
    }

    return self;
}

-(void)setupView{
    _label=[UILabel new];
    //_label.backgroundColor=[UIColor redColor];
    _label.font=[UIFont systemFontOfSize:15];
    [self.contentView sd_addSubviews:@[_label]];
    UIView * bgview=self.contentView;
    _label.sd_layout
    .centerYEqualToView(bgview)
    .leftSpaceToView(bgview,15)
    .heightIs(34);
    [_label setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _textFiled=[UITextField new];
    _textFiled.font=[UIFont systemFontOfSize:15];
    //_textFiled.backgroundColor=[UIColor redColor];
    _textFiled.hidden=YES;
    [self.contentView sd_addSubviews:@[_textFiled]];
    _textFiled.sd_layout
    .leftSpaceToView(_label,20)
    .centerYEqualToView(bgview)
    .rightSpaceToView(bgview,30+25)//到时候换成距离右端的字体
    .heightIs(30);
    
    _image1=[UIImageView new];
    _image1.hidden=YES;
    _image1.image=[UIImage imageNamed:@"下边按钮"];
    [self.contentView sd_addSubviews:@[_image1]];
    _image1.sd_layout
    .rightSpaceToView(bgview,30)
    .centerYEqualToView(bgview)
    .widthIs(9)
    .heightIs(15);

    _taiLabel=[UILabel new];
    _yuanLabel=[UILabel new];
    _taiLabel.hidden=YES;
    _yuanLabel.hidden=YES;
    _taiLabel.text=@"台";
    _yuanLabel.text=@"元";
    _taiLabel.font=[UIFont systemFontOfSize:16];
    _yuanLabel.font=[UIFont systemFontOfSize:16];
    [self.contentView sd_addSubviews:@[_taiLabel,_yuanLabel]];
    _taiLabel.sd_layout
    .centerYEqualToView(bgview)
    .rightSpaceToView(bgview,15)
    .heightIs(30)
    .widthIs(30);
    _yuanLabel.sd_layout
    .centerYEqualToView(bgview)
    .rightSpaceToView(bgview,15)
    .heightIs(30)
    .widthIs(30);
    
    _titleNameLabel=[UILabel new];
    _titleNameLabel.font=[UIFont systemFontOfSize:15];
   // _titleNameLabel.backgroundColor=[UIColor redColor];
    _titleNameLabel.hidden=YES;
    [self.contentView sd_addSubviews:@[_titleNameLabel]];
    _titleNameLabel.sd_layout
    .leftSpaceToView(_label,20)
    .centerYEqualToView(bgview)
    .rightSpaceToView(bgview,30+25)//到时候换成距离右端的字体
    .heightIs(30);
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
