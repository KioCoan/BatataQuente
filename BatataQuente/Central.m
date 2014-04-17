//
//  Central.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 17/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "Central.h"

@implementation Central

-(id)init{
    self = [super init];
    if(self){
        self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        self.deviceNameServiceUUID = [CBUUID UUIDWithString:@"180A"];
        self.deviceNameCharacteristicUUID = [CBUUID UUIDWithString:@"2A00"];
    }
    return self;
}


-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    if(self.centralManager.state == CBCentralManagerStatePoweredOn){
        NSLog(@"central on");
        [self.centralManager scanForPeripheralsWithServices:@[self.deviceNameServiceUUID] options:nil];
    }
}


-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    NSLog(@"Dispositivo nome: %@", [[NSString alloc] initWithData: (NSData *)characteristic.value encoding:NSUTF8StringEncoding]);
}


-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    for(CBCharacteristic * c in service.characteristics){
        if([c.UUID.UUIDString isEqualToString: self.deviceNameCharacteristicUUID.UUIDString]){
            [self.peripheral readValueForCharacteristic:c];
        }
    }
}


-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    for(CBService *service in peripheral.services){
        if([service.UUID.UUIDString isEqualToString:self.deviceNameServiceUUID.UUIDString]){
            [peripheral discoverCharacteristics:nil forService:service];
        }
    }
}


-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral{
    NSLog(@"Periférico conectado");
    self.peripheral.delegate = self;
    [self.peripheral discoverServices:@[self.deviceNameServiceUUID]];
}


-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    NSLog(@"Dispositivo encontrato - Tentando se conectar a periféricos");
    
    [self.centralManager stopScan];
    self.peripheral = peripheral;
    [self.centralManager connectPeripheral:self.peripheral options:nil];
    
}

-(void)peripheral:(CBPeripheral *)peripheral didModifyServices:(NSArray *)invalidatedServices{
    NSLog(@"Serviço invalidado");
}


@end
