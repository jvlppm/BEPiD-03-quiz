//
//  UIView_Blur.m
//  BEPiD-03-quiz
//
//  Based on: http://stackoverflow.com/questions/19177348/ios-7-translucent-modal-view-controller
//

#import "UIView_Blur.h"
#import "UIImage+ImageEffects.h"

@implementation UIView(Blur)

- (UIImage *)blur: (int) radius {
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image applyBlurWithRadius: radius tintColor: [UIColor colorWithWhite:1.0 alpha:0.2] saturationDeltaFactor: 1.3 maskImage: nil];
}

@end
