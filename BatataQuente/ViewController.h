//
//  ViewController.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "Central.h"
#import "Periferico.h"

@interface ViewController : UIViewController

@property Central *central;
@property Periferico *periferico;

- (IBAction)virarCentral:(id)sender;
- (IBAction)virarPeriferico:(id)sender;

@end
