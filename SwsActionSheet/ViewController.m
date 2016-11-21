//
//  ViewController.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import "ViewController.h"
#import "SwsActionSheet.h"

@interface ViewController () <SwsActionSheetDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - CenterWithTitle
- (IBAction)CenterWithTitle:(id)sender {
    
    SwsActionSheet *actionSheet = [[SwsActionSheet alloc] initWithCenterTitle:@"Title Title Title Title Title Title Title Title Title Title Title" optionTitleArray:[NSMutableArray arrayWithObjects:@"Item1",@"Item2",@"Item3", nil] delegate:self];
    [actionSheet show];
}

#pragma mark - CenterNoTitle
- (IBAction)CenterNoTitle:(id)sender {
    
    SwsActionSheet *actionSheet = [[SwsActionSheet alloc] initWithCenterTitle:nil optionTitleArray:[NSMutableArray arrayWithObjects:@"Item1",@"Item2",@"Item3", nil] delegate:self];
    [actionSheet show];
}

#pragma mark - BottomWithTitle
- (IBAction)BottomWithTitle:(id)sender {
    
    SwsActionSheet *actionSheet = [[SwsActionSheet alloc] initWithBottomTitle:@"Title Title Title Title Title Title Title Title Title Title Title" cancelText:@"Cancel" optionTitleArray:[NSMutableArray arrayWithObjects:@"Item1",@"Item2",@"Item3", nil] delegate:self];
    [actionSheet show];
}

#pragma mark - BottomNoTitle
- (IBAction)BottomNoTitle:(id)sender {
    
    SwsActionSheet *actionSheet = [[SwsActionSheet alloc] initWithBottomTitle:nil cancelText:@"Cancel" optionTitleArray:[NSMutableArray arrayWithObjects:@"Item1",@"Item2",@"Item3", nil] delegate:self];
    [actionSheet show];
}

#pragma mark - BottomNoCancel
- (IBAction)BottomNoCancel:(id)sender {
    
    SwsActionSheet *actionSheet = [[SwsActionSheet alloc] initWithBottomTitle:@"Title Title Title Title Title Title Title Title Title Title Title" cancelText:nil optionTitleArray:[NSMutableArray arrayWithObjects:@"Item1",@"Item2",@"Item3", nil] delegate:self];
    [actionSheet show];
}

- (IBAction)bottomNoTitleNoCancel:(id)sender {
    
    SwsActionSheet *actionSheet = [[SwsActionSheet alloc] initWithBottomTitle:nil cancelText:nil optionTitleArray:[NSMutableArray arrayWithObjects:@"Item1",@"Item2",@"Item3", nil] delegate:self];
    [actionSheet show];
}

#pragma mark - SwsActionSheetDelegate
- (void)clickSwsActionSheetButtonAtIndex:(NSInteger)index {
    
    NSLog(@"%ld", index);
}

@end
