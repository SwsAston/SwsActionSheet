//
//  SwsActionSheet.h
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwsActionSheet;

@protocol SwsActionSheetDelegate <NSObject>

@optional

/** 0:Cancel  1.2.3...: Top >> Bottom */
- (void)clickSwsActionSheetButtonAtIndex:(NSInteger)index swsActionSheet:(SwsActionSheet *)SwsActionSheet;

@end

@interface SwsActionSheet : UIView

@property (nonatomic, weak) id <SwsActionSheetDelegate> delegate;

/** Center_ActionSheet */
- (SwsActionSheet *)initWithCenterTitle:(NSString *)title
                       optionTitleArray:(NSMutableArray *)optionTitleArray
                               delegate:(id)delegate;

/** Bottom_ActionSheet */
- (SwsActionSheet *)initWithBottomTitle:(NSString *)title
                             cancelText:(NSString *)cancelText
                       optionTitleArray:(NSMutableArray *)optionTitleArray
                               delegate:(id)delegate;


/** show */
- (void)show;

@end
