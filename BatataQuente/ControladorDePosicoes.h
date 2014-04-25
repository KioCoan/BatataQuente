//
//  ControladorDePosicoes.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 23/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ControladorDePosicoes : NSObject

{
    NSArray *posicoesIpadFoto;
    NSArray *posicoesIpadIcone;
    NSArray *posicoesIphoneFoto;
    NSArray *posicoesIphoneIcone;
}

-(CGRect)retornaPosicaoIpadFoto:(int)index;
-(CGRect)retornaPosicaoIpadIcone:(int)index;
-(CGRect)retornaPosicaoIphoneFoto:(int)index;
-(CGRect)retornaPosicaoIphoneIcone:(int)index;

-(int)countVetorPosicoes;

@end
