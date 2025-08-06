import 'package:sqflite/sqflite.dart';
import '../../shared/models/card.dart';
import 'database_helper.dart';

class CardRepository {
  static final CardRepository instance = CardRepository._internal();
  CardRepository._internal();

  // CRUD Operations
  Future<void> create(Card card) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('cards', card.toMap());
  }

  Future<Card?> read(String id) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'id = ?',
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      return CardExtensions.fromMap(maps.first);
    }
    return null;
  }

  Future<void> update(Card card) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'cards',
      card.toMap(),
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }

  Future<void> delete(String id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'cards',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Query Methods
  Future<List<Card>> getAll({int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      limit: limit,
      offset: offset,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> getCardsByGame(CardGame game, {int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'game = ?',
      whereArgs: [game.name],
      limit: limit,
      offset: offset,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> getCardsForSale({int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'is_for_sale = ?',
      whereArgs: [1],
      limit: limit,
      offset: offset,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> getCardsForTrade({int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'is_for_trade = ?',
      whereArgs: [1],
      limit: limit,
      offset: offset,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> getCardsBySeller(String sellerId, {int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'seller_id = ?',
      whereArgs: [sellerId],
      limit: limit,
      offset: offset,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> searchCards(String query, {int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'name LIKE ? OR set_name LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%', '%$query%'],
      limit: limit,
      offset: offset,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> getCardsByCondition(CardCondition condition, {int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'condition = ?',
      whereArgs: [condition.name],
      limit: limit,
      offset: offset,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> getCardsByRarity(CardRarity rarity, {int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'rarity = ?',
      whereArgs: [rarity.name],
      limit: limit,
      offset: offset,
      orderBy: 'created_at DESC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> getCardsByPriceRange(double minPrice, double maxPrice, {int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.query(
      'cards',
      where: 'price >= ? AND price <= ?',
      whereArgs: [minPrice, maxPrice],
      limit: limit,
      offset: offset,
      orderBy: 'price ASC',
    );
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  Future<List<Card>> getCardsByCollection(String collectionId, {int? limit, int? offset}) async {
    final db = await DatabaseHelper.instance.database;
    final maps = await db.rawQuery('''
      SELECT c.* FROM cards c
      INNER JOIN collection_cards cc ON c.id = cc.card_id
      WHERE cc.collection_id = ?
      ORDER BY cc.added_at DESC
      ${limit != null ? 'LIMIT $limit' : ''}
      ${offset != null ? 'OFFSET $offset' : ''}
    ''', [collectionId]);
    
    return maps.map((map) => CardExtensions.fromMap(map)).toList();
  }

  // Statistics
  Future<int> getTotalCards() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM cards');
    return result.first['count'] as int;
  }

  Future<int> getCardsForSaleCount() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM cards WHERE is_for_sale = 1');
    return result.first['count'] as int;
  }

  Future<int> getCardsForTradeCount() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM cards WHERE is_for_trade = 1');
    return result.first['count'] as int;
  }

  Future<double> getAveragePrice() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('SELECT AVG(price) as avg_price FROM cards WHERE price IS NOT NULL');
    return (result.first['avg_price'] as num?)?.toDouble() ?? 0.0;
  }

  Future<Map<CardGame, int>> getCardsByGameStats() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery('''
      SELECT game, COUNT(*) as count 
      FROM cards 
      GROUP BY game
    ''');
    
    final stats = <CardGame, int>{};
    for (final row in result) {
      final game = CardGame.values.firstWhere(
        (e) => e.name == row['game'],
        orElse: () => CardGame.pokemon,
      );
      stats[game] = row['count'] as int;
    }
    
    return stats;
  }

  // Utility methods
  Future<List<String>> getAllImagePaths() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'cards',
      columns: ['image_url'],
      where: 'image_url IS NOT NULL',
    );
    
    return result.map((row) => row['image_url'] as String).toList();
  }

  Future<void> updateCardPrice(String cardId, double newPrice) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'cards',
      {
        'price': newPrice,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [cardId],
    );
  }

  Future<void> toggleForSale(String cardId, bool isForSale) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'cards',
      {
        'is_for_sale': isForSale ? 1 : 0,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [cardId],
    );
  }

  Future<void> toggleForTrade(String cardId, bool isForTrade) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'cards',
      {
        'is_for_trade': isForTrade ? 1 : 0,
        'updated_at': DateTime.now().millisecondsSinceEpoch,
      },
      where: 'id = ?',
      whereArgs: [cardId],
    );
  }
} 