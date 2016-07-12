//
//  InterfaceController.m
//  HistoryOfTimeWatch Extension
//
//  Created by hzhou on 16/7/10.
//  Copyright © 2016年 hzhou. All rights reserved.
//

#import "InterfaceController.h"
#import "TableRowController.h"

@interface InterfaceController()

@end


@implementation InterfaceController
@synthesize table;

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSArray *data =[@[
                      @{@"text":@"我们的宇宙图像"},
                      @{@"text":@"空间和时间(上)"},
                      @{@"text":@"空间和时间(中)"},
                      @{@"text":@"空间和时间(下)"},
                      @{@"text":@"膨胀的宇宙"},
                      @{@"text":@"不确定性原理"},
                      @{@"text":@"基本粒子和自然力"},
                      @{@"text":@"黑洞"},
                      @{@"text":@"黑洞不是这么黑的"},
                      @{@"text":@"宇宙起源和命运(上)"},
                      ] mutableCopy];
    [table setNumberOfRows:data.count withRowType:@"TableRowController"];
    for(int i=0;i<data.count;i++){
        TableRowController *row=[table rowControllerAtIndex:i];
        [row.soundName setText:[data objectAtIndex:i][@"text"]];
    }
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    //NSLog(@"%i",rowIndex);
    NSString *soundName=[NSString stringWithFormat:@"%i",rowIndex+1];
    NSString *path=[[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"];
    NSURL *url=[NSURL fileURLWithPath:path];
    [self presentMediaPlayerControllerWithURL:url options:nil completion:^(BOOL didPlayToEnd, NSTimeInterval endTime, NSError * __nullable error){
        
    }];
}
@end



