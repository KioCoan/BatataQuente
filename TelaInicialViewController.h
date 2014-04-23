//
//  TelaInicialViewController.h
//  BatataQuente
//
//  Created by Henrique Pereira de Lima on 23/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface TelaInicialViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBProfilePictureView *fotoPerfil;
@property (weak, nonatomic) IBOutlet FBLoginView *loginView;


@end
