//
//  MapViewViewController.m
//  Hotel
//
//  Created by Phuong on 4/26/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import "MapViewViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKDirections *direction;


@end

@implementation MapViewViewController{
    CLLocationManager *locationManager;
    id<MKOverlay> _overlay;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
   
    self.mapView.mapType = MKMapTypeStandard;
    MKPointAnnotation *start = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D pinCoordinate;
    pinCoordinate.latitude = 21.03534;
    pinCoordinate.longitude = 105.82389;
    start.coordinate = pinCoordinate;
    [self.mapView addAnnotation:start];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(pinCoordinate, 2000, 2000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//    [self.view addSubview:self.mapView];
    
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    NSString *address = @"Ha Dinh, Ha Noi";
    [geoCoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if(error) {
            NSLog(@"Khong tim duoc dia chi nay");
        } else {
            CLPlacemark *foundPlace;
            foundPlace = placemarks.firstObject;
            MKPointAnnotation *destination = [[MKPointAnnotation alloc] init];
            [destination setCoordinate:foundPlace.location.coordinate];
            [self.mapView addAnnotation:destination];
            [self mapSetRegion:foundPlace.location.coordinate and:start.coordinate];
            MKPlacemark *startMark = [[MKPlacemark alloc] initWithCoordinate:start.coordinate addressDictionary:nil];
            MKPlacemark *desMark = [[MKPlacemark alloc] initWithCoordinate:foundPlace.location.coordinate addressDictionary:nil];
            [self routePath:startMark toLocation:desMark];
        }
        
    }];
}

-(void)mapSetRegion: (CLLocationCoordinate2D) fromPoint
                and: (CLLocationCoordinate2D) toPoint
{
    CLLocationCoordinate2D centerPoint =
    CLLocationCoordinate2DMake((fromPoint.latitude + toPoint.latitude)/2.0,
                               (fromPoint.longitude + toPoint.longitude)/2.0);
    
    double latitudeDelta = ABS(fromPoint.latitude - toPoint.latitude) * 1.5;
    double longtitudeDelta = ABS(fromPoint.longitude - toPoint.longitude) * 1.5;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta);
    
    MKCoordinateRegion region = MKCoordinateRegionMake(centerPoint, span);
    
    [self.mapView setRegion:region animated:YES];
}

-(void) routePath: (MKPlacemark *) fromPlace
       toLocation: (MKPlacemark *) toPlace {
    MKDirectionsRequest * request = [MKDirectionsRequest new];
    
    MKMapItem *fromMapItem = [[MKMapItem alloc] initWithPlacemark:fromPlace];
    [request setSource: fromMapItem];
    
    MKMapItem *toMapItem = [[MKMapItem alloc] initWithPlacemark:toPlace];
    [request setDestination:toMapItem];
    
    
    self.direction = [[MKDirections alloc] initWithRequest: request];
    
    [self.direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if (error) {
            NSLog(@"Error %@", [error localizedDescription]);
        } else {
            [self showRoute:response];
            
        }
    }];
    
    
}

-(void)showRoute:(MKDirectionsResponse *)response
{
    
    for (MKRoute *route in response.routes)
    {
        _overlay = route.polyline;
        [self.mapView addOverlay:_overlay
                           level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id < MKOverlay >)overlay
{
    MKPolylineRenderer *renderer =
    [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor blueColor];
    renderer.lineWidth = 5.0;
    return renderer;
}
//105.82389, 21.03534

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
