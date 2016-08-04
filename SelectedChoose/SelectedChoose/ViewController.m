//
//  ViewController.m
//  SelectedChoose
//
//  Created by YXT on 16/8/4.
//  Copyright © 2016年 YXT. All rights reserved.
//

#import "ViewController.h"
#import "ContactVC.h"


@interface ViewController ()<ContactVCDelegate>

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad]; 
    
}

- (IBAction)mulSelected:(id)sender {
    
    ContactVC *cantactVC = [[ContactVC alloc] init];
    cantactVC.delegate = self;
    [self.navigationController pushViewController:cantactVC animated:YES];
}

- (void)contactVC:(ContactVC *)contactVC reciveList:(NSArray *)array complete:(complete)complete{
    
    
    NSString *title = [NSString string];
    for (NSDictionary *dic in array) {
        
        title = [[title stringByAppendingString:[dic valueForKey:@"key"]] stringByAppendingString:@","];
    }
    
    if (title.length != 0) {
        title = [title substringWithRange:NSMakeRange(0, title.length - 1)];
    }
    
    self.label.text = title;
    
    NSString *show = [NSString stringWithFormat:@"我选择了%@",title];
    
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle:@"提示" message:show preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:alertvc animated:YES completion:nil];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertvc dismissViewControllerAnimated:YES completion:nil];
        
    });
}


@end
