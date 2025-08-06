// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Auction {
  String get id;
  String get title;
  String get description;
  Card get card;
  String get sellerId;
  String? get sellerName;
  String? get sellerAvatar;
  double get startingPrice;
  double get currentPrice;
  double? get reservePrice;
  double? get buyNowPrice;
  DateTime get startTime;
  DateTime get endTime;
  AuctionStatus get status;
  AuctionType get type;
  String get tcg;
  List<String>? get images;
  String? get condition;
  String? get rarity;
  String? get cardSet;
  String? get language;
  List<Bid>? get bids;
  String? get winnerId;
  String? get winnerName;
  int? get totalBids;
  int? get views;
  bool? get isWatched;
  DateTime? get createdAt;
  DateTime? get updatedAt;

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuctionCopyWith<Auction> get copyWith =>
      _$AuctionCopyWithImpl<Auction>(this as Auction, _$identity);

  /// Serializes this Auction to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Auction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.card, card) || other.card == card) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.sellerName, sellerName) ||
                other.sellerName == sellerName) &&
            (identical(other.sellerAvatar, sellerAvatar) ||
                other.sellerAvatar == sellerAvatar) &&
            (identical(other.startingPrice, startingPrice) ||
                other.startingPrice == startingPrice) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.reservePrice, reservePrice) ||
                other.reservePrice == reservePrice) &&
            (identical(other.buyNowPrice, buyNowPrice) ||
                other.buyNowPrice == buyNowPrice) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tcg, tcg) || other.tcg == tcg) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.cardSet, cardSet) || other.cardSet == cardSet) &&
            (identical(other.language, language) ||
                other.language == language) &&
            const DeepCollectionEquality().equals(other.bids, bids) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.winnerName, winnerName) ||
                other.winnerName == winnerName) &&
            (identical(other.totalBids, totalBids) ||
                other.totalBids == totalBids) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.isWatched, isWatched) ||
                other.isWatched == isWatched) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        card,
        sellerId,
        sellerName,
        sellerAvatar,
        startingPrice,
        currentPrice,
        reservePrice,
        buyNowPrice,
        startTime,
        endTime,
        status,
        type,
        tcg,
        const DeepCollectionEquality().hash(images),
        condition,
        rarity,
        cardSet,
        language,
        const DeepCollectionEquality().hash(bids),
        winnerId,
        winnerName,
        totalBids,
        views,
        isWatched,
        createdAt,
        updatedAt
      ]);

  @override
  String toString() {
    return 'Auction(id: $id, title: $title, description: $description, card: $card, sellerId: $sellerId, sellerName: $sellerName, sellerAvatar: $sellerAvatar, startingPrice: $startingPrice, currentPrice: $currentPrice, reservePrice: $reservePrice, buyNowPrice: $buyNowPrice, startTime: $startTime, endTime: $endTime, status: $status, type: $type, tcg: $tcg, images: $images, condition: $condition, rarity: $rarity, cardSet: $cardSet, language: $language, bids: $bids, winnerId: $winnerId, winnerName: $winnerName, totalBids: $totalBids, views: $views, isWatched: $isWatched, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $AuctionCopyWith<$Res> {
  factory $AuctionCopyWith(Auction value, $Res Function(Auction) _then) =
      _$AuctionCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      Card card,
      String sellerId,
      String? sellerName,
      String? sellerAvatar,
      double startingPrice,
      double currentPrice,
      double? reservePrice,
      double? buyNowPrice,
      DateTime startTime,
      DateTime endTime,
      AuctionStatus status,
      AuctionType type,
      String tcg,
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
      DateTime? updatedAt});
}

/// @nodoc
class _$AuctionCopyWithImpl<$Res> implements $AuctionCopyWith<$Res> {
  _$AuctionCopyWithImpl(this._self, this._then);

  final Auction _self;
  final $Res Function(Auction) _then;

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? card = null,
    Object? sellerId = null,
    Object? sellerName = freezed,
    Object? sellerAvatar = freezed,
    Object? startingPrice = null,
    Object? currentPrice = null,
    Object? reservePrice = freezed,
    Object? buyNowPrice = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? type = null,
    Object? tcg = null,
    Object? images = freezed,
    Object? condition = freezed,
    Object? rarity = freezed,
    Object? cardSet = freezed,
    Object? language = freezed,
    Object? bids = freezed,
    Object? winnerId = freezed,
    Object? winnerName = freezed,
    Object? totalBids = freezed,
    Object? views = freezed,
    Object? isWatched = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      card: null == card
          ? _self.card
          : card // ignore: cast_nullable_to_non_nullable
              as Card,
      sellerId: null == sellerId
          ? _self.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      sellerName: freezed == sellerName
          ? _self.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerAvatar: freezed == sellerAvatar
          ? _self.sellerAvatar
          : sellerAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      startingPrice: null == startingPrice
          ? _self.startingPrice
          : startingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      currentPrice: null == currentPrice
          ? _self.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      reservePrice: freezed == reservePrice
          ? _self.reservePrice
          : reservePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      buyNowPrice: freezed == buyNowPrice
          ? _self.buyNowPrice
          : buyNowPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuctionStatus,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as AuctionType,
      tcg: null == tcg
          ? _self.tcg
          : tcg // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      condition: freezed == condition
          ? _self.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      rarity: freezed == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as String?,
      cardSet: freezed == cardSet
          ? _self.cardSet
          : cardSet // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      bids: freezed == bids
          ? _self.bids
          : bids // ignore: cast_nullable_to_non_nullable
              as List<Bid>?,
      winnerId: freezed == winnerId
          ? _self.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      winnerName: freezed == winnerName
          ? _self.winnerName
          : winnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      totalBids: freezed == totalBids
          ? _self.totalBids
          : totalBids // ignore: cast_nullable_to_non_nullable
              as int?,
      views: freezed == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as int?,
      isWatched: freezed == isWatched
          ? _self.isWatched
          : isWatched // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Auction implements Auction {
  const _Auction(
      {required this.id,
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
      final List<String>? images,
      this.condition,
      this.rarity,
      this.cardSet,
      this.language,
      final List<Bid>? bids,
      this.winnerId,
      this.winnerName,
      this.totalBids,
      this.views,
      this.isWatched,
      this.createdAt,
      this.updatedAt})
      : _images = images,
        _bids = bids;
  factory _Auction.fromJson(Map<String, dynamic> json) =>
      _$AuctionFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final Card card;
  @override
  final String sellerId;
  @override
  final String? sellerName;
  @override
  final String? sellerAvatar;
  @override
  final double startingPrice;
  @override
  final double currentPrice;
  @override
  final double? reservePrice;
  @override
  final double? buyNowPrice;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final AuctionStatus status;
  @override
  final AuctionType type;
  @override
  final String tcg;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? condition;
  @override
  final String? rarity;
  @override
  final String? cardSet;
  @override
  final String? language;
  final List<Bid>? _bids;
  @override
  List<Bid>? get bids {
    final value = _bids;
    if (value == null) return null;
    if (_bids is EqualUnmodifiableListView) return _bids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? winnerId;
  @override
  final String? winnerName;
  @override
  final int? totalBids;
  @override
  final int? views;
  @override
  final bool? isWatched;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuctionCopyWith<_Auction> get copyWith =>
      __$AuctionCopyWithImpl<_Auction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuctionToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Auction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.card, card) || other.card == card) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.sellerName, sellerName) ||
                other.sellerName == sellerName) &&
            (identical(other.sellerAvatar, sellerAvatar) ||
                other.sellerAvatar == sellerAvatar) &&
            (identical(other.startingPrice, startingPrice) ||
                other.startingPrice == startingPrice) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            (identical(other.reservePrice, reservePrice) ||
                other.reservePrice == reservePrice) &&
            (identical(other.buyNowPrice, buyNowPrice) ||
                other.buyNowPrice == buyNowPrice) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.tcg, tcg) || other.tcg == tcg) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.cardSet, cardSet) || other.cardSet == cardSet) &&
            (identical(other.language, language) ||
                other.language == language) &&
            const DeepCollectionEquality().equals(other._bids, _bids) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.winnerName, winnerName) ||
                other.winnerName == winnerName) &&
            (identical(other.totalBids, totalBids) ||
                other.totalBids == totalBids) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.isWatched, isWatched) ||
                other.isWatched == isWatched) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        title,
        description,
        card,
        sellerId,
        sellerName,
        sellerAvatar,
        startingPrice,
        currentPrice,
        reservePrice,
        buyNowPrice,
        startTime,
        endTime,
        status,
        type,
        tcg,
        const DeepCollectionEquality().hash(_images),
        condition,
        rarity,
        cardSet,
        language,
        const DeepCollectionEquality().hash(_bids),
        winnerId,
        winnerName,
        totalBids,
        views,
        isWatched,
        createdAt,
        updatedAt
      ]);

  @override
  String toString() {
    return 'Auction(id: $id, title: $title, description: $description, card: $card, sellerId: $sellerId, sellerName: $sellerName, sellerAvatar: $sellerAvatar, startingPrice: $startingPrice, currentPrice: $currentPrice, reservePrice: $reservePrice, buyNowPrice: $buyNowPrice, startTime: $startTime, endTime: $endTime, status: $status, type: $type, tcg: $tcg, images: $images, condition: $condition, rarity: $rarity, cardSet: $cardSet, language: $language, bids: $bids, winnerId: $winnerId, winnerName: $winnerName, totalBids: $totalBids, views: $views, isWatched: $isWatched, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$AuctionCopyWith<$Res> implements $AuctionCopyWith<$Res> {
  factory _$AuctionCopyWith(_Auction value, $Res Function(_Auction) _then) =
      __$AuctionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      Card card,
      String sellerId,
      String? sellerName,
      String? sellerAvatar,
      double startingPrice,
      double currentPrice,
      double? reservePrice,
      double? buyNowPrice,
      DateTime startTime,
      DateTime endTime,
      AuctionStatus status,
      AuctionType type,
      String tcg,
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
      DateTime? updatedAt});
}

/// @nodoc
class __$AuctionCopyWithImpl<$Res> implements _$AuctionCopyWith<$Res> {
  __$AuctionCopyWithImpl(this._self, this._then);

  final _Auction _self;
  final $Res Function(_Auction) _then;

  /// Create a copy of Auction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? card = null,
    Object? sellerId = null,
    Object? sellerName = freezed,
    Object? sellerAvatar = freezed,
    Object? startingPrice = null,
    Object? currentPrice = null,
    Object? reservePrice = freezed,
    Object? buyNowPrice = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? status = null,
    Object? type = null,
    Object? tcg = null,
    Object? images = freezed,
    Object? condition = freezed,
    Object? rarity = freezed,
    Object? cardSet = freezed,
    Object? language = freezed,
    Object? bids = freezed,
    Object? winnerId = freezed,
    Object? winnerName = freezed,
    Object? totalBids = freezed,
    Object? views = freezed,
    Object? isWatched = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Auction(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      card: null == card
          ? _self.card
          : card // ignore: cast_nullable_to_non_nullable
              as Card,
      sellerId: null == sellerId
          ? _self.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      sellerName: freezed == sellerName
          ? _self.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerAvatar: freezed == sellerAvatar
          ? _self.sellerAvatar
          : sellerAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      startingPrice: null == startingPrice
          ? _self.startingPrice
          : startingPrice // ignore: cast_nullable_to_non_nullable
              as double,
      currentPrice: null == currentPrice
          ? _self.currentPrice
          : currentPrice // ignore: cast_nullable_to_non_nullable
              as double,
      reservePrice: freezed == reservePrice
          ? _self.reservePrice
          : reservePrice // ignore: cast_nullable_to_non_nullable
              as double?,
      buyNowPrice: freezed == buyNowPrice
          ? _self.buyNowPrice
          : buyNowPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      startTime: null == startTime
          ? _self.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _self.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuctionStatus,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as AuctionType,
      tcg: null == tcg
          ? _self.tcg
          : tcg // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      condition: freezed == condition
          ? _self.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      rarity: freezed == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as String?,
      cardSet: freezed == cardSet
          ? _self.cardSet
          : cardSet // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      bids: freezed == bids
          ? _self._bids
          : bids // ignore: cast_nullable_to_non_nullable
              as List<Bid>?,
      winnerId: freezed == winnerId
          ? _self.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      winnerName: freezed == winnerName
          ? _self.winnerName
          : winnerName // ignore: cast_nullable_to_non_nullable
              as String?,
      totalBids: freezed == totalBids
          ? _self.totalBids
          : totalBids // ignore: cast_nullable_to_non_nullable
              as int?,
      views: freezed == views
          ? _self.views
          : views // ignore: cast_nullable_to_non_nullable
              as int?,
      isWatched: freezed == isWatched
          ? _self.isWatched
          : isWatched // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
mixin _$Bid {
  String get id;
  String get auctionId;
  String get bidderId;
  String? get bidderName;
  String? get bidderAvatar;
  double get amount;
  DateTime get timestamp;
  bool? get isAutoBid;
  bool? get isWinning;

  /// Create a copy of Bid
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $BidCopyWith<Bid> get copyWith =>
      _$BidCopyWithImpl<Bid>(this as Bid, _$identity);

  /// Serializes this Bid to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Bid &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.auctionId, auctionId) ||
                other.auctionId == auctionId) &&
            (identical(other.bidderId, bidderId) ||
                other.bidderId == bidderId) &&
            (identical(other.bidderName, bidderName) ||
                other.bidderName == bidderName) &&
            (identical(other.bidderAvatar, bidderAvatar) ||
                other.bidderAvatar == bidderAvatar) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isAutoBid, isAutoBid) ||
                other.isAutoBid == isAutoBid) &&
            (identical(other.isWinning, isWinning) ||
                other.isWinning == isWinning));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, auctionId, bidderId,
      bidderName, bidderAvatar, amount, timestamp, isAutoBid, isWinning);

  @override
  String toString() {
    return 'Bid(id: $id, auctionId: $auctionId, bidderId: $bidderId, bidderName: $bidderName, bidderAvatar: $bidderAvatar, amount: $amount, timestamp: $timestamp, isAutoBid: $isAutoBid, isWinning: $isWinning)';
  }
}

/// @nodoc
abstract mixin class $BidCopyWith<$Res> {
  factory $BidCopyWith(Bid value, $Res Function(Bid) _then) = _$BidCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String auctionId,
      String bidderId,
      String? bidderName,
      String? bidderAvatar,
      double amount,
      DateTime timestamp,
      bool? isAutoBid,
      bool? isWinning});
}

/// @nodoc
class _$BidCopyWithImpl<$Res> implements $BidCopyWith<$Res> {
  _$BidCopyWithImpl(this._self, this._then);

  final Bid _self;
  final $Res Function(Bid) _then;

  /// Create a copy of Bid
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? auctionId = null,
    Object? bidderId = null,
    Object? bidderName = freezed,
    Object? bidderAvatar = freezed,
    Object? amount = null,
    Object? timestamp = null,
    Object? isAutoBid = freezed,
    Object? isWinning = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      auctionId: null == auctionId
          ? _self.auctionId
          : auctionId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderId: null == bidderId
          ? _self.bidderId
          : bidderId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderName: freezed == bidderName
          ? _self.bidderName
          : bidderName // ignore: cast_nullable_to_non_nullable
              as String?,
      bidderAvatar: freezed == bidderAvatar
          ? _self.bidderAvatar
          : bidderAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAutoBid: freezed == isAutoBid
          ? _self.isAutoBid
          : isAutoBid // ignore: cast_nullable_to_non_nullable
              as bool?,
      isWinning: freezed == isWinning
          ? _self.isWinning
          : isWinning // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Bid implements Bid {
  const _Bid(
      {required this.id,
      required this.auctionId,
      required this.bidderId,
      this.bidderName,
      this.bidderAvatar,
      required this.amount,
      required this.timestamp,
      this.isAutoBid,
      this.isWinning});
  factory _Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);

  @override
  final String id;
  @override
  final String auctionId;
  @override
  final String bidderId;
  @override
  final String? bidderName;
  @override
  final String? bidderAvatar;
  @override
  final double amount;
  @override
  final DateTime timestamp;
  @override
  final bool? isAutoBid;
  @override
  final bool? isWinning;

  /// Create a copy of Bid
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$BidCopyWith<_Bid> get copyWith =>
      __$BidCopyWithImpl<_Bid>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$BidToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Bid &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.auctionId, auctionId) ||
                other.auctionId == auctionId) &&
            (identical(other.bidderId, bidderId) ||
                other.bidderId == bidderId) &&
            (identical(other.bidderName, bidderName) ||
                other.bidderName == bidderName) &&
            (identical(other.bidderAvatar, bidderAvatar) ||
                other.bidderAvatar == bidderAvatar) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isAutoBid, isAutoBid) ||
                other.isAutoBid == isAutoBid) &&
            (identical(other.isWinning, isWinning) ||
                other.isWinning == isWinning));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, auctionId, bidderId,
      bidderName, bidderAvatar, amount, timestamp, isAutoBid, isWinning);

  @override
  String toString() {
    return 'Bid(id: $id, auctionId: $auctionId, bidderId: $bidderId, bidderName: $bidderName, bidderAvatar: $bidderAvatar, amount: $amount, timestamp: $timestamp, isAutoBid: $isAutoBid, isWinning: $isWinning)';
  }
}

/// @nodoc
abstract mixin class _$BidCopyWith<$Res> implements $BidCopyWith<$Res> {
  factory _$BidCopyWith(_Bid value, $Res Function(_Bid) _then) =
      __$BidCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String auctionId,
      String bidderId,
      String? bidderName,
      String? bidderAvatar,
      double amount,
      DateTime timestamp,
      bool? isAutoBid,
      bool? isWinning});
}

/// @nodoc
class __$BidCopyWithImpl<$Res> implements _$BidCopyWith<$Res> {
  __$BidCopyWithImpl(this._self, this._then);

  final _Bid _self;
  final $Res Function(_Bid) _then;

  /// Create a copy of Bid
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? auctionId = null,
    Object? bidderId = null,
    Object? bidderName = freezed,
    Object? bidderAvatar = freezed,
    Object? amount = null,
    Object? timestamp = null,
    Object? isAutoBid = freezed,
    Object? isWinning = freezed,
  }) {
    return _then(_Bid(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      auctionId: null == auctionId
          ? _self.auctionId
          : auctionId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderId: null == bidderId
          ? _self.bidderId
          : bidderId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderName: freezed == bidderName
          ? _self.bidderName
          : bidderName // ignore: cast_nullable_to_non_nullable
              as String?,
      bidderAvatar: freezed == bidderAvatar
          ? _self.bidderAvatar
          : bidderAvatar // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _self.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isAutoBid: freezed == isAutoBid
          ? _self.isAutoBid
          : isAutoBid // ignore: cast_nullable_to_non_nullable
              as bool?,
      isWinning: freezed == isWinning
          ? _self.isWinning
          : isWinning // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
mixin _$AuctionFilter {
  String? get tcg;
  double? get minPrice;
  double? get maxPrice;
  AuctionStatus? get status;
  String? get rarity;
  String? get cardSet;
  String? get condition;
  String? get language;
  bool? get hasReserve;
  bool? get hasBuyNow;
  String? get searchQuery;
  String? get sortBy; // 'price', 'time', 'popularity'
  bool? get sortAscending;

  /// Create a copy of AuctionFilter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuctionFilterCopyWith<AuctionFilter> get copyWith =>
      _$AuctionFilterCopyWithImpl<AuctionFilter>(
          this as AuctionFilter, _$identity);

  /// Serializes this AuctionFilter to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuctionFilter &&
            (identical(other.tcg, tcg) || other.tcg == tcg) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.cardSet, cardSet) || other.cardSet == cardSet) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.hasReserve, hasReserve) ||
                other.hasReserve == hasReserve) &&
            (identical(other.hasBuyNow, hasBuyNow) ||
                other.hasBuyNow == hasBuyNow) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortAscending, sortAscending) ||
                other.sortAscending == sortAscending));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tcg,
      minPrice,
      maxPrice,
      status,
      rarity,
      cardSet,
      condition,
      language,
      hasReserve,
      hasBuyNow,
      searchQuery,
      sortBy,
      sortAscending);

  @override
  String toString() {
    return 'AuctionFilter(tcg: $tcg, minPrice: $minPrice, maxPrice: $maxPrice, status: $status, rarity: $rarity, cardSet: $cardSet, condition: $condition, language: $language, hasReserve: $hasReserve, hasBuyNow: $hasBuyNow, searchQuery: $searchQuery, sortBy: $sortBy, sortAscending: $sortAscending)';
  }
}

/// @nodoc
abstract mixin class $AuctionFilterCopyWith<$Res> {
  factory $AuctionFilterCopyWith(
          AuctionFilter value, $Res Function(AuctionFilter) _then) =
      _$AuctionFilterCopyWithImpl;
  @useResult
  $Res call(
      {String? tcg,
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
      String? sortBy,
      bool? sortAscending});
}

/// @nodoc
class _$AuctionFilterCopyWithImpl<$Res>
    implements $AuctionFilterCopyWith<$Res> {
  _$AuctionFilterCopyWithImpl(this._self, this._then);

  final AuctionFilter _self;
  final $Res Function(AuctionFilter) _then;

  /// Create a copy of AuctionFilter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tcg = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? status = freezed,
    Object? rarity = freezed,
    Object? cardSet = freezed,
    Object? condition = freezed,
    Object? language = freezed,
    Object? hasReserve = freezed,
    Object? hasBuyNow = freezed,
    Object? searchQuery = freezed,
    Object? sortBy = freezed,
    Object? sortAscending = freezed,
  }) {
    return _then(_self.copyWith(
      tcg: freezed == tcg
          ? _self.tcg
          : tcg // ignore: cast_nullable_to_non_nullable
              as String?,
      minPrice: freezed == minPrice
          ? _self.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      maxPrice: freezed == maxPrice
          ? _self.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuctionStatus?,
      rarity: freezed == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as String?,
      cardSet: freezed == cardSet
          ? _self.cardSet
          : cardSet // ignore: cast_nullable_to_non_nullable
              as String?,
      condition: freezed == condition
          ? _self.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      hasReserve: freezed == hasReserve
          ? _self.hasReserve
          : hasReserve // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasBuyNow: freezed == hasBuyNow
          ? _self.hasBuyNow
          : hasBuyNow // ignore: cast_nullable_to_non_nullable
              as bool?,
      searchQuery: freezed == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: freezed == sortBy
          ? _self.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      sortAscending: freezed == sortAscending
          ? _self.sortAscending
          : sortAscending // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _AuctionFilter implements AuctionFilter {
  const _AuctionFilter(
      {this.tcg,
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
      this.sortAscending});
  factory _AuctionFilter.fromJson(Map<String, dynamic> json) =>
      _$AuctionFilterFromJson(json);

  @override
  final String? tcg;
  @override
  final double? minPrice;
  @override
  final double? maxPrice;
  @override
  final AuctionStatus? status;
  @override
  final String? rarity;
  @override
  final String? cardSet;
  @override
  final String? condition;
  @override
  final String? language;
  @override
  final bool? hasReserve;
  @override
  final bool? hasBuyNow;
  @override
  final String? searchQuery;
  @override
  final String? sortBy;
// 'price', 'time', 'popularity'
  @override
  final bool? sortAscending;

  /// Create a copy of AuctionFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuctionFilterCopyWith<_AuctionFilter> get copyWith =>
      __$AuctionFilterCopyWithImpl<_AuctionFilter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$AuctionFilterToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuctionFilter &&
            (identical(other.tcg, tcg) || other.tcg == tcg) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.cardSet, cardSet) || other.cardSet == cardSet) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.hasReserve, hasReserve) ||
                other.hasReserve == hasReserve) &&
            (identical(other.hasBuyNow, hasBuyNow) ||
                other.hasBuyNow == hasBuyNow) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.sortBy, sortBy) || other.sortBy == sortBy) &&
            (identical(other.sortAscending, sortAscending) ||
                other.sortAscending == sortAscending));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      tcg,
      minPrice,
      maxPrice,
      status,
      rarity,
      cardSet,
      condition,
      language,
      hasReserve,
      hasBuyNow,
      searchQuery,
      sortBy,
      sortAscending);

  @override
  String toString() {
    return 'AuctionFilter(tcg: $tcg, minPrice: $minPrice, maxPrice: $maxPrice, status: $status, rarity: $rarity, cardSet: $cardSet, condition: $condition, language: $language, hasReserve: $hasReserve, hasBuyNow: $hasBuyNow, searchQuery: $searchQuery, sortBy: $sortBy, sortAscending: $sortAscending)';
  }
}

/// @nodoc
abstract mixin class _$AuctionFilterCopyWith<$Res>
    implements $AuctionFilterCopyWith<$Res> {
  factory _$AuctionFilterCopyWith(
          _AuctionFilter value, $Res Function(_AuctionFilter) _then) =
      __$AuctionFilterCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? tcg,
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
      String? sortBy,
      bool? sortAscending});
}

/// @nodoc
class __$AuctionFilterCopyWithImpl<$Res>
    implements _$AuctionFilterCopyWith<$Res> {
  __$AuctionFilterCopyWithImpl(this._self, this._then);

  final _AuctionFilter _self;
  final $Res Function(_AuctionFilter) _then;

  /// Create a copy of AuctionFilter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? tcg = freezed,
    Object? minPrice = freezed,
    Object? maxPrice = freezed,
    Object? status = freezed,
    Object? rarity = freezed,
    Object? cardSet = freezed,
    Object? condition = freezed,
    Object? language = freezed,
    Object? hasReserve = freezed,
    Object? hasBuyNow = freezed,
    Object? searchQuery = freezed,
    Object? sortBy = freezed,
    Object? sortAscending = freezed,
  }) {
    return _then(_AuctionFilter(
      tcg: freezed == tcg
          ? _self.tcg
          : tcg // ignore: cast_nullable_to_non_nullable
              as String?,
      minPrice: freezed == minPrice
          ? _self.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      maxPrice: freezed == maxPrice
          ? _self.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuctionStatus?,
      rarity: freezed == rarity
          ? _self.rarity
          : rarity // ignore: cast_nullable_to_non_nullable
              as String?,
      cardSet: freezed == cardSet
          ? _self.cardSet
          : cardSet // ignore: cast_nullable_to_non_nullable
              as String?,
      condition: freezed == condition
          ? _self.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as String?,
      language: freezed == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      hasReserve: freezed == hasReserve
          ? _self.hasReserve
          : hasReserve // ignore: cast_nullable_to_non_nullable
              as bool?,
      hasBuyNow: freezed == hasBuyNow
          ? _self.hasBuyNow
          : hasBuyNow // ignore: cast_nullable_to_non_nullable
              as bool?,
      searchQuery: freezed == searchQuery
          ? _self.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
      sortBy: freezed == sortBy
          ? _self.sortBy
          : sortBy // ignore: cast_nullable_to_non_nullable
              as String?,
      sortAscending: freezed == sortAscending
          ? _self.sortAscending
          : sortAscending // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
