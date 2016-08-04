/**
 ---------------------------------------------------------------------
 * 文件名：    SelectionView.h
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

#import <UIKit/UIKit.h>

typedef void(^completeBlock)();

@protocol SelectionViewDelegate;

@interface SelectionView : UIView

@property (nonatomic, strong) NSArray *allSelectionArray;//所有的选项

@property (nonatomic, assign) BOOL isSelection;//是否允许选择，YES：允许，NO：不允许

@property (nonatomic, assign) NSInteger selctionType;//若允许,选择类型1：单选，2：多选

@property (nonatomic, assign) id<SelectionViewDelegate>delegate;

@end


@protocol SelectionViewDelegate <NSObject>

- (void)tableView:(UITableView *)tableView selectedData:(NSArray *)array complete:(completeBlock)complete;

@end