import 'package:uuid/uuid.dart';
import '../../shared/models/user.dart';
import '../../shared/models/card.dart';
import 'database_helper.dart';
import 'card_repository.dart';

class SeedDataService {
  static final _uuid = Uuid();
  
  static Future<void> seedDatabase() async {
    print('🌱 Seeding database with sample data...');
    
    // Usuarios de ejemplo
    await _seedUsers();
    
    // Cartas populares de cada juego
    await _seedCards();
    
    print('✅ Database seeded successfully!');
  }
  
  static Future<void> _seedUsers() async {
    final users = [
      User(
        id: 'user_001',
        email: 'master.collector@cardx.com',
        displayName: 'Master Collector',
        photoURL: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
        collectionValue: 25000.0,
        totalCards: 1250,
        joinDate: DateTime.now().subtract(Duration(days: 365)),
        location: 'Santo Domingo, DO',
        createdAt: DateTime.now().subtract(Duration(days: 365)),
        updatedAt: DateTime.now(),
      ),
      User(
        id: 'user_002',
        email: 'pokemon.fan@cardx.com',
        displayName: 'Pokémon Fan',
        photoURL: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150',
        collectionValue: 8500.0,
        totalCards: 450,
        joinDate: DateTime.now().subtract(Duration(days: 180)),
        location: 'Santiago, DO',
        createdAt: DateTime.now().subtract(Duration(days: 180)),
        updatedAt: DateTime.now(),
      ),
      User(
        id: 'user_003',
        email: 'mtg.player@cardx.com',
        displayName: 'MTG Player',
        photoURL: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
        collectionValue: 15000.0,
        totalCards: 800,
        joinDate: DateTime.now().subtract(Duration(days: 90)),
        location: 'La Romana, DO',
        createdAt: DateTime.now().subtract(Duration(days: 90)),
        updatedAt: DateTime.now(),
      ),
    ];
    
    final db = await DatabaseHelper.instance.database;
    for (final user in users) {
      await db.insert('users', user.toMap());
    }
    print('👥 Created ${users.length} sample users');
  }
  
  static Future<void> _seedCards() async {
    final cards = [
      // Pokémon Cards
      Card(
        id: _uuid.v4(),
        name: 'Charizard',
        setName: 'Base Set',
        game: CardGame.pokemon,
        rarity: CardRarity.rareHolo,
        condition: CardCondition.nearMint,
        price: 350.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_001',
        isForSale: true,
        description: 'Classic Charizard from Base Set in excellent condition',
        createdAt: DateTime.now().subtract(Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
      Card(
        id: _uuid.v4(),
        name: 'Pikachu',
        setName: 'Base Set',
        game: CardGame.pokemon,
        rarity: CardRarity.common,
        condition: CardCondition.mint,
        price: 25.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_001',
        isForTrade: true,
        description: 'Mint condition Pikachu from Base Set',
        createdAt: DateTime.now().subtract(Duration(days: 25)),
        updatedAt: DateTime.now(),
      ),
      Card(
        id: _uuid.v4(),
        name: 'Blastoise',
        setName: 'Base Set',
        game: CardGame.pokemon,
        rarity: CardRarity.rareHolo,
        condition: CardCondition.excellent,
        price: 180.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_002',
        isForSale: true,
        description: 'Excellent condition Blastoise holo',
        createdAt: DateTime.now().subtract(Duration(days: 20)),
        updatedAt: DateTime.now(),
      ),
      Card(
        id: _uuid.v4(),
        name: 'Venusaur',
        setName: 'Base Set',
        game: CardGame.pokemon,
        rarity: CardRarity.rareHolo,
        condition: CardCondition.good,
        price: 120.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_002',
        isForSale: true,
        description: 'Good condition Venusaur, some edge wear',
        createdAt: DateTime.now().subtract(Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
      
      // Magic: The Gathering Cards
      Card(
        id: _uuid.v4(),
        name: 'Black Lotus',
        setName: 'Alpha',
        game: CardGame.mtg,
        rarity: CardRarity.rare,
        condition: CardCondition.good,
        price: 15000.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_003',
        isForSale: true,
        description: 'Alpha Black Lotus in good condition',
        createdAt: DateTime.now().subtract(Duration(days: 10)),
        updatedAt: DateTime.now(),
      ),
      Card(
        id: _uuid.v4(),
        name: 'Lightning Bolt',
        setName: 'Alpha',
        game: CardGame.mtg,
        rarity: CardRarity.common,
        condition: CardCondition.nearMint,
        price: 45.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_003',
        isForTrade: true,
        description: 'Alpha Lightning Bolt in near mint condition',
        createdAt: DateTime.now().subtract(Duration(days: 8)),
        updatedAt: DateTime.now(),
      ),
      Card(
        id: _uuid.v4(),
        name: 'Counterspell',
        setName: 'Alpha',
        game: CardGame.mtg,
        rarity: CardRarity.uncommon,
        condition: CardCondition.excellent,
        price: 85.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_001',
        isForSale: true,
        description: 'Alpha Counterspell in excellent condition',
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        updatedAt: DateTime.now(),
      ),
      
      // Yu-Gi-Oh! Cards
      Card(
        id: _uuid.v4(),
        name: 'Blue-Eyes White Dragon',
        setName: 'LOB',
        game: CardGame.yugioh,
        rarity: CardRarity.ultraRare,
        condition: CardCondition.nearMint,
        price: 450.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_001',
        isForSale: true,
        description: 'LOB Blue-Eyes White Dragon in near mint condition',
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        updatedAt: DateTime.now(),
      ),
      Card(
        id: _uuid.v4(),
        name: 'Dark Magician',
        setName: 'LOB',
        game: CardGame.yugioh,
        rarity: CardRarity.ultraRare,
        condition: CardCondition.mint,
        price: 380.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_002',
        isForSale: true,
        description: 'Mint condition Dark Magician from LOB',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        updatedAt: DateTime.now(),
      ),
      Card(
        id: _uuid.v4(),
        name: 'Red-Eyes Black Dragon',
        setName: 'LOB',
        game: CardGame.yugioh,
        rarity: CardRarity.ultraRare,
        condition: CardCondition.excellent,
        price: 320.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_003',
        isForTrade: true,
        description: 'Excellent condition Red-Eyes Black Dragon',
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        updatedAt: DateTime.now(),
      ),
    ];
    
    for (final card in cards) {
      await CardRepository.instance.create(card);
    }
    print('🃏 Created ${cards.length} sample cards');
  }
  
  // Método para limpiar datos de ejemplo
  static Future<void> clearSampleData() async {
    final db = await DatabaseHelper.instance.database;
    
    await db.delete('cards');
    await db.delete('users');
    
    print('🗑️ Cleared all sample data');
  }
  
  // Método para verificar si la BD está vacía
  static Future<bool> isDatabaseEmpty() async {
    final totalCards = await CardRepository.instance.getTotalCards();
    return totalCards == 0;
  }
  
  // Método para obtener estadísticas de los datos de ejemplo
  static Future<Map<String, dynamic>> getSampleDataStats() async {
    final totalCards = await CardRepository.instance.getTotalCards();
    final cardsForSale = await CardRepository.instance.getCardsForSaleCount();
    final cardsForTrade = await CardRepository.instance.getCardsForTradeCount();
    final avgPrice = await CardRepository.instance.getAveragePrice();
    final gameStats = await CardRepository.instance.getCardsByGameStats();
    
    return {
      'totalCards': totalCards,
      'cardsForSale': cardsForSale,
      'cardsForTrade': cardsForTrade,
      'averagePrice': avgPrice,
      'gameStats': gameStats,
    };
  }
} 