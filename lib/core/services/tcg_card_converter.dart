import '../../shared/models/card.dart';

class TcgCardConverter {
  static Card fromApiData(Map<String, dynamic> apiData, CardGame game) {
    // Extract image URL with better handling
    String? imageUrl;
    
    // Try different possible image URL fields
    if (apiData['image_url'] != null) {
      imageUrl = apiData['image_url'].toString();
    } else if (apiData['imageUrl'] != null) {
      imageUrl = apiData['imageUrl'].toString();
    } else if (apiData['image'] != null) {
      imageUrl = apiData['image'].toString();
    } else if (apiData['images'] != null && apiData['images'] is Map) {
      final images = apiData['images'] as Map<String, dynamic>;
      imageUrl = images['small'] ?? images['large'] ?? images['normal'] ?? images['png'];
    }
    
    // Log for debugging
    print('TCG Card Converter - Card: ${apiData['name']}, Image URL: $imageUrl');
    print('TCG Card Converter - Available fields: ${apiData.keys.toList()}');

    // Extract price
    double? price;
    if (apiData['cardmarket'] != null && apiData['cardmarket'] is Map) {
      final cardmarket = apiData['cardmarket'] as Map<String, dynamic>;
      if (cardmarket['prices'] != null && cardmarket['prices'] is Map) {
        final prices = cardmarket['prices'] as Map<String, dynamic>;
        final averagePrice = prices['averageSellPrice'];
        if (averagePrice != null) {
          price = double.tryParse(averagePrice.toString());
        }
      }
    }

    // Extract rarity
    CardRarity? rarity;
    final rarityString = apiData['rarity']?.toString().toLowerCase();
    rarity = _parseRarity(rarityString);

    // Extract set name
    String? setName;
    if (apiData['set'] != null && apiData['set'] is Map) {
      final set = apiData['set'] as Map<String, dynamic>;
      setName = set['name'];
    } else if (apiData['set_name'] != null) {
      setName = apiData['set_name'].toString();
    }

    return Card(
      id: apiData['id']?.toString() ?? '',
      name: apiData['name'] ?? '',
      setName: setName,
      game: game,
      rarity: rarity,
      condition: null, // Not provided by API
      price: price,
      imageUrl: imageUrl,
      sellerId: null, // Not provided by API
      isForSale: false, // Not provided by API
      isForTrade: false, // Not provided by API
      description: apiData['description'] ?? apiData['desc'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      // Game-specific fields (mostly null for non-Yu-Gi-Oh! games)
      type: apiData['types']?.join(', ') ?? apiData['type'],
      frameType: null,
      attribute: null,
      race: apiData['subtypes']?.join(', '),
      level: null,
      atk: null,
      def: null,
      archetype: null,
      scale: null,
      linkval: null,
      linkmarkers: null,
      cardSets: null,
      cardImages: null,
      cardPrices: null,
      banlistInfo: null,
    );
  }

  static CardRarity? _parseRarity(String? rarityString) {
    if (rarityString == null) return null;
    
    final rarity = rarityString.toLowerCase();
    
    if (rarity.contains('common')) return CardRarity.common;
    if (rarity.contains('uncommon')) return CardRarity.uncommon;
    if (rarity.contains('rare') && !rarity.contains('secret') && !rarity.contains('ultra') && !rarity.contains('super')) return CardRarity.rare;
    if (rarity.contains('secret rare')) return CardRarity.secretRare;
    if (rarity.contains('ultra rare')) return CardRarity.ultraRare;
    if (rarity.contains('super rare')) return CardRarity.superRare;
    if (rarity.contains('ultimate rare')) return CardRarity.ultimateRare;
    if (rarity.contains('ghost rare')) return CardRarity.ghostRare;
    if (rarity.contains('platinum rare')) return CardRarity.platinumRare;
    if (rarity.contains('starlight rare')) return CardRarity.starlightRare;
    if (rarity.contains('quarter century rare')) return CardRarity.quarterCenturyRare;
    if (rarity.contains('prismatic secret rare')) return CardRarity.prismaticSecretRare;
    if (rarity.contains('gold rare')) return CardRarity.goldRare;
    if (rarity.contains('gold secret rare')) return CardRarity.goldSecretRare;
    if (rarity.contains('parallel rare')) return CardRarity.parallelRare;
    if (rarity.contains('parallel secret rare')) return CardRarity.parallelSecretRare;
    if (rarity.contains('parallel ultra rare')) return CardRarity.parallelUltraRare;
    if (rarity.contains('parallel common')) return CardRarity.parallelCommon;
    if (rarity.contains('parallel uncommon')) return CardRarity.parallelUncommon;
    if (rarity.contains('parallel rare holo')) return CardRarity.parallelRareHolo;
    if (rarity.contains('parallel secret rare holo')) return CardRarity.parallelSecretRareHolo;
    if (rarity.contains('parallel ultra rare holo')) return CardRarity.parallelUltraRareHolo;
    if (rarity.contains('parallel common holo')) return CardRarity.parallelCommonHolo;
    if (rarity.contains('parallel uncommon holo')) return CardRarity.parallelUncommonHolo;
    if (rarity.contains('parallel rare holo secret')) return CardRarity.parallelRareHoloSecret;
    if (rarity.contains('parallel ultra rare holo secret')) return CardRarity.parallelUltraRareHoloSecret;
    if (rarity.contains('parallel common holo secret')) return CardRarity.parallelCommonHoloSecret;
    if (rarity.contains('parallel uncommon holo secret')) return CardRarity.parallelUncommonHoloSecret;
    
    // Default fallback
    return CardRarity.common;
  }

  static List<Card> fromApiDataList(List<Map<String, dynamic>> apiDataList, CardGame game) {
    return apiDataList.map((apiData) => fromApiData(apiData, game)).toList();
  }
} 