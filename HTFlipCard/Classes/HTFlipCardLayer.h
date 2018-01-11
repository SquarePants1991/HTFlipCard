//
//  HTFlipCardLayer.h
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import <QuartzCore/QuartzCore.h>

typedef enum : NSUInteger {
    HTFlipDirectionVertical,
    HTFlipDirectionHorizontal,
} HTFlipDirection;

@interface HTFlipCardLayer : CALayer
@property (assign, nonatomic) CGFloat flipRotation;
@property (assign, nonatomic) HTFlipDirection flipDirection;
- (void)setFrontLayer:(CALayer *)frontLayer backLayer:(CALayer *)backLayer;
@end
