//
//  ControladorJogadores.h
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 21/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jogador.h"

@interface ControladorJogadores : NSObject
{
    NSMutableArray *jogadores;
}

-(void)insereJogador:(NSString*)nomeJogador;
-(BOOL)jogadorEstaPronto:(NSString*)nomeJogador;
-(int)retornaIndiceJogador:(NSString*)nomeJogador;
-(void)removeJogador:(int)indiceJogador;
-(int)retornaNumeroDeJogadores;
-(NSString*)retornaNomeDeJogaddor:(int)indice;
-(BOOL)saiuDoJogo:(NSString*)nomeJogador;
-(void)jogadorComNome:(NSString*)nomeJogador estaPronto:(BOOL)status;
-(BOOL)todosProntos;
-(void)adicionaNoJogador:(NSString*)player aImagem:(NSString*)imagem;
-(UIImage*)retornaImagemDoGogador:(int)i;
- (int)retornaNumeroDeJogadoresProntos;


@end
