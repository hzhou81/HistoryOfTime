//
//  ViewController.m
//  HistoryOfTime
//
//  Created by hzhou on 16/6/21.
//  Copyright © 2016年 hzhou. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+CBTableViewDataSource.h"
#import "UINavigationBar+Awesome.h"
#import "CBTableViewSectionMaker.h"
#import "CBTableViewDataSourceMaker.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView,photos;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar lt_setBackgroundColor: [UIColor colorWithRed:0.27 green:0.75 blue:0.78 alpha:1.00]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if(!tableView) {
        tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.backgroundColor = [UIColor colorWithRed:0.94 green:0.95 blue:0.96 alpha:1.00];
        [self.view addSubview:tableView];
        NSArray *data =[@[
            @{@"text":@"第一章 我们的宇宙图像"},
            @{@"text":@"第二章 空间和时间(上)"},
            @{@"text":@"第二章 空间和时间(中)"},
            @{@"text":@"第二章 空间和时间(下)"},
            @{@"text":@"第三章 膨胀的宇宙"},
            @{@"text":@"第四章 不确定性原理"},
            @{@"text":@"第五章 基本粒子和自然的力"},
            @{@"text":@"第六章 黑洞"},
            @{@"text":@"第七章 黑洞不是这么黑的"},
            @{@"text":@"第八章 宇宙的起源和命运(上)"},
            @{@"text":@"第八章 宇宙的起源和命运(下)"},
            @{@"text":@"第九章 时间箭头"},
            @{@"text":@"第十章 虫洞与时间旅行"},
            @{@"text":@"第十一章 物理学的统一"},
            @{@"text":@"第十二章 结论"},
            ] mutableCopy];
        [tableView cb_makeDataSource:^(CBTableViewDataSourceMaker * make) {
            [make makeSection:^(CBTableViewSectionMaker *section) {
                section.cell([UITableViewCell class])
                .data(data)
                .adapter(^(UITableViewCell * cell,id data,NSUInteger index){
                    cell.textLabel.text=data[@"text"];
                })
                .event(^(NSUInteger index,id row){
                    self.photos = [NSMutableArray array];
                    NSString *fileName=[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"5分钟读懂《时间简史》%i",index+1] ofType:@"mp4"];
                    NSString *picName=[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%i",index+1] ofType:@"jpg"];
                    MWPhoto *video = [MWPhoto photoWithURL:[NSURL fileURLWithPath:picName]];
                    video.videoURL=[NSURL fileURLWithPath:fileName];
                    [photos addObject:video];
                    
                    // Create browser (must be done each time photo browser is
                    // displayed. Photo browser objects cannot be re-used)
                    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
                    
                    // Set options
                    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
                    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
                    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
                    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
                    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
                    browser.enableGrid = NO; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
                    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
                    browser.autoPlayOnAppear = YES; // Auto-play first video
                    
                    // Customise selection images to change colours if required
                    browser.customImageSelectedIconName = @"ImageSelected.png";
                    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
                    
                    // Optionally set the current visible photo before displaying
                    [browser setCurrentPhotoIndex:1];
                    
                    // Present
                    [self.navigationController pushViewController:browser animated:YES];
                    
                    // Manipulate
                    [browser showNextPhotoAnimated:YES];
                    [browser showPreviousPhotoAnimated:YES];
                    [browser setCurrentPhotoIndex:10];
                })
                .autoHeight();
            }];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count) {
        return [self.photos objectAtIndex:index];
    }
    return nil;
}


@end
