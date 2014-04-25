
//
//  ImagensTelaPartida.m
//  BatataQuente
//
//  Created by Felipe Costa Nascimento on 25/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "ImagensTelaPartida.h"

@implementation ImagensTelaPartida

- (id)initWithFrame:(CGRect)frame isIpad:(BOOL)ipad
{
    self = [super initWithFrame:frame];
    if (self) {
        
        controladorPosicoes = [[ControladorDePosicoes alloc] init];
        arrayFotos = [[NSMutableArray alloc] init];
        arrayIcones = [[NSMutableArray alloc] init];
        
        if (ipad) {
            [self instanciaArrayIpad];
        }else{
            [self instanciaArrayIphone];
        }
    }
    return self;
}


-(void)instanciaArrayIpad{
    for(int i=0; i<controladorPosicoes.countVetorPosicoes; i++){
        UIImageView *imgFoto = [[UIImageView alloc] initWithFrame:[controladorPosicoes retornaPosicaoIpadFoto:i]];
        UIImageView *imgIcone = [[UIImageView alloc] initWithFrame:[controladorPosicoes retornaPosicaoIpadIcone:i]];
        
        CGRect x = imgFoto.bounds;
        
        imgFoto.layer.cornerRadius = CGRectGetHeight(x)/2;
        //self.iconePersonagem.layer.borderColor = [UIColor clearColor].CGColor;
        imgFoto.clipsToBounds = YES;
        
        [arrayFotos addObject:imgFoto];
        [arrayIcones addObject:imgIcone];
    }
}


-(void)instanciaArrayIphone{
    for(int i=0; i<controladorPosicoes.countVetorPosicoes; i++){
        UIImageView *imgFoto = [[UIImageView alloc] initWithFrame:[controladorPosicoes retornaPosicaoIphoneFoto:i]];
        UIImageView *imgIcone = [[UIImageView alloc] initWithFrame:[controladorPosicoes retornaPosicaoIphoneIcone:i]];
        
        CGRect x = imgFoto.bounds;
        
        imgFoto.layer.cornerRadius = CGRectGetHeight(x)/2;
        //self.iconePersonagem.layer.borderColor = [UIColor clearColor].CGColor;
        imgFoto.clipsToBounds = YES;
        
        [arrayFotos addObject:imgFoto];
        [arrayIcones addObject:imgIcone];
    }
}



-(void)setImagemFoto:(int)index imagem:(UIImage*)img{
    UIImageView *imgViewFoto = [arrayFotos objectAtIndex:index];
    [imgViewFoto setImage:img];
    
    [arrayFotos replaceObjectAtIndex:index withObject:imgViewFoto];
    
    [self addSubview:[arrayFotos objectAtIndex:index]];
    
    
    
    UIImageView *imgViewIcone = [arrayIcones objectAtIndex:index];
    [imgViewIcone setImage:[UIImage imageNamed:@"imagemPronto.png"]];
    
    [arrayIcones replaceObjectAtIndex:index withObject:imgViewIcone];
    
    [self addSubview:[arrayIcones objectAtIndex:index]];
}

@end
