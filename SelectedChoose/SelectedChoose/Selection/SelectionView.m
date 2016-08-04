/**
 ---------------------------------------------------------------------
 * 文件名：    SelectionView.m
 * 工程名：    SelectedChoose
 * 创建者：    Created by YXT on 16/8/4.
 * 所有者：    Copyright © 2016年 YXT. All rights reserved.
 *
 ---------------------------------------------------------------------
 * Date  : 16/8/4
 * Author: YXT
 * Notes :
 *
 ---------------------------------------------------------------------
 */

#import "SelectionView.h"

#define cellIdentifier @"selection"

@interface SelectionView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *selectionTableView;

@property (nonatomic, strong) NSMutableArray *mSelectedDataArray;//选中的数据

@end

@implementation SelectionView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        //insert code here
        [self addSubview:self.selectionTableView];
    }
    
    return self;
}


#pragma mark - Self Property Setting

//XTODO::UITableView Data Update
- (void)setAllSelectionArray:(NSArray *)allSelectionArray{
    _allSelectionArray = allSelectionArray;
    
    [self.selectionTableView reloadData];
}


//XTODO:: 是否允许选择
- (void)setIsSelection:(BOOL)isSelection{
    _isSelection = isSelection;
}

//XTODO::多选还是单选
- (void)setSelctionType:(NSInteger)selctionType{
    _selctionType = selctionType;
    
    if (self.isSelection) {
        //允许选择
        if (selctionType == 1) {
             [self.selectionTableView setAllowsSelectionDuringEditing:YES];
        }else if (selctionType == 2){
             [self.selectionTableView setAllowsMultipleSelectionDuringEditing:YES];
            [self.selectionTableView setEditing:YES animated:YES];
        }
        
    }else{
        self.selectionTableView.allowsSelection = NO;
        self.selectionTableView.allowsMultipleSelection = NO;
    }
    
}
 

#pragma mark - UITableView Delegate And DataSource

- (UITableView *)selectionTableView{
    
    if (!_selectionTableView) {
        _selectionTableView = [[UITableView alloc]initWithFrame:self.frame style:(UITableViewStyleGrouped)];
        _selectionTableView.delegate = self;
        _selectionTableView.dataSource = self;
    }
    
    return _selectionTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.allSelectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSDictionary *sectionDic = [self.allSelectionArray objectAtIndex:section];
    return [[sectionDic valueForKey:@"list"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *sectionDic = [self.allSelectionArray objectAtIndex:indexPath.section];
    NSArray *listArray = [NSArray arrayWithArray:[sectionDic valueForKey:@"list"]];
    
    NSDictionary *rowDic = [listArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [rowDic valueForKey:@"key"];
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

//XTODO::section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;//section头部高度
}
//XTODO::section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 20.0)];
    
    
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero] ;
    
    headerLabel.backgroundColor = [UIColor clearColor];
    
    headerLabel.opaque = NO;
    
    headerLabel.textColor = [UIColor lightGrayColor];
    
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    
    headerLabel.font = [UIFont boldSystemFontOfSize:10];
    
    headerLabel.frame = CGRectMake(10.0, 0.0, 300.0, 20.0);
    
    NSString *title = [[self.allSelectionArray objectAtIndex:section] valueForKey:@"title"];
    
    headerLabel.text = title;
    
    [customView addSubview:headerLabel];
    
    
    
    return customView;

}

//XTODO::返回每组头标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    if (section == 0) {
//        return @"科目一考试";
//    }
//    return @"科目二考试";
//}

//XTODO::section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
//XTODO::section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1)];
    view.backgroundColor = [UIColor clearColor];
    return view ;
}

//XTODO::UITableView 索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray *mIndexArray = [NSMutableArray array];
    //获取索引
    
    for (int i = 0; i < self.allSelectionArray.count; i++) {
        NSString *title = [[self.allSelectionArray objectAtIndex:i] valueForKey:@"title"];
        [mIndexArray addObject:title];
    }
    
    return mIndexArray;
}
// 点击目录
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    // 获取所点目录对应的indexPath值
    NSIndexPath *selectIndexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    
    // 让table滚动到对应的indexPath位置
    [tableView scrollToRowAtIndexPath:selectIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    return index;
}


#pragma mark - 选中的数据处理

//含有选中数据的数组
- (NSMutableArray *)mSelectedDataArray{
    
    if (!_mSelectedDataArray) {
        _mSelectedDataArray = [NSMutableArray array];
    }
    
    return _mSelectedDataArray;
}

//XTODO::已选择
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //选中的数据类型自己设置，我这的是字典
    NSDictionary *sectionDic = [self.allSelectionArray objectAtIndex:indexPath.section];
    NSArray *rowArray = [NSArray arrayWithArray:[sectionDic valueForKey:@"list"]];
    
    
    
    NSDictionary *selectedic = [rowArray objectAtIndex: indexPath.row];
    
    if (self.isSelection && (self.selctionType == 1 || self.selctionType == 2)) {
        //单选 或者 多选
        [self.mSelectedDataArray addObject:selectedic];
        
        
        
    }else{
        //点击相应 cell 跳转到其他界面
        [self.mSelectedDataArray addObject:selectedic];
    }
    
    if (self.delegate || [self.delegate respondsToSelector:@selector(tableView:selectedData:complete:)]) {
        
        [self.delegate tableView:self.selectionTableView selectedData:self.mSelectedDataArray complete:^{
           
            [self.mSelectedDataArray removeAllObjects];
        }];
    }
}

//XTODO::取消选择
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取消选择
    NSDictionary *sectionDic = [self.allSelectionArray objectAtIndex:indexPath.section];
    NSArray *rowArray = [NSArray arrayWithArray:[sectionDic valueForKey:@"list"]];
    
    NSDictionary *selectedic = [rowArray objectAtIndex: indexPath.row];
    
    if ([self.mSelectedDataArray containsObject:selectedic]) {
        [self.mSelectedDataArray removeObject:selectedic];
    }
}

@end
