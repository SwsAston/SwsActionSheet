//
//  SwsActionSheet.m
//
//  Created by sws on 6/6/6.
//  Copyright © 666年 sws. All rights reserved.
//

#define Width [UIScreen mainScreen].bounds.size.width

#define Button_NormalColor   [UIColor clearColor]
#define Button_HightedColor  [UIColor grayColor]

#define Option_Title_Alignment NSTextAlignmentCenter

#define Option_Title_Font           13.0
#define OptionView_Height           40

#define CenterView_Left_To_View     50
#define CenterView_Radius           5.0

#define BottomOptionView_To_Cancel  5
#define BottomView_Left_To_View     0
#define BottomView_Bottom_To_View   0
#define BottomView_Radius           0

#import "SwsActionSheet.h"
#import "AppDelegate.h"

@interface SwsActionSheet ()

// Center_ActionSheet
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewLeftToView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerViewRightToView;

@property (weak, nonatomic) IBOutlet UIView *centerTitleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerTitleViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *centerTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerTitleLabelBottomToView;
@property (weak, nonatomic) IBOutlet UIView *centerOptionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerOptionViewHeight;

@property (nonatomic, assign) BOOL isCenter;

// Bottom_ActionSheet
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewRightToView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewLeftToView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomToView;

@property (weak, nonatomic) IBOutlet UIView *bottomTitleAndOptionView;

@property (weak, nonatomic) IBOutlet UIView *bottomTitleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTitleViewHeight;

@property (weak, nonatomic) IBOutlet UILabel *bottomTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTitleLabelBottomToView;

@property (weak, nonatomic) IBOutlet UIView *bottomOptionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomTitleAndOptionViewToCancel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomOptionViewHeight;

@property (weak, nonatomic) IBOutlet UIView *cancelView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *cancelLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation SwsActionSheet

#pragma mark - Center_ActionSheet
- (SwsActionSheet *)initWithCenterTitle:(NSString *)title
                       optionTitleArray:(NSMutableArray *)optionTitleArray
                               delegate:(id)delegate {
    
    SwsActionSheet *actionSheet = [[[NSBundle mainBundle] loadNibNamed:@"SwsActionSheet" owner:self options:nil] firstObject];
    actionSheet.frame = [UIScreen mainScreen].bounds;
    actionSheet.delegate = delegate;
    
    [actionSheet.bottomView removeFromSuperview];
    
    actionSheet.centerViewLeftToView.constant = CenterView_Left_To_View;
    actionSheet.centerViewRightToView.constant = CenterView_Left_To_View;
    actionSheet.centerView.layer.cornerRadius = CenterView_Radius;
    actionSheet.centerView.layer.masksToBounds = YES;
    
    actionSheet.isCenter = YES;
    
    // Title
    if (title) {
        
        [actionSheet.centerTitleView removeConstraint:actionSheet.centerTitleViewHeight];
        actionSheet.centerTitleLabel.text = title;
    } else {
        
        [actionSheet.centerTitleView removeConstraint:actionSheet.centerTitleLabelBottomToView];
        actionSheet.centerTitleViewHeight.constant = 0;
        actionSheet.centerTitleLabel.text = nil;
    }
    
    // OptionView
    actionSheet.centerOptionViewHeight.constant = optionTitleArray.count * OptionView_Height;
    
    for (int i = 0; i < optionTitleArray.count; i ++) {
        
        UIView *optionView = [self createOptionViewWithFrame:CGRectMake(0, i * OptionView_Height, Width - 2 * CenterView_Left_To_View, OptionView_Height) title:optionTitleArray[i] tag:i];
        [actionSheet.centerOptionView addSubview:optionView];
    }
    
    return actionSheet;
}

#pragma mark - Bottom_ActionSheet
- (SwsActionSheet *)initWithBottomTitle:(NSString *)title
                             cancelText:(NSString *)cancelText
                       optionTitleArray:(NSMutableArray *)optionTitleArray
                               delegate:(id)delegate {
    
    SwsActionSheet *actionSheet = [[[NSBundle mainBundle] loadNibNamed:@"SwsActionSheet" owner:self options:nil] firstObject];
    actionSheet.frame = [UIScreen mainScreen].bounds;
    actionSheet.delegate = delegate;
    
    [actionSheet.centerView removeFromSuperview];
    
    actionSheet.bottomViewLeftToView.constant = BottomView_Left_To_View;
    actionSheet.bottomViewRightToView.constant = BottomView_Left_To_View;
    actionSheet.bottomViewBottomToView.constant = BottomView_Bottom_To_View;
    
    // Title
    if (title) {
        
        [actionSheet.bottomTitleView removeConstraint:actionSheet.bottomTitleViewHeight];
        actionSheet.bottomTitleLabel.text = title;
    } else {
        
        [actionSheet.bottomTitleView removeConstraint:actionSheet.bottomTitleLabelBottomToView];
        actionSheet.bottomTitleViewHeight.constant = 0;
        actionSheet.bottomTitleLabel.text = nil;
    }
    
    // Cancel
    if (cancelText) {
        
        [actionSheet.cancelButton setBackgroundImage:[self createImageWithColor:Button_NormalColor] forState:UIControlStateNormal];
        [actionSheet.cancelButton  setBackgroundImage:[self createImageWithColor:Button_HightedColor] forState:UIControlStateHighlighted];
        actionSheet.bottomTitleAndOptionViewToCancel.constant = BottomOptionView_To_Cancel;
        if (0 ==  actionSheet.bottomTitleAndOptionViewToCancel.constant) {
            
            actionSheet.bottomView.layer.cornerRadius = BottomView_Radius;
            actionSheet.bottomView.layer.masksToBounds = YES;
        } else {
            
            actionSheet.bottomTitleAndOptionView.layer.cornerRadius = BottomView_Radius;
            actionSheet.bottomTitleAndOptionView.layer.masksToBounds = YES;
            actionSheet.cancelView.layer.cornerRadius = BottomView_Radius;
            actionSheet.cancelView.layer.masksToBounds = YES;
        }
      
    } else {
        
        actionSheet.cancelViewHeight.constant = 0;
        actionSheet.cancelLabel.text = nil;
        actionSheet.bottomTitleAndOptionViewToCancel.constant = 0;
        actionSheet.bottomView.layer.cornerRadius = BottomView_Radius;
        actionSheet.bottomView.layer.masksToBounds = YES;
    }
    
    // OptionView
    actionSheet.bottomOptionViewHeight.constant = optionTitleArray.count * OptionView_Height;
    
    for (int i = 0; i < optionTitleArray.count; i ++) {
        
        UIView *optionView = [self createOptionViewWithFrame:CGRectMake(0, i * OptionView_Height, Width - 2 * BottomView_Left_To_View, OptionView_Height) title:optionTitleArray[i] tag:i];
        [actionSheet.bottomOptionView addSubview:optionView];
    }
    
    return actionSheet;
}

#pragma mark - Create_OptionView
- (UIView *)createOptionViewWithFrame:(CGRect)frame
                                title:(NSString *)title
                                  tag:(int)tag {
    
    UIView *optionView = [[UIView alloc] initWithFrame:frame];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, optionView.bounds.size.height - 1, optionView.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor colorWithRed:225.0 / 255.0 green:225.0 / 255.0 blue:225.0 / 255.0 alpha:1];
    [optionView addSubview:lineView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:optionView.bounds];
    button.tag = tag + 1;
    [button setBackgroundImage:[self createImageWithColor:Button_NormalColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[self createImageWithColor:Button_HightedColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(clickOptionButton:) forControlEvents:UIControlEventTouchUpInside];
    [optionView addSubview:button];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, optionView.bounds.size.width - 2 * 15, optionView.bounds.size.height)];
    label.text = title;
    label.textAlignment = Option_Title_Alignment;
    label.font = [UIFont systemFontOfSize:Option_Title_Font];
    [optionView addSubview:label];
    
    return optionView;
}

#pragma mark - Click_OptionButton
- (void)clickOptionButton:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickSwsActionSheetButtonAtIndex:swsActionSheet:)]) {
        
        [_delegate clickSwsActionSheetButtonAtIndex:sender.tag swsActionSheet:self];
    }
    [self dismiss];
}

#pragma mark - Cancel
- (IBAction)cancel:(UIButton *)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickSwsActionSheetButtonAtIndex:swsActionSheet:)]) {
        
        [_delegate clickSwsActionSheetButtonAtIndex:sender.tag swsActionSheet:self];
    }
    [self dismiss];
}

#pragma mark - Background_Button
- (IBAction)backgroundButton:(UIButton *)sender {
    
    [self dismiss];
}

#pragma mark - show / dismiss
- (void)show {
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UIWindow *window = appDelegate.window;
    [window addSubview:self];
    
    __weak SwsActionSheet *view = self;
    view.alpha = 0;
    
    if (view.isCenter) {
        
        view.centerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } else {
        
        view.bottomView.transform = CGAffineTransformMakeTranslation(0, view.bottomView.bounds.size.height);
    }
    
    [UIView animateWithDuration:.2 animations:^{
        
        view.alpha = 1;
        if (view.isCenter) {
            
            view.centerView.transform = CGAffineTransformIdentity;
        } else {
            
            view.bottomView.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)dismiss {
    
    __weak SwsActionSheet *view = self;
    [UIView animateWithDuration:.2 animations:^{
        
        view.alpha = 0;
        if (view.isCenter) {
            
            view.centerView.transform = CGAffineTransformMakeScale(0.5, 0.5);
        } else {
            
            view.bottomView.transform = CGAffineTransformMakeTranslation(0, view.bottomView.bounds.size.height);
        }
    } completion:^(BOOL finished) {
        
        [view removeFromSuperview];
    }];
}

#pragma mark - Color_Image
- (UIImage *)createImageWithColor:(UIColor*)color {
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
