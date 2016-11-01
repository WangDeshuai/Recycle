//
//  ShengJiTeQuanCell.m
//  Recycle
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ShengJiTeQuanCell.h"

@implementation ShengJiTeQuanCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image1=[UIImageView new];
        _image2=[UIImageView new];
        _image2=[UIImageView new];
        _image2.frame=CGRectMake(KUAN-25, 29/2, 9, 15);
        _image2.image=[UIImage imageNamed:@"下边按钮"];
        [self addSubview:_image2];

        _lab=[UILabel new];
        _lab.alpha=.9;
        _lab.font=[UIFont systemFontOfSize:15];
        [self.contentView sd_addSubviews:@[_image1,_lab,_image2]];
        
        _image1.sd_layout
        .topSpaceToView(self.contentView,7)
        .leftSpaceToView(self.contentView,35)
        .widthIs(15)
        .heightIs(30);
        
        _lab.sd_layout
        .leftSpaceToView(_image1,15)
        .topSpaceToView(self.contentView,12)
        .heightIs(30);
        [_lab setSingleLineAutoResizeWithMaxWidth:KUAN];
        
        

        
        
        
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
