import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/models/card.dart' as card_model;
import '../../shared/widgets/card_tile.dart';
import '../../shared/widgets/google_ads_widget.dart';

enum FilterType { cards, decks, packs }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late TabController _tabController;
  
  // Filters for Cards
  String _selectedGame = 'Todos';
  String _selectedRarity = 'Todas';
  String _selectedCondition = 'Todas';
  double _minPrice = 0;
  double _maxPrice = 1000;
  bool _isForSale = false;
  bool _isForTrade = false;

  // Filters for Decks
  String _selectedFormat = 'Todos';
  String _selectedArchetype = 'Todos';
  
  // Filters for Packs
  String _selectedSet = 'Todos';
  String _selectedLanguage = 'Todos';
  
  List<card_model.Card> _searchResults = [];
  bool _isLoading = false;

  final List<String> _games = [
    'Todos',
    'Pokémon',
    'Yu-Gi-Oh!',
    'Magic: The Gathering',
    'One Piece',
    'Dragon Ball Super',
    'Digimon',
    'Gundam',
    'Star Wars Unlimited',
  ];

  final List<String> _rarities = [
    'Todas',
    'Común',
    'Poco común',
    'Rara',
    'Rara Holográfica',
    'Ultra Rara',
    'Secreta Rara',
    'Mítica',
  ];

  final List<String> _conditions = [
    'Todas',
    'Mint',
    'Near Mint',
    'Excellent',
    'Good',
    'Light Played',
    'Played',
    'Poor',
  ];

  final List<String> _formats = [
    'Todos',
    'Standard',
    'Modern',
    'Legacy',
    'Commander',
    'Pioneer',
    'Vintage',
    'Pauper',
  ];

  final List<String> _languages = [
    'Todos',
    'Inglés',
    'Español',
    'Japonés',
    'Alemán',
    'Francés',
    'Italiano',
    'Portugués',
    'Coreano',
    'Chino Simplificado',
    'Chino Tradicional',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadMockData();
  }

  void _loadMockData() {
    // Mock data for demonstration
    final now = DateTime.now();
    _searchResults = [
      card_model.Card(
        id: 'search-1',
        name: 'Charizard',
        game: card_model.CardGame.pokemon,
        imageUrl: 'https://images.pokemontcg.io/base1/4.png',
        setName: 'Base Set',
        rarity: card_model.CardRarity.rareHolo,
        condition: card_model.CardCondition.nearMint,
        price: 299.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'search-2',
        name: 'Blue-Eyes White Dragon',
        game: card_model.CardGame.yugioh,
        imageUrl: 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
        setName: 'Legend of Blue Eyes White Dragon',
        rarity: card_model.CardRarity.ultraRare,
        condition: card_model.CardCondition.excellent,
        price: 25.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      card_model.Card(
        id: 'search-3',
        name: 'Black Lotus',
        game: card_model.CardGame.mtg,
        imageUrl: 'https://via.placeholder.com/250x350/000000/FFFFFF?text=Black+Lotus',
        setName: 'Alpha',
        rarity: card_model.CardRarity.rare,
        condition: card_model.CardCondition.good,
        price: 15000.00,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }

  void _performSearch() {
    setState(() {
      _isLoading = true;
    });

    // Simulate search delay
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _isLoading = false;
        // Filter results based on search query and filters
        _searchResults = _getMockSearchResults().where((card) {
          final query = _searchController.text.toLowerCase();
          final matchesQuery = query.isEmpty || 
              card.name.toLowerCase().contains(query) ||
              card.setName?.toLowerCase().contains(query) == true;
          
          final matchesGame = _selectedGame == 'Todos' || 
              card.game.name.toLowerCase() == _selectedGame.toLowerCase();
          
          final matchesRarity = _selectedRarity == 'Todas' || 
              card.rarity?.name.toLowerCase() == _selectedRarity.toLowerCase();
          
          final matchesCondition = _selectedCondition == 'Todas' || 
              card.condition?.name.toLowerCase() == _selectedCondition.toLowerCase();
          
          final matchesSale = !_isForSale || card.isForSale;
          final matchesTrade = !_isForTrade || card.isForTrade;
          
          return matchesQuery && matchesGame && matchesRarity && 
                 matchesCondition && matchesSale && matchesTrade;
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Buscar',
                      style: AppTypography.h5.copyWith(
            color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(text: 'Cartas'),
            Tab(text: 'Mazos'),
            Tab(text: 'Paquetes'),
                  ],
                ),
              ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCardsTab(),
          _buildDecksTab(),
          _buildPacksTab(),
        ],
      ),
    );
  }

  Widget _buildCardsTab() {
    return SafeArea(
      child: Column(
        children: [
        // Search Bar
        Container(
            padding: const EdgeInsets.all(AppSpacing.md),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                hintText: 'Buscar cartas...',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
              suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list, color: AppColors.primary),
                  onPressed: () => _showFilterDialog(FilterType.cards),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: AppColors.surface,
              ),
              onSubmitted: (value) => _performSearch(),
            ),
          ),

          // Active Filters
          if (_hasActiveFilters())
        Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Wrap(
                spacing: AppSpacing.sm,
            children: [
                  if (_selectedGame != 'Todos')
                    _buildFilterChip('Juego: $_selectedGame', () {
                      setState(() => _selectedGame = 'Todos');
                    }),
                  if (_selectedRarity != 'Todas')
                    _buildFilterChip('Rareza: $_selectedRarity', () {
                      setState(() => _selectedRarity = 'Todas');
                    }),
                  if (_selectedCondition != 'Todas')
                    _buildFilterChip('Condición: $_selectedCondition', () {
                      setState(() => _selectedCondition = 'Todas');
                    }),
                  if (_isForSale)
                    _buildFilterChip('En Venta', () {
                      setState(() => _isForSale = false);
                    }),
                  if (_isForTrade)
                    _buildFilterChip('Para Intercambio', () {
                      setState(() => _isForTrade = false);
                    }),
            ],
          ),
        ),
        
          // Results
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: AppColors.primary))
                : _searchResults.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: AppColors.textSecondary),
                            const SizedBox(height: 16),
                            Text(
                              'No se encontraron resultados',
                              style: AppTypography.h6.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      )
                                        : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.lg),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.5, // Increased height (was 0.6)
                          crossAxisSpacing: AppSpacing.md,
                          mainAxisSpacing: AppSpacing.md,
                        ),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          return CardTile(
                            card: _searchResults[index],
                            onTap: () {
                              // TODO: Navigate to card detail
                            },
                            showFavoriteButton: true,
                          );
                        },
                      ),
        ),
      ],
      ),
    );
  }

  Widget _buildDecksTab() {
    return SafeArea(
      child: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar mazos...',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list, color: AppColors.primary),
                  onPressed: () => _showFilterDialog(FilterType.decks),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: AppColors.surface,
              ),
              onSubmitted: (value) => _performSearch(),
            ),
          ),

          // Active Filters
          if (_hasActiveFilters())
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Wrap(
                spacing: AppSpacing.sm,
                children: [
                  if (_selectedGame != 'Todos')
                    _buildFilterChip('Juego: $_selectedGame', () {
                      setState(() => _selectedGame = 'Todos');
                    }),
                  if (_selectedRarity != 'Todas')
                    _buildFilterChip('Rareza: $_selectedRarity', () {
                      setState(() => _selectedRarity = 'Todas');
                    }),
                  if (_selectedCondition != 'Todas')
                    _buildFilterChip('Condición: $_selectedCondition', () {
                      setState(() => _selectedCondition = 'Todas');
                    }),
                  if (_minPrice > 0 || _maxPrice < 10000)
                    _buildFilterChip('Precio: \$${_minPrice.toInt()} - \$${_maxPrice.toInt()}', () {
                      setState(() {
                        _minPrice = 0;
                        _maxPrice = 10000;
                      });
                    }),
                  if (_isForSale)
                    _buildFilterChip('En venta', () {
                      setState(() => _isForSale = false);
                    }),
                ],
              ),
            ),

          // Results
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
              ),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final deck = _getMockDeckResults()[index % _getMockDeckResults().length];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.cardBorderRadius),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Navegar al detalle del mazo
                    },
                    borderRadius: BorderRadius.circular(AppSpacing.cardBorderRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen del mazo
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(AppSpacing.cardBorderRadius),
                              ),
                            ),
                            child: Icon(
                              Icons.deck,
                              size: 48,
                              color: AppColors.grey400,
                            ),
                          ),
                        ),
                        // Información del mazo
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                deck['name'],
                                style: AppTypography.h6.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${deck['cardCount']} cartas',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getGameColor(deck['game']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: _getGameColor(deck['game']).withOpacity(0.3),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  deck['game'],
                                  style: AppTypography.labelSmall.copyWith(
                                    color: _getGameColor(deck['game']),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPacksTab() {
    return SafeArea(
      child: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar paquetes...',
                prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                suffixIcon: IconButton(
                  icon: Icon(Icons.filter_list, color: AppColors.primary),
                  onPressed: () => _showFilterDialog(FilterType.packs),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.grey300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: AppColors.surface,
              ),
              onSubmitted: (value) => _performSearch(),
            ),
          ),

          // Active Filters
          if (_hasActiveFilters())
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Wrap(
                spacing: AppSpacing.sm,
                children: [
                  if (_selectedGame != 'Todos')
                    _buildFilterChip('Juego: $_selectedGame', () {
                      setState(() => _selectedGame = 'Todos');
                    }),
                  if (_selectedLanguage != 'Todos')
                    _buildFilterChip('Idioma: $_selectedLanguage', () {
                      setState(() => _selectedLanguage = 'Todos');
                    }),
                ],
              ),
            ),

          // Results
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
              ),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final pack = _getMockPackResults()[index % _getMockPackResults().length];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.cardBorderRadius),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Navegar al detalle del paquete
                    },
                    borderRadius: BorderRadius.circular(AppSpacing.cardBorderRadius),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagen del paquete
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(AppSpacing.cardBorderRadius),
                              ),
                            ),
                            child: Icon(
                              Icons.inventory_2,
                              size: 48,
                              color: AppColors.grey400,
                            ),
                          ),
                        ),
                        // Información del paquete
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.sm),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pack['name'],
                                style: AppTypography.h6.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${pack['cardCount']} cartas',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: _getGameColor(pack['game']).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: _getGameColor(pack['game']).withOpacity(0.3),
                                    width: 0.5,
                                  ),
                                ),
                                child: Text(
                                  pack['game'],
                                  style: AppTypography.labelSmall.copyWith(
                                    color: _getGameColor(pack['game']),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Chip(
      label: Text(label, style: AppTypography.body2.copyWith(color: Colors.white)),
      backgroundColor: AppColors.primary,
      deleteIcon: Icon(Icons.close, color: Colors.white, size: 18),
      onDeleted: onRemove,
    );
  }

  bool _hasActiveFilters() {
    return _selectedGame != 'Todos' ||
           _selectedRarity != 'Todas' ||
           _selectedCondition != 'Todas' ||
           _isForSale ||
           _isForTrade;
  }

  List<Map<String, dynamic>> _getMockDeckResults() {
    return [
      {
        'id': '1',
        'name': 'Mazo de Control Pokémon',
        'game': 'Pokémon',
        'cardCount': 60,
        'description': 'Mazo de control para Pokémon TCG',
      },
      {
        'id': '2',
        'name': 'Mazo Aggro Yu-Gi-Oh!',
        'game': 'Yu-Gi-Oh!',
        'cardCount': 40,
        'description': 'Mazo agresivo para Yu-Gi-Oh!',
      },
      {
        'id': '3',
        'name': 'Mazo Control Magic',
        'game': 'Magic',
        'cardCount': 60,
        'description': 'Mazo de control para Magic: The Gathering',
      },
      {
        'id': '4',
        'name': 'Mazo One Piece Starter',
        'game': 'One Piece',
        'cardCount': 50,
        'description': 'Mazo inicial para One Piece TCG',
      },
      {
        'id': '5',
        'name': 'Mazo Dragon Ball Z',
        'game': 'Dragon Ball',
        'cardCount': 50,
        'description': 'Mazo para Dragon Ball Super Card Game',
      },
    ];
  }

  List<Map<String, dynamic>> _getMockPackResults() {
    return [
      {
        'id': '1',
        'name': 'Booster Pack Pokémon',
        'game': 'Pokémon',
        'cardCount': 10,
        'description': 'Booster pack de Pokémon TCG',
      },
      {
        'id': '2',
        'name': 'Booster Pack Yu-Gi-Oh!',
        'game': 'Yu-Gi-Oh!',
        'cardCount': 9,
        'description': 'Booster pack de Yu-Gi-Oh!',
      },
      {
        'id': '3',
        'name': 'Booster Pack Magic',
        'game': 'Magic',
        'cardCount': 15,
        'description': 'Booster pack de Magic: The Gathering',
      },
      {
        'id': '4',
        'name': 'Booster Pack One Piece',
        'game': 'One Piece',
        'cardCount': 12,
        'description': 'Booster pack de One Piece TCG',
      },
      {
        'id': '5',
        'name': 'Booster Pack Dragon Ball',
        'game': 'Dragon Ball',
        'cardCount': 10,
        'description': 'Booster pack de Dragon Ball Super Card Game',
      },
    ];
  }

  Color _getGameColor(String game) {
    switch (game.toLowerCase()) {
      case 'pokémon':
        return Colors.red;
      case 'magic':
        return Colors.blue;
      case 'yu-gi-oh!':
        return Colors.orange;
      case 'one piece':
        return Colors.deepPurple;
      case 'dragon ball':
        return Colors.deepOrange;
      default:
        return AppColors.grey600;
    }
  }

  List<card_model.Card> _getMockSearchResults() {
    return [
      card_model.Card(
        id: '1',
        name: 'Pikachu',
        setName: 'Base Set',
        game: card_model.CardGame.pokemon,
        rarity: card_model.CardRarity.common,
        condition: card_model.CardCondition.nearMint,
        price: 5.99,
        imageUrl: 'https://example.com/pikachu.jpg',
        isForSale: true,
        isForTrade: false,
        description: 'A classic Pikachu card from the original set.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      card_model.Card(
        id: '2',
        name: 'Blue-Eyes White Dragon',
        setName: 'Legend of Blue Eyes White Dragon',
        game: card_model.CardGame.yugioh,
        rarity: card_model.CardRarity.ultraRare,
        condition: card_model.CardCondition.excellent,
        price: 25.99,
        imageUrl: 'https://example.com/blue-eyes.jpg',
        isForSale: true,
        isForTrade: true,
        description: 'One of the most iconic Yu-Gi-Oh! cards.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      card_model.Card(
        id: '3',
        name: 'Black Lotus',
        setName: 'Alpha',
        game: card_model.CardGame.mtg,
        rarity: card_model.CardRarity.mythic,
        condition: card_model.CardCondition.nearMint,
        price: 25000.00,
        imageUrl: 'https://example.com/black-lotus.jpg',
        isForSale: false,
        isForTrade: true,
        description: 'The most valuable Magic: The Gathering card.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      card_model.Card(
        id: '4',
        name: 'Monkey D. Luffy',
        setName: 'Starter Deck',
        game: card_model.CardGame.onePiece,
        rarity: card_model.CardRarity.rare,
        condition: card_model.CardCondition.good,
        price: 12.99,
        imageUrl: 'https://example.com/luffy.jpg',
        isForSale: true,
        isForTrade: false,
        description: 'The main character from One Piece TCG.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      card_model.Card(
        id: '5',
        name: 'Goku',
        setName: 'Saiyan Saga',
        game: card_model.CardGame.dragonBall,
        rarity: card_model.CardRarity.superRare,
        condition: card_model.CardCondition.nearMint,
        price: 18.99,
        imageUrl: 'https://example.com/goku.jpg',
        isForSale: true,
        isForTrade: true,
        description: 'The legendary Saiyan warrior.',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  void _showFilterDialog(FilterType type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _buildFilterDialog(type),
    );
  }

  Widget _buildFilterDialog(FilterType type) {
    Widget dialogContent;
    
    switch (type) {
      case FilterType.cards:
        dialogContent = _buildCardFilters();
        break;
      case FilterType.decks:
        dialogContent = _buildDeckFilters();
        break;
      case FilterType.packs:
        dialogContent = _buildPackFilters();
        break;
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
        mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                'Filtros',
                style: AppTypography.h5.copyWith(
                              fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _selectedGame = 'Todos';
                    _selectedRarity = 'Todas';
                    _selectedCondition = 'Todas';
                    _isForSale = false;
                    _isForTrade = false;
                    _minPrice = 0;
                    _maxPrice = 1000;
                  });
                  Navigator.pop(context);
                },
                child: Text('Limpiar', style: TextStyle(color: AppColors.primary)),
                          ),
                        ],
                      ),
          const SizedBox(height: 24),
          dialogContent,
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _performSearch();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text('Aplicar Filtros', style: AppTypography.button),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _buildCardFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Game Filter
        Text('Juego', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedGame,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _games.map((game) => DropdownMenuItem(value: game, child: Text(game))).toList(),
          onChanged: (value) => setState(() => _selectedGame = value!),
        ),
        const SizedBox(height: 16),

        // Rarity Filter
        Text('Rareza', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedRarity,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _rarities.map((rarity) => DropdownMenuItem(value: rarity, child: Text(rarity))).toList(),
          onChanged: (value) => setState(() => _selectedRarity = value!),
        ),
        const SizedBox(height: 16),

        // Condition Filter
        Text('Condición', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedCondition,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _conditions.map((condition) => DropdownMenuItem(value: condition, child: Text(condition))).toList(),
          onChanged: (value) => setState(() => _selectedCondition = value!),
        ),
        const SizedBox(height: 16),

        // Availability Filters
        Text('Disponibilidad', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: CheckboxListTile(
                title: Text('En Venta', style: AppTypography.body2),
                value: _isForSale,
                onChanged: (value) => setState(() => _isForSale = value!),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ),
            Expanded(
              child: CheckboxListTile(
                title: Text('Para Intercambio', style: AppTypography.body2),
                value: _isForTrade,
                onChanged: (value) => setState(() => _isForTrade = value!),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeckFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Game Filter
        Text('Juego', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedGame,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _games.map((game) => DropdownMenuItem(value: game, child: Text(game))).toList(),
          onChanged: (value) => setState(() => _selectedGame = value!),
        ),
        const SizedBox(height: 16),

        // Format Filter
        Text('Formato', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedFormat,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _formats.map((format) => DropdownMenuItem(value: format, child: Text(format))).toList(),
          onChanged: (value) => setState(() => _selectedFormat = value!),
        ),
        const SizedBox(height: 16),

        // Archetype Filter
        Text('Arquetipo', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedArchetype,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: ['Todos', 'Dragones', 'Guerreros', 'Zombies', 'Máquinas'].map(
            (archetype) => DropdownMenuItem(value: archetype, child: Text(archetype))
          ).toList(),
          onChanged: (value) => setState(() => _selectedArchetype = value!),
        ),
      ],
    );
  }

  Widget _buildPackFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Game Filter
        Text('Juego', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedGame,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _games.map((game) => DropdownMenuItem(value: game, child: Text(game))).toList(),
          onChanged: (value) => setState(() => _selectedGame = value!),
        ),
        const SizedBox(height: 16),

        // Set Filter
        Text('Set', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedSet,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: ['Todos', 'Base Set', 'Jungle', 'Fossil', 'Team Rocket'].map(
            (set) => DropdownMenuItem(value: set, child: Text(set))
          ).toList(),
          onChanged: (value) => setState(() => _selectedSet = value!),
        ),
        const SizedBox(height: 16),

        // Language Filter
        Text('Idioma', style: AppTypography.h6.copyWith(color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedLanguage,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _languages.map((language) => DropdownMenuItem(value: language, child: Text(language))).toList(),
          onChanged: (value) => setState(() => _selectedLanguage = value!),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }
} 