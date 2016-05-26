//
//  SearchViewController.m
//  Hotel
//
//  Created by Phuong on 2/17/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "SearchViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <TNRadioButtonGroup.h>
#import "JMMarkSlider.h"

@interface SearchViewController()<CLLocationManagerDelegate>{
    
    NSString *longtitude;
    NSString *lattitude;
}
@property (nonatomic , strong) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UILabel *searchLabel;
@property (weak, nonatomic) IBOutlet UIView *searchRadiusView;


@property (weak, nonatomic) IBOutlet UILabel *guestLabel;
@property (weak, nonatomic) IBOutlet UILabel *bedLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneSpacing;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoSpacing;
@property (weak, nonatomic) IBOutlet JMMarkSlider *priceSlider;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;




@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createHorizontalList];
    
   
    
    self.firstSlider.markColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.firstSlider.markPositions = @[@10,@20,@30,@40,@50,@60,@70,@80,@90,@100];
    self.firstSlider.markWidth = 1.0;
    self.firstSlider.selectedBarColor = [UIColor grayColor];
    self.firstSlider.unselectedBarColor = [UIColor blackColor];
    
    self.oneSpacing.constant = self.priceSlider.frame.size.width/4;
    self.twoSpacing.constant = self.priceSlider.frame.size.width/4;
    [self.priceLabel setText:[NSString stringWithFormat:@"%0.f $",self.firstSlider.value*300]];
 
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChange:(id)sender {
    [self.priceLabel setText:[NSString stringWithFormat:@"%0.f $",self.firstSlider.value*300]];
}
- (IBAction)guestIncrease:(id)sender {
    int value = [self.guestLabel.text intValue];
    if(value <5) {
        value = value+1;
    } else {
        value = 5;
    }
    [self.guestLabel setText:[NSString stringWithFormat:@"%i",value]];

}
- (IBAction)guestDecrease:(id)sender {
    int value = [self.guestLabel.text intValue];
    if(value>1) {
        value = value -1;
    } else {
        value = 1;
    }
    [self.guestLabel setText:[NSString stringWithFormat:@"%i",value]];

}
- (IBAction)bedIncrease:(id)sender {
    int value = [self.bedLabel.text intValue];
    if(value <5){
        value = value +1;
    } else {
        value = 5;
    }
    [self.bedLabel setText:[NSString stringWithFormat:@"%i",value]];
}
- (IBAction)bedDecrease:(id)sender {
    int value = [self.bedLabel.text intValue];
    if(value >1) {
        value = value -1;
    } else {
        value = 1;
    }
    [self.bedLabel setText:[NSString stringWithFormat:@"%i",value]];

}


- (void)createHorizontalList {
    TNCircularRadioButtonData *fiveData = [TNCircularRadioButtonData new];
    fiveData.labelText = @"5";
    fiveData.identifier = @"five";
    fiveData.selected = YES;
    
    
    TNCircularRadioButtonData *tenData = [TNCircularRadioButtonData new];
    tenData.labelText = @"10";
    tenData.identifier = @"ten";
    tenData.selected = NO;
    tenData.borderRadius = 12;
    tenData.circleRadius = 5;
    
    TNCircularRadioButtonData *fifteenData = [TNCircularRadioButtonData new];
    fifteenData.labelText = @"15";
    fifteenData.identifier = @"fifteen";
    fifteenData.selected = NO;
    fifteenData.borderRadius = 12;
    fifteenData.circleRadius = 5;
    
    TNCircularRadioButtonData *twentyData = [TNCircularRadioButtonData new];
    twentyData.labelText = @"20";
    twentyData.identifier = @"twenty";
    twentyData.selected = NO;
    twentyData.borderRadius = 12;
    twentyData.circleRadius = 5;
    
    
    self.radiusGroup = [[TNRadioButtonGroup alloc] initWithRadioButtonData:@[fiveData, tenData, fifteenData, twentyData] layout:TNRadioButtonGroupLayoutHorizontal];
    self.radiusGroup.identifier = @"Radius group";
    [self.radiusGroup create];
    self.radiusGroup.position = CGPointMake((self.view.frame.size.width - self.radiusGroup.frame.size.width)/2, self.searchLabel.center.y + 30);
    [self.searchRadiusView addSubview:self.radiusGroup];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radiusGroupUpdated:) name:SELECTED_RADIO_BUTTON_CHANGED object:self.radiusGroup];
    
    // show how update data works...
    
    [self.radiusGroup update];
   
}

- (void)radiusGroupUpdated:(NSNotification *)notification {
    NSLog(@"%@", self.radiusGroup.selectedRadioButton.data.labelText);
}

- (IBAction)Search:(id)sender {
    
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    
    [self.locationManager startUpdatingLocation];
    
   
    NSString *guest = [self.guestLabel text];
    NSString *numofbeds = [self.bedLabel text];
    NSString *destination = [self.destinationTextField text];
    NSString *radius = self.radiusGroup.selectedRadioButton.data.labelText;
    NSString *price = [NSString stringWithFormat:@"%f", self.firstSlider.value*300];
    
    
    if(destination == nil) {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Error"
                                          message:@"Please enter destination"
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       NSLog(@"OK");
                                   }];
    [alertController addAction:cancelAction];
    } else {
        NSDictionary *param = @{@"numberofbedrooms":numofbeds,@"guest":guest,@"maxdistance":radius,@"pricemax":price};
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
     NSLog(@"didFailWithError: %@", error);
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//    NSLog(@"didUpdateToLocation: %@", locations);
    CLLocation *currentLocation = locations.lastObject;
    
    if (currentLocation != nil) {
        longtitude = [NSString stringWithFormat:@"%.5f", currentLocation.coordinate.longitude];
        lattitude = [NSString stringWithFormat:@"%.5f", currentLocation.coordinate.latitude];
    }
    
     NSLog(@"%@, %@", longtitude,lattitude);
    [self.locationManager stopUpdatingLocation];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
