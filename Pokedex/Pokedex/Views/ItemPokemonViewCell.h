//
//  ItemPokemonViewCell.h
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

#import <UIKit/UIKit.h>
@class PokemonVM;
NS_ASSUME_NONNULL_BEGIN

@protocol ItemPokemonViewCellDelegate <NSObject>

- (void)notifyItemSelected:(PokemonVM *)pokemonVM;

@end

@interface ItemPokemonViewCell : UICollectionViewCell
- (void) buildData:(PokemonVM*) pokemon andDelegate:(id<ItemPokemonViewCellDelegate>)delegate;
- (void) buildData:(PokemonVM*) pokemon;
@end

NS_ASSUME_NONNULL_END
