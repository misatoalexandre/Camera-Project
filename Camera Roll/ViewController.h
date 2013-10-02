//
//  ViewController.h
//  Camera Roll
//
//  Created by Misato Tina Alexandre on 10/2/13.
//  Copyright (c) 2013 Misato Tina Alexandre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
- (IBAction)selectPhoto:(id)sender;
@end
