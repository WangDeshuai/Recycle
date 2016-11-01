//
//  FukuanStayCell.m
//  Recycle
//
//  Created by mac on 16/5/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FukuanStayCell.h"

@implementation FukuanStayCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image1=[UIImageView new];
        _userNmae=[UILabel new];
        _account=[UILabel new];
        _openHang=[UILabel new];
       
        _userNmae.font=[UIFont systemFontOfSize:15];
        _account.font=[UIFont systemFontOfSize:15];
        _openHang.font=[UIFont systemFontOfSize:15];
        
//        _userNmae.backgroundColor=[UIColor redColor];
//        _account.backgroundColor=[UIColor greenColor];
//        _openHang.backgroundColor=[UIColor yellowColor];
        [self.contentView sd_addSubviews:@[_image1,_userNmae,_account,_openHang]];
       
        _image1.sd_layout
        .leftSpaceToView(self.contentView,0)
        .topSpaceToView(self.contentView,10)
        .widthIs(140)
        .bottomSpaceToView(self.contentView,0);
        
        
        _userNmae.sd_layout
        .leftSpaceToView(_image1,0)
        .rightSpaceToView(self.contentView,0)
        .heightIs(20)
        .topSpaceToView(self.contentView,10);
        
        _account.sd_layout
        .leftSpaceToView(_image1,0)
        .rightSpaceToView(self.contentView,0)
        .heightIs(20)
        .topSpaceToView(_userNmae,10);
        
        _openHang.sd_layout
        .leftSpaceToView(_image1,0)
        .rightSpaceToView(self.contentView,0)
        .heightIs(20)
        .topSpaceToView(_account,10);
        
        
        
    }
    return self;
}


-(void)setModel:(VipQuanXianModel *)model{
    _model=model;
    [_image1 sd_setImageWithURL:[NSURL URLWithString:model.bankimg] placeholderImage:[UIImage imageNamed:@"中国工商银行"]];
    _image1.image=[Engine compressImageWith:_image1.image width:_image1.image.size.width height:_image1.image.size.height];
    
    _userNmae.text=model.bankname;
    _account.text=model.kahao;
    _openHang.text=model.yinHangAddress;
    
}


-(void)setFrame:(CGRect)frame
{
    
    frame.origin.y+=10;
    frame.size.height-=10;
    frame.origin.x+=10;
    frame.size.width-=20;
    [super setFrame:frame ];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
