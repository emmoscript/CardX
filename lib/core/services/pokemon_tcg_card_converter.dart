import '../../shared/models/card.dart';

class PokemonTcgCardConverter {
  static Card fromApiData(Map<String, dynamic> apiData) {
    // Extract image URL
    String? imageUrl;
    if (apiData['images'] != null && apiData['images'] is Map) {
      final images = apiData['images'] as Map<String, dynamic>;
      imageUrl = images['large'] ?? images['small'] ?? images['png'];
    }
    
    // Extract set information
    String setName = 'Unknown Set';
    String rarity = 'Common';
    double price = 0.0;
    
    if (apiData['set'] != null && apiData['set'] is Map) {
      final set = apiData['set'] as Map<String, dynamic>;
      setName = set['name'] ?? 'Unknown Set';
    }
    
    if (apiData['cardmarket'] != null && apiData['cardmarket'] is Map) {
      final cardmarket = apiData['cardmarket'] as Map<String, dynamic>;
      if (cardmarket['prices'] != null && cardmarket['prices'] is Map) {
        final prices = cardmarket['prices'] as Map<String, dynamic>;
        final averagePrice = prices['averageSellPrice'];
        if (averagePrice != null) {
          try {
            price = double.parse(averagePrice.toString());
          } catch (e) {
            price = 0.0;
          }
        }
      }
    }
    
    // Convert rarity string to CardRarity enum
    CardRarity cardRarity = _convertRarityString(apiData['rarity'] ?? 'Common');
    
    // Create description from card data
    String description = apiData['flavorText'] ?? '';
    if (apiData['attacks'] != null && apiData['attacks'] is List) {
      final attacks = apiData['attacks'] as List;
      if (attacks.isNotEmpty) {
        description += '\n\nAtaques:';
        for (final attack in attacks) {
          if (attack is Map) {
            final name = attack['name'] ?? '';
            final damage = attack['damage'] ?? '';
            description += '\n• $name: $damage';
          }
        }
      }
    }
    
    final now = DateTime.now();
    
    return Card(
      id: apiData['id']?.toString() ?? DateTime.now().millisecondsSinceEpoch.toString(),
      name: apiData['name'] ?? 'Unknown Card',
      game: CardGame.pokemon,
      imageUrl: imageUrl ?? 'https://via.placeholder.com/250x350/FFD700/000000?text=Pokemon',
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
    } else if (lowerRarity.contains('legendary')) {
      return CardRarity.legendary;
    } else {
      return CardRarity.common;
    }
  }
} 