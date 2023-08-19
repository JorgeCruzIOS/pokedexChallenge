//
//  ItemPokemonViewCell.m
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

#import "ItemPokemonViewCell.h"
#import "Pokedex-Swift.h"
@interface ItemPokemonViewCell ()
@property (nonatomic, strong) UIView *cardView;
@property (nonatomic, strong) UILabel *numberOnPokedexLabel;
@property (nonatomic, strong) UILabel *nameOfPokemonLabel;
@property (nonatomic, strong) UIImageView *pokemonSpriteImage;
@property (nonatomic, strong) UIButton *viewDetailButton;
@property (nonatomic, weak) id<ItemPokemonViewCellDelegate> delegate;
@property (nonatomic, strong) PokemonVM* pokemonItem;
@end

@implementation ItemPokemonViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
        if (self) {
            [self buildUI];
            [self buildConstraints];
        }
        return self;
}

- (void) buildData:(PokemonVM*) pokemon andDelegate:(id<ItemPokemonViewCellDelegate>)delegate{
    _delegate = delegate;
    _pokemonItem = pokemon;
    _numberOnPokedexLabel.text = pokemon.pkmNumber;
    _nameOfPokemonLabel.text = pokemon.pkmName;
    [pokemon fetchImage:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.pokemonSpriteImage.image = [UIImage imageWithData:pokemon.pkmImage];
        });
    }];
}

- (void)buildData:(PokemonVM *)pokemon{
    _pokemonItem = pokemon;
    _numberOnPokedexLabel.text = pokemon.pkmNumber;
    _nameOfPokemonLabel.text = pokemon.pkmName;
    _pokemonSpriteImage.image = [UIImage imageWithData:pokemon.pkmImage];
}

- (void) buildUI{
    _cardView = [[UIView alloc] initWithFrame: CGRectZero];
    [_cardView setTranslatesAutoresizingMaskIntoConstraints:false];
    [_cardView setBackgroundColor: UIColor.whiteColor];
    _cardView.layer.cornerRadius = 8;
    
    _viewDetailButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [_viewDetailButton setTranslatesAutoresizingMaskIntoConstraints:false];
    [_viewDetailButton addTarget:self action:@selector(viewDetailAction:) forControlEvents:UIControlEventTouchUpInside];
    [_viewDetailButton setTitle:@"Ver más" forState:UIControlStateNormal];
    _viewDetailButton.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightLight];
    [_viewDetailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _viewDetailButton.layer.cornerRadius = 3;
    _viewDetailButton.layer.borderWidth = 0.4;
    _viewDetailButton.layer.borderColor = [[UIColor colorWithRed:164/255 green:164/255 blue:164/255 alpha:1.0] CGColor];
    [_viewDetailButton setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];


    _numberOnPokedexLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [_numberOnPokedexLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    [_numberOnPokedexLabel setFont: [UIFont systemFontOfSize:18 weight:UIFontWeightBlack]];
    
    _nameOfPokemonLabel = [[UILabel alloc] initWithFrame: CGRectZero];
    [_nameOfPokemonLabel setTranslatesAutoresizingMaskIntoConstraints:false];
    [_nameOfPokemonLabel setFont: [UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
    
    _pokemonSpriteImage = [[UIImageView alloc] initWithFrame: CGRectZero];
    [_pokemonSpriteImage setTranslatesAutoresizingMaskIntoConstraints:false];
    [_pokemonSpriteImage setContentMode: UIViewContentModeScaleAspectFill];
    
    [self addSubview:_cardView];
    [_cardView addSubview:_numberOnPokedexLabel];
    [_cardView addSubview:_nameOfPokemonLabel];
    [_cardView addSubview:_pokemonSpriteImage];
    [_cardView addSubview:_viewDetailButton];
}

- (void) buildConstraints{
    [NSLayoutConstraint activateConstraints: @[
        [self.cardView.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant: 5],
        [self.cardView.trailingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.trailingAnchor],
        [self.cardView.leadingAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leadingAnchor],
        [self.cardView.bottomAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.bottomAnchor],
        
        [self.viewDetailButton.heightAnchor constraintEqualToConstant:15],
        [self.viewDetailButton.trailingAnchor constraintEqualToAnchor:self.cardView.trailingAnchor constant:-8],
        [self.viewDetailButton.topAnchor constraintEqualToAnchor:self.cardView.topAnchor constant:8],
        [self.viewDetailButton.widthAnchor constraintEqualToConstant:60],
        
        [self.numberOnPokedexLabel.topAnchor constraintEqualToAnchor:self.cardView.topAnchor constant:5],
        [self.numberOnPokedexLabel.leadingAnchor constraintEqualToAnchor:self.cardView.leadingAnchor constant:10],
        [self.numberOnPokedexLabel.widthAnchor constraintEqualToConstant:100],
        
        [self.nameOfPokemonLabel.centerXAnchor constraintEqualToAnchor:self.cardView.centerXAnchor],
        [self.nameOfPokemonLabel.bottomAnchor constraintEqualToAnchor:self.cardView.bottomAnchor constant:-5],
        
        [self.pokemonSpriteImage.bottomAnchor constraintEqualToAnchor:self.nameOfPokemonLabel.topAnchor constant:-5],
        [self.pokemonSpriteImage.centerXAnchor constraintEqualToAnchor:self.cardView.centerXAnchor],
        [self.pokemonSpriteImage.heightAnchor constraintEqualToAnchor:self.cardView.heightAnchor multiplier:0.6],
        [self.pokemonSpriteImage.widthAnchor constraintEqualToAnchor:self.cardView.widthAnchor multiplier:0.4]
    ]];
}

- (void)viewDetailAction:(UIButton *)sender {
    [_delegate notifyItemSelected: _pokemonItem];
}


@end
