//
//  ReuserView.m
//  Recycle
//
//  Created by Macx on 16/6/7.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ReuserView.h"

@implementation ReuserView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, KUAN, 30)];
        _label.font=[UIFont systemFontOfSize:19];
        [self addSubview:_label];
        
        
    }
    return self;
}
@end
