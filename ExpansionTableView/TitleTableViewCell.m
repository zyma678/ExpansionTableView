//
//  TitleTableViewCell.m
//  ExpansionTableView
//
//  Created by zyma on 14-8-31.
//  Copyright (c) 2014年 zyma. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor grayColor]];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
