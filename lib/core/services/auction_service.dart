import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import '../constants/secrets.dart';
import '../../shared/models/auction.dart';
import '../../shared/models/card.dart' as card_model;
import '../../shared/models/user.dart';
import 'database_helper.dart';

part 'auction_service.g.dart';

class AuctionService {
  final DatabaseHelper _databaseHelper;
  
  AuctionService(this._databaseHelper);

  // Obtener todas las subastas activas
  Future<List<Auction>> getActiveAuctions({AuctionFilter? filter}) async {
    // For now, return mock data instead of database query
    final now = DateTime.now();
    final mockAuctions = [
      Auction(
        id: 'auction-1',
        title: 'Charizard Base Set Holo',
        description: 'Charizard holográfico de Base Set en excelente condición',
        card: card_model.Card(
          id: 'card-1',
          name: 'Charizard',
          game: card_model.CardGame.pokemon,
          imageUrl: 'https://images.pokemontcg.io/base1/4.png',
          setName: 'Base Set',
          rarity: card_model.CardRarity.rareHolo,
          price: 299.99,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(days: 1)),
          updatedAt: now,
        ),
        currentPrice: 299.99,
        startingPrice: 250.00,
        startTime: now.subtract(Duration(days: 1)),
        endTime: now.add(Duration(days: 2)),
        sellerId: 'user_001',
        sellerName: 'Master Collector',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Pokémon',
        imageUrl: 'https://images.pokemontcg.io/base1/4.png',
        setName: 'Base Set',
        bidCount: 5,
        views: 45,
        isWatched: false,
        sellerJoinDate: now.subtract(Duration(days: 365)),
        createdAt: now.subtract(Duration(days: 1)),
        updatedAt: now,
      ),
      Auction(
        id: 'auction-2',
        title: 'Blue-Eyes White Dragon LOB',
        description: 'Blue-Eyes White Dragon de Legend of Blue Eyes White Dragon',
        card: card_model.Card(
          id: 'card-2',
          name: 'Blue-Eyes White Dragon',
          game: card_model.CardGame.yugioh,
          imageUrl: 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
          setName: 'Legend of Blue Eyes White Dragon',
          rarity: card_model.CardRarity.ultraRare,
          price: 85.50,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(hours: 6)),
          updatedAt: now,
        ),
        currentPrice: 85.50,
        startingPrice: 75.00,
        startTime: now.subtract(Duration(hours: 6)),
        endTime: now.add(Duration(hours: 12)),
        sellerId: 'user_002',
        sellerName: 'Pokémon Fan',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Yu-Gi-Oh!',
        imageUrl: 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
        setName: 'Legend of Blue Eyes White Dragon',
        bidCount: 3,
        views: 28,
        isWatched: true,
        sellerJoinDate: now.subtract(Duration(days: 180)),
        createdAt: now.subtract(Duration(hours: 6)),
        updatedAt: now,
      ),
      Auction(
        id: 'auction-3',
        title: 'Black Lotus Alpha',
        description: 'Black Lotus de Alpha en buena condición',
        card: card_model.Card(
          id: 'card-3',
          name: 'Black Lotus',
          game: card_model.CardGame.mtg,
          imageUrl: 'https://via.placeholder.com/250x350/000000/FFFFFF?text=Black+Lotus',
          setName: 'Alpha',
          rarity: card_model.CardRarity.rare,
          price: 15000.00,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(days: 2)),
          updatedAt: now,
        ),
        currentPrice: 15000.00,
        startingPrice: 14000.00,
        startTime: now.subtract(Duration(days: 2)),
        endTime: now.add(Duration(days: 5)),
        sellerId: 'user_003',
        sellerName: 'MTG Player',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Magic',
        imageUrl: 'https://via.placeholder.com/250x350/000000/FFFFFF?text=Black+Lotus',
        setName: 'Alpha',
        bidCount: 2,
        views: 156,
        isWatched: false,
        sellerJoinDate: now.subtract(Duration(days: 90)),
        createdAt: now.subtract(Duration(days: 2)),
        updatedAt: now,
      ),
      Auction(
        id: 'auction-4',
        title: 'Pikachu Base Set',
        description: 'Pikachu común de Base Set en condición mint',
        card: card_model.Card(
          id: 'card-4',
          name: 'Pikachu',
          game: card_model.CardGame.pokemon,
          imageUrl: 'https://images.pokemontcg.io/base1/58.png',
          setName: 'Base Set',
          rarity: card_model.CardRarity.common,
          price: 15.99,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(hours: 2)),
          updatedAt: now,
        ),
        currentPrice: 15.99,
        startingPrice: 10.00,
        startTime: now.subtract(Duration(hours: 2)),
        endTime: now.add(Duration(hours: 24)),
        sellerId: 'user_001',
        sellerName: 'Master Collector',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Pokémon',
        imageUrl: 'https://images.pokemontcg.io/base1/58.png',
        setName: 'Base Set',
        bidCount: 8,
        views: 32,
        isWatched: false,
        sellerJoinDate: now.subtract(Duration(days: 365)),
        createdAt: now.subtract(Duration(hours: 2)),
        updatedAt: now,
      ),
      Auction(
        id: 'auction-5',
        title: 'Dark Magician LOB',
        description: 'Dark Magician de Legend of Blue Eyes White Dragon',
        card: card_model.Card(
          id: 'card-5',
          name: 'Dark Magician',
          game: card_model.CardGame.yugioh,
          imageUrl: 'https://images.ygoprodeck.com/images/cards/46986414.jpg',
          setName: 'Legend of Blue Eyes White Dragon',
          rarity: card_model.CardRarity.ultraRare,
          price: 45.75,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(days: 1)),
          updatedAt: now,
        ),
        currentPrice: 45.75,
        startingPrice: 40.00,
        startTime: now.subtract(Duration(days: 1)),
        endTime: now.add(Duration(days: 1)),
        sellerId: 'user_002',
        sellerName: 'Pokémon Fan',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Yu-Gi-Oh!',
        imageUrl: 'https://images.ygoprodeck.com/images/cards/46986414.jpg',
        setName: 'Legend of Blue Eyes White Dragon',
        bidCount: 4,
        views: 67,
        isWatched: true,
        sellerJoinDate: now.subtract(Duration(days: 180)),
        createdAt: now.subtract(Duration(days: 1)),
        updatedAt: now,
      ),
    ];

    // Apply filters if provided
    List<Auction> filteredAuctions = mockAuctions;
    
    if (filter != null) {
      if (filter.tcg != null && filter.tcg != 'all') {
        filteredAuctions = filteredAuctions.where((auction) => 
          auction.tcg.toLowerCase() == filter.tcg!.toLowerCase()
        ).toList();
      }
      
      if (filter.minPrice != null) {
        filteredAuctions = filteredAuctions.where((auction) => 
          auction.currentPrice >= filter.minPrice!
        ).toList();
      }
      
      if (filter.maxPrice != null) {
        filteredAuctions = filteredAuctions.where((auction) => 
          auction.currentPrice <= filter.maxPrice!
        ).toList();
      }
    }

    // Apply sorting
    if (filter?.sortBy != null) {
      switch (filter!.sortBy) {
        case 'price':
          filteredAuctions.sort((a, b) => filter.sortAscending == true 
            ? a.currentPrice.compareTo(b.currentPrice)
            : b.currentPrice.compareTo(a.currentPrice));
          break;
        case 'time':
          filteredAuctions.sort((a, b) => filter.sortAscending == true 
            ? a.endTime.compareTo(b.endTime)
            : b.endTime.compareTo(a.endTime));
          break;
        case 'popularity':
          filteredAuctions.sort((a, b) => (b.views ?? 0).compareTo(a.views ?? 0));
          break;
        default:
          filteredAuctions.sort((a, b) => (b.createdAt ?? now).compareTo(a.createdAt ?? now));
      }
    }

    return filteredAuctions;
  }

  // Obtener subasta por ID
  Future<Auction?> getAuctionById(String id) async {
    final db = await _databaseHelper.database;
    
    final results = await db.rawQuery('''
      SELECT a.*, c.*, u.display_name as seller_name, u.photo_url as seller_avatar
      FROM auctions a
      LEFT JOIN cards c ON a.card_id = c.id
      LEFT JOIN users u ON a.seller_id = u.id
      WHERE a.id = ?
    ''', [id]);
    
    if (results.isEmpty) return null;
    
    final auction = _mapRowToAuction(results.first);
    
    // Obtener pujas
    final bids = await getBidsForAuction(id);
    return auction.copyWith(bids: bids);
  }

  // Crear nueva subasta
  Future<String> createAuction(Auction auction) async {
    final db = await _databaseHelper.database;
    
    final auctionId = await db.insert('auctions', {
      'id': auction.id,
      'title': auction.title,
      'description': auction.description,
      'card_id': auction.card.id,
      'seller_id': auction.sellerId,
      'starting_price': auction.startingPrice,
      'current_price': auction.currentPrice,
      'reserve_price': auction.reservePrice,
      'buy_now_price': auction.buyNowPrice,
      'start_time': auction.startTime.toIso8601String(),
      'end_time': auction.endTime.toIso8601String(),
      'status': auction.status.name,
      'type': auction.type.name,
      'tcg': auction.tcg,
      'condition': auction.condition,
      'rarity': auction.rarity,
      'card_set': auction.cardSet,
      'language': auction.language,
      'created_at': DateTime.now().toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    });
    
    return auctionId.toString();
  }

  // Realizar puja
  Future<bool> placeBid(String auctionId, String bidderId, double amount) async {
    final db = await _databaseHelper.database;
    
    // Verificar que la subasta esté activa
    final auction = await getAuctionById(auctionId);
    if (auction == null || !auction.isActive) {
      throw Exception('Subasta no disponible');
    }
    
    // Verificar que la puja sea válida
    if (amount <= auction.currentPrice) {
      throw Exception('La puja debe ser mayor al precio actual');
    }
    
    // Verificar puja mínima
    if (amount < auction.nextBidAmount) {
      throw Exception('La puja mínima es \$${auction.nextBidAmount.toStringAsFixed(2)}');
    }
    
    await db.transaction((txn) async {
      // Insertar puja
      await txn.insert('bids', {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'auction_id': auctionId,
        'bidder_id': bidderId,
        'amount': amount,
        'timestamp': DateTime.now().toIso8601String(),
        'is_auto_bid': false,
        'is_winning': true,
      });
      
      // Actualizar precio actual de la subasta
      await txn.update(
        'auctions',
        {
          'current_price': amount,
          'status': 'bidding',
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [auctionId],
      );
      
      // Marcar pujas anteriores como no ganadoras
      await txn.update(
        'bids',
        {'is_winning': false},
        where: 'auction_id = ? AND bidder_id != ?',
        whereArgs: [auctionId, bidderId],
      );
    });
    
    return true;
  }

  // Obtener pujas de una subasta
  Future<List<Bid>> getBidsForAuction(String auctionId) async {
    final db = await _databaseHelper.database;
    
    final results = await db.rawQuery('''
      SELECT b.*, u.display_name as bidder_name, u.photo_url as bidder_avatar
      FROM bids b
      LEFT JOIN users u ON b.bidder_id = u.id
      WHERE b.auction_id = ?
      ORDER BY b.amount DESC, b.timestamp ASC
    ''', [auctionId]);
    
    return results.map((row) => Bid(
      id: row['id'] as String,
      auctionId: row['auction_id'] as String,
      bidderId: row['bidder_id'] as String,
      bidderName: row['bidder_name'] as String?,
      bidderAvatar: row['bidder_avatar'] as String?,
      amount: (row['amount'] as num).toDouble(),
      timestamp: DateTime.parse(row['timestamp'] as String),
      isAutoBid: row['is_auto_bid'] == 1,
      isWinning: row['is_winning'] == 1,
    )).toList();
  }

  // Marcar subasta como vista
  Future<void> incrementViews(String auctionId) async {
    final db = await _databaseHelper.database;
    
    await db.rawUpdate('''
      UPDATE auctions 
      SET views = COALESCE(views, 0) + 1 
      WHERE id = ?
    ''', [auctionId]);
  }

  // Agregar/remover de favoritos
  Future<void> toggleWatch(String auctionId, String userId) async {
    final db = await _databaseHelper.database;
    
    final existing = await db.query(
      'auction_watches',
      where: 'auction_id = ? AND user_id = ?',
      whereArgs: [auctionId, userId],
    );
    
    if (existing.isEmpty) {
      await db.insert('auction_watches', {
        'auction_id': auctionId,
        'user_id': userId,
        'created_at': DateTime.now().toIso8601String(),
      });
    } else {
      await db.delete(
        'auction_watches',
        where: 'auction_id = ? AND user_id = ?',
        whereArgs: [auctionId, userId],
      );
    }
  }

  // Obtener subastas vigiladas
  Future<List<Auction>> getWatchedAuctions(String userId) async {
    // For now, return mock data for watched auctions
    final now = DateTime.now();
    final mockWatchedAuctions = [
      Auction(
        id: 'auction-2',
        title: 'Blue-Eyes White Dragon LOB',
        description: 'Blue-Eyes White Dragon de Legend of Blue Eyes White Dragon',
        card: card_model.Card(
          id: 'card-2',
          name: 'Blue-Eyes White Dragon',
          game: card_model.CardGame.yugioh,
          imageUrl: 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
          setName: 'Legend of Blue Eyes White Dragon',
          rarity: card_model.CardRarity.ultraRare,
          price: 85.50,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(hours: 6)),
          updatedAt: now,
        ),
        currentPrice: 85.50,
        startingPrice: 75.00,
        startTime: now.subtract(Duration(hours: 6)),
        endTime: now.add(Duration(hours: 12)),
        sellerId: 'user_002',
        sellerName: 'Pokémon Fan',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Yu-Gi-Oh!',
        imageUrl: 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
        setName: 'Legend of Blue Eyes White Dragon',
        bidCount: 3,
        views: 28,
        isWatched: true,
        sellerJoinDate: now.subtract(Duration(days: 180)),
        createdAt: now.subtract(Duration(hours: 6)),
        updatedAt: now,
      ),
      Auction(
        id: 'auction-5',
        title: 'Dark Magician LOB',
        description: 'Dark Magician de Legend of Blue Eyes White Dragon',
        card: card_model.Card(
          id: 'card-5',
          name: 'Dark Magician',
          game: card_model.CardGame.yugioh,
          imageUrl: 'https://images.ygoprodeck.com/images/cards/46986414.jpg',
          setName: 'Legend of Blue Eyes White Dragon',
          rarity: card_model.CardRarity.ultraRare,
          price: 45.75,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(days: 1)),
          updatedAt: now,
        ),
        currentPrice: 45.75,
        startingPrice: 40.00,
        startTime: now.subtract(Duration(days: 1)),
        endTime: now.add(Duration(days: 1)),
        sellerId: 'user_002',
        sellerName: 'Pokémon Fan',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Yu-Gi-Oh!',
        imageUrl: 'https://images.ygoprodeck.com/images/cards/46986414.jpg',
        setName: 'Legend of Blue Eyes White Dragon',
        bidCount: 4,
        views: 67,
        isWatched: true,
        sellerJoinDate: now.subtract(Duration(days: 180)),
        createdAt: now.subtract(Duration(days: 1)),
        updatedAt: now,
      ),
    ];
    
    return mockWatchedAuctions;
  }

  // Obtener subastas del usuario
  Future<List<Auction>> getUserAuctions(String userId) async {
    // For now, return mock data for user auctions
    final now = DateTime.now();
    final mockUserAuctions = [
      Auction(
        id: 'auction-1',
        title: 'Charizard Base Set Holo',
        description: 'Charizard holográfico de Base Set en excelente condición',
        card: card_model.Card(
          id: 'card-1',
          name: 'Charizard',
          game: card_model.CardGame.pokemon,
          imageUrl: 'https://images.pokemontcg.io/base1/4.png',
          setName: 'Base Set',
          rarity: card_model.CardRarity.rareHolo,
          price: 299.99,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(days: 1)),
          updatedAt: now,
        ),
        currentPrice: 299.99,
        startingPrice: 250.00,
        startTime: now.subtract(Duration(days: 1)),
        endTime: now.add(Duration(days: 2)),
        sellerId: 'user_001',
        sellerName: 'Master Collector',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Pokémon',
        imageUrl: 'https://images.pokemontcg.io/base1/4.png',
        setName: 'Base Set',
        bidCount: 5,
        views: 45,
        isWatched: false,
        sellerJoinDate: now.subtract(Duration(days: 365)),
        createdAt: now.subtract(Duration(days: 1)),
        updatedAt: now,
      ),
      Auction(
        id: 'auction-4',
        title: 'Pikachu Base Set',
        description: 'Pikachu común de Base Set en condición mint',
        card: card_model.Card(
          id: 'card-4',
          name: 'Pikachu',
          game: card_model.CardGame.pokemon,
          imageUrl: 'https://images.pokemontcg.io/base1/58.png',
          setName: 'Base Set',
          rarity: card_model.CardRarity.common,
          price: 15.99,
          isForSale: true,
          isForTrade: false,
          createdAt: now.subtract(Duration(hours: 2)),
          updatedAt: now,
        ),
        currentPrice: 15.99,
        startingPrice: 10.00,
        startTime: now.subtract(Duration(hours: 2)),
        endTime: now.add(Duration(hours: 24)),
        sellerId: 'user_001',
        sellerName: 'Master Collector',
        status: AuctionStatus.active,
        type: AuctionType.standard,
        tcg: 'Pokémon',
        imageUrl: 'https://images.pokemontcg.io/base1/58.png',
        setName: 'Base Set',
        bidCount: 8,
        views: 32,
        isWatched: false,
        sellerJoinDate: now.subtract(Duration(days: 365)),
        createdAt: now.subtract(Duration(hours: 2)),
        updatedAt: now,
      ),
    ];
    
    return mockUserAuctions;
  }

  // Finalizar subastas expiradas
  Future<void> finalizeExpiredAuctions() async {
    final db = await _databaseHelper.database;
    
    await db.rawUpdate('''
      UPDATE auctions 
      SET status = 'finished' 
      WHERE end_time < ? AND status IN ('active', 'bidding')
    ''', [DateTime.now().toIso8601String()]);
  }

  // Mapear fila de BD a objeto Auction
  Auction _mapRowToAuction(Map<String, dynamic> row) {
    return Auction(
      id: row['id'] as String,
      title: row['title'] as String,
      description: row['description'] as String,
      card: card_model.Card(
        id: row['card_id'] as String,
        name: row['name'] as String,
        imageUrl: row['image_url'] as String?,
        game: card_model.CardGame.values.firstWhere(
          (e) => e.name == row['game'],
          orElse: () => card_model.CardGame.yugioh,
        ),
        rarity: row['rarity'] != null 
          ? card_model.CardRarity.values.firstWhere(
              (e) => e.name == row['rarity'],
              orElse: () => card_model.CardRarity.common,
            )
          : null,
        setName: row['set_name'] as String?,
        price: (row['price'] as num?)?.toDouble(),
        createdAt: DateTime.fromMillisecondsSinceEpoch(row['created_at'] as int),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(row['updated_at'] as int),
      ),
      sellerId: row['seller_id'] as String,
      sellerName: row['seller_name'] as String?,
      sellerAvatar: row['seller_avatar'] as String?,
      startingPrice: (row['starting_price'] as num).toDouble(),
      currentPrice: (row['current_price'] as num).toDouble(),
      reservePrice: (row['reserve_price'] as num?)?.toDouble(),
      buyNowPrice: (row['buy_now_price'] as num?)?.toDouble(),
      startTime: DateTime.parse(row['start_time'] as String),
      endTime: DateTime.parse(row['end_time'] as String),
      status: AuctionStatus.values.firstWhere(
        (e) => e.name == row['status'],
        orElse: () => AuctionStatus.active,
      ),
      type: AuctionType.values.firstWhere(
        (e) => e.name == row['type'],
        orElse: () => AuctionType.standard,
      ),
      tcg: row['tcg'] as String,
      condition: row['condition'] as String?,
      rarity: row['rarity'] as String?,
      cardSet: row['card_set'] as String?,
      language: row['language'] as String?,
      totalBids: row['total_bids'] as int?,
      views: row['views'] as int?,
      createdAt: row['created_at'] != null 
          ? DateTime.parse(row['created_at'] as String) 
          : null,
      updatedAt: row['updated_at'] != null 
          ? DateTime.parse(row['updated_at'] as String) 
          : null,
    );
  }
}

// Providers de Riverpod simplificados
@riverpod
AuctionService auctionService(AuctionServiceRef ref) {
  return AuctionService(DatabaseHelper.instance);
}

@riverpod
Future<List<Auction>> activeAuctions(
  ActiveAuctionsRef ref, {
  AuctionFilter? filter,
}) async {
  final auctionService = ref.watch(auctionServiceProvider);
  return await auctionService.getActiveAuctions(filter: filter);
}

@riverpod
Future<Auction?> auctionById(AuctionByIdRef ref, String id) async {
  final auctionService = ref.watch(auctionServiceProvider);
  return await auctionService.getAuctionById(id);
}

@riverpod
Future<List<Auction>> watchedAuctions(
  WatchedAuctionsRef ref,
  String userId,
) async {
  final auctionService = ref.watch(auctionServiceProvider);
  return await auctionService.getWatchedAuctions(userId);
}

@riverpod
Future<List<Auction>> userAuctions(
  UserAuctionsRef ref,
  String userId,
) async {
  final auctionService = ref.watch(auctionServiceProvider);
  return await auctionService.getUserAuctions(userId);
} 