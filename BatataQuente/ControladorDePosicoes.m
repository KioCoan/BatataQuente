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
        
        [self inicializaArrayDePosicoesIphoneIcone];
        [self inicializaArrayDePosicoesIphoneFoto];
        [self inicializaArrayDePosicoesIpadIcone];
        [self inicializaArrayDePosicoesIpadFoto];

    }
    return self;
}



-(CGRect)retornaPosicaoIpadFoto:(int)index{
    
    return [[posicoesIpadFoto objectAtIndex:index] CGRectValue];
    
}


-(CGRect)retornaPosicaoIpadIcone:(int)index{
    
    return [[posicoesIpadIcone objectAtIndex:index] CGRectValue];
    
}


-(CGRect)retornaPosicaoIphoneFoto:(int)index{
    
    return [[posicoesIphoneFoto objectAtIndex:index] CGRectValue];
    
}


-(CGRect)retornaPosicaoIphoneIcone:(int)index{
    
    return [[posicoesIphoneIcone objectAtIndex:index] CGRectValue];
    
}


//POSIÇÕES DO ICONE E FOTO NO iPod ------------------------------------------
-(void)inicializaArrayDePosicoesIphoneIcone{
    posicoesIphoneIcone = [NSArray arrayWithObjects:
                        [NSValue valueWithCGRect:CGRectMake(149, 74, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(88, 98, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(206, 98, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(66, 187, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(230, 188, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(66, 282, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(230, 283, 26, 22)],nil];
}


-(void)inicializaArrayDePosicoesIphoneFoto{
    posicoesIphoneFoto = [NSArray arrayWithObjects:
                        [NSValue valueWithCGRect:CGRectMake(129, 8, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(28, 52, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(226, 52, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(7, 141, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(251, 142, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(7, 236, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(251, 237, 63, 65)],nil];
}





//POSIÇÕES DO ICONE E FOTO NO iPad ------------------------------------------
-(void)inicializaArrayDePosicoesIpadIcone{
    posicoesIpadIcone = [NSArray arrayWithObjects:
                         [NSValue valueWithCGRect:CGRectMake(364, 133, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(160, 176, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(556, 176, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(122, 369, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(601, 371, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(122, 573, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(601, 574, 47, 41)],nil];
}


-(void)inicializaArrayDePosicoesIpadFoto{
    posicoesIpadFoto = [NSArray arrayWithObjects:
                        [NSValue valueWithCGRect:CGRectMake(326, 12, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(51, 92, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(591, 92, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(13, 286, 166, 120)],
                        [NSValue valueWithCGRect:CGRectMake(636, 287, 166, 120)],
                        [NSValue valueWithCGRect:CGRectMake(13, 489, 166, 120)],
                        [NSValue valueWithCGRect:CGRectMake(636, 490, 166, 120)],nil];
}

@end
