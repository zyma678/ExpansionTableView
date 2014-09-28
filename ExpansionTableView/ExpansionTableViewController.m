//
//  ExpansionTableView.m
//  ExpansionTableView
//
//  Created by zyma on 14-8-29.
//  Copyright (c) 2014年 zyma. All rights reserved.
//

#import "ExpansionTableViewController.h"
#import "ExpensionCellModel.h"
#import "TitleTableViewCell.h"
#import "DetailTableViewCell.h"

@interface ExpansionTableViewController ()

@property (nonatomic, assign) NSInteger numberOfRaw;

@property (nonatomic, strong) NSMutableArray *sourcArrayUnCtg;

@end

@implementation ExpansionTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[ExpansionTableView alloc] initWithFrame:CGRectMake(0, 20, 360, 460) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.sourceArray = [[NSMutableArray alloc] init];
    
    [self createCourceData];
    [self createArrayUnCtg];
    self.numberOfRaw = [_sourcArrayUnCtg count];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
}

- (void)createCourceData{
    ExpensionCellModel *sourceModel = [[ExpensionCellModel alloc] init];
    CellModel *titleModel = sourceModel.title;
    titleModel.remark = @"标题1";
    titleModel.cellType = eExtensionCell_title;
    titleModel.titleIndex = 0;
    for (int i = 0; i < 3; i ++) {
        CellModel *detailModel = [[CellModel alloc] init];
        detailModel.cellType = eExtensionCell_detail;
        detailModel.remark = [NSString stringWithFormat:@"第%d个CELL",i];
        detailModel.titleIndex =  0;
        detailModel.rowIndex = i;
        [sourceModel.detailList addObject:detailModel];
    }
    [self.sourceArray addObject:sourceModel];
    
    ExpensionCellModel *sourceModel2 = [[ExpensionCellModel alloc] init];
    CellModel *titleModel2 = sourceModel2.title;
    titleModel2.remark = @"标题2";
    titleModel2.cellType = eExtensionCell_title;
    titleModel2.titleIndex = 1;
    for (int i = 0; i < 2; i ++) {
        CellModel *detailModel = [[CellModel alloc] init];
        detailModel.cellType = eExtensionCell_detail;
        detailModel.remark = [NSString stringWithFormat:@"第%d个CELL",i];
        detailModel.titleIndex =  1;
        detailModel.rowIndex = i;
        [sourceModel2.detailList addObject:detailModel];
    }
    [self.sourceArray addObject:sourceModel2];
}

- (void)createArrayUnCtg{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.sourceArray count]; i++) {
        ExpensionCellModel *titleModel = [self.sourceArray objectAtIndex:i];
        CellModel *cellModel = titleModel.title;
        [tempArray addObject:cellModel];
        if (titleModel.isExpension) {
            for (int j = 0; j < [titleModel.detailList count]; j++) {
                [tempArray addObject:[titleModel.detailList objectAtIndex:j]];
            }
        }
    }
    _sourcArrayUnCtg = tempArray;
    self.numberOfRaw = [_sourcArrayUnCtg count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------- tableView delegate --------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numberOfRaw;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *titleCellIdentify = @"titleCellIdentify";
    static NSString *detailCellIdentify = @"detailCellIdentify";
    NSInteger _row = indexPath.row;
    CellModel *model = [_sourcArrayUnCtg objectAtIndex:_row];
    if (model.cellType == eExtensionCell_title) {
        TitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:titleCellIdentify];
        if (!titleCell) {
            titleCell = [[TitleTableViewCell alloc] init];
        }
        [titleCell.textLabel setText:model.remark];
        return titleCell;
    }else{
        DetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentify];
        if (!detailCell) {
            detailCell = [[DetailTableViewCell alloc] init];
        }
        [detailCell.textLabel setText:model.remark];
        
        return detailCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] init];
    [headView setBackgroundColor:[UIColor redColor]];
    return headView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger _row = indexPath.row;
    CellModel *cellModel = [_sourcArrayUnCtg objectAtIndex:_row];
    if (cellModel.cellType == eExtensionCell_title) {
        ExpensionCellModel *expensionModel = [self.sourceArray objectAtIndex:cellModel.titleIndex];
        if (expensionModel.isExpension) {
            expensionModel.isExpension = NO;
        }else{
            expensionModel.isExpension = YES;
        }
        [self createArrayUnCtg];
        [tableView reloadData];
    }
    
    
//    NSMutableArray *indexPaths = [NSMutableArray array];
//    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
//    
//    NSDictionary *dic = [self.sourceArray objectAtIndex:section];
//    NSMutableArray *array = [dic objectForKey:@"detail"];
//    [array removeObjectAtIndex:row];
//    [indexPaths addObject:indexPath];
//
//    __block UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    
//    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
////    [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
//    [UIView animateWithDuration:0.2 animations:^{
//        cell.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
//    } completion:^(BOOL finished) {
//        id indicatorView = [cell.contentView viewWithTag:-1];
//        [indicatorView removeFromSuperview];
//    }];
    
//    [UIView animateWithDuration:0.2 animations:^{
//        if (cell.isExpanded) {
//            
//            cell.accessoryView.transform = CGAffineTransformMakeRotation(M_PI);
//            
//        } else {
//            cell.accessoryView.transform = CGAffineTransformMakeRotation(0);
//        }
//    } completion:^(BOOL finished) {
//        
//        if (!cell.isExpanded)
//            [cell removeIndicatorView];
//        
//    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
