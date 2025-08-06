import 'dart:convert';
import 'package:http/http.dart' as http;

class StarWarsUnlimitedApiService {
  // Note: Star Wars Unlimited is a relatively new TCG, so we'll use a placeholder API
  // In the future, this could be replaced with an official API when available
  static const String _baseUrl = 'https://api.scryfall.com/cards/search';

  // Search cards with fuzzy search
  Future<List<Map<String, dynamic>>> searchCards({
    String? query, 
    int page = 1, 
    int pageSize = 20,
  }) async {
    try {
      final queryParams = <String, String>{
        'q': 'game:starwars ${query ?? ''}'.trim(),
        'page': page.toString(),
      };
      
      final uri = Uri.parse(_baseUrl).replace(queryParameters: queryParams);
      
      print('Star Wars Unlimited API - Searching cards');
      print('Request URL: $uri');
      print('Query: $query');
      
      final response = await http.get(uri);
      
      print('Star Wars Unlimited API response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List cards = data['data'] ?? [];
        print('Star Wars Unlimited API - Found ${cards.length} cards');
        
        if (cards.isNotEmpty) {
          print('First card: ${cards.first['name']} (${cards.first['id']})');
        }
        
        return List<Map<String, dynamic>>.from(cards);
      } else {
        print('Error searching cards: ${response.statusCode}');
        print('Error response body: ${response.body}');
        throw Exception('Failed to fetch cards: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception searching cards: $e');
      throw Exception('Failed to search cards: $e');
    }
  }

  // Get popular Star Wars Unlimited cards
  Future<List<Map<String, dynamic>>> getPopularCards() async {
    try {
      print('Star Wars Unlimited API - Getting popular cards');
      
      // Since Star Wars Unlimited is new, we'll return some popular Star Wars characters
      // that might appear in the game
      final popularCardNames = [
        'Luke Skywalker',
        'Darth Vader',
        'Han Solo',
        'Princess Leia',
        'Obi-Wan Kenobi',
        'Yoda',
        'Chewbacca',
        'R2-D2',
        'C-3PO',
        'Emperor Palpatine',
        'Boba Fett',
        'Lando Calrissian',
        'Mace Windu',
        'Qui-Gon Jinn',
        'Padmé Amidala',
      ];
      
      List<Map<String, dynamic>> popularCards = [];
      
      for (String cardName in popularCardNames) {
        try {
          final cards = await searchCards(query: cardName, pageSize: 1);
          if (cards.isNotEmpty) {
            popularCards.add(cards.first);
          }
        } catch (e) {
          print('Error fetching popular card $cardName: $e');
        }
      }
      
      print('Star Wars Unlimited API - Retrieved ${popularCards.length} popular cards');
      return popularCards;
    } catch (e) {
      print('Exception getting popular cards: $e');
      return [];
    }
  }

  // Get cards by set
  Future<List<Map<String, dynamic>>> getCardsBySet(String setId) async {
    try {
      return await searchCards(query: 'set:$setId', pageSize: 50);
    } catch (e) {
      print('Exception getting cards by set: $e');
      return [];
    }
  }

  // Get cards by type
  Future<List<Map<String, dynamic>>> getCardsByType(String type) async {
    try {
      return await searchCards(query: 'type:$type', pageSize: 50);
    } catch (e) {
      print('Exception getting cards by type: $e');
      return [];
    }
  }

  // Get cards by rarity
  Future<List<Map<String, dynamic>>> getCardsByRarity(String rarity) async {
    try {
      return await searchCards(query: 'rarity:$rarity', pageSize: 50);
    } catch (e) {
      print('Exception getting cards by rarity: $e');
      return [];
    }
  }

  // Get random card
  Future<Map<String, dynamic>?> getRandomCard() async {
    try {
      final uri = Uri.parse('https://api.scryfall.com/cards/random?q=game:starwars');
      print('Star Wars Unlimited API - Getting random card');
      
      final response = await http.get(uri);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data as Map<String, dynamic>;
      } else {
        print('Error getting random card: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception getting random card: $e');
      return null;
    }
  }
} 