//
//  DZProgressButton.h
//  Pods
//
//  Created by stonedong on 16/3/8.
//
//

#import <UIKit/UIKit.h>
@interface DZProgressButton : UIControl
@property (nonatomic, assign) CGFloat progressLineWitdth;
@property (nonatomic, strong) UIColor* progressColor;
@property (nonatomic, strong, readonly) UIImageView* imageView;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UIImage* backgroundImage;

- (void) setImage:(UIImage*)image forState:(UIControlState)state;

@end
