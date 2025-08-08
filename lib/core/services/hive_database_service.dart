import 'package:hive_flutter/hive_flutter.dart';
import '../../shared/models/user.dart';
import '../../shared/models/card.dart';
import '../../shared/models/auction.dart';

class HiveDatabaseService {
  static final HiveDatabaseService instance = HiveDatabaseService._init();
  
  HiveDatabaseService._init();

  // Box names
  static const String usersBox = 'users';
  static const String cardsBox = 'cards';
  static const String auctionsBox = 'auctions';
  static const String bidsBox = 'bids';
  static const String collectionsBox = 'collections';
  static const String priceHistoryBox = 'price_history';
  static const String tradesBox = 'trades';
  static const String auctionWatchesBox = 'auction_watches';

  // Initialize Hive
  Future<void> initialize() async {
    await Hive.initFlutter();
    
    // Open boxes
    await Hive.openBox(usersBox);
    await Hive.openBox(cardsBox);
    await Hive.openBox(auctionsBox);
    await Hive.openBox(bidsBox);
    await Hive.openBox(collectionsBox);
    await Hive.openBox(priceHistoryBox);
    await Hive.openBox(tradesBox);
    await Hive.openBox(auctionWatchesBox);
  }

  // User operations
  Future<void> insertUser(User user) async {
    final box = Hive.box(usersBox);
    await box.put(user.id, user.toJson());
  }

  Future<List<User>> getAllUsers() async {
    final box = Hive.box(usersBox);
    final List<dynamic> usersData = box.values.toList();
    return usersData.map((data) {
      if (data is Map<String, dynamic>) {
        return User.fromJson(data);
      } else if (data is Map) {
        return User.fromJson(Map<String, dynamic>.from(data));
      }
      throw Exception('Invalid user data format');
    }).toList();
  }

  Future<User?> getUserById(String id) async {
    final box = Hive.box(usersBox);
    final data = box.get(id);
    if (data == null) return null;
    
    if (data is Map<String, dynamic>) {
      return User.fromJson(data);
    } else if (data is Map) {
      return User.fromJson(Map<String, dynamic>.from(data));
    }
    throw Exception('Invalid user data format');
  }

  Future<void> updateUser(User user) async {
    final box = Hive.box(usersBox);
    await box.put(user.id, user.toJson());
  }

  Future<void> deleteUser(String id) async {
    final box = Hive.box(usersBox);
    await box.delete(id);
  }

  // Card operations
  Future<void> insertCard(Card card) async {
    final box = Hive.box(cardsBox);
    await box.put(card.id, card.toJson());
  }

  Future<List<Card>> getAllCards() async {
    final box = Hive.box(cardsBox);
    final List<dynamic> cardsData = box.values.toList();
    return cardsData.map((data) {
      if (data is Map<String, dynamic>) {
        return Card.fromJson(data);
      } else if (data is Map) {
        return Card.fromJson(Map<String, dynamic>.from(data));
      }
      throw Exception('Invalid card data format');
    }).toList();
  }

  Future<Card?> getCardById(String id) async {
    final box = Hive.box(cardsBox);
    final data = box.get(id);
    if (data == null) return null;
    
    if (data is Map<String, dynamic>) {
      return Card.fromJson(data);
    } else if (data is Map) {
      return Card.fromJson(Map<String, dynamic>.from(data));
    }
    throw Exception('Invalid card data format');
  }

  Future<List<Card>> getCardsByGame(String game) async {
    final box = Hive.box(cardsBox);
    final List<dynamic> cardsData = box.values.toList();
    final cards = cardsData.map((data) {
      if (data is Map<String, dynamic>) {
        return Card.fromJson(data);
      } else if (data is Map) {
        return Card.fromJson(Map<String, dynamic>.from(data));
      }
      throw Exception('Invalid card data format');
    }).toList();
    return cards.where((card) => card.game.name == game).toList();
  }

  Future<List<Card>> searchCards(String query) async {
    final box = Hive.box(cardsBox);
    final List<dynamic> cardsData = box.values.toList();
    final cards = cardsData.map((data) {
      if (data is Map<String, dynamic>) {
        return Card.fromJson(data);
      } else if (data is Map) {
        return Card.fromJson(Map<String, dynamic>.from(data));
      }
      throw Exception('Invalid card data format');
    }).toList();
    return cards.where((card) => 
      card.name.toLowerCase().contains(query.toLowerCase()) ||
      card.description?.toLowerCase().contains(query.toLowerCase()) == true
    ).toList();
  }

  Future<void> updateCard(Card card) async {
    final box = Hive.box(cardsBox);
    await box.put(card.id, card.toJson());
  }

  Future<void> deleteCard(String id) async {
    final box = Hive.box(cardsBox);
    await box.delete(id);
  }

  // Auction operations
  Future<void> insertAuction(Auction auction) async {
    final box = Hive.box(auctionsBox);
    await box.put(auction.id, auction.toJson());
  }

  Future<List<Auction>> getAllAuctions() async {
    final box = Hive.box(auctionsBox);
    final List<dynamic> auctionsData = box.values.toList();
    return auctionsData.map((data) {
      if (data is Map<String, dynamic>) {
        return Auction.fromJson(data);
      } else if (data is Map) {
        return Auction.fromJson(Map<String, dynamic>.from(data));
      }
      throw Exception('Invalid auction data format');
    }).toList();
  }

  Future<Auction?> getAuctionById(String id) async {
    final box = Hive.box(auctionsBox);
    final data = box.get(id);
    if (data == null) return null;
    
    if (data is Map<String, dynamic>) {
      return Auction.fromJson(data);
    } else if (data is Map) {
      return Auction.fromJson(Map<String, dynamic>.from(data));
    }
    throw Exception('Invalid auction data format');
  }

  Future<List<Auction>> getActiveAuctions() async {
    final box = Hive.box(auctionsBox);
    final List<dynamic> auctionsData = box.values.toList();
    final auctions = auctionsData.map((data) {
      if (data is Map<String, dynamic>) {
        return Auction.fromJson(data);
      } else if (data is Map) {
        return Auction.fromJson(Map<String, dynamic>.from(data));
      }
      throw Exception('Invalid auction data format');
    }).toList();
    final now = DateTime.now();
    return auctions.where((auction) => 
      auction.endTime.isAfter(now) && auction.status == AuctionStatus.active
    ).toList();
  }

  Future<void> updateAuction(Auction auction) async {
    final box = Hive.box(auctionsBox);
    await box.put(auction.id, auction.toJson());
  }

  Future<void> deleteAuction(String id) async {
    final box = Hive.box(auctionsBox);
    await box.delete(id);
  }

  // Collection operations
  Future<void> addToCollection(String userId, String cardId) async {
    final box = Hive.box(collectionsBox);
    final key = '${userId}_$cardId';
    await box.put(key, {
      'userId': userId,
      'cardId': cardId,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> removeFromCollection(String userId, String cardId) async {
    final box = Hive.box(collectionsBox);
    final key = '${userId}_$cardId';
    await box.delete(key);
  }

  Future<List<String>> getUserCollection(String userId) async {
    final box = Hive.box(collectionsBox);
    final collection = box.values.where((item) => 
      item['userId'] == userId
    ).toList();
    return collection.map((item) => item['cardId'] as String).toList();
  }

  Future<bool> isInCollection(String userId, String cardId) async {
    final box = Hive.box(collectionsBox);
    final key = '${userId}_$cardId';
    return box.containsKey(key);
  }

  // Price history operations
  Future<void> addPriceHistory(String cardId, double price) async {
    final box = Hive.box(priceHistoryBox);
    final key = '${cardId}_${DateTime.now().millisecondsSinceEpoch}';
    await box.put(key, {
      'cardId': cardId,
      'price': price,
      'recordedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getPriceHistory(String cardId) async {
    final box = Hive.box(priceHistoryBox);
    return box.values.where((item) => 
      item['cardId'] == cardId
    ).toList().cast<Map<String, dynamic>>();
  }

  // Bid operations
  Future<void> addBid(String auctionId, String bidderId, double amount) async {
    final box = Hive.box(bidsBox);
    final key = '${auctionId}_${DateTime.now().millisecondsSinceEpoch}';
    await box.put(key, {
      'auctionId': auctionId,
      'bidderId': bidderId,
      'amount': amount,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getAuctionBids(String auctionId) async {
    final box = Hive.box(bidsBox);
    return box.values.where((item) => 
      item['auctionId'] == auctionId
    ).toList().cast<Map<String, dynamic>>();
  }

  // Trade operations
  Future<void> createTrade(String initiatorId, String recipientId) async {
    final box = Hive.box(tradesBox);
    final tradeId = 'trade_${DateTime.now().millisecondsSinceEpoch}';
    await box.put(tradeId, {
      'id': tradeId,
      'initiatorId': initiatorId,
      'recipientId': recipientId,
      'status': 'pending',
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, dynamic>>> getUserTrades(String userId) async {
    final box = Hive.box(tradesBox);
    return box.values.where((item) => 
      item['initiatorId'] == userId || item['recipientId'] == userId
    ).toList().cast<Map<String, dynamic>>();
  }

  // Auction watch operations
  Future<void> watchAuction(String userId, String auctionId) async {
    final box = Hive.box(auctionWatchesBox);
    final key = '${userId}_$auctionId';
    await box.put(key, {
      'userId': userId,
      'auctionId': auctionId,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> unwatchAuction(String userId, String auctionId) async {
    final box = Hive.box(auctionWatchesBox);
    final key = '${userId}_$auctionId';
    await box.delete(key);
  }

  Future<List<String>> getWatchedAuctions(String userId) async {
    final box = Hive.box(auctionWatchesBox);
    final watches = box.values.where((item) => 
      item['userId'] == userId
    ).toList();
    return watches.map((item) => item['auctionId'] as String).toList();
  }

  // Utility methods
  Future<void> clearAllData() async {
    await Hive.box(usersBox).clear();
    await Hive.box(cardsBox).clear();
    await Hive.box(auctionsBox).clear();
    await Hive.box(bidsBox).clear();
    await Hive.box(collectionsBox).clear();
    await Hive.box(priceHistoryBox).clear();
    await Hive.box(tradesBox).clear();
    await Hive.box(auctionWatchesBox).clear();
  }

  // Debug method to show database contents
  Future<void> debugShowDatabaseContents() async {
    print('=== HIVE DATABASE CONTENTS ===');
    
    // Show users
    final users = await getAllUsers();
    print('USERS (${users.length}):');
    for (final user in users) {
      print('  - ${user.displayName} (${user.email})');
    }
    
    // Show cards
    final cards = await getAllCards();
    print('CARDS (${cards.length}):');
    for (final card in cards) {
      print('  - ${card.name} (${card.game.name}) - \$${card.price}');
    }
    
    // Show auctions
    final auctions = await getAllAuctions();
    print('AUCTIONS (${auctions.length}):');
    for (final auction in auctions) {
      print('  - ${auction.title} - \$${auction.currentPrice}');
    }
    
    print('=== END DATABASE CONTENTS ===');
  }

  Future<void> close() async {
    await Hive.close();
  }
}
