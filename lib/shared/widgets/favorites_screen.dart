import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/models/card.dart';
import '../../shared/widgets/card_tile.dart';
import '../../features/tcg/tcg_card_detail_screen.dart';
import 'package:hive/hive.dart';

class FavoritesScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends ConsumerState<FavoritesScreen> {
  List<Card> _favoriteCards = [];
  List<String> _favoriteLists = ['Mi Colección', 'Deseos', 'Para Vender'];
  String _selectedList = 'Mi Colección';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteCards();
  }

  Future<void> _loadFavoriteCards() async {
    setState(() {
      _isLoading = true;
    });

    // Simular carga de favoritos
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock data - en una implementación real esto vendría de la base de datos
    final now = DateTime.now();
    _favoriteCards = [
      Card(
        id: 'pokemon-1',
        name: 'Charizard',
        game: CardGame.pokemon,
        imageUrl: 'https://images.pokemontcg.io/base1/4.png',
        setName: 'Base Set',
        rarity: CardRarity.rareHolo,
        price: 299.99,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
      Card(
        id: 'yugioh-1',
        name: 'Blue-Eyes White Dragon',
        game: CardGame.yugioh,
        imageUrl: 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
        setName: 'Legend of Blue Eyes White Dragon',
        rarity: CardRarity.ultraRare,
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
      Card(
        id: 'magic-1',
        name: 'Black Lotus',
        game: CardGame.mtg,
        imageUrl: 'https://via.placeholder.com/250x350/000000/FFFFFF?text=Black+Lotus',
        setName: 'Alpha',
        rarity: CardRarity.rare,
        price: 50000.00,
        isForSale: true,
        isForTrade: false,
        createdAt: now,
        updatedAt: now,
      ),
    ];

    setState(() {
      _isLoading = false;
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
          'Favoritos',
          style: AppTypography.h4.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.textPrimary),
            onPressed: _showCreateListDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Hero Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.1),
                  AppColors.primary.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Construye tu colección',
                  style: AppTypography.h5.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Organiza tus cartas favoritas en listas personalizadas',
                  style: AppTypography.body1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          
          // List Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: Row(
              children: [
                Text(
                  'Lista:',
                  style: AppTypography.body1.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedList,
                    isExpanded: true,
                    underline: Container(),
                    items: _favoriteLists.map((String list) {
                      return DropdownMenuItem<String>(
                        value: list,
                        child: Text(list),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedList = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _favoriteCards.isEmpty
                    ? _buildEmptyState()
                    : _buildFavoritesList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCardDialog,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'No tienes favoritos',
            style: AppTypography.h6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Agrega cartas a tu lista de favoritos\npara organizarlas y compartirlas',
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: _showAddCardDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Agregar primera carta',
              style: AppTypography.body1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: _favoriteCards.length,
      itemBuilder: (context, index) {
        final card = _favoriteCards[index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: CardTile(
            card: card,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TcgCardDetailScreen(
                    card: card,
                    bottomNavBar: _buildBottomNavigationBar(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grey400,
      currentIndex: 3, // Favoritos tab
      items: const [
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
    );
  }

  void _showCreateListDialog() {
    final TextEditingController listNameController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Crear nueva lista',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        content: TextField(
          controller: listNameController,
          decoration: InputDecoration(
            labelText: 'Nombre de la lista',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: AppTypography.body1.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (listNameController.text.isNotEmpty) {
                setState(() {
                  _favoriteLists.add(listNameController.text);
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Lista "${listNameController.text}" creada'),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
            child: Text(
              'Crear',
              style: AppTypography.body1.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddCardDialog() {
    // TODO: Implementar búsqueda y agregado de cartas
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Función de agregar cartas próximamente'),
      ),
    );
  }
} 