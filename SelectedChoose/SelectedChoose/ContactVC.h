/**
 ---------------------------------------------------------------------
 * 文件名：    ContactVC.h
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

typedef void(^complete)();

@protocol ContactVCDelegate;

@interface ContactVC : UIViewController

@property (nonatomic, weak) id<ContactVCDelegate>delegate;

@end

@protocol ContactVCDelegate <NSObject>

- (void)contactVC:(ContactVC *)contactVC reciveList:(NSArray *)array complete:(complete)complete;

@end