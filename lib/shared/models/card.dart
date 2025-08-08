// Temporarily converted to regular class to fix Freezed issues
// import 'package:freezed_annotation/freezed_annotation.dart';

import 'dart:convert';

enum CardGame {
  pokemon,
  yugioh,
  mtg,
  onePiece,
  dragonBall,
  digimon,
  gundam,
  starWars,
  starWarsUnlimited,
}

enum CardRarity {
  common,
  uncommon,
  rare,
  rareHolo,
  ultraRare,
  secretRare,
  legendary,
  mythic,
  superRare,
  ultimateRare,
  ghostRare,
  platinumRare,
  starlightRare,
  quarterCenturyRare,
  prismaticSecretRare,
  goldRare,
  goldSecretRare,
  parallelRare,
  parallelSecretRare,
  parallelUltraRare,
  parallelCommon,
  parallelUncommon,
  parallelRareHolo,
  parallelSecretRareHolo,
  parallelUltraRareHolo,
  parallelCommonHolo,
  parallelUncommonHolo,
  parallelRareHoloSecret,
  parallelUltraRareHoloSecret,
  parallelCommonHoloSecret,
  parallelUncommonHoloSecret,
}

enum CardCondition {
  mint,
  nearMint,
  excellent,
  good,
  lightPlayed,
  played,
  poor
}

class Card {
  final String id;
  final String name;
  final String? setName;
  final CardGame game;
  final CardRarity? rarity;
  final CardCondition? condition;
  final double? price;
  final String? imageUrl;
  final String? sellerId;
  final bool isForSale;
  final bool isForTrade;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? type;
  final String? frameType;
  final String? attribute;
  final String? race;
  final int? level;
  final int? atk;
  final int? def;
  final String? archetype;
  final int? scale;
  final int? linkval;
  final List<String>? linkmarkers;
  final List<Map<String, dynamic>>? cardSets;
  final List<Map<String, dynamic>>? cardImages;
  final List<Map<String, dynamic>>? cardPrices;
  final List<Map<String, dynamic>>? banlistInfo;

  const Card({
    required this.id,
    required this.name,
    this.setName,
    required this.game,
    this.rarity,
    this.condition,
    this.price,
    this.imageUrl,
    this.sellerId,
    this.isForSale = false,
    this.isForTrade = false,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.type,
    this.frameType,
    this.attribute,
    this.race,
    this.level,
    this.atk,
    this.def,
    this.archetype,
    this.scale,
    this.linkval,
    this.linkmarkers,
    this.cardSets,
    this.cardImages,
    this.cardPrices,
    this.banlistInfo,
  });

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      id: json['id'] as String,
      name: json['name'] as String,
      setName: json['setName'] as String?,
      game: CardGame.values.firstWhere((e) => e.name == json['game']),
      rarity: json['rarity'] != null ? CardRarity.values.firstWhere((e) => e.name == json['rarity']) : null,
      condition: json['condition'] != null ? CardCondition.values.firstWhere((e) => e.name == json['condition']) : null,
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      sellerId: json['sellerId'] as String?,
      isForSale: json['isForSale'] as bool? ?? false,
      isForTrade: json['isForTrade'] as bool? ?? false,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      type: json['type'] as String?,
      frameType: json['frameType'] as String?,
      attribute: json['attribute'] as String?,
      race: json['race'] as String?,
      level: json['level'] as int?,
      atk: json['atk'] as int?,
      def: json['def'] as int?,
      archetype: json['archetype'] as String?,
      scale: json['scale'] as int?,
      linkval: json['linkval'] as int?,
      linkmarkers: (json['linkmarkers'] as List<dynamic>?)?.cast<String>(),
      cardSets: (json['cardSets'] as List<dynamic>?)?.cast<Map<String, dynamic>>(),
      cardImages: (json['cardImages'] as List<dynamic>?)?.cast<Map<String, dynamic>>(),
      cardPrices: (json['cardPrices'] as List<dynamic>?)?.cast<Map<String, dynamic>>(),
      banlistInfo: (json['banlistInfo'] as List<dynamic>?)?.cast<Map<String, dynamic>>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'setName': setName,
      'game': game.name,
      'rarity': rarity?.name,
      'condition': condition?.name,
      'price': price,
      'imageUrl': imageUrl,
      'sellerId': sellerId,
      'isForSale': isForSale,
      'isForTrade': isForTrade,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'type': type,
      'frameType': frameType,
      'attribute': attribute,
      'race': race,
      'level': level,
      'atk': atk,
      'def': def,
      'archetype': archetype,
      'scale': scale,
      'linkval': linkval,
      'linkmarkers': linkmarkers,
      'cardSets': cardSets,
      'cardImages': cardImages,
      'cardPrices': cardPrices,
      'banlistInfo': banlistInfo,
    };
  }

  Card copyWith({
    String? id,
    String? name,
    String? setName,
    CardGame? game,
    CardRarity? rarity,
    CardCondition? condition,
    double? price,
    String? imageUrl,
    String? sellerId,
    bool? isForSale,
    bool? isForTrade,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? type,
    String? frameType,
    String? attribute,
    String? race,
    int? level,
    int? atk,
    int? def,
    String? archetype,
    int? scale,
    int? linkval,
    List<String>? linkmarkers,
    List<Map<String, dynamic>>? cardSets,
    List<Map<String, dynamic>>? cardImages,
    List<Map<String, dynamic>>? cardPrices,
    List<Map<String, dynamic>>? banlistInfo,
  }) {
    return Card(
      id: id ?? this.id,
      name: name ?? this.name,
      setName: setName ?? this.setName,
      game: game ?? this.game,
      rarity: rarity ?? this.rarity,
      condition: condition ?? this.condition,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      sellerId: sellerId ?? this.sellerId,
      isForSale: isForSale ?? this.isForSale,
      isForTrade: isForTrade ?? this.isForTrade,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      frameType: frameType ?? this.frameType,
      attribute: attribute ?? this.attribute,
      race: race ?? this.race,
      level: level ?? this.level,
      atk: atk ?? this.atk,
      def: def ?? this.def,
      archetype: archetype ?? this.archetype,
      scale: scale ?? this.scale,
      linkval: linkval ?? this.linkval,
      linkmarkers: linkmarkers ?? this.linkmarkers,
      cardSets: cardSets ?? this.cardSets,
      cardImages: cardImages ?? this.cardImages,
      cardPrices: cardPrices ?? this.cardPrices,
      banlistInfo: banlistInfo ?? this.banlistInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Card &&
        other.id == id &&
        other.name == name &&
        other.setName == setName &&
        other.game == game &&
        other.rarity == rarity &&
        other.condition == condition &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.sellerId == sellerId &&
        other.isForSale == isForSale &&
        other.isForTrade == isForTrade &&
        other.description == description &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.type == type &&
        other.frameType == frameType &&
        other.attribute == attribute &&
        other.race == race &&
        other.level == level &&
        other.atk == atk &&
        other.def == def &&
        other.archetype == archetype &&
        other.scale == scale &&
        other.linkval == linkval &&
        other.linkmarkers == linkmarkers &&
        other.cardSets == cardSets &&
        other.cardImages == cardImages &&
        other.cardPrices == cardPrices &&
        other.banlistInfo == banlistInfo;
  }

  @override
  int get hashCode {
    return Object.hash(
      Object.hash(
        id, name, setName, game, rarity, condition, price, imageUrl, sellerId, isForSale,
        isForTrade, description, createdAt, updatedAt, type, frameType, attribute, race, level, atk
      ),
      Object.hash(
        def, archetype, scale, linkval, linkmarkers, cardSets, cardImages, cardPrices, banlistInfo
      ),
    );
  }

  @override
  String toString() {
    return 'Card(id: $id, name: $name, setName: $setName, game: $game, rarity: $rarity, condition: $condition, price: $price, imageUrl: $imageUrl, sellerId: $sellerId, isForSale: $isForSale, isForTrade: $isForTrade, description: $description, createdAt: $createdAt, updatedAt: $updatedAt, type: $type, frameType: $frameType, attribute: $attribute, race: $race, level: $level, atk: $atk, def: $def, archetype: $archetype, scale: $scale, linkval: $linkval, linkmarkers: $linkmarkers, cardSets: $cardSets, cardImages: $cardImages, cardPrices: $cardPrices, banlistInfo: $banlistInfo)';
  }
}

// Extension para métodos de SQLite y Firestore
extension CardExtensions on Card {
  // Factory method para crear desde SQLite
  static Card fromMap(Map<String, dynamic> map) => Card(
    id: map['id'] as String,
    name: map['name'] as String,
    setName: map['set_name'] as String?,
    game: CardGame.values.firstWhere(
      (e) => e.name == map['game'],
      orElse: () => CardGame.yugioh,
    ),
    rarity: map['rarity'] != null 
      ? CardRarity.values.firstWhere(
          (e) => e.name == map['rarity'],
          orElse: () => CardRarity.common,
        )
      : null,
    condition: map['condition'] != null
      ? CardCondition.values.firstWhere(
          (e) => e.name == map['condition'],
          orElse: () => CardCondition.nearMint,
        )
      : null,
    price: (map['price'] as num?)?.toDouble(),
    imageUrl: map['image_url'] as String?,
    sellerId: map['seller_id'] as String?,
    isForSale: map['is_for_sale'] == 1,
    isForTrade: map['is_for_trade'] == 1,
    description: map['description'] as String?,
    createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
    type: map['type'] as String?,
    frameType: map['frame_type'] as String?,
    attribute: map['attribute'] as String?,
    race: map['race'] as String?,
    level: (map['level'] as num?)?.toInt(),
    atk: (map['atk'] as num?)?.toInt(),
    def: (map['def'] as num?)?.toInt(),
    archetype: map['archetype'] as String?,
    scale: (map['scale'] as num?)?.toInt(),
    linkval: (map['linkval'] as num?)?.toInt(),
    linkmarkers: map['linkmarkers']?.split(','),
    cardSets: map['card_sets'] != null ? List<Map<String, dynamic>>.from(jsonDecode(map['card_sets'])) : null,
    cardImages: map['card_images'] != null ? List<Map<String, dynamic>>.from(jsonDecode(map['card_images'])) : null,
    cardPrices: map['card_prices'] != null ? List<Map<String, dynamic>>.from(jsonDecode(map['card_prices'])) : null,
    banlistInfo: map['banlist_info'] != null ? List<Map<String, dynamic>>.from(jsonDecode(map['banlist_info'])) : null,
  );
  // SQLite helpers
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'set_name': setName,
    'game': game.name,
    'rarity': rarity?.name,
    'condition': condition?.name,
    'price': price,
    'image_url': imageUrl,
    'seller_id': sellerId,
    'is_for_sale': isForSale ? 1 : 0,
    'is_for_trade': isForTrade ? 1 : 0,
    'description': description,
    'created_at': createdAt.millisecondsSinceEpoch,
    'updated_at': updatedAt.millisecondsSinceEpoch,
    'type': type,
    'frame_type': frameType,
    'attribute': attribute,
    'race': race,
    'level': level,
    'atk': atk,
    'def': def,
    'archetype': archetype,
    'scale': scale,
    'linkval': linkval,
    'linkmarkers': linkmarkers?.join(','),
    'card_sets': cardSets != null ? jsonEncode(cardSets) : null,
    'card_images': cardImages != null ? jsonEncode(cardImages) : null,
    'card_prices': cardPrices != null ? jsonEncode(cardPrices) : null,
    'banlist_info': banlistInfo != null ? jsonEncode(banlistInfo) : null,
  };

  // Firestore helpers
  Map<String, dynamic> toFirestore() => {
    'name': name,
    'setName': setName,
    'game': game.name,
    'rarity': rarity?.name,
    'condition': condition?.name,
    'price': price,
    'imageUrl': imageUrl,
    'sellerId': sellerId,
    'isForSale': isForSale,
    'isForTrade': isForTrade,
    'description': description,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'type': type,
    'frameType': frameType,
    'attribute': attribute,
    'race': race,
    'level': level,
    'atk': atk,
    'def': def,
    'archetype': archetype,
    'scale': scale,
    'linkval': linkval,
    'linkmarkers': linkmarkers,
    'cardSets': cardSets,
    'cardImages': cardImages,
    'cardPrices': cardPrices,
    'banlistInfo': banlistInfo,
  };
}

// Extension methods for enums
extension CardGameExtension on CardGame {
  String get name {
    switch (this) {
      case CardGame.pokemon:
        return 'pokemon';
      case CardGame.yugioh:
        return 'yugioh';
      case CardGame.mtg:
        return 'mtg';
      case CardGame.onePiece:
        return 'onePiece';
      case CardGame.dragonBall:
        return 'dragonBall';
      case CardGame.digimon:
        return 'digimon';
      case CardGame.gundam:
        return 'gundam';
      case CardGame.starWars:
        return 'starWars';
      case CardGame.starWarsUnlimited:
        return 'starWarsUnlimited';
    }
  }

  String get displayName {
    switch (this) {
      case CardGame.pokemon:
        return 'Pokémon';
      case CardGame.yugioh:
        return 'Yu-Gi-Oh!';
      case CardGame.mtg:
        return 'Magic: The Gathering';
      case CardGame.onePiece:
        return 'One Piece';
      case CardGame.dragonBall:
        return 'Dragon Ball Super';
      case CardGame.digimon:
        return 'Digimon';
      case CardGame.gundam:
        return 'Gundam';
      case CardGame.starWars:
        return 'Star Wars Unlimited';
      case CardGame.starWarsUnlimited:
        return 'Star Wars Unlimited';
    }
  }

  String get shortName {
    switch (this) {
      case CardGame.pokemon:
        return 'PKM';
      case CardGame.yugioh:
        return 'YGO';
      case CardGame.mtg:
        return 'MTG';
      case CardGame.onePiece:
        return 'OP';
      case CardGame.dragonBall:
        return 'DBS';
      case CardGame.digimon:
        return 'DIG';
      case CardGame.gundam:
        return 'GUN';
      case CardGame.starWars:
        return 'SWU';
      case CardGame.starWarsUnlimited:
        return 'SWU';
    }
  }
}

extension CardRarityExtension on CardRarity {
  String get name {
    switch (this) {
      case CardRarity.common:
        return 'common';
      case CardRarity.uncommon:
        return 'uncommon';
      case CardRarity.rare:
        return 'rare';
      case CardRarity.rareHolo:
        return 'rareHolo';
      case CardRarity.ultraRare:
        return 'ultraRare';
      case CardRarity.secretRare:
        return 'secretRare';
      case CardRarity.legendary:
        return 'legendary';
      case CardRarity.mythic:
        return 'mythic';
      case CardRarity.superRare:
        return 'superRare';
      case CardRarity.ultimateRare:
        return 'ultimateRare';
      case CardRarity.ghostRare:
        return 'ghostRare';
      case CardRarity.platinumRare:
        return 'platinumRare';
      case CardRarity.starlightRare:
        return 'starlightRare';
      case CardRarity.quarterCenturyRare:
        return 'quarterCenturyRare';
      case CardRarity.prismaticSecretRare:
        return 'prismaticSecretRare';
      case CardRarity.goldRare:
        return 'goldRare';
      case CardRarity.goldSecretRare:
        return 'goldSecretRare';
      case CardRarity.parallelRare:
        return 'parallelRare';
      case CardRarity.parallelSecretRare:
        return 'parallelSecretRare';
      case CardRarity.parallelUltraRare:
        return 'parallelUltraRare';
      case CardRarity.parallelCommon:
        return 'parallelCommon';
      case CardRarity.parallelUncommon:
        return 'parallelUncommon';
      case CardRarity.parallelRareHolo:
        return 'parallelRareHolo';
      case CardRarity.parallelSecretRareHolo:
        return 'parallelSecretRareHolo';
      case CardRarity.parallelUltraRareHolo:
        return 'parallelUltraRareHolo';
      case CardRarity.parallelCommonHolo:
        return 'parallelCommonHolo';
      case CardRarity.parallelUncommonHolo:
        return 'parallelUncommonHolo';
      case CardRarity.parallelRareHoloSecret:
        return 'parallelRareHoloSecret';
      case CardRarity.parallelUltraRareHoloSecret:
        return 'parallelUltraRareHoloSecret';
      case CardRarity.parallelCommonHoloSecret:
        return 'parallelCommonHoloSecret';
      case CardRarity.parallelUncommonHoloSecret:
        return 'parallelUncommonHoloSecret';
    }
  }

  String get displayName {
    switch (this) {
      case CardRarity.common:
        return 'Common';
      case CardRarity.uncommon:
        return 'Uncommon';
      case CardRarity.rare:
        return 'Rare';
      case CardRarity.rareHolo:
        return 'Rare Holo';
      case CardRarity.ultraRare:
        return 'Ultra Rare';
      case CardRarity.secretRare:
        return 'Secret Rare';
      case CardRarity.legendary:
        return 'Legendary';
      case CardRarity.mythic:
        return 'Mythic';
      case CardRarity.superRare:
        return 'Super Rare';
      case CardRarity.ultimateRare:
        return 'Ultimate Rare';
      case CardRarity.ghostRare:
        return 'Ghost Rare';
      case CardRarity.platinumRare:
        return 'Platinum Rare';
      case CardRarity.starlightRare:
        return 'Starlight Rare';
      case CardRarity.quarterCenturyRare:
        return 'Quarter Century Rare';
      case CardRarity.prismaticSecretRare:
        return 'Prismatic Secret Rare';
      case CardRarity.goldRare:
        return 'Gold Rare';
      case CardRarity.goldSecretRare:
        return 'Gold Secret Rare';
      case CardRarity.parallelRare:
        return 'Parallel Rare';
      case CardRarity.parallelSecretRare:
        return 'Parallel Secret Rare';
      case CardRarity.parallelUltraRare:
        return 'Parallel Ultra Rare';
      case CardRarity.parallelCommon:
        return 'Parallel Common';
      case CardRarity.parallelUncommon:
        return 'Parallel Uncommon';
      case CardRarity.parallelRareHolo:
        return 'Parallel Rare Holo';
      case CardRarity.parallelSecretRareHolo:
        return 'Parallel Secret Rare Holo';
      case CardRarity.parallelUltraRareHolo:
        return 'Parallel Ultra Rare Holo';
      case CardRarity.parallelCommonHolo:
        return 'Parallel Common Holo';
      case CardRarity.parallelUncommonHolo:
        return 'Parallel Uncommon Holo';
      case CardRarity.parallelRareHoloSecret:
        return 'Parallel Rare Holo Secret';
      case CardRarity.parallelUltraRareHoloSecret:
        return 'Parallel Ultra Rare Holo Secret';
      case CardRarity.parallelCommonHoloSecret:
        return 'Parallel Common Holo Secret';
      case CardRarity.parallelUncommonHoloSecret:
        return 'Parallel Uncommon Holo Secret';
    }
  }
}

extension CardConditionExtension on CardCondition {
  String get name {
    switch (this) {
      case CardCondition.mint:
        return 'mint';
      case CardCondition.nearMint:
        return 'nearMint';
      case CardCondition.excellent:
        return 'excellent';
      case CardCondition.good:
        return 'good';
      case CardCondition.lightPlayed:
        return 'lightPlayed';
      case CardCondition.played:
        return 'played';
      case CardCondition.poor:
        return 'poor';
    }
  }

  String get displayName {
    switch (this) {
      case CardCondition.mint:
        return 'Mint';
      case CardCondition.nearMint:
        return 'Near Mint';
      case CardCondition.excellent:
        return 'Excellent';
      case CardCondition.good:
        return 'Good';
      case CardCondition.lightPlayed:
        return 'Light Played';
      case CardCondition.played:
        return 'Played';
      case CardCondition.poor:
        return 'Poor';
    }
  }
} 