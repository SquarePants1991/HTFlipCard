//
//  HTFlipCardLayer.m
//  Expecta
//
//  Created by ocean on 2018/1/11.
//

#import "HTFlipCardLayer.h"

@interface HTFlipCardLayer() {
    @private
    CALayer *_frontLayer;
    CALayer *_backLayer;
}
@property (strong, nonatomic) CALayer *frontLayer;
@end

@implementation HTFlipCardLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.flipDirection = HTFlipDirectionVertical;
    }
    return self;
}

- (void)setFrontLayer:(CALayer *)frontLayer backLayer:(CALayer *)backLayer {
    _frontLayer = frontLayer;
    _backLayer = backLayer;
    _frontLayer.doubleSided = NO;
    _backLayer.doubleSided = NO;
}

- (void)layoutSublayers {
    [super layoutSublayers];
    _frontLayer.frame = self.bounds;
    _backLayer.frame = self.bounds;
}

- (void)setFlipRotation:(CGFloat)flipRotation {
    _flipRotation = flipRotation;
    [self syncFlipRotation:flipRotation];
}

- (void)syncFlipRotation:(CGFloat)flipRotation {
    int flipAxis[3] = {0, 1, 0};
    if(self.flipDirection & HTFlipDirectionVertical) {
        flipAxis[0] = 1;
        flipAxis[1] = 0;
    }
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -400.0;
    CATransform3D backTransform = CATransform3DRotate(transform, M_PI + flipRotation, flipAxis[0], flipAxis[1], flipAxis[2]);
    CATransform3D frontTransform = CATransform3DRotate(transform, flipRotation, flipAxis[0], flipAxis[1], flipAxis[2]);
    _frontLayer.transform = frontTransform;
    _backLayer.transform = backTransform;
}

- (void)display {
    HTFlipCardLayer *flipCardLayer = (HTFlipCardLayer *)[self presentationLayer];
    if (flipCardLayer != nil) {
        CGFloat realFlipRotation = [flipCardLayer flipRotation];
        [self syncFlipRotation: realFlipRotation];
    }
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"flipRotation"]) {
        return YES;
    }
    return [super needsDisplayForKey:key];
}
@end
