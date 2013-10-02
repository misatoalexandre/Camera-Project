//
//  ViewController.m
//  Camera Roll
//
//  Created by Misato Tina Alexandre on 10/2/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.statusLabel.text=@"No image";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectPhoto:(id)sender {
    self.statusLabel.text=@"Selecting a photo";
    [self startCameraControllerFromViewController:self usingDelegate:self];
    
    
}

#pragma mark-UIImagePickerControllerDelegate Methods
-(BOOL) startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate{
    
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO ) || (delegate ==nil)|| (controller==nil) )
        //not available
        return NO;
        
        UIImagePickerController *cameraUI=[[UIImagePickerController alloc]init];
        cameraUI.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        
        cameraUI.delegate=delegate;
        [controller presentViewController:cameraUI animated:YES completion:nil];
    
        return YES;
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    
    self.statusLabel.text=[NSString stringWithFormat:@"Have image:%d x %d", (int)image.size.width, (int)image.size.height];
    self.imageView.image=image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
