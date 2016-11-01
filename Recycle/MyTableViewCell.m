//
//  MyTableViewCell.m
//  Recycle
//
//  Created by mac on 16/5/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
      
        _lab2=[UILabel new];
        _lab2.font=[UIFont systemFontOfSize:14];
        _lab2.textColor=[UIColor blackColor];
        [self addSubview:_lab2];

        _lab=[UILabel new];
        _lab.font=[UIFont systemFontOfSize:16];
        _lab.frame=CGRectMake(70, 5, 100, 34);
      //  _lab.backgroundColor=[UIColor yellowColor];
        [self addSubview:_lab];
        
        _image1=[UIImageView new];
        _image1.frame=CGRectMake(30, 10, 22, 22);
        [self addSubview:_image1];
        
        _image2=[UIImageView new];
        _image2.frame=CGRectMake(KUAN-25, 29/2, 9, 15);
        _image2.image=[UIImage imageNamed:@"下边按钮"];
        [self addSubview:_image2];
        
        
        _vipName=[UILabel new];
        _vipName.font=[UIFont systemFontOfSize:15];
        _vipName.frame=CGRectMake(125+100, 20,100, 34);
        _vipName.textColor=[UIColor orangeColor];
       // _vipName.backgroundColor=[UIColor redColor];
        _vipName.hidden=YES;
        [self addSubview:_vipName];
        
    
    }
    return self;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
