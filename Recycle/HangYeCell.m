//
//  HangYeCell.m
//  Recycle
//
//  Created by Macx on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HangYeCell.h"

@implementation HangYeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
+(instancetype)cellWithTableView:(UITableView*)tableView{
    static NSString * ID =@"main";
    HangYeCell * cell =[tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell =[[HangYeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView * bg =[[UIImageView alloc]init];
        bg.image=[UIImage imageNamed:@"bg_dropdown_leftpart"];
        self.backgroundView=bg;
        
        UIImageView * selectbg =[UIImageView new];
        selectbg.image=[UIImage imageNamed:@"bg_dropdown_left_selected"];
        self.selectedBackgroundView=selectbg;
    }
    
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
