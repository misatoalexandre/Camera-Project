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
    self.selectPhoto=YES;
    self.statusLabel.text=@"Selecting a photo";
    [self startCameraControllerFromViewController:self usingDelegate:self];
    

}

- (IBAction)camera:(id)sender {
    self.selectPhoto=NO;
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (IBAction)save:(id)sender {
    if (self.imageView.image) {
        self.statusLabel.text=@"Saving image...";
        
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else{
        self.statusLabel.text=@"Cannot save: no image.";
    }
    
}

- (IBAction)shareButton:(id)sender {
    NSLog(@"Just testing");
    NSString *text=@"Hey! my photo update.";
    UIImage *shareImage=self.imageView.image;
    NSArray *items=@[text, shareImage];
    UIActivityViewController *avc=[[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}



#pragma mark- Save Image Callbacks
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        self.statusLabel.text=[NSString stringWithFormat:@"Error %d: %@", error.code, error.localizedDescription];
    }else{
        self.statusLabel.text=@"Image saved.";
        self.imageView.image=nil;
    }
}

#pragma mark-UIImagePickerControllerDelegate Methods
-(BOOL) startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id<UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate{
    
    
    
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO ) || (delegate ==nil)|| (controller==nil) )
        //not available
        return NO;
    UIImagePickerController *cameraUI=[[UIImagePickerController alloc]init];
    if (self.selectPhoto) {
        cameraUI.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    } else
        cameraUI.sourceType=UIImagePickerControllerSourceTypeCamera;
    
    
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
