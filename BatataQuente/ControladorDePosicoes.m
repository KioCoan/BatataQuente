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


-(int)countVetorPosicoes{
    return (int)posicoesIpadFoto.count;
}

//POSIÇÕES DO ICONE E FOTO NO iPod ------------------------------------------
-(void)inicializaArrayDePosicoesIphoneIcone{
    posicoesIphoneIcone = [NSArray arrayWithObjects:
                        [NSValue valueWithCGRect:CGRectMake(149, 74, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(77, 105, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(217, 107, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(67, 203, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(230, 204, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(66, 309, 26, 22)],
                        [NSValue valueWithCGRect:CGRectMake(230, 310, 26, 22)],nil];
}


-(void)inicializaArrayDePosicoesIphoneFoto{
    posicoesIphoneFoto = [NSArray arrayWithObjects:
                        [NSValue valueWithCGRect:CGRectMake(129, 8, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(17, 59, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(237, 61, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(7, 157, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(250, 159, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(7, 263, 63, 65)],
                        [NSValue valueWithCGRect:CGRectMake(250, 264, 63, 65)],nil];
}





//POSIÇÕES DO ICONE E FOTO NO iPad ------------------------------------------
-(void)inicializaArrayDePosicoesIpadIcone{
    posicoesIpadIcone = [NSArray arrayWithObjects:
                         [NSValue valueWithCGRect:CGRectMake(364, 133, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(160, 177, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(567, 176, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(122, 370, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(604, 370, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(122, 577, 47, 41)],
                         [NSValue valueWithCGRect:CGRectMake(604, 573, 47, 41)],nil];
}


-(void)inicializaArrayDePosicoesIpadFoto{
    posicoesIpadFoto = [NSArray arrayWithObjects:
                        [NSValue valueWithCGRect:CGRectMake(326, 12, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(52, 94, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(602, 94, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(13, 287, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(639, 287, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(13, 493, 116, 120)],
                        [NSValue valueWithCGRect:CGRectMake(639, 490, 116, 120)],nil];
}

@end
