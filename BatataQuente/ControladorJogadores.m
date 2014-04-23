//
//  ControladorJogadores.m
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 21/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ControladorJogadores.h"

@implementation ControladorJogadores

-(id)init{
    self = [super init];
    
    if(self){
        //INSTANCIO MEU VETOR COM AS POSIÇOES DAS IMAGENS DOS PERSONAGEM QUE APARECERAM NA TELA DE PARTIDA
        
        jogadores = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}


-(void)insereJogador:(NSString*)nomeJogador{
    Jogador *j = [[Jogador alloc] init];
    [j setNome:nomeJogador];
    [j setPronto:NO];
    [jogadores addObject:j];
    
    
}
-(BOOL)jogadorEstaPronto:(NSString*)nomeJogador{
    for (Jogador *j in jogadores){
        if ([[j nome]isEqualToString:nomeJogador]) {
            return [j pronto];
        }
    }
    return NO;
}



-(int)retornaIndiceJogador:(NSString*)nomeJogador{
    for (Jogador *j in jogadores){
        if ([[j nome]isEqualToString:nomeJogador]) {
            return [jogadores indexOfObject:j];
        }
 
    }
    return -1;
}

-(int)retornaNumeroDeJogadores{
    return [jogadores count];
}

-(NSString*)retornaNomeDeJogaddor:(int)indice{
    return [[jogadores objectAtIndex:indice]nome];
}

-(BOOL)saiuDoJogo:(NSString *)nomeJogador{
    
    
    for (Jogador *player in jogadores   ) {
        if ([[player nome ]isEqualToString:nomeJogador]) {
            return NO;
            
        }
    }
    return YES;
}
-(void)removeJogador:(int)indiceJogador{
    [jogadores removeObjectAtIndex:indiceJogador];
}


-(void)jogadorComNome:(NSString *)nomeJogador estaPronto:(BOOL)status{
    
    [[jogadores objectAtIndex:[self retornaIndiceJogador:nomeJogador]]setPronto:status];
    
}

-(BOOL)todosProntos{
    for (Jogador *j in jogadores){
        if (![j pronto]) {
            return NO;
        }
    
    }
    return YES;
}

@end
