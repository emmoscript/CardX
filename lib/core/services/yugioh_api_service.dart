import 'dart:convert';
import 'package:http/http.dart' as http;

class YugiohApiService {
  static const String _baseUrl = 'https://db.ygoprodeck.com/api/v7';
  
  // Get popular Yu-Gi-Oh! cards
  Future<List<Map<String, dynamic>>> getPopularCards() async {
    try {
      // Get popular archetype cards
      final popularArchetypes = [
        'Blue-Eyes',
        'Dark Magician', 
        'Red-Eyes',
        'Elemental HERO',
        'Cyber Dragon',
        'Blackwing',
        'Infernity',
        'Lightsworn',
        'Six Samurai',
        'Gladiator Beast'
      ];
      
      List<Map<String, dynamic>> allCards = [];
      
      for (final archetype in popularArchetypes) {
        try {
          final cards = await _getCardsByArchetype(archetype);
          allCards.addAll(cards);
          
          // Limit to avoid too many requests
          if (allCards.length >= 50) break;
        } catch (e) {
          print('Error fetching $archetype cards: $e');
          continue;
        }
      }
      
      // Shuffle and limit results
      allCards.shuffle();
      return allCards.take(20).toList();
      
    } catch (e) {
      print('Error in getPopularCards: $e');
      return _getFallbackCards();
    }
  }
  
  // Get cards by archetype
  Future<List<Map<String, dynamic>>> _getCardsByArchetype(String archetype) async {
    final uri = Uri.parse('$_baseUrl/cardinfo.php').replace(
      queryParameters: {
        'archetype': archetype,
        'num': '5', // Limit to 5 cards per archetype
        'offset': '0',
      },
    );
    
    print('Yugioh API: Fetching $archetype cards from $uri');
    
    final response = await http.get(uri);
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['data'] != null) {
        return List<Map<String, dynamic>>.from(data['data']);
      }
    }
    
    return [];
  }
  
  // Search cards by name
  Future<List<Map<String, dynamic>>> searchCards({
    String? query,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      if (query == null || query.trim().isEmpty) {
        return getPopularCards();
      }
      
      final offset = (page - 1) * pageSize;
      
      final uri = Uri.parse('$_baseUrl/cardinfo.php').replace(
        queryParameters: {
          'fname': query.trim(),
          'num': pageSize.toString(),
          'offset': offset.toString(),
        },
      );
      
      print('Yugioh API: Searching cards with query "$query"');
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          return List<Map<String, dynamic>>.from(data['data']);
        }
      }
      
      return [];
      
    } catch (e) {
      print('Error searching Yu-Gi-Oh! cards: $e');
      return [];
    }
  }
  
  // Get cards by set
  Future<List<Map<String, dynamic>>> getCardsBySet(String setName) async {
    try {
      final uri = Uri.parse('$_baseUrl/cardinfo.php').replace(
        queryParameters: {
          'cardset': setName,
          'num': '20',
          'offset': '0',
        },
      );
      
      print('Yugioh API: Fetching cards from set "$setName"');
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null) {
          return List<Map<String, dynamic>>.from(data['data']);
        }
      }
      
      return [];
      
    } catch (e) {
      print('Error getting Yu-Gi-Oh! cards by set: $e');
      return [];
    }
  }
  
  // Get random card
  Future<Map<String, dynamic>?> getRandomCard() async {
    try {
      final uri = Uri.parse('$_baseUrl/randomcard.php');
      
      print('Yugioh API: Fetching random card');
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] != null && data['data'].isNotEmpty) {
          return data['data'][0];
        }
      }
      
      return null;
      
    } catch (e) {
      print('Error getting random Yu-Gi-Oh! card: $e');
      return null;
    }
  }
  
  // Get all card sets
  Future<List<Map<String, dynamic>>> getAllCardSets() async {
    try {
      final uri = Uri.parse('$_baseUrl/cardsets.php');
      
      print('Yugioh API: Fetching all card sets');
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return List<Map<String, dynamic>>.from(data);
        }
      }
      
      return [];
      
    } catch (e) {
      print('Error getting Yu-Gi-Oh! card sets: $e');
      return [];
    }
  }
  
  // Get all archetypes
  Future<List<String>> getAllArchetypes() async {
    try {
      final uri = Uri.parse('$_baseUrl/archetypes.php');
      
      print('Yugioh API: Fetching all archetypes');
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data is List) {
          return List<String>.from(data);
        }
      }
      
      return [];
      
    } catch (e) {
      print('Error getting Yu-Gi-Oh! archetypes: $e');
      return [];
    }
  }
  
  // Fallback cards when API fails
  List<Map<String, dynamic>> _getFallbackCards() {
    return [
      {
        'id': 46986414,
        'name': 'Dark Magician',
        'type': 'Normal Monster',
        'frameType': 'normal',
        'desc': 'The ultimate wizard in terms of attack and defense.',
        'atk': 2500,
        'def': 2100,
        'level': 7,
        'race': 'Spellcaster',
        'attribute': 'DARK',
        'card_sets': [
          {
            'set_name': 'Legend of Blue Eyes White Dragon',
            'set_code': 'LOB-005',
            'set_rarity': 'Ultra Rare',
            'set_price': '15.99'
          }
        ],
        'card_images': [
          {
            'id': 46986414,
            'image_url': 'https://images.ygoprodeck.com/images/cards/46986414.jpg',
            'image_url_small': 'https://images.ygoprodeck.com/images/cards_small/46986414.jpg'
          }
        ],
        'card_prices': [
          {
            'cardmarket_price': '12.50',
            'tcgplayer_price': '15.99',
            'ebay_price': '18.99',
            'amazon_price': '16.50'
          }
        ]
      },
      {
        'id': 89631139,
        'name': 'Blue-Eyes White Dragon',
        'type': 'Normal Monster',
        'frameType': 'normal',
        'desc': 'This legendary dragon is a powerful engine of destruction.',
        'atk': 3000,
        'def': 2500,
        'level': 8,
        'race': 'Dragon',
        'attribute': 'LIGHT',
        'card_sets': [
          {
            'set_name': 'Legend of Blue Eyes White Dragon',
            'set_code': 'LOB-001',
            'set_rarity': 'Ultra Rare',
            'set_price': '25.99'
          }
        ],
        'card_images': [
          {
            'id': 89631139,
            'image_url': 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
            'image_url_small': 'https://images.ygoprodeck.com/images/cards_small/89631139.jpg'
          }
        ],
        'card_prices': [
          {
            'cardmarket_price': '22.00',
            'tcgplayer_price': '25.99',
            'ebay_price': '29.99',
            'amazon_price': '26.50'
          }
        ]
      },
      {
        'id': 74677422,
        'name': 'Red-Eyes Black Dragon',
        'type': 'Normal Monster',
        'frameType': 'normal',
        'desc': 'A ferocious dragon with a deadly attack.',
        'atk': 2400,
        'def': 2000,
        'level': 7,
        'race': 'Dragon',
        'attribute': 'DARK',
        'card_sets': [
          {
            'set_name': 'Legend of Blue Eyes White Dragon',
            'set_code': 'LOB-070',
            'set_rarity': 'Ultra Rare',
            'set_price': '18.99'
          }
        ],
        'card_images': [
          {
            'id': 74677422,
            'image_url': 'https://images.ygoprodeck.com/images/cards/74677422.jpg',
            'image_url_small': 'https://images.ygoprodeck.com/images/cards_small/74677422.jpg'
          }
        ],
        'card_prices': [
          {
            'cardmarket_price': '16.00',
            'tcgplayer_price': '18.99',
            'ebay_price': '22.99',
            'amazon_price': '19.50'
          }
        ]
      }
    ];
  }
} 