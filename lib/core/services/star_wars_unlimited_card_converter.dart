import '../../shared/models/card.dart';

class StarWarsUnlimitedCardConverter {
  static Card fromApiData(Map<String, dynamic> apiData) {
    // Extract image URL with better handling
    String? imageUrl;
    
    // Try different possible image URL fields
    if (apiData['image_uris'] != null && apiData['image_uris'] is Map) {
      final images = apiData['image_uris'] as Map<String, dynamic>;
      imageUrl = images['normal'] ?? images['large'] ?? images['small'] ?? images['png'];
    } else if (apiData['image_url'] != null) {
      imageUrl = apiData['image_url'].toString();
    } else if (apiData['imageUrl'] != null) {
      imageUrl = apiData['imageUrl'].toString();
    } else if (apiData['image'] != null) {
      imageUrl = apiData['image'].toString();
    }
    
    // Log for debugging
    print('Star Wars Unlimited Card Converter - Card: ${apiData['name']}, Image URL: $imageUrl');
    print('Star Wars Unlimited Card Converter - Available fields: ${apiData.keys.toList()}');

    // Extract price from prices object
    double? price;
    if (apiData['prices'] != null && apiData['prices'] is Map) {
      final prices = apiData['prices'] as Map<String, dynamic>;
      final usdPrice = prices['usd'];
      if (usdPrice != null) {
        price = double.tryParse(usdPrice.toString());
      }
    }

    // Extract rarity
    CardRarity? rarity;
    final rarityString = apiData['rarity']?.toString().toLowerCase();
    rarity = _parseRarity(rarityString);

    // Extract set name
    String? setName;
    if (apiData['set_name'] != null) {
      setName = apiData['set_name'].toString();
    } else if (apiData['set'] != null && apiData['set'] is Map) {
      final set = apiData['set'] as Map<String, dynamic>;
      setName = set['name'];
    }

    return Card(
      id: apiData['id']?.toString() ?? '',
      name: apiData['name'] ?? '',
      setName: setName,
      game: CardGame.starWarsUnlimited,
      rarity: rarity,
      condition: null, // Not provided by API
      price: price,
      imageUrl: imageUrl,
      sellerId: null, // Not provided by API
      isForSale: false, // Not provided by API
      isForTrade: false, // Not provided by API
      description: apiData['oracle_text'] ?? apiData['description'] ?? apiData['desc'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      // Star Wars Unlimited specific fields
      type: apiData['type_line'] ?? apiData['types']?.join(', '),
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
    if (rarity.contains('mythic')) return CardRarity.secretRare;
    if (rarity.contains('special')) return CardRarity.ultraRare;
    if (rarity.contains('bonus')) return CardRarity.superRare;
    
    // Default fallback
    return CardRarity.common;
  }

  static List<Card> fromApiDataList(List<Map<String, dynamic>> apiDataList) {
    return apiDataList.map((apiData) => fromApiData(apiData)).toList();
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