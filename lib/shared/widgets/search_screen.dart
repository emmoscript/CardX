import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

class SearchScreenScaffold extends StatelessWidget {
  const SearchScreenScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _selectedGame = 'Todos';
  String _selectedRarity = 'Todas';
  String _selectedPriceRange = 'Todos';

  final List<String> games = ['Todos', 'Pokémon', 'Yu-Gi-Oh!', 'Magic', 'One Piece', 'Digimon'];
  final List<String> rarities = ['Todas', 'Común', 'Poco Común', 'Rara', 'Ultra Rara', 'Secret Rara'];
  final List<String> priceRanges = ['Todos', '0-10', '10-50', '50-100', '100-500', '500+'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero Section
        Container(
          margin: EdgeInsets.all(16),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF9800),
                Color(0xFFF57C00),
                Color(0xFFE65100),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                size: 32,
                color: Colors.white,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Encuentra lo que Buscas',
                      style: AppTypography.h5.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Cartas, mazos, colecciones y usuarios',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Search Bar
        Container(
          padding: EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar cartas, mazos, colecciones, usuarios...',
              prefixIcon: Icon(Icons.search, color: AppColors.grey400),
              suffixIcon: IconButton(
                icon: Icon(Icons.filter_list, color: AppColors.grey400),
                onPressed: () => _showFilterModal(context),
              ),
              filled: true,
              fillColor: AppColors.grey50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ),
        
        // Filters
        Container(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              _buildFilterChip('Juego: $_selectedGame', () => _showGameFilter()),
              SizedBox(width: 8),
              _buildFilterChip('Rareza: $_selectedRarity', () => _showRarityFilter()),
              SizedBox(width: 8),
              _buildFilterChip('Precio: $_selectedPriceRange', () => _showPriceFilter()),
            ],
          ),
        ),
        
        SizedBox(height: 16), // Espaciado entre filtros y tabs
        
        // Tabs
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.grey50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: AppColors.grey600,
            labelStyle: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            unselectedLabelStyle: AppTypography.bodyMedium,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Tab(text: 'Cartas'),
              Tab(text: 'Mazos'),
              Tab(text: 'Colecciones'),
              Tab(text: 'Usuarios'),
            ],
            indicatorColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            dividerColor: Colors.transparent,
          ),
        ),
        
        SizedBox(height: 16), // Espaciado entre tabs y contenido
        
        // Tab Content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildCardsTab(),
              _buildDecksTab(),
              _buildCollectionsTab(),
              _buildUsersTab(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildCardsTab() {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen de la carta
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.grey100,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(Icons.image, size: 40, color: AppColors.grey400),
                      ),
                      // Badge de rareza
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'Rara',
                            style: AppTypography.labelSmall.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Información de la carta
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Carta ${index + 1}',
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Pokémon • Base Set',
                        style: AppTypography.labelSmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${(25 + index * 5).toStringAsFixed(2)}',
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.buyGreen,
                              fontSize: 12,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border, size: 16),
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDecksTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.deck, color: AppColors.grey400),
            ),
            title: Text('Mazo ${index + 1}'),
            subtitle: Text('60 cartas • Yu-Gi-Oh! • \$45.99'),
            trailing: Icon(Icons.favorite_border, color: AppColors.grey400),
          ),
        );
      },
    );
  }

  Widget _buildCollectionsTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(
              width: 50,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.grey100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.collections, color: AppColors.grey400),
            ),
            title: Text('Colección ${index + 1}'),
            subtitle: Text('150 cartas • Magic • Valor: \$1,250'),
            trailing: Icon(Icons.favorite_border, color: AppColors.grey400),
          ),
        );
      },
    );
  }

  Widget _buildUsersTab() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.grey100,
              child: Icon(Icons.person, color: AppColors.grey400),
            ),
            title: Text('Usuario ${index + 1}'),
            subtitle: Text('Vendedor • 4.8 ⭐ • 150 ventas'),
            trailing: Icon(Icons.person_add_outlined, color: AppColors.grey400),
          ),
        );
      },
    );
  }

  void _showFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filtros Avanzados', style: AppTypography.h5),
            SizedBox(height: 16),
            _buildFilterSection('Juego', games, _selectedGame, (value) {
              setState(() => _selectedGame = value);
            }),
            _buildFilterSection('Rareza', rarities, _selectedRarity, (value) {
              setState(() => _selectedRarity = value);
            }),
            _buildFilterSection('Rango de Precio', priceRanges, _selectedPriceRange, (value) {
              setState(() => _selectedPriceRange = value);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, String selected, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) => ChoiceChip(
            label: Text(option),
            selected: selected == option,
            onSelected: (selected) => onChanged(option),
          )).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  void _showGameFilter() {
    // Implement filter logic
  }

  void _showRarityFilter() {
    // Implement filter logic
  }

  void _showPriceFilter() {
    // Implement filter logic
  }
} 