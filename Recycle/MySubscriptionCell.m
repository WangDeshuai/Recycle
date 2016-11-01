//
//  MySubscriptionCell.m
//  Recycle
//
//  Created by Macx on 16/6/12.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "MySubscriptionCell.h"

@implementation MySubscriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //_deleteDingYue
      
//
    }
    return self;
}
-(void)setModel:(DingYueModel *)model{
    [self setUP];
    _model=model;
    _titleLabel.text=model.titleName;
    _addressLabel.text=model.diqu;
    _vipLable.text=model.laiyuan;
    
    
    
}
-(void)setUP{
    [self.contentView sd_addSubviews:@[_titleLabel,_Ddiqu,_addressLabel,_LaiYuan,_vipLable,_LineView,_deleteDingYue]];
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView,33)
    .topSpaceToView(self.contentView,8)
    .heightIs(21);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
   
    _Ddiqu.sd_layout
    .leftEqualToView(_titleLabel)
    .heightIs(21)
    .topSpaceToView(_titleLabel,1);
    [_Ddiqu setSingleLineAutoResizeWithMaxWidth:KUAN];
    _addressLabel.sd_layout
    .leftSpaceToView(_Ddiqu,3)
    .topSpaceToView(_titleLabel,3)
    .heightIs(21);
    [_addressLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _LaiYuan.sd_layout
    .leftSpaceToView(_addressLabel,20)
    .topEqualToView(_Ddiqu)
    .heightIs(21);
    [_LaiYuan setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _vipLable.sd_layout
    .leftSpaceToView(_LaiYuan,3)
    .topEqualToView(_addressLabel)
    .heightIs(21);
    [_vipLable setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _deleteDingYue.sd_layout
    .topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10)
    .rightSpaceToView(self.contentView,15)
    .widthIs(40);
    
    
    _LineView.sd_layout
    .topSpaceToView(self.contentView,10)
    .bottomSpaceToView(self.contentView,10)
    .widthIs(1)
    .rightSpaceToView(_deleteDingYue,20);
    
   
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
