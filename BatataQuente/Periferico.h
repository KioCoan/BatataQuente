//
//  Periferico.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface Periferico : NSObject <CBPeripheralManagerDelegate>

@property CBPeripheralManager *peripheralManager;
@property CBMutableCharacteristic *deviceNameCharacteristic;
@property CBMutableService *deviceInformationService;

@end
