//
//  DiscoverCell.m
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DiscoverCell.h"

@implementation DiscoverCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lab=[UILabel new];
        _lab.font=[UIFont systemFontOfSize:16];
        _lab.frame=CGRectMake(70, 5, 100, 34);
        [self addSubview:_lab];
        
        _image1=[UIImageView new];
        _image1.frame=CGRectMake(30, 10, 22, 22);
        [self addSubview:_image1];
        
        _image2=[UIImageView new];
        _image2.frame=CGRectMake(KUAN-45, 33/2, 11, 11);
        _image2.hidden=YES;
        [self addSubview:_image2];
        
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
