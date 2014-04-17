//
//  Central.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface Central : NSObject <CBCentralManagerDelegate, CBPeripheralDelegate>

@property CBPeripheral *peripheral;
@property CBCentralManager *centralManager;
@property CBUUID *deviceNameServiceUUID;
@property CBUUID *deviceNameCharacteristicUUID;

@end
