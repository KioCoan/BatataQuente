//
//  ControladorDePosicoes.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 23/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ControladorDePosicoes.h"

@implementation ControladorDePosicoes


-(id)init{
    self = [super init];
    if (self) {
        
        posicoesIpadFoto = [NSArray arrayWithObjects:
                            [NSValue valueWithCGPoint:CGPointMake(149, 74)], nil];
        
        
        
    }
    return self;
}



-(CGRect)retornaPosicaoBesta{
    
    return CGRectMake(149, 74, 26, 22);
    
}
@end
