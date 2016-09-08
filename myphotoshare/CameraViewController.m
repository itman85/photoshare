//
//  CameraViewController.m
//  
//
//  Created by Phan Nguyen on 3/27/2015.
//  Copyright (c) 2015. All rights reserved.
//

#import "CameraViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import <Parse/Parse.h>
@interface CameraViewController ()
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIImageView *chosenImageView;
@property (nonatomic,assign) BOOL isShowSelectRoll;
@end

@implementation CameraViewController

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
	// Do any additional setup after loading the view.
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar_logo"]];
    self.titleTextField.layer.borderColor = BLUE_COLOR.CGColor;
    self.titleTextField.layer.borderWidth = 1.0;
    self.titleTextField.layer.cornerRadius = 5.0;
    self.isShowSelectRoll = true;
    _imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.isShowSelectRoll){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
        else {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        self.imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        [self presentViewController:self.imagePicker animated:NO completion:nil];

    }
    
  }

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isShowSelectRoll = true;
    [self clear];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.chosenImageView.image = chosenImage;
    self.isShowSelectRoll = false;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:NO completion:nil];
    [self.tabBarController setSelectedIndex:0];
}

- (void)clear {
    self.chosenImageView.image = nil;
    self.titleTextField.text = nil;
}

- (IBAction)share:(id)sender {
    if (self.chosenImageView.image) {
        NSData *imageData = UIImagePNGRepresentation(self.chosenImageView.image);
        PFFile *photoFile = [PFFile fileWithData:imageData];
        PFObject *photo = [PFObject objectWithClassName:@"Photo"];
        photo[@"image"] = photoFile;
        photo[@"whoTook"] = [PFUser currentUser];
        photo[@"title"] = self.titleTextField.text;
        [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!succeeded) {
                [self showError];
            }
        }];
    }
    else {
        [self showError];
    }
    [self clear];
    [self.tabBarController setSelectedIndex:0];
}

- (void)showError {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Could not post your photo, please try again" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.titleTextField resignFirstResponder];
}



- (IBAction)slectpicture:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    self.imagePicker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
    [self presentViewController:self.imagePicker animated:NO completion:nil];
}












@end
