//
//  Jogador.h
//  BatataQuente
//
//  Created by Rafael Aparecido de Freitas on 22/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Jogador : NSObject

@property NSString *nome;
@property BOOL pronto;
@property UIImage *imagem;


-(id)initWithNome:(NSString*)nome estaPronto:(BOOL)pronto andImagem:(UIImage*)imagem;

@end
