// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Auction _$AuctionFromJson(Map<String, dynamic> json) => _Auction(
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
      status: $enumDecode(_$AuctionStatusEnumMap, json['status']),
      type: $enumDecode(_$AuctionTypeEnumMap, json['type']),
      tcg: json['tcg'] as String,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageUrl: json['imageUrl'] as String?,
      condition: json['condition'] as String?,
      rarity: json['rarity'] as String?,
      cardSet: json['cardSet'] as String?,
      setName: json['setName'] as String?,
      language: json['language'] as String?,
      bids: (json['bids'] as List<dynamic>?)
          ?.map((e) => Bid.fromJson(e as Map<String, dynamic>))
          .toList(),
      winnerId: json['winnerId'] as String?,
      winnerName: json['winnerName'] as String?,
      totalBids: (json['totalBids'] as num?)?.toInt(),
      bidCount: (json['bidCount'] as num?)?.toInt(),
      views: (json['views'] as num?)?.toInt(),
      isWatched: json['isWatched'] as bool?,
      sellerJoinDate: json['sellerJoinDate'] == null
          ? null
          : DateTime.parse(json['sellerJoinDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AuctionToJson(_Auction instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'card': instance.card,
      'sellerId': instance.sellerId,
      'sellerName': instance.sellerName,
      'sellerAvatar': instance.sellerAvatar,
      'startingPrice': instance.startingPrice,
      'currentPrice': instance.currentPrice,
      'reservePrice': instance.reservePrice,
      'buyNowPrice': instance.buyNowPrice,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'status': _$AuctionStatusEnumMap[instance.status]!,
      'type': _$AuctionTypeEnumMap[instance.type]!,
      'tcg': instance.tcg,
      'images': instance.images,
      'imageUrl': instance.imageUrl,
      'condition': instance.condition,
      'rarity': instance.rarity,
      'cardSet': instance.cardSet,
      'setName': instance.setName,
      'language': instance.language,
      'bids': instance.bids,
      'winnerId': instance.winnerId,
      'winnerName': instance.winnerName,
      'totalBids': instance.totalBids,
      'bidCount': instance.bidCount,
      'views': instance.views,
      'isWatched': instance.isWatched,
      'sellerJoinDate': instance.sellerJoinDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$AuctionStatusEnumMap = {
  AuctionStatus.active: 'active',
  AuctionStatus.bidding: 'bidding',
  AuctionStatus.finished: 'finished',
  AuctionStatus.cancelled: 'cancelled',
  AuctionStatus.sold: 'sold',
};

const _$AuctionTypeEnumMap = {
  AuctionType.standard: 'standard',
  AuctionType.reserve: 'reserve',
  AuctionType.buyNow: 'buyNow',
  AuctionType.dutch: 'dutch',
};

_Bid _$BidFromJson(Map<String, dynamic> json) => _Bid(
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

Map<String, dynamic> _$BidToJson(_Bid instance) => <String, dynamic>{
      'id': instance.id,
      'auctionId': instance.auctionId,
      'bidderId': instance.bidderId,
      'bidderName': instance.bidderName,
      'bidderAvatar': instance.bidderAvatar,
      'amount': instance.amount,
      'timestamp': instance.timestamp.toIso8601String(),
      'isAutoBid': instance.isAutoBid,
      'isWinning': instance.isWinning,
    };

_AuctionFilter _$AuctionFilterFromJson(Map<String, dynamic> json) =>
    _AuctionFilter(
      tcg: json['tcg'] as String?,
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      status: $enumDecodeNullable(_$AuctionStatusEnumMap, json['status']),
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

Map<String, dynamic> _$AuctionFilterToJson(_AuctionFilter instance) =>
    <String, dynamic>{
      'tcg': instance.tcg,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'status': _$AuctionStatusEnumMap[instance.status],
      'rarity': instance.rarity,
      'cardSet': instance.cardSet,
      'condition': instance.condition,
      'language': instance.language,
      'hasReserve': instance.hasReserve,
      'hasBuyNow': instance.hasBuyNow,
      'searchQuery': instance.searchQuery,
      'sortBy': instance.sortBy,
      'sortAscending': instance.sortAscending,
    };
