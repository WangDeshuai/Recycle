//
//  ZiXunFenLeiCell.m
//  Recycle
//
//  Created by Macx on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZiXunFenLeiCell.h"

@implementation ZiXunFenLeiCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titlelabel.font=[UIFont systemFontOfSize:13];
        _titlelabel.alpha=.6;
        _titlelabel.textAlignment=1;
        [self addSubview:_titlelabel];
        
    }
    return self;
}
@end
