//
//  CustomImagePickerController.h
//  ZBImagePickerController
//
//  Created by Kevin Zhang on 13-9-5.
//  Copyright (c) 2013年 zimbean. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomImagePickerControllerDelegate;

@interface CustomImagePickerController : UIImagePickerController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
}

@property (nonatomic,unsafe_unretained)id<CustomImagePickerControllerDelegate>customDelegate;

@end



@protocol CustomImagePickerControllerDelegate <NSObject>

- (void)cameraPhoto:(UIImage *)image;

- (void)cancelCamera;

@end