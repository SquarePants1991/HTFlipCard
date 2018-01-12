//
//  HTFlipCardLayer.h
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import <QuartzCore/QuartzCore.h>

typedef enum : NSUInteger {
    HTFlipDirectionVertical = 1 << 0,
    HTFlipDirectionHorizontal = 1 << 1,
    HTFlipDirectionNegtive = 1 << 2,
    HTFlipDirectionPositive = 1 << 3
} HTFlipDirection;

@interface HTFlipCardLayer : CALayer
@property (assign, nonatomic) CGFloat flipRotation;
@property (assign, nonatomic) HTFlipDirection flipDirection;
- (void)setFrontLayer:(CALayer *)frontLayer backLayer:(CALayer *)backLayer;
@end
