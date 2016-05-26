//
//  SearchViewController.h
//  Hotel
//
//  Created by Phuong on 2/17/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNRadioButton.h"
#import <TNRadioButtonGroup.h>
#import "JMMarkSlider.h"


@interface SearchViewController : UIViewController

@property (nonatomic, strong) TNRadioButtonGroup *radiusGroup;

@property (weak, nonatomic) IBOutlet JMMarkSlider *firstSlider;

@end

