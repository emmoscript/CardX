import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/services/tcg_api_service.dart';
import '../../core/services/yugioh_api_service.dart';
import '../../core/services/star_wars_unlimited_api_service.dart';
import '../../core/services/yugioh_card_converter.dart';
import '../../core/services/tcg_card_converter.dart';
import '../../core/services/star_wars_unlimited_card_converter.dart';
import '../../shared/models/card.dart' as card_model;
import '../../shared/widgets/hero_section_slider.dart';
import '../../shared/widgets/auction_slider.dart';
import '../../shared/widgets/tcg_category_slider.dart';
import '../../shared/widgets/price_update_slider.dart';
import '../../shared/widgets/latest_singles_slider.dart';
import '../../shared/widgets/accessory_slider.dart';
import '../../shared/widgets/google_ads_widget.dart';
import '../../shared/widgets/search_screen.dart';
import '../../shared/widgets/favorites_screen.dart';
import '../../shared/widgets/notifications_screen.dart';
import '../../shared/widgets/profile_screen.dart';
import '../../features/tcg/tcg_card_list_screen.dart';
import '../../features/auctions/auctions_screen.dart';
import 'package:hive/hive.dart';
import '../../shared/widgets/shopping_cart_screen.dart';
import '../../shared/widgets/messages_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TcgApiService _tcgApiService = TcgApiService();
  final YugiohApiService _yugiohApiService = YugiohApiService();
  final StarWarsUnlimitedApiService _starWarsApiService = StarWarsUnlimitedApiService();

  // Data for each game section
  List<card_model.Card> _yugiohCards = [];
  List<card_model.Card> _pokemonCards = [];
  List<card_model.Card> _onePieceCards = [];
  List<card_model.Card> _dragonBallCards = [];
  List<card_model.Card> _magicCards = [];
  List<card_model.Card> _digimonCards = [];
  List<card_model.Card> _gundamCards = [];
  List<card_model.Card> _starWarsCards = [];

  // Loading states
  bool _isLoadingYugioh = true;
  bool _isLoadingPokemon = true;
  bool _isLoadingOnePiece = true;
  bool _isLoadingDragonBall = true;
  bool _isLoadingMagic = true;
  bool _isLoadingDigimon = true;
  bool _isLoadingGundam = true;
  bool _isLoadingStarWars = true;

  int _currentIndex = 0;
  String? _activeTcgGrid;
  Color? _activeTcgColor;
  String? _activeTcgImage;

  @override
  void initState() {
    super.initState();
    _loadAllCardData();
  }

  Future<void> _loadAllCardData() async {
    // Load Yu-Gi-Oh! cards
    _loadYugiohCards();
    
    // Load other card games
    _loadPokemonCards();
    _loadOnePieceCards();
    _loadDragonBallCards();
    _loadMagicCards();
    _loadDigimonCards();
    _loadGundamCards();
    _loadStarWarsCards();
  }

  Future<void> _loadYugiohCards() async {
    try {
      setState(() => _isLoadingYugioh = true);
      final apiCards = await _yugiohApiService.getPopularCards();
      final cards = YugiohCardConverter.fromApiDataList(apiCards);
      setState(() {
        _yugiohCards = cards;
        _isLoadingYugioh = false;
      });
    } catch (e) {
      print('Error loading Yu-Gi-Oh! cards: $e');
      setState(() {
        _yugiohCards = _getFallbackYugiohCards();
        _isLoadingYugioh = false;
      });
    }
  }

  Future<void> _loadPokemonCards() async {
    try {
      setState(() => _isLoadingPokemon = true);
      final cards = await _tcgApiService.getPokemonCards();
      setState(() {
        _pokemonCards = cards;
        _isLoadingPokemon = false;
      });
    } catch (e) {
      print('Error loading Pokémon cards: $e');
      setState(() {
        _pokemonCards = _getFallbackPokemonCards();
        _isLoadingPokemon = false;
      });
    }
  }

  Future<void> _loadOnePieceCards() async {
    try {
      setState(() => _isLoadingOnePiece = true);
      final cards = await _tcgApiService.getOnePieceCards();
      setState(() {
        _onePieceCards = cards;
        _isLoadingOnePiece = false;
      });
    } catch (e) {
      print('Error loading One Piece cards: $e');
      setState(() {
        _onePieceCards = _getFallbackOnePieceCards();
        _isLoadingOnePiece = false;
      });
    }
  }

  Future<void> _loadDragonBallCards() async {
    try {
      setState(() => _isLoadingDragonBall = true);
      final cards = await _tcgApiService.getDragonBallCards();
      setState(() {
        _dragonBallCards = cards;
        _isLoadingDragonBall = false;
      });
    } catch (e) {
      print('Error loading Dragon Ball cards: $e');
      setState(() {
        _dragonBallCards = _getFallbackDragonBallCards();
        _isLoadingDragonBall = false;
      });
    }
  }

  Future<void> _loadMagicCards() async {
    try {
      setState(() => _isLoadingMagic = true);
      final cards = await _tcgApiService.getMagicCards();
      setState(() {
        _magicCards = cards;
        _isLoadingMagic = false;
      });
    } catch (e) {
      print('Error loading Magic cards: $e');
      setState(() {
        _magicCards = _getFallbackMagicCards();
        _isLoadingMagic = false;
      });
    }
  }

  Future<void> _loadDigimonCards() async {
    try {
      setState(() => _isLoadingDigimon = true);
      final cards = await _tcgApiService.getDigimonCards();
      setState(() {
        _digimonCards = cards;
        _isLoadingDigimon = false;
      });
    } catch (e) {
      print('Error loading Digimon cards: $e');
      setState(() {
        _digimonCards = _getFallbackDigimonCards();
        _isLoadingDigimon = false;
      });
    }
  }

  Future<void> _loadGundamCards() async {
    try {
      setState(() => _isLoadingGundam = true);
      final cards = await _tcgApiService.getGundamCards();
      setState(() {
        _gundamCards = cards;
        _isLoadingGundam = false;
      });
    } catch (e) {
      print('Error loading Gundam cards: $e');
      setState(() {
        _gundamCards = _getFallbackGundamCards();
        _isLoadingGundam = false;
      });
    }
  }

  Future<void> _loadStarWarsCards() async {
    try {
      setState(() => _isLoadingStarWars = true);
      final apiCards = await _starWarsApiService.getPopularCards();
      final cards = StarWarsUnlimitedCardConverter.fromApiDataList(apiCards);
      setState(() {
        _starWarsCards = cards;
        _isLoadingStarWars = false;
      });
    } catch (e) {
      print('Error loading Star Wars cards: $e');
      setState(() {
        _starWarsCards = _getFallbackStarWarsCards();
        _isLoadingStarWars = false;
      });
    }
  }

  // Fallback cards for each game
  List<card_model.Card> _getFallbackYugiohCards() {
    final now = DateTime.now();
    return [
      card_model.Card(
        id: 'yugioh-1',
        name: 'Blue-Eyes White Dragon',
        game: card_model.CardGame.yugioh,
        imageUrl: 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
        setName: 'Legend of Blue Eyes White Dragon',
        rarity: card_model.CardRarity.ultraRare,
        price: 25.99,
        type: 'Dragon / Normal',
        attribute: 'Light',
        level: 8,
        atk: 3000,
        def: 2500,
        archetype: 'Blue-Eyes',
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'yugioh-2',
        name: 'Dark Magician',
        game: card_model.CardGame.yugioh,
        imageUrl: 'https://images.ygoprodeck.com/images/cards/46986414.jpg',
        setName: 'Legend of Blue Eyes White Dragon',
        rarity: card_model.CardRarity.ultraRare,
        price: 15.50,
        type: 'Spellcaster / Normal',
        attribute: 'Dark',
        level: 7,
        atk: 2500,
        def: 2100,
        archetype: 'Dark Magician',
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  List<card_model.Card> _getFallbackPokemonCards() {
    final now = DateTime.now();
    return [
      card_model.Card(
        id: 'pokemon-1',
        name: 'Charizard',
        game: card_model.CardGame.pokemon,
        imageUrl: 'https://images.pokemontcg.io/base1/4.png',
        setName: 'Base Set',
        rarity: card_model.CardRarity.rareHolo,
        price: 299.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'pokemon-2',
        name: 'Pikachu',
        game: card_model.CardGame.pokemon,
        imageUrl: 'https://images.pokemontcg.io/base1/58.png',
        setName: 'Base Set',
        rarity: card_model.CardRarity.common,
        price: 5.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  List<card_model.Card> _getFallbackOnePieceCards() {
    final now = DateTime.now();
    return [
      card_model.Card(
        id: 'onepiece-1',
        name: 'Monkey D. Luffy',
        game: card_model.CardGame.onePiece,
        imageUrl: 'https://via.placeholder.com/250x350/FF6B35/FFFFFF?text=Luffy',
        setName: 'Starter Deck',
        rarity: card_model.CardRarity.rare,
        price: 12.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'onepiece-2',
        name: 'Roronoa Zoro',
        game: card_model.CardGame.onePiece,
        imageUrl: 'https://via.placeholder.com/250x350/228B22/FFFFFF?text=Zoro',
        setName: 'Starter Deck',
        rarity: card_model.CardRarity.uncommon,
        price: 8.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  List<card_model.Card> _getFallbackDragonBallCards() {
    final now = DateTime.now();
    return [
      card_model.Card(
        id: 'dragonball-1',
        name: 'Goku',
        game: card_model.CardGame.dragonBall,
        imageUrl: 'https://via.placeholder.com/250x350/FFD700/000000?text=Goku',
        setName: 'Starter Deck',
        rarity: card_model.CardRarity.rare,
        price: 15.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'dragonball-2',
        name: 'Vegeta',
        game: card_model.CardGame.dragonBall,
        imageUrl: 'https://via.placeholder.com/250x350/4169E1/FFFFFF?text=Vegeta',
        setName: 'Starter Deck',
        rarity: card_model.CardRarity.uncommon,
        price: 10.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  List<card_model.Card> _getFallbackMagicCards() {
    final now = DateTime.now();
    return [
      card_model.Card(
        id: 'magic-1',
        name: 'Lightning Bolt',
        game: card_model.CardGame.mtg,
        imageUrl: 'https://via.placeholder.com/250x350/FFD700/000000?text=Lightning+Bolt',
        setName: 'Alpha',
        rarity: card_model.CardRarity.common,
        price: 45.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'magic-2',
        name: 'Counterspell',
        game: card_model.CardGame.mtg,
        imageUrl: 'https://via.placeholder.com/250x350/4169E1/FFFFFF?text=Counterspell',
        setName: 'Alpha',
        rarity: card_model.CardRarity.uncommon,
        price: 85.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  List<card_model.Card> _getFallbackDigimonCards() {
    final now = DateTime.now();
    return [
      card_model.Card(
        id: 'digimon-1',
        name: 'Agumon',
        game: card_model.CardGame.digimon,
        imageUrl: 'https://via.placeholder.com/250x350/FF8C00/FFFFFF?text=Agumon',
        setName: 'Starter Deck',
        rarity: card_model.CardRarity.common,
        price: 8.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'digimon-2',
        name: 'Gabumon',
        game: card_model.CardGame.digimon,
        imageUrl: 'https://via.placeholder.com/250x350/4682B4/FFFFFF?text=Gabumon',
        setName: 'Starter Deck',
        rarity: card_model.CardRarity.common,
        price: 7.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  List<card_model.Card> _getFallbackGundamCards() {
    final now = DateTime.now();
    return [
      card_model.Card(
        id: 'gundam-1',
        name: 'RX-78-2 Gundam',
        game: card_model.CardGame.gundam,
        imageUrl: 'https://via.placeholder.com/250x350/FF8C00/FFFFFF?text=RX-78-2+Gundam',
        setName: 'Starter Deck',
        rarity: card_model.CardRarity.rare,
        price: 18.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'gundam-2',
        name: 'MS-06 Zaku II',
        game: card_model.CardGame.gundam,
        imageUrl: 'https://via.placeholder.com/250x350/4682B4/FFFFFF?text=Zaku+II',
        setName: 'Starter Deck',
        rarity: card_model.CardRarity.common,
        price: 12.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  List<card_model.Card> _getFallbackStarWarsCards() {
    final now = DateTime.now();
    return [
      card_model.Card(
        id: 'starwars-1',
        name: 'Luke Skywalker',
        game: card_model.CardGame.starWarsUnlimited,
        imageUrl: 'https://via.placeholder.com/250x350/FFD700/000000?text=Luke+Skywalker',
        setName: 'Spark of Rebellion',
        rarity: card_model.CardRarity.rare,
        price: 15.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'starwars-2',
        name: 'Darth Vader',
        game: card_model.CardGame.starWarsUnlimited,
        imageUrl: 'https://via.placeholder.com/250x350/8B0000/FFFFFF?text=Darth+Vader',
        setName: 'Spark of Rebellion',
        rarity: card_model.CardRarity.ultraRare,
        price: 25.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  void _goToSearchTab() {
    setState(() {
      _currentIndex = 1;
    });
  }

  void _closeTcgGrid() {
    setState(() {
      _activeTcgGrid = null;
      _activeTcgColor = null;
      _activeTcgImage = null;
    });
  }

  void _showTcgGridByName(String tcgName, Color tcgColor, String tcgImage) {
    setState(() {
      _activeTcgGrid = tcgName;
      _activeTcgColor = tcgColor;
      _activeTcgImage = tcgImage;
    });
  }

  void _showShoppingCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShoppingCartScreen(),
      ),
    );
  }

  void _showMessages() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MessagesScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey400,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel_outlined),
            activeIcon: Icon(Icons.gavel),
            label: 'Subastas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_activeTcgGrid != null && _activeTcgColor != null && _activeTcgImage != null) {
      return TcgCardListScreen(
        tcgName: _activeTcgGrid!,
        tcgColor: _activeTcgColor!,
        tcgImage: _activeTcgImage!,
        onBack: _closeTcgGrid,
      );
    }
    
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return SearchScreen();
      case 2:
        return const AuctionsScreen();
      case 3:
        return FavoritesScreen();
      case 4:
        return ProfileScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    // Leer nombre del usuario desde Hive
    var box = Hive.box('userBox');
    String name = box.get('name', defaultValue: '');
    bool isLoggedIn = box.get('isLoggedIn', defaultValue: false);
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: isLoggedIn && name.isNotEmpty 
          ? Text('Hola, $name 👋') 
          : Text('Bienvenido'),
        actions: [
          IconButton(
            icon: Icon(Icons.gavel, color: AppColors.textPrimary),
            onPressed: () {
              setState(() {
                _currentIndex = 2; // Navigate to auctions
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NotificationsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: AppColors.textPrimary),
            onPressed: () {
              _showShoppingCart();
            },
          ),
          IconButton(
            icon: Icon(Icons.message_outlined, color: AppColors.textPrimary),
            onPressed: () {
              _showMessages();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroSectionSlider(),
            SizedBox(height: 24),
            AuctionSlider(),
            SizedBox(height: 24),
            TcgCategorySlider(onSeeAll: _goToSearchTab, onSeeTcgGrid: _showTcgGridByName),
            SizedBox(height: 24),
            PriceUpdateSlider(
              cards: [..._pokemonCards, ..._yugiohCards, ..._magicCards].take(5).toList(),
              isLoading: _isLoadingPokemon || _isLoadingYugioh || _isLoadingMagic,
            ),
            SizedBox(height: 24),
            LatestSinglesSlider(
              game: 'Pokémon',
              cards: _pokemonCards,
              isLoading: _isLoadingPokemon,
              onSeeAll: _goToSearchTab,
              onSeeTcgGrid: _showTcgGridByName,
            ),
            SizedBox(height: 24),
            LatestSinglesSlider(
              game: 'Yu-Gi-Oh!',
              cards: _yugiohCards,
              isLoading: _isLoadingYugioh,
              onSeeAll: _goToSearchTab,
              onSeeTcgGrid: _showTcgGridByName,
            ),
            SizedBox(height: 24),
            LatestSinglesSlider(
              game: 'Magic',
              cards: _magicCards,
              isLoading: _isLoadingMagic,
              onSeeAll: _goToSearchTab,
              onSeeTcgGrid: _showTcgGridByName,
            ),
            SizedBox(height: 24),
            LatestSinglesSlider(
              game: 'One Piece',
              cards: _onePieceCards,
              isLoading: _isLoadingOnePiece,
              onSeeAll: _goToSearchTab,
              onSeeTcgGrid: _showTcgGridByName,
            ),
            SizedBox(height: 24),
            LatestSinglesSlider(
              game: 'Digimon',
              cards: _digimonCards,
              isLoading: _isLoadingDigimon,
              onSeeAll: _goToSearchTab,
              onSeeTcgGrid: _showTcgGridByName,
            ),
            SizedBox(height: 24),
            LatestSinglesSlider(
              game: 'Gundam',
              cards: _gundamCards,
              isLoading: _isLoadingGundam,
              onSeeAll: _goToSearchTab,
              onSeeTcgGrid: _showTcgGridByName,
            ),
            SizedBox(height: 24),
            LatestSinglesSlider(
              game: 'Star Wars Unlimited',
              cards: _starWarsCards,
              isLoading: _isLoadingStarWars,
              onSeeAll: _goToSearchTab,
              onSeeTcgGrid: _showTcgGridByName,
            ),
            SizedBox(height: 24),
            AccessorySlider(),
            SizedBox(height: 24),
            GoogleAdsWidget(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class TcgInfo {
  final String name;
  final Color color;
  final String image;
  const TcgInfo(this.name, this.color, this.image);
}

TcgInfo getTcgInfo(String tcgName) {
  switch (tcgName) {
    case 'Pokémon':
      return TcgInfo('Pokémon', Color(0xFFFFDE4A), 'assets/images/pokemon_logo.png');
    case 'One Piece':
      return TcgInfo('One Piece', Color(0xFF1E90FF), 'assets/images/onepiece_logo.png');
    case 'Magic':
      return TcgInfo('Magic', Color(0xFFB97A56), 'assets/images/magic_logo.png');
    case 'Yu-Gi-Oh!':
      return TcgInfo('Yu-Gi-Oh!', Color(0xFFB22222), 'assets/images/yugioh_logo.png');
    case 'Dragon Ball Super':
      return TcgInfo('Dragon Ball Super', Color(0xFFFF6B35), 'assets/images/dbs_logo.png');
    case 'Gundam':
      return TcgInfo('Gundam', Color(0xFF1A1A1A), 'assets/images/gundam_logo.png');
    case 'Star Wars Unlimited':
      return TcgInfo('Star Wars Unlimited', Color(0xFFF4D03F), 'assets/images/starwarsunlimited_logo.png');
    default:
      return TcgInfo(tcgName, AppColors.primary, '');
  }
} 