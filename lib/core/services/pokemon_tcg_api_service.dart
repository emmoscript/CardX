import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/secrets.dart';

class PokemonTcgApiService {
  static const String _baseUrl = 'https://api.pokemontcg.io/v2';

  // Fetch a single card by ID
  Future<Map<String, dynamic>?> getCardById(String id) async {
    try {
      final uri = Uri.parse('$_baseUrl/cards/$id');
      print('Pokémon TCG API - Fetching card by ID: $id');
      print('Request URL: $uri');
      
      final response = await http.get(
        uri,
        headers: {
          'X-Api-Key': pokemonTcgApiKey,
          'Content-Type': 'application/json',
        },
      );
      
      print('Pokémon TCG API response status: ${response.statusCode}');
      print('Pokémon TCG API response body: ${response.body.substring(0, response.body.length > 200 ? 200 : response.body.length)}...');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data'] as Map<String, dynamic>;
      } else {
        print('Error fetching card by ID: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Exception fetching card by ID: $e');
      return null;
    }
  }

  // Search cards with improved error handling
  Future<List<Map<String, dynamic>>> searchCards({
    String? query, 
    int page = 1, 
    int pageSize = 20
  }) async {
    try {
      final queryParams = <String, String>{
        'page': page.toString(),
        'pageSize': pageSize.toString(),
      };
      
      if (query != null && query.isNotEmpty) {
        queryParams['q'] = query;
      }
      
      final uri = Uri.parse('$_baseUrl/cards').replace(queryParameters: queryParams);
      
      print('Pokémon TCG API - Searching cards');
      print('Request URL: $uri');
      print('Query: $query');
      print('API Key (first 6 chars): ${pokemonTcgApiKey.substring(0, 6)}...');
      
      final response = await http.get(
        uri,
        headers: {
          'X-Api-Key': pokemonTcgApiKey,
          'Content-Type': 'application/json',
        },
      );
      
      print('Pokémon TCG API response status: ${response.statusCode}');
      print('Pokémon TCG API response headers: ${response.headers}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List cards = data['data'] ?? [];
        print('Pokémon TCG API - Found ${cards.length} cards');
        
        if (cards.isNotEmpty) {
          print('First card: ${cards.first['name']} (${cards.first['id']})');
        } else {
          print('No cards found in response');
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

  // Get popular cards with better error handling
  Future<List<Map<String, dynamic>>> getPopularCards() async {
    try {
      print('Pokémon TCG API - Getting popular cards');
      
      // Use a simple search to get some popular cards
      final cards = await searchCards(
        query: 'name:charizard OR name:pikachu OR name:blastoise OR name:venusaur',
        pageSize: 10
      );
      
      print('Pokémon TCG API - Retrieved ${cards.length} popular cards');
      
      // If no cards found, try a more general search
      if (cards.isEmpty) {
        print('No popular cards found, trying general search...');
        return await searchCards(pageSize: 10);
      }
      
      return cards;
    } catch (e) {
      print('Exception getting popular cards: $e');
      return [];
    }
  }

  // Get cards by set
  Future<List<Map<String, dynamic>>> getCardsBySet(String setId) async {
    try {
      return await searchCards(query: 'set.id:$setId', pageSize: 50);
    } catch (e) {
      print('Exception getting cards by set: $e');
      return [];
    }
  }

  // Get cards by type
  Future<List<Map<String, dynamic>>> getCardsByType(String type) async {
    try {
      return await searchCards(query: 'types:$type', pageSize: 50);
    } catch (e) {
      print('Exception getting cards by type: $e');
      return [];
    }
  }
} 