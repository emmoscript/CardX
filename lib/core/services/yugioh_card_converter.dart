import '../../shared/models/card.dart';

class YugiohCardConverter {
  static Card fromApiData(Map<String, dynamic> apiData) {
    // Extract image URL from the new API structure
    String? imageUrl;
    if (apiData['card_images'] != null && apiData['card_images'] is List) {
      final images = apiData['card_images'] as List;
      if (images.isNotEmpty) {
        final firstImage = images.first as Map<String, dynamic>;
        imageUrl = firstImage['image_url'] ?? firstImage['image_url_small'];
      }
    }
    
    // Extract set information
    String setName = 'Unknown Set';
    String rarity = 'Common';
    double price = 0.0;
    
    if (apiData['card_sets'] != null && apiData['card_sets'] is List) {
      final sets = apiData['card_sets'] as List;
      if (sets.isNotEmpty) {
        final firstSet = sets.first as Map<String, dynamic>;
        setName = firstSet['set_name'] ?? 'Unknown Set';
        rarity = firstSet['set_rarity'] ?? 'Common';
        
        // Try to get price from set or card_prices
        if (firstSet['set_price'] != null) {
          try {
            price = double.parse(firstSet['set_price'].toString());
          } catch (e) {
            price = 0.0;
          }
        }
      }
    }
    
    // If no price from set, try card_prices
    if (price == 0.0 && apiData['card_prices'] != null && apiData['card_prices'] is List) {
      final prices = apiData['card_prices'] as List;
      if (prices.isNotEmpty) {
        final firstPrice = prices.first as Map<String, dynamic>;
        // Try different price sources
        final tcgPrice = firstPrice['tcgplayer_price'];
        final cardmarketPrice = firstPrice['cardmarket_price'];
        final ebayPrice = firstPrice['ebay_price'];
        
        if (tcgPrice != null) {
          try {
            price = double.parse(tcgPrice.toString());
          } catch (e) {
            price = 0.0;
          }
        } else if (cardmarketPrice != null) {
          try {
            price = double.parse(cardmarketPrice.toString());
          } catch (e) {
            price = 0.0;
          }
        } else if (ebayPrice != null) {
          try {
            price = double.parse(ebayPrice.toString());
          } catch (e) {
            price = 0.0;
          }
        }
      }
    }
    
    // Convert rarity string to CardRarity enum
    CardRarity cardRarity = _convertRarityString(rarity);
    
    // Create description from card effect and stats
    String description = apiData['desc'] ?? '';
    if (apiData['atk'] != null && apiData['def'] != null) {
      description += '\n\nATK: ${apiData['atk']} / DEF: ${apiData['def']}';
    }
    if (apiData['level'] != null) {
      description += '\nLevel: ${apiData['level']}';
    }
    if (apiData['attribute'] != null) {
      description += '\nAttribute: ${apiData['attribute']}';
    }
    if (apiData['race'] != null) {
      description += '\nType: ${apiData['race']}';
    }
    
    final now = DateTime.now();
    
    return Card(
      id: apiData['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: apiData['name'] ?? 'Unknown Card',
      game: CardGame.yugioh,
      imageUrl: imageUrl ?? 'https://via.placeholder.com/250x350/FFD700/000000?text=Yu-Gi-Oh!',
      setName: setName,
      rarity: cardRarity,
      price: price,
      description: description,
      isForSale: price > 0,
      isForTrade: true,
      createdAt: now,
      updatedAt: now,
    );
  }
  
  static List<Card> fromApiDataList(List<Map<String, dynamic>> apiDataList) {
    return apiDataList.map((apiData) => fromApiData(apiData)).toList();
  }
  
  static CardRarity _convertRarityString(String rarity) {
    final lowerRarity = rarity.toLowerCase();
    
    if (lowerRarity.contains('secret')) {
      return CardRarity.secretRare;
    } else if (lowerRarity.contains('ultra')) {
      return CardRarity.ultraRare;
    } else if (lowerRarity.contains('super')) {
      return CardRarity.superRare;
    } else if (lowerRarity.contains('rare')) {
      return CardRarity.rare;
    } else if (lowerRarity.contains('uncommon')) {
      return CardRarity.uncommon;
    } else if (lowerRarity.contains('common')) {
      return CardRarity.common;
    } else if (lowerRarity.contains('ultimate')) {
      return CardRarity.ultimateRare;
    } else if (lowerRarity.contains('ghost')) {
      return CardRarity.ghostRare;
    } else if (lowerRarity.contains('platinum')) {
      return CardRarity.platinumRare;
    } else if (lowerRarity.contains('starlight')) {
      return CardRarity.starlightRare;
    } else if (lowerRarity.contains('quarter century')) {
      return CardRarity.quarterCenturyRare;
    } else if (lowerRarity.contains('prismatic')) {
      return CardRarity.prismaticSecretRare;
    } else if (lowerRarity.contains('gold')) {
      return CardRarity.goldRare;
    } else if (lowerRarity.contains('parallel')) {
      return CardRarity.parallelRare;
    } else if (lowerRarity.contains('legendary')) {
      return CardRarity.legendary;
    } else {
      return CardRarity.common;
    }
  }

  // Handle different response structures
  static List<Card> fromApiResponse(dynamic response) {
    if (response is Map<String, dynamic>) {
      // If response is a single card
      return [fromApiData(response)];
    } else if (response is List) {
      // If response is a list of cards
      return response.map((card) => fromApiData(card as Map<String, dynamic>)).toList();
    } else {
      print('Unexpected response type: ${response.runtimeType}');
      return [];
    }
  }
} 