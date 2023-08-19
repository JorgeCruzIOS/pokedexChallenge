//
//  ListPokemonVC.h
//  Pokedex
//
//  Created by Dsi Soporte Tecnico on 17/08/23.
//

#import <UIKit/UIKit.h>
#import "ItemPokemonViewCell.h"
@class DetailPokemonViewController;
@class PDFBuilderManager;
@class ListPokemonPDF;

NS_ASSUME_NONNULL_BEGIN

@interface ListPokemonViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, ItemPokemonViewCellDelegate>

@end

NS_ASSUME_NONNULL_END
