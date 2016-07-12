//
//  InterfaceController.h
//  HistoryOfTimeWatch Extension
//
//  Created by hzhou on 16/7/10.
//  Copyright © 2016年 hzhou. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTable *table;

@end
