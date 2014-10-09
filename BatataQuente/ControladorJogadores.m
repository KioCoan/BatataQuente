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
    Jogador *j = [[Jogador alloc] initWithNome:nomeJogador estaPronto:NO andImagem:nil];

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
    
    for (int i = 0; i<[jogadores count]; i++) {
        if ([[[jogadores objectAtIndex:i ] nome]isEqualToString:nomeJogador]) {
            
            return i;
        }
    }
    
    
//    for (Jogador *j in jogadores){
//        if ([[j nome]isEqualToString:nomeJogador]) {
//            NSLog(@"%d",[jogadores indexOfObject:j]);
//            return [jogadores indexOfObject:j];
//        }
// 
//    }
    return -1;
}

-(int)retornaNumeroDeJogadores{
    return (int)[jogadores count];
}

-(NSString*)retornaNomeDeJogaddor:(int)indice{
    return [[jogadores objectAtIndex:indice]nome];
}

-(BOOL)saiuDoJogo:(NSString *)nomeJogador{
    
    int i = [self retornaIndiceJogador:nomeJogador];
    
    
    
    return ![[jogadores objectAtIndex:i] pronto];
    
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
-(void)adicionaNoJogador:(NSString*)player aImagem:(NSString*)imagem{
    int i = [self retornaIndiceJogador:player];
    [[jogadores objectAtIndex:i]setImagem:imagem];
}
-(NSString*)retornaImagemDoGogador:(int)i{
    
    return [[jogadores objectAtIndex:i]imagem ];
}

- (int)retornaNumeroDeJogadoresProntos{
    int n = 0;
    for (Jogador *j in jogadores){
        if ([j pronto]) {
            n+= 1;
        }
    }
    
    return n;

}

@end
