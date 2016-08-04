/**
 ---------------------------------------------------------------------
 * 文件名：    ContactVC.m
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

#import "ContactVC.h"
#import "SelectionView.h"

@interface ContactVC ()<SelectionViewDelegate>

@property (nonatomic, strong) SelectionView *selectionView;

@property (nonatomic, strong) NSArray *recieveArray;

@end

@implementation ContactVC

- (void)loadView{
    [super loadView];
    _selectionView = [[SelectionView alloc]initWithFrame:self.view.frame];
    _selectionView.delegate = self;
    self.view = _selectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectionView.isSelection = YES;
    self.selectionView.selctionType = 2;
    self.selectionView.allSelectionArray = @[@{@"title":@"科目一考试",
                                               @"list":@[@{@"key":@"科目一选项1"},@{@"key":@"科目一选项2"},@{@"key":@"科目一选项3"},@{@"key":@"科目一选项4"},@{@"key":@"科目一选项5"},@{@"key":@"科目一选项6"},@{@"key":@"科目一选项7"},@{@"key":@"科目一选项8"}]}, @{@"title":@"科目二考试",
                                                                                                                                                                                                                              @"list":@[@{@"key":@"科目二选项1"},@{@"key":@"科目二选项2"}]},  @{@"title":@"科目三考试",
                                                                                                                                                                                                                                                                                      @"list":@[@{@"key":@"科目三选项1"},@{@"key":@"科目三选项2"},@{@"key":@"科目三选项3"}]}, @{@"title":@"科目四考试",
                                                                                                                                                                                                                                                                                                                                                                 @"list":@[@{@"key":@"科目四选项1"},@{@"key":@"科目四选项2"},@{@"key":@"科目四选项3"},@{@"key":@"科目四选项4"}]},@{@"title":@"科目五考试",
                                                                                                                                                                                                                                                                                                                                                                                                                                                               @"list":@[@{@"key":@"科目五选项1"},@{@"key":@"科目五选项2"},@{@"key":@"科目五选项3"},@{@"key":@"科目五选项4"},@{@"key":@"科目五选项5"}]},@{@"title":@"科目六考试",
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 @"list":@[@{@"key":@"科目六选项1"},@{@"key":@"科目六选项2"},@{@"key":@"科目六选项3"},@{@"key":@"科目六选项4"},@{@"key":@"科目六选项5"},@{@"key":@"科目六选项6"}]}];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(action)];
    
}

- (void)action{
     [self.navigationController popViewControllerAnimated:YES];
    if (self.delegate || [self.delegate respondsToSelector:@selector(contactVC:reciveList:complete:)]) {
        
        [self.delegate contactVC:self reciveList:self.recieveArray complete:^{
            
           
        }];
    } 
}

- (void)tableView:(UITableView *)tableView selectedData:(NSArray *)array complete:(completeBlock)complete{
    
    self.recieveArray = [NSArray arrayWithArray:array];
}

@end
