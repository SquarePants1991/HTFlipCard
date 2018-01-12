//
//  HTFlipCardView.m
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import "HTFlipCardView.h"
#import "HTFlipCardLayer.h"

@interface HTFlipCardView () <CAAnimationDelegate> {
@private
    UIView *_frontView;
    UIView *_backView;
    BOOL _isFlipped;
    HTFlipAction *_currentFlipAction;
}
@property (strong, nonatomic) NSMutableArray *flipActions;
@end

@implementation HTFlipCardView

+ (Class)layerClass {
    return [HTFlipCardLayer class];
}

- (instancetype)initWithFrontView:(UIView *)frontView backView:(UIView *)backView {
    if (self = [super init]) {
        _isFlipped = NO;
        [self setFrontView:frontView backView:backView];
    }
    return self;
}

- (void)setFrontView:(UIView *)frontView backView:(UIView *)backView {
    _frontView = frontView;
    _backView = backView;
    [self addSubview:_backView];
    [self addSubview:_frontView];
    [(HTFlipCardLayer *) self.layer setFrontLayer:_frontView.layer backLayer:_backView.layer];
}

- (void)flip:(HTFlipDirection)direction {
//    [self flip:direction completed:nil];
}

- (void)flip:(HTFlipDirection)direction beforeFlip:(HTFlipActionWillFlipHandler)willFlip completed:(HTFlipActionDidFlipCompleteHandler)completed {
    HTFlipAction *action = [HTFlipAction flipActionWithDirection:direction willFlipHandler:willFlip completeHandler:completed];
    [self.flipActions addObject:action];

    dispatch_async(dispatch_get_main_queue(), ^{
        if (_currentFlipAction == nil) {
            [self peekAndDoAction];
        }
    });
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    dispatch_async(dispatch_get_main_queue(), ^{
        _isFlipped = !_isFlipped;
        if (_currentFlipAction != nil) {
            UIView *frontView = _isFlipped ? _backView : _frontView;
            UIView *backView = _isFlipped ? _frontView : _backView;
            if (_currentFlipAction.didFlipCompleteHandler) {
                _currentFlipAction.didFlipCompleteHandler(frontView, backView);
            }
            _currentFlipAction = nil;
        }
        [self peekAndDoAction];
    });
}

- (void)peekAndDoAction {
    if (self.flipActions.count > 0) {
        _currentFlipAction = self.flipActions.firstObject;
        [self.flipActions removeObjectAtIndex:0];
        [self doFlipAction:_currentFlipAction];
    }
}

- (void)doFlipAction:(HTFlipAction *)action {
    if (action.willFlipHandler) {
        action.willFlipHandler(self.frontView, self.backView);
    }
    CGFloat directionFactor = (action.flipDirection & HTFlipDirectionNegtive) ? -1 : 1;
    [(HTFlipCardLayer *) self.layer setFlipDirection:action.flipDirection];
    CABasicAnimation *flipAnimation = [CABasicAnimation animationWithKeyPath:@"flipRotation"];
    flipAnimation.fromValue = _isFlipped ? @(M_PI * directionFactor) : @0;
    flipAnimation.toValue = _isFlipped ? @(2 * M_PI * directionFactor) : @(M_PI * directionFactor);
    flipAnimation.duration = 0.5;
    flipAnimation.fillMode = kCAFillModeForwards;
    flipAnimation.removedOnCompletion = NO;
    flipAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    flipAnimation.delegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.layer addAnimation:flipAnimation forKey:@"flipRotation"];
    });
}

- (NSMutableArray *)flipActions {
    if (_flipActions == nil) {
        _flipActions = [NSMutableArray new];
    }
    return _flipActions;
}

- (UIView *)backView {
    return _isFlipped ? _frontView : _backView;
}

- (UIView *)frontView {
    return _isFlipped ? _backView : _frontView;
}
@end
