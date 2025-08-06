import 'package:freezed_annotation/freezed_annotation.dart';
import 'card.dart';
import 'user.dart';

part 'auction.freezed.dart';
part 'auction.g.dart';

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

@freezed
abstract class Auction with _$Auction {
  const factory Auction({
    required String id,
    required String title,
    required String description,
    required Card card,
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    required double startingPrice,
    required double currentPrice,
    double? reservePrice,
    double? buyNowPrice,
    required DateTime startTime,
    required DateTime endTime,
    required AuctionStatus status,
    required AuctionType type,
    required String tcg,
    List<String>? images,
    String? condition,
    String? rarity,
    String? cardSet,
    String? language,
    List<Bid>? bids,
    String? winnerId,
    String? winnerName,
    int? totalBids,
    int? views,
    bool? isWatched,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _Auction;

  factory Auction.fromJson(Map<String, dynamic> json) => _$AuctionFromJson(json);
}

@freezed
abstract class Bid with _$Bid {
  const factory Bid({
    required String id,
    required String auctionId,
    required String bidderId,
    String? bidderName,
    String? bidderAvatar,
    required double amount,
    required DateTime timestamp,
    bool? isAutoBid,
    bool? isWinning,
  }) = _Bid;

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);
}

@freezed
abstract class AuctionFilter with _$AuctionFilter {
  const factory AuctionFilter({
    String? tcg,
    double? minPrice,
    double? maxPrice,
    AuctionStatus? status,
    String? rarity,
    String? cardSet,
    String? condition,
    String? language,
    bool? hasReserve,
    bool? hasBuyNow,
    String? searchQuery,
    String? sortBy, // 'price', 'time', 'popularity'
    bool? sortAscending,
  }) = _AuctionFilter;

  factory AuctionFilter.fromJson(Map<String, dynamic> json) => _$AuctionFilterFromJson(json);
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