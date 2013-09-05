//
//  ZBImagePickerControllerViewController.m
//  ZBImagePickerController
//
//  Created by zimbean on 13-9-5.
//  Copyright (c) 2013年 zimbean. All rights reserved.
//

#import "ZBImagePickerControllerViewController.h"

@interface ZBImagePickerControllerViewController ()

@end

@implementation ZBImagePickerControllerViewController

@synthesize takephotoButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    [self.view addSubview:imageview];
}



- (IBAction)takePhotoButtonRsp:(id)sender{
    CustomImagePickerController *imagepickerCtrl = [[CustomImagePickerController alloc] init];
    imagepickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagepickerCtrl.customDelegate = self;
    [self presentViewController:imagepickerCtrl animated:YES completion:NULL];
}

#pragma mark CustomImagePickerControllerDelegate
- (void)cameraPhoto:(UIImage *)image{
    [imageview setImage:image];
}

- (void)cancelCamera{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
