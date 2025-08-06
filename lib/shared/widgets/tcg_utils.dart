import 'package:flutter/material.dart';

class TcgUtils {
  static const Map<String, Color> _tcgColors = {
    'pokemon': Color(0xFFE3350D),
    'yugioh': Color(0xFF1E3A8A),
    'magic': Color(0xFF7C3AED),
    'onepiece': Color(0xFFDC2626),
    'starwarsunlimited': Color(0xFFF59E0B),
    'gundam': Color(0xFF059669),
    'dbs': Color(0xFF3B82F6),
  };

  static const Map<String, String> _tcgLogos = {
    'pokemon': 'assets/images/pokemon_logo.png',
    'yugioh': 'assets/images/yugioh_logo.png',
    'magic': 'assets/images/magic_logo.png',
    'onepiece': 'assets/images/onepiece_logo.png',
    'starwarsunlimited': 'assets/images/starwarsunlimited_logo.png',
    'gundam': 'assets/images/gundam_logo.png',
    'dbs': 'assets/images/dbs_logo.png',
  };

  static const Map<String, String> _tcgAuctionImages = {
    'pokemon': 'assets/images/pokemon_auction.png',
    'yugioh': 'assets/images/yugioh_auction.png',
    'magic': 'assets/images/magic_auction.png',
  };

  static const List<String> _tcgNames = [
    'pokemon',
    'yugioh',
    'magic',
    'onepiece',
    'starwarsunlimited',
    'gundam',
    'dbs',
  ];

  static const Map<String, String> _tcgDisplayNames = {
    'pokemon': 'Pokémon TCG',
    'yugioh': 'Yu-Gi-Oh!',
    'magic': 'Magic: The Gathering',
    'onepiece': 'One Piece TCG',
    'starwarsunlimited': 'Star Wars Unlimited',
    'gundam': 'Gundam TCG',
    'dbs': 'Dragon Ball Super',
  };

  static Color getTcgColor(String tcg) {
    return _tcgColors[tcg.toLowerCase()] ?? Colors.grey;
  }

  static String? getTcgLogo(String tcg) {
    return _tcgLogos[tcg.toLowerCase()];
  }

  static String? getTcgAuctionImage(String tcg) {
    return _tcgAuctionImages[tcg.toLowerCase()];
  }

  static List<String> getTcgNames() {
    return List.from(_tcgNames);
  }

  static String getTcgDisplayName(String tcg) {
    return _tcgDisplayNames[tcg.toLowerCase()] ?? tcg;
  }

  static bool isValidTcg(String tcg) {
    return _tcgNames.contains(tcg.toLowerCase());
  }

  static String getTcgShortName(String tcg) {
    switch (tcg.toLowerCase()) {
      case 'pokemon':
        return 'Pokémon';
      case 'yugioh':
        return 'Yu-Gi-Oh!';
      case 'magic':
        return 'Magic';
      case 'onepiece':
        return 'One Piece';
      case 'starwarsunlimited':
        return 'Star Wars';
      case 'gundam':
        return 'Gundam';
      case 'dbs':
        return 'DBS';
      default:
        return tcg;
    }
  }

  static IconData getTcgIcon(String tcg) {
    switch (tcg.toLowerCase()) {
      case 'pokemon':
        return Icons.catching_pokemon;
      case 'yugioh':
        return Icons.diamond;
      case 'magic':
        return Icons.auto_awesome;
      case 'onepiece':
        return Icons.sailing;
      case 'starwarsunlimited':
        return Icons.rocket;
      case 'gundam':
        return Icons.airplanemode_active;
      case 'dbs':
        return Icons.flash_on;
      default:
        return Icons.sports_esports;
    }
  }

  static String getTcgDescription(String tcg) {
    switch (tcg.toLowerCase()) {
      case 'pokemon':
        return 'Colecciona y juega con tus Pokémon favoritos';
      case 'yugioh':
        return 'Suma monstruos y derrota a tus oponentes';
      case 'magic':
        return 'El juego de cartas coleccionables más popular del mundo';
      case 'onepiece':
        return 'Únete a la tripulación de los Piratas del Sombrero de Paja';
      case 'starwarsunlimited':
        return 'Que la fuerza te acompañe en el universo de Star Wars';
      case 'gundam':
        return 'Pilota los Mobile Suits más poderosos';
      case 'dbs':
        return 'Lucha con el poder de los guerreros Saiyajin';
      default:
        return 'Juego de cartas coleccionables';
    }
  }

  static List<String> getTcgRarities(String tcg) {
    switch (tcg.toLowerCase()) {
      case 'pokemon':
        return ['Common', 'Uncommon', 'Rare', 'Rare Holo', 'Ultra Rare', 'Secret Rare'];
      case 'yugioh':
        return ['Common', 'Rare', 'Super Rare', 'Ultra Rare', 'Secret Rare', 'Ultimate Rare'];
      case 'magic':
        return ['Common', 'Uncommon', 'Rare', 'Mythic Rare'];
      case 'onepiece':
        return ['Common', 'Uncommon', 'Rare', 'Super Rare', 'Secret Rare'];
      case 'starwarsunlimited':
        return ['Common', 'Uncommon', 'Rare', 'Legendary'];
      case 'gundam':
        return ['Common', 'Uncommon', 'Rare', 'Super Rare'];
      case 'dbs':
        return ['Common', 'Uncommon', 'Rare', 'Super Rare', 'Secret Rare'];
      default:
        return ['Common', 'Uncommon', 'Rare'];
    }
  }

  static List<String> getTcgConditions() {
    return [
      'Mint',
      'Near Mint',
      'Excellent',
      'Good',
      'Light Played',
      'Played',
      'Poor',
    ];
  }

  static String getTcgConditionDescription(String condition) {
    switch (condition.toLowerCase()) {
      case 'mint':
        return 'Perfecta, sin defectos visibles';
      case 'near_mint':
        return 'Casi perfecta, defectos menores';
      case 'excellent':
        return 'Muy buena, algunos defectos menores';
      case 'good':
        return 'Buena, defectos moderados';
      case 'light_played':
        return 'Ligeramente jugada, desgaste visible';
      case 'played':
        return 'Jugada, desgaste significativo';
      case 'poor':
        return 'Muy desgastada, defectos mayores';
      default:
        return 'Condición no especificada';
    }
  }
} 