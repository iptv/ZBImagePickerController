//
//  CustomImagePickerController.m
//  ZBImagePickerController
//
//  Created by Kevin Zhang on 13-9-5.
//  Copyright (c) 2013年 zimbean. All rights reserved.
//

#import "CustomImagePickerController.h"
#import<QuartzCore/QuartzCore.h>
@interface CustomImagePickerController ()

@end

@implementation CustomImagePickerController

@synthesize customDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;
	// Do any additional setup after loading the view.
}


//切换前、后置摄像头
- (void)swapFrontAndBackCameras:(id)sender {
    if (self.cameraDevice ==UIImagePickerControllerCameraDeviceRear ) {
        self.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    else {
        self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}

#pragma mark /////////////
- (UIView *)findView:(UIView *)aView withName:(NSString *)name{
    Class cl = [aView class];
    NSString *desc = [cl description];
    
    if ([name isEqualToString:desc]) {
        return aView;
    }
    
    for (int i = 0; i < [aView subviews].count; i++) {
        UIView *subview = [aView.subviews objectAtIndex:i];
        subview = [self findView:subview withName:name];
        
        if(subview){
            return subview;
        }
    }
    
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if(self.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImage *deviceImage = [UIImage imageNamed:@"camera_button_switch_camera.png"];
        UIButton *deviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deviceBtn setBackgroundImage:deviceImage forState:UIControlStateNormal];
        [deviceBtn addTarget:self
                      action:@selector(swapFrontAndBackCameras:)
            forControlEvents:UIControlEventTouchUpInside];
        [deviceBtn setFrame:CGRectMake(250, 20, deviceImage.size.width, deviceImage.size.height)];
        
        UIView *PLCameraView=[self findView:viewController.view withName:@"PLCameraView"];
        [PLCameraView addSubview:deviceBtn];
        
        [self setShowsCameraControls:NO];
        
        //overlyView
        UIView *overlyView = [[UIView alloc] initWithFrame:CGRectMake(0,  426, 320, 54)];
        [overlyView setBackgroundColor:[UIColor redColor]];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [backBtn addTarget:self
                    action:@selector(closeView)
          forControlEvents:UIControlEventTouchUpInside];
        [backBtn setFrame:CGRectMake(10, 5, 60, 44)];
        [backBtn setTitle:@"Back" forState:UIControlStateNormal];
        [overlyView addSubview:backBtn];
        
        UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cameraBtn.frame = CGRectMake(120, 5, 80, 44);
        [cameraBtn setTitle:@"TakePhoto" forState:UIControlStateNormal];
        [cameraBtn addTarget:self
                      action:@selector(takePicture)
            forControlEvents:UIControlEventTouchUpInside];
        [overlyView addSubview:cameraBtn];
    
        UIButton *photoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        photoBtn.frame = CGRectMake(250, 5, 60, 44);
        [photoBtn setTitle:@"ShowPhoto" forState:UIControlStateNormal];
        [photoBtn addTarget:self
                     action:@selector(showPhoto)
           forControlEvents:UIControlEventTouchUpInside];
        [overlyView addSubview:photoBtn];
        
        self.cameraOverlayView = overlyView;
    }
}

- (void)showPhoto
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)closeView{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)takePicture{
    [super takePicture];
}


#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:NO completion:NULL];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    if ([customDelegate respondsToSelector:@selector(cameraPhoto:)]) {
        [customDelegate cameraPhoto:image];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
