//
//  ExpensionCellModel.m
//  ExpansionTableView
//
//  Created by zyma on 14-8-31.
//  Copyright (c) 2014年 zyma. All rights reserved.
//

#import "ExpensionCellModel.h"

@implementation CellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

@implementation ExpensionCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _title = [[CellModel alloc] init];
        _detailList = [[NSMutableArray alloc] init];
        _isExpension = NO;
    }
    return self;
}

@end
