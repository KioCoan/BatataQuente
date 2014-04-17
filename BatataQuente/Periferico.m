//
//  Periferico.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "Periferico.h"

@implementation Periferico

-(id)init{
    self = [super init];
    if(self){
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    }
    return self;
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    if(peripheral.state == CBPeripheralManagerStatePoweredOn){
        [self setupTestPeripheral];
        NSLog(@"Periférico on");
    }
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error{
    if(error){
        NSLog(@"Erro ao adicionar serviço");
        return;
    }
    else{
        NSLog(@"advertising");
        [self.peripheralManager startAdvertising:@{CBAdvertisementDataServiceUUIDsKey : @[service.UUID]}];
    }
}

-(void) setupTestPeripheral{
    
    self.deviceNameCharacteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:@"2A00"] properties:CBCharacteristicPropertyRead value:[@"iPod_Rafa" dataUsingEncoding:NSUTF8StringEncoding] permissions:CBAttributePermissionsReadable];
    
    self.deviceInformationService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:@"180A"] primary:YES];
    self.deviceInformationService.characteristics = @[self.deviceNameCharacteristic];
    [self.peripheralManager addService:self.deviceInformationService];
}


@end
