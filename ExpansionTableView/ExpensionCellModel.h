//
//  ExpensionCellModel.h
//  ExpansionTableView
//
//  Created by zyma on 14-8-31.
//  Copyright (c) 2014年 zyma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    eExtensionCell_title,
    eExtensionCell_detail
}eExtensionCellType;

@interface CellModel : NSObject

@property(nonatomic, copy) NSString *remark;

@property(nonatomic, assign) eExtensionCellType cellType;

@property(nonatomic, assign) NSInteger rowIndex;

@property(nonatomic, assign) NSInteger titleIndex;

@end

@interface ExpensionCellModel : NSObject

@property(nonatomic, copy) CellModel *title;

@property(nonatomic, strong) NSMutableArray *detailList;//CellModel

@property(nonatomic, assign) BOOL isExpension;

@end
