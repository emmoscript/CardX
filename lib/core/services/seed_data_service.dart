import 'package:uuid/uuid.dart';
import '../../shared/models/user.dart';
import '../../shared/models/card.dart';
import 'hive_database_service.dart';
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
    
    int createdCount = 0;
    
    for (final user in users) {
      try {
        await HiveDatabaseService.instance.insertUser(user);
        createdCount++;
      } catch (e) {
        // User already exists, skip
        print('⚠️ User ${user.email} already exists, skipping...');
      }
    }
    print('👥 Created $createdCount new sample users');
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
        condition: CardCondition.nearMint,
        price: 15.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_002',
        isForSale: true,
        description: 'Classic Pikachu from Base Set',
        createdAt: DateTime.now().subtract(Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
      // Yu-Gi-Oh! Cards
      Card(
        id: _uuid.v4(),
        name: 'Blue-Eyes White Dragon',
        setName: 'Legend of Blue Eyes White Dragon',
        game: CardGame.yugioh,
        rarity: CardRarity.ultraRare,
        condition: CardCondition.mint,
        price: 200.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_001',
        isForSale: true,
        description: 'First edition Blue-Eyes White Dragon',
        createdAt: DateTime.now().subtract(Duration(days: 45)),
        updatedAt: DateTime.now(),
      ),
      // Magic: The Gathering Cards
      Card(
        id: _uuid.v4(),
        name: 'Black Lotus',
        setName: 'Alpha',
        game: CardGame.mtg,
        rarity: CardRarity.rare,
        condition: CardCondition.excellent,
        price: 50000.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_003',
        isForSale: false,
        isForTrade: true,
        description: 'Alpha Black Lotus - The most valuable Magic card',
        createdAt: DateTime.now().subtract(Duration(days: 60)),
        updatedAt: DateTime.now(),
      ),
      // One Piece Cards
      Card(
        id: _uuid.v4(),
        name: 'Monkey D. Luffy',
        setName: 'OP-01',
        game: CardGame.onePiece,
        rarity: CardRarity.secretRare,
        condition: CardCondition.nearMint,
        price: 150.0,
        imageUrl: 'https://images.unsplash.com/photo-1611224923853-80b023f02d71?w=300',
        sellerId: 'user_002',
        isForSale: true,
        description: 'Secret Rare Luffy from OP-01',
        createdAt: DateTime.now().subtract(Duration(days: 20)),
        updatedAt: DateTime.now(),
      ),
    ];
    
    int createdCount = 0;
    
    for (final card in cards) {
      try {
        await HiveDatabaseService.instance.insertCard(card);
        createdCount++;
      } catch (e) {
        // Card already exists, skip
        print('⚠️ Card ${card.name} already exists, skipping...');
      }
    }
    print('🃏 Created $createdCount new sample cards');
  }
  
  static Future<bool> isDatabaseEmpty() async {
    try {
      final users = await HiveDatabaseService.instance.getAllUsers();
      final cards = await HiveDatabaseService.instance.getAllCards();
      
      return users.isEmpty && cards.isEmpty;
    } catch (e) {
      print('❌ Error checking database: $e');
      return true; // Assume empty if error
    }
  }
} 