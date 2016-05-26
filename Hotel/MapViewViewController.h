//
//  MapViewViewController.h
//  Hotel
//
//  Created by Phuong on 4/26/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewViewController : UIViewController <MKMapViewDelegate>
@property (strong, nonatomic) CLLocation *currentLocation;
@end
