//
//  Jogador.m
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 22/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "Jogador.h"

@implementation Jogador

-(id)initWithNome:(NSString*)nome estaPronto:(BOOL)pronto andImagem:(NSString*)imagem{
    self = [super init];
    
    if (self) {
        [self setNome:nome];
        [self setPronto:pronto];
        [self setImagem:imagem];
    }
    
    return self;
}

@end
