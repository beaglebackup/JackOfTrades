//
//  UIImage+Extensions.h
//  WSPhoto
//
//  Created by Admin on 12/18/13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Extensions)

+ (UIImage *) imageWithView:(UIView *)view;
+ (UIImage *)imageWithColor:(UIColor *)color;


+ (UIImage *)squareImageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

@end
