//
//  LiuYanTiXingCell.m
//  Recycle
//
//  Created by Macx on 16/6/29.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "LiuYanTiXingCell.h"
@interface LiuYanTiXingCell ()
@property(nonatomic,retain)UIImageView * headImage;
@property(nonatomic,retain)UILabel * titleName;
@property(nonatomic,retain)UILabel * subheadName;
@property(nonatomic,retain)UILabel * timeName;

@end
@implementation LiuYanTiXingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    
    return self;
    
}
-(void)setup{
    _headImage=[UIImageView new];
    _titleName=[UILabel new];
    _subheadName=[UILabel new];
    _timeName =[UILabel new];
    
    //_headImage.image=[UIImage imageNamed:@"headImage"];
    _titleName.font=[UIFont systemFontOfSize:15];
    _subheadName.font=[UIFont systemFontOfSize:13];
    _subheadName.alpha=.7;
    _timeName.font=[UIFont systemFontOfSize:13];
    _timeName.alpha=.7;
    [self.contentView sd_addSubviews:@[_headImage,_titleName,_subheadName,_timeName]];
    UIView * bgView=self.contentView;
    
    _headImage.sd_layout
    .leftSpaceToView(bgView,20)
    .topSpaceToView(bgView,10);
    
    
    _titleName.sd_layout
    .leftSpaceToView(_headImage,10)
    .topSpaceToView(bgView,10)
    .heightIs(20);
    [_titleName setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _subheadName.sd_layout
    .leftEqualToView(_titleName)
    .heightRatioToView(_titleName,1)
    .topSpaceToView(_titleName,10)
    .rightSpaceToView(_timeName,5);
    //[_subheadName setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    _timeName.sd_layout
    .rightSpaceToView(bgView,10)
    .heightIs(20)
    .topEqualToView(_subheadName);
    [_timeName setSingleLineAutoResizeWithMaxWidth:KUAN];
    
    [self setupAutoHeightWithBottomView:_headImage bottomMargin:10];
    
}

-(void)setModel:(LiuYanModel *)model{
    _model=model;
    _titleName.text=model.liuYanName;
    _subheadName.text=model.liuYanContent;//@"请问可以吗?";
    _timeName.text= [Engine nsdateToTime:_model.time];
    
    if (model.isChaKan==YES) {
        _headImage.image=[UIImage imageNamed:@"headimage1"];
        _headImage.sd_layout
        .widthIs(108/2)
        .heightIs(98/2);
    }else{
        _headImage.image=[UIImage imageNamed:@"headImage"];
        _headImage.sd_layout
        .widthIs(93/2)
        .heightIs(93/2);
        
    }
//    if ([model.mesview isEqualToString:@"0"]) {
//        _headImage.image=[UIImage imageNamed:@"headimage1"];
//        _headImage.sd_layout
//        .widthIs(108/2)
//        .heightIs(98/2);
//    }else{
//        _headImage.image=[UIImage imageNamed:@"headImage"];
//        _headImage.sd_layout
//        .widthIs(93/2)
//        .heightIs(93/2);
//
//    }
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
