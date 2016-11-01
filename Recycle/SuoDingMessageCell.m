//
//  SuoDingMessageCell.m
//  Recycle
//
//  Created by Macx on 16/6/22.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SuoDingMessageCell.h"

@interface  SuoDingMessageCell()
@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UILabel * typeLabel;
@property(nonatomic,retain)UILabel * timeLabel;
@end

@implementation SuoDingMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup{
    _titleLabel=[UILabel new];
    _typeLabel=[UILabel new];
    _timeLabel=[UILabel new];
    _titleLabel.font=[UIFont systemFontOfSize:14];
    _typeLabel.font=[UIFont systemFontOfSize:13];
    _timeLabel.font=[UIFont systemFontOfSize:13];
    _typeLabel.alpha=.5;
    _timeLabel.alpha=.5;
    [self.contentView sd_addSubviews:@[_titleLabel,_typeLabel,_timeLabel]];
    UIView * bgView =self.contentView;
    _titleLabel.sd_layout
    .leftSpaceToView(bgView,15)
    .topSpaceToView(bgView,10)
    .heightIs(20);
    [_titleLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _typeLabel.sd_layout
    .leftEqualToView(_titleLabel)
    .topSpaceToView(_titleLabel,15)
    .widthIs(100)
    .heightIs(20);
    
    _timeLabel.sd_layout
    .topEqualToView(_typeLabel)
    .rightSpaceToView(bgView,15)
    .heightIs(20);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    [self setupAutoHeightWithBottomView:_typeLabel bottomMargin:5];
}
-(void)setModel:(MessageSuoDingModel *)model{
    _model=model;
    _titleLabel.text=model.titleName;
    _typeLabel.text=model.type;
    _timeLabel.text=[Engine nsdateToTime:model.addTime];//model.addTime;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
