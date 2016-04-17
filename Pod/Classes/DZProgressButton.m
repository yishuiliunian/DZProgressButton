//
//  DZProgressButton.m
//  Pods
//
//  Created by stonedong on 16/3/8.
//
//

#import "DZProgressButton.h"
#import "DZGeometryTools.h"

#define PI 3.1415926

@interface DZProgressButton ()
{
    CAShapeLayer* _progressLayer;
    UIImageView* _actionImageView;
    NSMutableDictionary* _imageCache;
}
@end

@implementation DZProgressButton

- (instancetype) init
{
    self = [super init];
    if (!self) {
        return self;
    }
    _progressLineWitdth = 2;
    _progressColor = [UIColor blueColor];
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    _imageView.layer.masksToBounds = YES;
    _progressLayer = [[CAShapeLayer alloc] init];
    [self.layer addSublayer:_progressLayer];
    _progress  = 0.3;
    _actionImageView = [UIImageView new];
    [self addSubview:_actionImageView];
    _imageCache = [NSMutableDictionary new];
    return self;
}

- (void) setImage:(UIImage *)image forState:(UIControlState)state
{
    if (!image) {
        return;
    }
    _imageCache[@(state)] = image;
    [self __loadStateImage];
}

- (void) showProgressWithAnimation:(BOOL)animated
{
    CGFloat width = MIN(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
    CGRect contentRect = CGRectCenter(self.bounds, CGSizeMake(width, width));
    width = width/2;
    UIBezierPath* path = [UIBezierPath bezierPath];
    CGPoint centerPoint = CGPointMake(CGRectGetMidX(contentRect), CGRectGetMidY(contentRect));
    CGFloat startAngle = 3/2.0*PI;
    CGFloat angle = startAngle  + self.progress * PI * 2;
    [path addArcWithCenter:centerPoint radius:width startAngle:startAngle endAngle:angle clockwise:YES];
    [path addArcWithCenter:centerPoint radius:width - _progressLineWitdth startAngle:angle endAngle:startAngle clockwise:NO];
    [path closePath];
    [_progressLayer setPath:path.CGPath];
    _progressLayer.fillColor = self.progressColor.CGColor;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = MIN(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds));
    CGRect conentRect = CGRectCenter(self.bounds, CGSizeMake(width, width));
    conentRect =  CGRectCenterSubSize(conentRect, CGSizeMake(_progressLineWitdth*2 + 2, _progressLineWitdth*2 + 2));
    _imageView.frame = conentRect;
    _imageView.layer.cornerRadius = conentRect.size.width/2;
    _actionImageView.frame = CGRectCenterSubSize(conentRect, CGSizeMake(10, 10));
    [self showProgressWithAnimation:NO];
}

- (void) setBackgroundImage:(UIImage *)backgroundImage
{
    if (_backgroundImage != backgroundImage) {
        _backgroundImage = backgroundImage;
        _imageView.image = backgroundImage;
    }
}

- (void) setProgress:(CGFloat)progress
{
    progress = MAX(0, progress);
    progress = MIN(progress, 1);
    _progress = progress;
    [self showProgressWithAnimation:YES];
}


- (void) __loadStateImage
{
    UIImage* image = _imageCache[@(self.state)];
    if (!image) {
        for (NSNumber* key in _imageCache.allKeys) {
            image = _imageCache[key];
            if (image) {
                break;
            }
        }
    }
    _actionImageView.image = image;
}
- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [super endTrackingWithTouch:touch withEvent:event];
    [self __loadStateImage];
}
@end
