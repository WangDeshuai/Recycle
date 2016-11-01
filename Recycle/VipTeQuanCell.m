//
//  VipTeQuanCell.m
//  Recycle
//
//  Created by mac on 16/5/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "VipTeQuanCell.h"

@implementation VipTeQuanCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _label1=[UILabel new];
        _label2 =[UILabel new];
        _btn=[UIButton new];
        _label1.font=[UIFont systemFontOfSize:14];
        _label2.font=[UIFont systemFontOfSize:14];
        _btn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_btn setTitleColor:[UIColor blackColor] forState:0];
//        _label1.backgroundColor=[UIColor redColor];
      //  _label2.backgroundColor=[UIColor yellowColor];
//        _btn.backgroundColor=[UIColor greenColor];
        //_label2.textAlignment=1;
        [self.contentView sd_addSubviews:@[_label1,_label2,_btn]];
       
        
        
        UIView * view =self.contentView;
        _label1.sd_layout
        .centerYEqualToView(view)
        .heightIs(30)
        .leftSpaceToView(view,10);
        [_label1 setSingleLineAutoResizeWithMaxWidth:KUAN];
        
        _btn.sd_layout
        .topSpaceToView(view,7)
        .heightIs(30)
        .rightSpaceToView(view,10)
        .widthIs(100);
        
        _label2.sd_layout
        .topEqualToView(_label1)
        .heightIs(30)
        .rightSpaceToView(_btn,30);
        [_label2 setSingleLineAutoResizeWithMaxWidth:KUAN];
        
       
       // [_btn.titleLabel setSingleLineAutoResizeWithMaxWidth:KUAN ];
       // [_btn setSingleLineAutoResizeWithMaxWidth:KUAN];

        
        
    }
    return self;
}

-(void)setModel:(VipQuanXianModel *)model
{
    _model=model;
    _label1.text=model.opration;
    _label2.text=model.total;
    [_btn setTitle:model.leave forState:0];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
