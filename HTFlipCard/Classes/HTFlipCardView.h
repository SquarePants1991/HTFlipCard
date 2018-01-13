//
//  HTFlipCardView.h
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import <UIKit/UIKit.h>
#import "HTFlipCardLayer.h"
#import "HTFlipAction.h"

@interface HTFlipCardView : UIView
@property (strong, nonatomic, readonly) UIView * frontView;
@property (strong, nonatomic, readonly) UIView * backView;

- (instancetype)initWithFrontView:(UIView *)frontView backView:(UIView *)backView;
- (void)setFrontView:(UIView *)frontView backView:(UIView *)backView;
- (void)flip:(HTFlipDirection)direction;
- (void)flip:(HTFlipDirection)direction beforeFlip:(HTFlipActionWillFlipHandler)willFlip completed:(HTFlipActionDidFlipCompleteHandler)completed;
- (void)flip:(HTFlipDirection)direction duration:(CGFloat)duration beforeFlip:(HTFlipActionWillFlipHandler)willFlip completed:(HTFlipActionDidFlipCompleteHandler)completed;
@end
