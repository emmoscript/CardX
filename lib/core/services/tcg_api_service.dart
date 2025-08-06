import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/secrets.dart';

enum TcgGame {
  pokemon,
  onePiece,
  dragonBall,
  digimon,
  magic,
  unionArena,
  gundam,
  starWarsUnlimited,
}

class TcgApiService {
  static const String _baseUrl = 'https://apitcg.com/api';

  static String _getGameEndpoint(TcgGame game) {
    switch (game) {
      case TcgGame.pokemon:
        return '$_baseUrl/pokemon/cards';
      case TcgGame.onePiece:
        return '$_baseUrl/one-piece/cards';
      case TcgGame.dragonBall:
        return '$_baseUrl/dragon-ball-fusion/cards';
      case TcgGame.digimon:
        return '$_baseUrl/digimon/cards';
      case TcgGame.magic:
        return '$_baseUrl/magic/cards';
      case TcgGame.unionArena:
        return '$_baseUrl/union-arena/cards';
      case TcgGame.gundam:
        return '$_baseUrl/gundam/cards';
      case TcgGame.starWarsUnlimited:
        return '$_baseUrl/star-wars-unlimited/cards';
    }
  }

  // Search cards by property and value
  Future<List<Map<String, dynamic>>> searchCards({
    required TcgGame game,
    String? property,
    String? value,
    int page = 1,
    int limit = 25,
  }) async {
    try {
      final endpoint = _getGameEndpoint(game);
      final queryParams = <String, String>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (property != null && value != null) {
        queryParams[property] = value;
      }

      final uri = Uri.parse(endpoint).replace(queryParameters: queryParams);
      
      print('TCG API - Searching ${game.name} cards');
      print('Request URL: $uri');
      
      final response = await http.get(
        uri,
        headers: {
          'x-api-key': tcgApiKey,
          'Content-Type': 'application/json',
        },
      );
      
      print('TCG API response status: ${response.statusCode}');
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List cards = data['data'] ?? [];
        print('TCG API - Found ${cards.length} ${game.name} cards');
        
        return List<Map<String, dynamic>>.from(cards);
      } else {
        print('Error searching ${game.name} cards: ${response.statusCode}');
        print('Error response body: ${response.body}');
        throw Exception('Failed to fetch ${game.name} cards: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception searching ${game.name} cards: $e');
      throw Exception('Failed to search ${game.name} cards: $e');
    }
  }

  // Search cards by name
  Future<List<Map<String, dynamic>>> searchCardsByName({
    required TcgGame game,
    required String name,
    int page = 1,
    int limit = 25,
  }) async {
    return await searchCards(
      game: game,
      property: 'name',
      value: name,
      page: page,
      limit: limit,
    );
  }

  // Get popular cards for each game
  Future<List<Map<String, dynamic>>> getPopularCards(TcgGame game) async {
    try {
      print('TCG API - Getting popular ${game.name} cards');
      
      List<String> popularCardNames = [];
      
      switch (game) {
        case TcgGame.pokemon:
          popularCardNames = [
            'Charizard',
            'Pikachu',
            'Blastoise',
            'Venusaur',
            'Mewtwo',
            'Gyarados',
            'Alakazam',
            'Gengar',
            'Dragonite',
            'Snorlax',
          ];
          break;
        case TcgGame.onePiece:
          popularCardNames = [
            'Monkey.D.Luffy',
            'Roronoa Zoro',
            'Nami',
            'Usopp',
            'Sanji',
            'Tony Tony Chopper',
            'Nico Robin',
            'Franky',
            'Brook',
            'Jinbe',
          ];
          break;
        case TcgGame.dragonBall:
          popularCardNames = [
            'Son Goku',
            'Vegeta',
            'Gohan',
            'Trunks',
            'Piccolo',
            'Goku Black',
            'Jiren',
            'Beerus',
            'Whis',
            'Frieza',
          ];
          break;
        case TcgGame.digimon:
          popularCardNames = [
            'Agumon',
            'Gabumon',
            'Patamon',
            'Gatomon',
            'Tentomon',
            'Palmon',
            'Gomamon',
            'Piyomon',
            'Gallantmon',
            'Omnimon',
          ];
          break;
        case TcgGame.magic:
          popularCardNames = [
            'Black Lotus',
            'Ancestral Recall',
            'Time Walk',
            'Lightning Bolt',
            'Counterspell',
            'Dark Ritual',
            'Giant Growth',
            'Healing Salve',
            'Ancestral Vision',
            'Brainstorm',
          ];
          break;
        case TcgGame.unionArena:
          popularCardNames = [
            'Gon Freecss',
            'Killua Zoldyck',
            'Kurapika',
            'Leorio Paradinight',
            'Hisoka Morow',
            'Chrollo Lucilfer',
            'Illumi Zoldyck',
            'Feitan Portor',
            'Nobunaga Hazama',
            'Uvogin',
          ];
          break;
        case TcgGame.gundam:
          popularCardNames = [
            'Aile Strike Gundam',
            'Freedom Gundam',
            'Justice Gundam',
            'Destiny Gundam',
            'Wing Gundam',
            'RX-78-2 Gundam',
            'Zaku II',
            'Char Aznable',
            'Amuro Ray',
            'Kira Yamato',
          ];
          break;
        case TcgGame.starWarsUnlimited:
          popularCardNames = [
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
          ];
          break;
      }
      
      List<Map<String, dynamic>> popularCards = [];
      
      for (String cardName in popularCardNames) {
        try {
          final cards = await searchCardsByName(game: game, name: cardName, limit: 1);
          if (cards.isNotEmpty) {
            popularCards.add(cards.first);
          }
        } catch (e) {
          print('Error fetching popular ${game.name} card $cardName: $e');
        }
      }
      
      print('TCG API - Retrieved ${popularCards.length} popular ${game.name} cards');
      return popularCards;
    } catch (e) {
      print('Exception getting popular ${game.name} cards: $e');
      return [];
    }
  }

  // Get cards by rarity
  Future<List<Map<String, dynamic>>> getCardsByRarity({
    required TcgGame game,
    required String rarity,
    int page = 1,
    int limit = 25,
  }) async {
    return await searchCards(
      game: game,
      property: 'rarity',
      value: rarity,
      page: page,
      limit: limit,
    );
  }

  // Get cards by type
  Future<List<Map<String, dynamic>>> getCardsByType({
    required TcgGame game,
    required String type,
    int page = 1,
    int limit = 25,
  }) async {
    return await searchCards(
      game: game,
      property: 'type',
      value: type,
      page: page,
      limit: limit,
    );
  }
} 