import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import '../constants/secrets.dart';
import '../../shared/models/auction.dart';
import '../../shared/models/card.dart';
import '../../shared/models/user.dart';
import 'database_helper.dart';

part 'auction_service.g.dart';

class AuctionService {
  final DatabaseHelper _databaseHelper;
  
  AuctionService(this._databaseHelper);

  // Obtener todas las subastas activas
  Future<List<Auction>> getActiveAuctions({AuctionFilter? filter}) async {
    final db = await _databaseHelper.database;
    
    String query = '''
      SELECT a.*, c.*, u.display_name as seller_name, u.photo_url as seller_avatar
      FROM auctions a
      LEFT JOIN cards c ON a.card_id = c.id
      LEFT JOIN users u ON a.seller_id = u.id
      WHERE a.status IN ('active', 'bidding')
    ''';
    
    List<dynamic> args = [];
    
    if (filter != null) {
      if (filter.tcg != null) {
        query += ' AND a.tcg = ?';
        args.add(filter.tcg);
      }
      if (filter.minPrice != null) {
        query += ' AND a.current_price >= ?';
        args.add(filter.minPrice);
      }
      if (filter.maxPrice != null) {
        query += ' AND a.current_price <= ?';
        args.add(filter.maxPrice);
      }
      if (filter.rarity != null) {
        query += ' AND c.rarity = ?';
        args.add(filter.rarity);
      }
      if (filter.cardSet != null) {
        query += ' AND c.set_name = ?';
        args.add(filter.cardSet);
      }
      if (filter.searchQuery != null && filter.searchQuery!.isNotEmpty) {
        query += ' AND (a.title LIKE ? OR c.name LIKE ?)';
        args.add('%${filter.searchQuery}%');
        args.add('%${filter.searchQuery}%');
      }
    }
    
    // Ordenamiento
    if (filter?.sortBy != null) {
      switch (filter!.sortBy) {
        case 'price':
          query += ' ORDER BY a.current_price ${filter.sortAscending == true ? 'ASC' : 'DESC'}';
          break;
        case 'time':
          query += ' ORDER BY a.end_time ${filter.sortAscending == true ? 'ASC' : 'DESC'}';
          break;
        case 'popularity':
          query += ' ORDER BY a.views DESC';
          break;
        default:
          query += ' ORDER BY a.created_at DESC';
      }
    } else {
      query += ' ORDER BY a.created_at DESC';
    }
    
    final results = await db.rawQuery(query, args);
    return results.map((row) => _mapRowToAuction(row)).toList();
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
    final db = await _databaseHelper.database;
    
    final results = await db.rawQuery('''
      SELECT a.*, c.*, u.display_name as seller_name, u.photo_url as seller_avatar
      FROM auctions a
      LEFT JOIN cards c ON a.card_id = c.id
      LEFT JOIN users u ON a.seller_id = u.id
      INNER JOIN auction_watches aw ON a.id = aw.auction_id
      WHERE aw.user_id = ?
      ORDER BY a.end_time ASC
    ''', [userId]);
    
    return results.map((row) => _mapRowToAuction(row)).toList();
  }

  // Obtener subastas del usuario
  Future<List<Auction>> getUserAuctions(String userId) async {
    final db = await _databaseHelper.database;
    
    final results = await db.rawQuery('''
      SELECT a.*, c.*, u.display_name as seller_name, u.photo_url as seller_avatar
      FROM auctions a
      LEFT JOIN cards c ON a.card_id = c.id
      LEFT JOIN users u ON a.seller_id = u.id
      WHERE a.seller_id = ?
      ORDER BY a.created_at DESC
    ''', [userId]);
    
    return results.map((row) => _mapRowToAuction(row)).toList();
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
      card: Card(
        id: row['card_id'] as String,
        name: row['name'] as String,
        imageUrl: row['image_url'] as String?,
        game: CardGame.values.firstWhere(
          (e) => e.name == row['game'],
          orElse: () => CardGame.yugioh,
        ),
        rarity: row['rarity'] != null 
          ? CardRarity.values.firstWhere(
              (e) => e.name == row['rarity'],
              orElse: () => CardRarity.common,
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