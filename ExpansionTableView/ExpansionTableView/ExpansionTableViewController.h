//
//  ExpansionTableView.h
//  ExpansionTableView
//
//  Created by zyma on 14-8-29.
//  Copyright (c) 2014年 zyma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpansionTableView.h"

@interface ExpansionTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) ExpansionTableView *tableView;

@property (nonatomic, strong) NSMutableArray *sourceArray;

@end
