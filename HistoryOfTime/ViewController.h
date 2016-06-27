//
//  ViewController.h
//  HistoryOfTime
//
//  Created by hzhou on 16/6/21.
//  Copyright © 2016年 hzhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableView+CBTableViewDataSource.h"

@interface ViewController : UIViewController
@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, retain) NSMutableArray *photos;
@end

