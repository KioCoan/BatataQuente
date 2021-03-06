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
    self.loginView.readPermissions = @[@"basic_info",@"email",@"user_likes",@"user_photos"];
    //self.loginView.readPermissions = @[@"basic_info"];

    
    //Customiza foto do perfil
    
    self.fotoPerfil.layer.borderWidth = 1.0f;
    self.fotoPerfil.layer.cornerRadius = CGRectGetWidth(self.fotoPerfil.bounds) / 2.0f;
    
    //NSLog(@"Bundle ID: %@", [[NSBundle mainBundle] bundleIdentifier]);
    
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
}

- (void)configuracaoObjetosFacebook: (BOOL)opcao{
    self.loginView.hidden = opcao;
    self.fotoPerfil.hidden = opcao;
    self.lblNomeUsuario.hidden = opcao;
}




- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    
    
    
        self.lblNomeUsuario.text = user.name;
        self.fotoPerfil.profileID = user.id;
   // [self verificaConexao];
    
    
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView{
    self.fotoPerfil.profileID = nil;
    self.lblNomeUsuario.text = NSLocalizedString(@"Não Logado", nil);
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error{
    NSString *alertMessage, *alertTitle;
    
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Erro no Facebook";
        alertMessage = [FBErrorUtility userMessageForError:error];
    }else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
        alertTitle = @"Erro na sessão";
        alertMessage = @"A sessão atual não é mais válida. Por favor faça login novamente";
    }else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled){
        //NSLog(@"usuario cancelou o login");
    }else{
        alertTitle = @"Ocorreu um erro";
        alertMessage = @"tente de novo mais tarde";
        //NSLog(@"Unexpected error: %@",error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc]initWithTitle:alertTitle message:alertMessage delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil]show];
    }
}

- (BOOL)verificaConexao{
    
    Reachability *networkReability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReability currentReachabilityStatus];
    
    
    if (networkStatus == NotReachable) {
        // nao existe conexao
       // UIAlertView *alert = [[[UIAlertView alloc]initWithTitle:@"Sem conexão a internet" message:@"Conecte primeiro na internet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
        
        
        
        [[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Sem conexão com a internet", nil) message:NSLocalizedString(@"Certifique-se que você está conectado ao bluetooth ou Wifi", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil]show];
        [FBSession.activeSession close];
        [FBSession.activeSession closeAndClearTokenInformation];
        self.lblNomeUsuario.text = NSLocalizedString(@"Não Logado", nil);
        return NO;
    }
    return YES;
    
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

- (UIImage*)capturaImagem {
    
    UIImage *imagemCapturada = [[UIImage alloc] init];
    
    //AQUI RECUPERA A IMAGEM DO PERFIL
    UIImageView *imgView = [self.fotoPerfil.subviews objectAtIndex:0];
    
    imagemCapturada = imgView.image;
    
     //NSLog(@"Pegando imagem do facebook");
    return imagemCapturada;
}



- (IBAction)actionProximaTela {

    ViewController *lobby = [self.storyboard instantiateViewControllerWithIdentifier:@"lobby"];
    //[self.fotoPerfil.subviews objectAtIndex:0];
    //NSLog(@"Estou indo para proximo tela");
    
    if(self.verificaConexao){
        [lobby setMyImage: self.fotoPerfil.profileID];
         [lobby setMyName:[self.lblNomeUsuario text]];
    }else{
        [lobby setMyImage: nil];
    }
    
    
    lobby.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:lobby animated:YES completion:nil];
}



@end
