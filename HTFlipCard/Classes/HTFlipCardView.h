//
//  HTFlipCardView.h
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import <UIKit/UIKit.h>
#import "HTFlipCardLayer.h"

typedef void(^HTFlipCardCompleteHandler)(UIView *frontView, UIView *backView);

@interface HTFlipCardView : UIView
- (instancetype)initWithFrontView:(UIView *)frontView backView:(UIView *)backView;
- (void)setFrontView:(UIView *)frontView backView:(UIView *)backView;
- (void)flip:(HTFlipDirection)direction;
- (void)flip:(HTFlipDirection)direction completed:(HTFlipCardCompleteHandler)completed;
@end
