//
//  CustomCell.m
//  MyCollection2
//
//  Created by laoyu on 15/11/27.
//  Copyright (c) 2015年 zhiyou. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _lab = [[UILabel alloc]init];
        _lab.font=[UIFont systemFontOfSize:15];
        _lab.textAlignment=1;
      //  _lab.backgroundColor=[UIColor greenColor];
        _image1=[UIImageView new];
        _image1.frame=CGRectMake(0, 0, (KUAN-35)/2, (KUAN-35)/2.5-30);
         [self.contentView sd_addSubviews:@[_lab,_image1]];
        
        
        _lab.sd_layout
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .heightIs(20)
        .bottomSpaceToView(self.contentView,0);
        _image1.sd_layout
        .topSpaceToView(self.contentView,0)
        .leftSpaceToView(self.contentView,0)
        .rightSpaceToView(self.contentView,0)
        .bottomSpaceToView(_lab,0);
        
        
        
    }
    return self;
}
-(void)setModel:(FirstModel *)model{
    _model=model;
    //_image1.image=[UIImage imageNamed:model.picUrl];
    [_image1 sd_setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"pic"]];
   // [_image1 setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@"pic"]];
    
    
    _lab.text=model.titleLabel;
   // NSLog(@"猜你喜欢%@",model.titleLabel);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
