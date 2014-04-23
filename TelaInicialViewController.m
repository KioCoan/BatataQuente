//
//  TelaInicialViewController.m
//  BatataQuente
//
//  Created by Henrique Pereira de Lima on 23/04/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "TelaInicialViewController.h"

@interface TelaInicialViewController ()

@end

@implementation TelaInicialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self.loginView setDelegate:self];
    
    
    [self.loginView sizeToFit];
    //self.loginView.readPermissions = @[@"basic_info",@"email",@"user_likes",@"user_photos"];
    self.loginView.readPermissions = @[@"basic_info"];
    
    //Customiza foto do perfil
    
    self.fotoPerfil.layer.borderWidth = 1.0f;
    self.fotoPerfil.layer.cornerRadius = CGRectGetWidth(self.fotoPerfil.bounds) / 2.0f;
    
    NSLog(@"Bundle ID: %@", [[NSBundle mainBundle] bundleIdentifier]);
    
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    
    
    self.lblNomeUsuario.text = user.name;
    self.fotoPerfil.profileID = user.id;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
