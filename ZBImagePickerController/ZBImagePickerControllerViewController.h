//
//  ZBImagePickerControllerViewController.h
//  ZBImagePickerController
//
//  Created by zimbean on 13-9-5.
//  Copyright (c) 2013年 zimbean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomImagePickerController.h"
@interface ZBImagePickerControllerViewController : UIViewController<UINavigationControllerDelegate,CustomImagePickerControllerDelegate>{
    
    UIImageView *imageview;
}

@property (nonatomic, retain)IBOutlet UIButton *takephotoButton;

- (IBAction)takePhotoButtonRsp:(id)sender;

@end
