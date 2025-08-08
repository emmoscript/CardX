import 'card.dart';
import 'user.dart';

enum AuctionStatus {
  active,
  bidding,
  finished,
  cancelled,
  sold
}

enum AuctionType {
  standard,
  reserve,
  buyNow,
  dutch
}

class Auction {
  final String id;
  final String title;
  final String description;
  final Card card;
  final String sellerId;
  final String? sellerName;
  final String? sellerAvatar;
  final double startingPrice;
  final double currentPrice;
  final double? reservePrice;
  final double? buyNowPrice;
  final DateTime startTime;
  final DateTime endTime;
  final AuctionStatus status;
  final AuctionType type;
  final String tcg;
  final List<String>? images;
  final String? imageUrl;
  final String? condition;
  final String? rarity;
  final String? cardSet;
  final String? setName;
  final String? language;
  final List<Bid>? bids;
  final String? winnerId;
  final String? winnerName;
  final int? totalBids;
  final int? bidCount;
  final int? views;
  final bool? isWatched;
  final DateTime? sellerJoinDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Auction({
    required this.id,
    required this.title,
    required this.description,
    required this.card,
    required this.sellerId,
    this.sellerName,
    this.sellerAvatar,
    required this.startingPrice,
    required this.currentPrice,
    this.reservePrice,
    this.buyNowPrice,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.type,
    required this.tcg,
    this.images,
    this.imageUrl,
    this.condition,
    this.rarity,
    this.cardSet,
    this.setName,
    this.language,
    this.bids,
    this.winnerId,
    this.winnerName,
    this.totalBids,
    this.bidCount,
    this.views,
    this.isWatched,
    this.sellerJoinDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Auction.fromJson(Map<String, dynamic> json) {
    return Auction(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      card: Card.fromJson(json['card'] as Map<String, dynamic>),
      sellerId: json['sellerId'] as String,
      sellerName: json['sellerName'] as String?,
      sellerAvatar: json['sellerAvatar'] as String?,
      startingPrice: (json['startingPrice'] as num).toDouble(),
      currentPrice: (json['currentPrice'] as num).toDouble(),
      reservePrice: (json['reservePrice'] as num?)?.toDouble(),
      buyNowPrice: (json['buyNowPrice'] as num?)?.toDouble(),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      status: AuctionStatus.values.firstWhere((e) => e.name == json['status']),
      type: AuctionType.values.firstWhere((e) => e.name == json['type']),
      tcg: json['tcg'] as String,
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      imageUrl: json['imageUrl'] as String?,
      condition: json['condition'] as String?,
      rarity: json['rarity'] as String?,
      cardSet: json['cardSet'] as String?,
      setName: json['setName'] as String?,
      language: json['language'] as String?,
      bids: (json['bids'] as List<dynamic>?)?.map((e) => Bid.fromJson(e as Map<String, dynamic>)).toList(),
      winnerId: json['winnerId'] as String?,
      winnerName: json['winnerName'] as String?,
      totalBids: json['totalBids'] as int?,
      bidCount: json['bidCount'] as int?,
      views: json['views'] as int?,
      isWatched: json['isWatched'] as bool?,
      sellerJoinDate: json['sellerJoinDate'] != null ? DateTime.parse(json['sellerJoinDate'] as String) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt'] as String) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'card': card.toJson(),
      'sellerId': sellerId,
      'sellerName': sellerName,
      'sellerAvatar': sellerAvatar,
      'startingPrice': startingPrice,
      'currentPrice': currentPrice,
      'reservePrice': reservePrice,
      'buyNowPrice': buyNowPrice,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status.name,
      'type': type.name,
      'tcg': tcg,
      'images': images,
      'imageUrl': imageUrl,
      'condition': condition,
      'rarity': rarity,
      'cardSet': cardSet,
      'setName': setName,
      'language': language,
      'bids': bids?.map((e) => e.toJson()).toList(),
      'winnerId': winnerId,
      'winnerName': winnerName,
      'totalBids': totalBids,
      'bidCount': bidCount,
      'views': views,
      'isWatched': isWatched,
      'sellerJoinDate': sellerJoinDate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  Auction copyWith({
    String? id,
    String? title,
    String? description,
    Card? card,
    String? sellerId,
    String? sellerName,
    String? sellerAvatar,
    double? startingPrice,
    double? currentPrice,
    double? reservePrice,
    double? buyNowPrice,
    DateTime? startTime,
    DateTime? endTime,
    AuctionStatus? status,
    AuctionType? type,
    String? tcg,
    List<String>? images,
    String? imageUrl,
    String? condition,
    String? rarity,
    String? cardSet,
    String? setName,
    String? language,
    List<Bid>? bids,
    String? winnerId,
    String? winnerName,
    int? totalBids,
    int? bidCount,
    int? views,
    bool? isWatched,
    DateTime? sellerJoinDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Auction(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      card: card ?? this.card,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerAvatar: sellerAvatar ?? this.sellerAvatar,
      startingPrice: startingPrice ?? this.startingPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      reservePrice: reservePrice ?? this.reservePrice,
      buyNowPrice: buyNowPrice ?? this.buyNowPrice,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      type: type ?? this.type,
      tcg: tcg ?? this.tcg,
      images: images ?? this.images,
      imageUrl: imageUrl ?? this.imageUrl,
      condition: condition ?? this.condition,
      rarity: rarity ?? this.rarity,
      cardSet: cardSet ?? this.cardSet,
      setName: setName ?? this.setName,
      language: language ?? this.language,
      bids: bids ?? this.bids,
      winnerId: winnerId ?? this.winnerId,
      winnerName: winnerName ?? this.winnerName,
      totalBids: totalBids ?? this.totalBids,
      bidCount: bidCount ?? this.bidCount,
      views: views ?? this.views,
      isWatched: isWatched ?? this.isWatched,
      sellerJoinDate: sellerJoinDate ?? this.sellerJoinDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class Bid {
  final String id;
  final String auctionId;
  final String bidderId;
  final String? bidderName;
  final String? bidderAvatar;
  final double amount;
  final DateTime timestamp;
  final bool? isAutoBid;
  final bool? isWinning;

  const Bid({
    required this.id,
    required this.auctionId,
    required this.bidderId,
    this.bidderName,
    this.bidderAvatar,
    required this.amount,
    required this.timestamp,
    this.isAutoBid,
    this.isWinning,
  });

  factory Bid.fromJson(Map<String, dynamic> json) {
    return Bid(
      id: json['id'] as String,
      auctionId: json['auctionId'] as String,
      bidderId: json['bidderId'] as String,
      bidderName: json['bidderName'] as String?,
      bidderAvatar: json['bidderAvatar'] as String?,
      amount: (json['amount'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      isAutoBid: json['isAutoBid'] as bool?,
      isWinning: json['isWinning'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'auctionId': auctionId,
      'bidderId': bidderId,
      'bidderName': bidderName,
      'bidderAvatar': bidderAvatar,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
      'isAutoBid': isAutoBid,
      'isWinning': isWinning,
    };
  }
}

class AuctionFilter {
  final String? tcg;
  final double? minPrice;
  final double? maxPrice;
  final AuctionStatus? status;
  final String? rarity;
  final String? cardSet;
  final String? condition;
  final String? language;
  final bool? hasReserve;
  final bool? hasBuyNow;
  final String? searchQuery;
  final String? sortBy; // 'price', 'time', 'popularity'
  final bool? sortAscending;

  const AuctionFilter({
    this.tcg,
    this.minPrice,
    this.maxPrice,
    this.status,
    this.rarity,
    this.cardSet,
    this.condition,
    this.language,
    this.hasReserve,
    this.hasBuyNow,
    this.searchQuery,
    this.sortBy,
    this.sortAscending,
  });

  factory AuctionFilter.fromJson(Map<String, dynamic> json) {
    return AuctionFilter(
      tcg: json['tcg'] as String?,
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      status: json['status'] != null ? AuctionStatus.values.firstWhere((e) => e.name == json['status']) : null,
      rarity: json['rarity'] as String?,
      cardSet: json['cardSet'] as String?,
      condition: json['condition'] as String?,
      language: json['language'] as String?,
      hasReserve: json['hasReserve'] as bool?,
      hasBuyNow: json['hasBuyNow'] as bool?,
      searchQuery: json['searchQuery'] as String?,
      sortBy: json['sortBy'] as String?,
      sortAscending: json['sortAscending'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tcg': tcg,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'status': status?.name,
      'rarity': rarity,
      'cardSet': cardSet,
      'condition': condition,
      'language': language,
      'hasReserve': hasReserve,
      'hasBuyNow': hasBuyNow,
      'searchQuery': searchQuery,
      'sortBy': sortBy,
      'sortAscending': sortAscending,
    };
  }
}

// Extension para métodos útiles
extension AuctionExtensions on Auction {
  bool get isActive => status == AuctionStatus.active || status == AuctionStatus.bidding;
  bool get isFinished => status == AuctionStatus.finished || status == AuctionStatus.sold;
  bool get hasReserve => reservePrice != null && reservePrice! > 0;
  bool get hasBuyNow => buyNowPrice != null && buyNowPrice! > 0;
  bool get isReserveMet => hasReserve ? currentPrice >= reservePrice! : true;
  
  Duration get timeRemaining {
    final now = DateTime.now();
    if (endTime.isBefore(now)) return Duration.zero;
    return endTime.difference(now);
  }
  
  bool get isExpired => timeRemaining.inSeconds <= 0;
  
  double get nextBidAmount {
    // Lógica para calcular la siguiente puja mínima
    if (currentPrice < 10) return currentPrice + 1;
    if (currentPrice < 100) return currentPrice + 5;
    if (currentPrice < 1000) return currentPrice + 10;
    return currentPrice + (currentPrice * 0.05).roundToDouble();
  }
  
  String get timeRemainingText {
    final remaining = timeRemaining;
    if (remaining.inDays > 0) {
      return '${remaining.inDays}d ${remaining.inHours % 24}h';
    } else if (remaining.inHours > 0) {
      return '${remaining.inHours}h ${remaining.inMinutes % 60}m';
    } else if (remaining.inMinutes > 0) {
      return '${remaining.inMinutes}m ${remaining.inSeconds % 60}s';
    } else {
      return '${remaining.inSeconds}s';
    }
  }
  
  String get statusText {
    switch (status) {
      case AuctionStatus.active:
        return 'Activa';
      case AuctionStatus.bidding:
        return 'Pujando';
      case AuctionStatus.finished:
        return 'Finalizada';
      case AuctionStatus.cancelled:
        return 'Cancelada';
      case AuctionStatus.sold:
        return 'Vendida';
    }
  }
  
  String get typeText {
    switch (type) {
      case AuctionType.standard:
        return 'Estándar';
      case AuctionType.reserve:
        return 'Con Reserva';
      case AuctionType.buyNow:
        return 'Compra Ya';
      case AuctionType.dutch:
        return 'Holandesa';
    }
  }
} 