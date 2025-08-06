import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'cardx_database.db';
  static const int _databaseVersion = 3;
  
  // Singleton pattern
  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();
  
  static Database? _database;
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }
  
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }
  
  Future<void> _onCreate(Database db, int version) async {
    // Usuarios
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        email TEXT UNIQUE NOT NULL,
        display_name TEXT,
        photo_url TEXT,
        collection_value REAL DEFAULT 0,
        total_cards INTEGER DEFAULT 0,
        join_date INTEGER NOT NULL,
        preferences TEXT,
        location TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
    
    // Cartas
    await db.execute('''
      CREATE TABLE cards (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        set_name TEXT,
        game TEXT NOT NULL,
        rarity TEXT,
        condition TEXT,
        price REAL,
        image_url TEXT,
        seller_id TEXT,
        is_for_sale INTEGER DEFAULT 0,
        is_for_trade INTEGER DEFAULT 0,
        description TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (seller_id) REFERENCES users (id)
      )
    ''');
    
    // Colecciones
    await db.execute('''
      CREATE TABLE collections (
        id TEXT PRIMARY KEY,
        user_id TEXT NOT NULL,
        title TEXT NOT NULL,
        description TEXT,
        hero_image_url TEXT,
        is_public INTEGER DEFAULT 1,
        view_count INTEGER DEFAULT 0,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
    
    // Cartas en colecciones (relación muchos a muchos)
    await db.execute('''
      CREATE TABLE collection_cards (
        collection_id TEXT,
        card_id TEXT,
        added_at INTEGER NOT NULL,
        PRIMARY KEY (collection_id, card_id),
        FOREIGN KEY (collection_id) REFERENCES collections (id),
        FOREIGN KEY (card_id) REFERENCES cards (id)
      )
    ''');
    
    // Historial de precios
    await db.execute('''
      CREATE TABLE price_history (
        id TEXT PRIMARY KEY,
        card_id TEXT NOT NULL,
        price REAL NOT NULL,
        condition TEXT,
        date INTEGER NOT NULL,
        volume INTEGER DEFAULT 1,
        source TEXT DEFAULT 'local',
        FOREIGN KEY (card_id) REFERENCES cards (id)
      )
    ''');
    
    // Intercambios/Trades
    await db.execute('''
      CREATE TABLE trades (
        id TEXT PRIMARY KEY,
        from_user_id TEXT NOT NULL,
        to_user_id TEXT NOT NULL,
        status TEXT DEFAULT 'pending',
        cash_amount REAL DEFAULT 0,
        message TEXT,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL,
        FOREIGN KEY (from_user_id) REFERENCES users (id),
        FOREIGN KEY (to_user_id) REFERENCES users (id)
      )
    ''');
    
    // Cartas ofrecidas en trades
    await db.execute('''
      CREATE TABLE trade_cards (
        trade_id TEXT,
        card_id TEXT,
        type TEXT NOT NULL,
        PRIMARY KEY (trade_id, card_id, type),
        FOREIGN KEY (trade_id) REFERENCES trades (id),
        FOREIGN KEY (card_id) REFERENCES cards (id)
      )
    ''');
    
    // Wishlist
    await db.execute('''
      CREATE TABLE wishlist (
        user_id TEXT,
        card_id TEXT,
        added_at INTEGER NOT NULL,
        PRIMARY KEY (user_id, card_id),
        FOREIGN KEY (user_id) REFERENCES users (id),
        FOREIGN KEY (card_id) REFERENCES cards (id)
      )
    ''');
    
    // Subastas
    await db.execute('''
      CREATE TABLE auctions (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        card_id TEXT NOT NULL,
        seller_id TEXT NOT NULL,
        starting_price REAL NOT NULL,
        current_price REAL NOT NULL,
        reserve_price REAL,
        buy_now_price REAL,
        start_time TEXT NOT NULL,
        end_time TEXT NOT NULL,
        status TEXT NOT NULL DEFAULT 'active',
        type TEXT NOT NULL DEFAULT 'standard',
        tcg TEXT NOT NULL,
        condition TEXT,
        rarity TEXT,
        card_set TEXT,
        language TEXT,
        total_bids INTEGER DEFAULT 0,
        views INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (card_id) REFERENCES cards (id),
        FOREIGN KEY (seller_id) REFERENCES users (id)
      )
    ''');
    
    // Pujas
    await db.execute('''
      CREATE TABLE bids (
        id TEXT PRIMARY KEY,
        auction_id TEXT NOT NULL,
        bidder_id TEXT NOT NULL,
        amount REAL NOT NULL,
        timestamp TEXT NOT NULL,
        is_auto_bid INTEGER DEFAULT 0,
        is_winning INTEGER DEFAULT 0,
        FOREIGN KEY (auction_id) REFERENCES auctions (id),
        FOREIGN KEY (bidder_id) REFERENCES users (id)
      )
    ''');
    
    // Subastas vigiladas (favoritos)
    await db.execute('''
      CREATE TABLE auction_watches (
        auction_id TEXT,
        user_id TEXT,
        created_at TEXT NOT NULL,
        PRIMARY KEY (auction_id, user_id),
        FOREIGN KEY (auction_id) REFERENCES auctions (id),
        FOREIGN KEY (user_id) REFERENCES users (id)
      )
    ''');
    
    // Índices para optimizar queries
    await db.execute('CREATE INDEX idx_cards_game ON cards(game)');
    await db.execute('CREATE INDEX idx_cards_seller ON cards(seller_id)');
    await db.execute('CREATE INDEX idx_cards_for_sale ON cards(is_for_sale)');
    await db.execute('CREATE INDEX idx_cards_for_trade ON cards(is_for_trade)');
    await db.execute('CREATE INDEX idx_price_history_card ON price_history(card_id)');
    await db.execute('CREATE INDEX idx_price_history_date ON price_history(date)');
    await db.execute('CREATE INDEX idx_collections_user ON collections(user_id)');
    await db.execute('CREATE INDEX idx_collections_public ON collections(is_public)');
    
    // Índices para subastas
    await db.execute('CREATE INDEX idx_auctions_status ON auctions(status)');
    await db.execute('CREATE INDEX idx_auctions_tcg ON auctions(tcg)');
    await db.execute('CREATE INDEX idx_auctions_seller ON auctions(seller_id)');
    await db.execute('CREATE INDEX idx_auctions_end_time ON auctions(end_time)');
    await db.execute('CREATE INDEX idx_bids_auction ON bids(auction_id)');
    await db.execute('CREATE INDEX idx_bids_bidder ON bids(bidder_id)');
    await db.execute('CREATE INDEX idx_auction_watches_user ON auction_watches(user_id)');
  }
  
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      // Agregar tablas de subastas
      await db.execute('''
        CREATE TABLE auctions (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT,
          card_id TEXT NOT NULL,
          seller_id TEXT NOT NULL,
          starting_price REAL NOT NULL,
          current_price REAL NOT NULL,
          reserve_price REAL,
          buy_now_price REAL,
          start_time TEXT NOT NULL,
          end_time TEXT NOT NULL,
          status TEXT NOT NULL DEFAULT 'active',
          type TEXT NOT NULL DEFAULT 'standard',
          tcg TEXT NOT NULL,
          condition TEXT,
          rarity TEXT,
          card_set TEXT,
          language TEXT,
          total_bids INTEGER DEFAULT 0,
          views INTEGER DEFAULT 0,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          FOREIGN KEY (card_id) REFERENCES cards (id),
          FOREIGN KEY (seller_id) REFERENCES users (id)
        )
      ''');
      
      await db.execute('''
        CREATE TABLE bids (
          id TEXT PRIMARY KEY,
          auction_id TEXT NOT NULL,
          bidder_id TEXT NOT NULL,
          amount REAL NOT NULL,
          timestamp TEXT NOT NULL,
          is_auto_bid INTEGER DEFAULT 0,
          is_winning INTEGER DEFAULT 0,
          FOREIGN KEY (auction_id) REFERENCES auctions (id),
          FOREIGN KEY (bidder_id) REFERENCES users (id)
        )
      ''');
      
      await db.execute('''
        CREATE TABLE auction_watches (
          auction_id TEXT,
          user_id TEXT,
          created_at TEXT NOT NULL,
          PRIMARY KEY (auction_id, user_id),
          FOREIGN KEY (auction_id) REFERENCES auctions (id),
          FOREIGN KEY (user_id) REFERENCES users (id)
        )
      ''');
      
      // Índices para subastas
      await db.execute('CREATE INDEX idx_auctions_status ON auctions(status)');
      await db.execute('CREATE INDEX idx_auctions_tcg ON auctions(tcg)');
      await db.execute('CREATE INDEX idx_auctions_seller ON auctions(seller_id)');
      await db.execute('CREATE INDEX idx_auctions_end_time ON auctions(end_time)');
      await db.execute('CREATE INDEX idx_bids_auction ON bids(auction_id)');
      await db.execute('CREATE INDEX idx_bids_bidder ON bids(bidder_id)');
      await db.execute('CREATE INDEX idx_auction_watches_user ON auction_watches(user_id)');
    }
  }
  
  // Métodos de utilidad
  Future<void> close() async {
    final db = await instance.database;
    await db.close();
    _database = null;
  }
  
  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
  
  // Método para ejecutar transacciones
  Future<T> transaction<T>(Future<T> Function(Transaction) action) async {
    final db = await database;
    return await db.transaction(action);
  }
  
  // Método para obtener estadísticas de la BD
  Future<Map<String, int>> getDatabaseStats() async {
    final db = await database;
    final tables = ['users', 'cards', 'collections', 'trades', 'price_history', 'auctions', 'bids'];
    final stats = <String, int>{};
    
    for (final table in tables) {
      final result = await db.rawQuery('SELECT COUNT(*) as count FROM $table');
      stats[table] = result.first['count'] as int;
    }
    
    return stats;
  }
} 