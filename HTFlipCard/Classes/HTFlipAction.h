//
//  HTFlipCardLayer.h
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import <QuartzCore/QuartzCore.h>
#import "HTFlipCardLayer.h"

typedef void(^HTFlipActionWillFlipHandler)(UIView *frontView, UIView *backView);

typedef void(^HTFlipActionDidFlipCompleteHandler)(UIView *frontView, UIView *backView);

@interface HTFlipAction : CALayer
@property (copy, nonatomic) HTFlipActionWillFlipHandler willFlipHandler;
@property (copy, nonatomic) HTFlipActionDidFlipCompleteHandler didFlipCompleteHandler;
@property (assign, nonatomic) HTFlipDirection flipDirection;
@property (assign, nonatomic) NSTimeInterval duration;

+ (instancetype)flipActionWithDirection:(HTFlipDirection)flipDirection willFlipHandler:(HTFlipActionWillFlipHandler)willFlipHandler completeHandler:(HTFlipActionDidFlipCompleteHandler)completeHandler;
@end
