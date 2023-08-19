//
//  ListPokemonVC.m
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

#import "ListPokemonViewController.h"
#import "Pokedex-Swift.h"

@interface ListPokemonViewController ()
@property (nonatomic, strong) ListPokemonVM *pkmViewModel;
@property (nonatomic, strong) UICollectionView *listPokemonTV;
@end
@implementation ListPokemonViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
    [self buildConstraints];
    _pkmViewModel = [[ListPokemonVM alloc] init];
    [_pkmViewModel loadListPokemon:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.listPokemonTV reloadData];
        });
    }];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
   
}

- (void) buildUI{
    self.navigationItem.title = @"Pokemon list";
    [self.view setBackgroundColor:[UIColor colorWithRed: 245.0/256.0 green:246.0/256.0 blue:248.0/256.0 alpha:1]];
    
    UIBarButtonItem *downloadPokemonButton = [[UIBarButtonItem alloc] initWithTitle:@"Download PDF" style:UIBarButtonItemStylePlain target:self action:@selector(downloadAction)];
    self.navigationItem.rightBarButtonItem = downloadPokemonButton;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    _listPokemonTV = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _listPokemonTV.showsVerticalScrollIndicator = false;
    _listPokemonTV.delegate = self;
    _listPokemonTV.backgroundColor = UIColor.clearColor;
    _listPokemonTV.dataSource = self;
    [_listPokemonTV registerClass:[ItemPokemonViewCell class] forCellWithReuseIdentifier:@"ItemPokemonViewCell"];
    [_listPokemonTV setTranslatesAutoresizingMaskIntoConstraints: false];
    
    [self.view addSubview: _listPokemonTV];
}

- (void) buildConstraints{
    [NSLayoutConstraint activateConstraints: @[
        [self.listPokemonTV.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.listPokemonTV.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10],
        [self.listPokemonTV.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10],
        [self.listPokemonTV.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_pkmViewModel numberOfRowsInSection];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ItemPokemonViewCell *itempokemon = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemPokemonViewCell" forIndexPath:indexPath];
    [itempokemon buildData:[_pkmViewModel pokemonAtRow:indexPath.row] andDelegate:self];
    return itempokemon;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (collectionView.frame.size.width - 10) / 2;
    return CGSizeMake(cellWidth, 120);
}

- (void)downloadAction {
    ListPokemonPDF* pdftobuil = [[ListPokemonPDF alloc] initWithPkmViewModel:[_pkmViewModel fetchToPDF]];
    PDFBuilderManager* builderpdf = [[PDFBuilderManager alloc] initWithImageToBuild:pdftobuil.view];
    [builderpdf buildPDFToDownloadWithSuccesfull:^(NSURL * url) {
        UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[url] applicationActivities:nil];
        activityViewController.popoverPresentationController.sourceView = self.view;
        [self presentViewController:activityViewController animated:YES completion:nil];
    }];
}

- (void)notifyItemSelected:(PokemonVM *)pokemonVM{
    DetailPokemonViewController *detail = [[DetailPokemonViewController alloc] initWithPokemonvm:pokemonVM];
    [self.navigationController pushViewController:detail animated:YES];
}


@end

