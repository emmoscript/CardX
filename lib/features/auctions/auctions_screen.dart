import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cardx/core/constants/app_colors.dart';
import 'package:cardx/core/constants/app_spacing.dart';
import 'package:cardx/core/constants/app_typography.dart';
import 'package:cardx/shared/models/auction.dart';
import 'package:cardx/shared/widgets/auction_tile.dart';
import 'package:cardx/core/services/auction_service.dart';
import 'package:cardx/shared/widgets/tcg_category_slider.dart';
import 'package:cardx/shared/widgets/search_screen.dart';
import 'package:cardx/features/auctions/auction_detail_screen.dart';
import 'package:cardx/features/auctions/create_auction_screen.dart';

class AuctionsScreen extends ConsumerStatefulWidget {
  const AuctionsScreen({super.key});

  @override
  ConsumerState<AuctionsScreen> createState() => _AuctionsScreenState();
}

class _AuctionsScreenState extends ConsumerState<AuctionsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  AuctionFilter? _currentFilter;
  String _selectedTcg = 'all';
  String _sortBy = 'time';
  bool _sortAscending = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTcgChanged(String tcg) {
    setState(() {
      _selectedTcg = tcg;
      _updateFilter();
    });
  }

  void _onSortChanged(String sortBy) {
    setState(() {
      _sortBy = sortBy;
      _updateFilter();
    });
  }

  void _updateFilter() {
    setState(() {
      _currentFilter = AuctionFilter(
        tcg: _selectedTcg == 'all' ? null : _selectedTcg,
        sortBy: _sortBy,
        sortAscending: _sortAscending,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Subastas',
          style: AppTypography.h4.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: AppColors.textPrimary),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Tabs
          Container(
            color: AppColors.background,
            child: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.primary,
              tabs: const [
                Tab(text: 'Activas'),
                Tab(text: 'Vigiladas'),
                Tab(text: 'Mías'),
              ],
            ),
          ),
          
          // TCG Categories
          TcgCategorySlider(
            onSeeAll: () {},
            onSeeTcgGrid: (tcg, color, image) => _onTcgChanged(tcg),
          ),
          
          // Sort options
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Row(
              children: [
                Text(
                  'Ordenar por:',
                  style: AppTypography.body2.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildSortChip('Tiempo', 'time'),
                        const SizedBox(width: AppSpacing.xs),
                        _buildSortChip('Precio', 'price'),
                        const SizedBox(width: AppSpacing.xs),
                        _buildSortChip('Popularidad', 'popularity'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppSpacing.sm),
          
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActiveAuctionsTab(),
                _buildWatchedAuctionsTab(),
                _buildMyAuctionsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateAuctionDialog(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildSortChip(String label, String value) {
    final isSelected = _sortBy == value;
    return FilterChip(
      label: Text(
        label,
        style: AppTypography.body2.copyWith(
          color: isSelected ? Colors.white : AppColors.textPrimary,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) => _onSortChanged(value),
      backgroundColor: AppColors.surface,
      selectedColor: AppColors.primary,
      checkmarkColor: Colors.white,
    );
  }

  Widget _buildActiveAuctionsTab() {
    return Consumer(
      builder: (context, ref, child) {
        final auctionsAsync = ref.watch(activeAuctionsProvider(filter: _currentFilter));
        
        return auctionsAsync.when(
          data: (auctions) {
            if (auctions.isEmpty) {
              return _buildEmptyState(
                'No hay subastas activas',
                'Las subastas aparecerán aquí cuando estén disponibles',
                Icons.gavel,
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(activeAuctionsProvider);
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: auctions.length,
                itemBuilder: (context, index) {
                  final auction = auctions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: AuctionTile(
                      auction: auction,
                      onTap: () => _navigateToAuctionDetail(auction),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildErrorState(error.toString()),
        );
      },
    );
  }

  Widget _buildWatchedAuctionsTab() {
    // TODO: Implementar con el usuario actual
    return Consumer(
      builder: (context, ref, child) {
        // Por ahora usamos un ID hardcodeado
        const userId = 'current_user_id';
        final auctionsAsync = ref.watch(watchedAuctionsProvider(userId));
        
        return auctionsAsync.when(
          data: (auctions) {
            if (auctions.isEmpty) {
              return _buildEmptyState(
                'No tienes subastas vigiladas',
                'Agrega subastas a tu lista de vigiladas para verlas aquí',
                Icons.favorite_border,
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(watchedAuctionsProvider);
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: auctions.length,
                itemBuilder: (context, index) {
                  final auction = auctions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: AuctionTile(
                      auction: auction,
                      onTap: () => _navigateToAuctionDetail(auction),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildErrorState(error.toString()),
        );
      },
    );
  }

  Widget _buildMyAuctionsTab() {
    // TODO: Implementar con el usuario actual
    return Consumer(
      builder: (context, ref, child) {
        // Por ahora usamos un ID hardcodeado
        const userId = 'current_user_id';
        final auctionsAsync = ref.watch(userAuctionsProvider(userId));
        
        return auctionsAsync.when(
          data: (auctions) {
            if (auctions.isEmpty) {
              return _buildEmptyState(
                'No tienes subastas',
                'Crea tu primera subasta para empezar a vender',
                Icons.store,
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(userAuctionsProvider);
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(AppSpacing.md),
                itemCount: auctions.length,
                itemBuilder: (context, index) {
                  final auction = auctions[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: AuctionTile(
                      auction: auction,
                      onTap: () => _navigateToAuctionDetail(auction),
                    ),
                  );
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => _buildErrorState(error.toString()),
        );
      },
    );
  }

  Widget _buildEmptyState(String title, String message, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: AppColors.textSecondary,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            title,
            style: AppTypography.h6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Error al cargar subastas',
            style: AppTypography.h6.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            error,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => const AuctionFilterDialog(),
    );
  }

  void _showCreateAuctionDialog() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CreateAuctionScreen(),
      ),
    );
  }

  void _navigateToAuctionDetail(Auction auction) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuctionDetailScreen(auction: auction),
      ),
    );
  }
}

class AuctionFilterDialog extends StatefulWidget {
  const AuctionFilterDialog({super.key});

  @override
  State<AuctionFilterDialog> createState() => _AuctionFilterDialogState();
}

class _AuctionFilterDialogState extends State<AuctionFilterDialog> {
  double _minPrice = 0;
  double _maxPrice = 1000;
  String _selectedRarity = 'all';
  String _selectedCondition = 'all';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Filtros',
        style: AppTypography.h5.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Rango de precios
          Text(
            'Rango de precios',
            style: AppTypography.body1.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          RangeSlider(
            values: RangeValues(_minPrice, _maxPrice),
            min: 0,
            max: 1000,
            divisions: 100,
            labels: RangeLabels(
              '\$${_minPrice.toInt()}',
              '\$${_maxPrice.toInt()}',
            ),
            onChanged: (values) {
              setState(() {
                _minPrice = values.start;
                _maxPrice = values.end;
              });
            },
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          // Rareza
          Text(
            'Rareza',
            style: AppTypography.body1.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropdownButtonFormField<String>(
            value: _selectedRarity,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'all', child: Text('Todas')),
              DropdownMenuItem(value: 'common', child: Text('Común')),
              DropdownMenuItem(value: 'uncommon', child: Text('Poco común')),
              DropdownMenuItem(value: 'rare', child: Text('Rara')),
              DropdownMenuItem(value: 'mythic', child: Text('Mítica')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedRarity = value!;
              });
            },
          ),
          
          const SizedBox(height: AppSpacing.md),
          
          // Condición
          Text(
            'Condición',
            style: AppTypography.body1.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropdownButtonFormField<String>(
            value: _selectedCondition,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'all', child: Text('Todas')),
              DropdownMenuItem(value: 'mint', child: Text('Mint')),
              DropdownMenuItem(value: 'near_mint', child: Text('Near Mint')),
              DropdownMenuItem(value: 'excellent', child: Text('Excelente')),
              DropdownMenuItem(value: 'good', child: Text('Buena')),
              DropdownMenuItem(value: 'light_played', child: Text('Ligeramente jugada')),
              DropdownMenuItem(value: 'played', child: Text('Jugada')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCondition = value!;
              });
            },
          ),
        ],
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
            // TODO: Aplicar filtros
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: Text(
            'Aplicar',
            style: AppTypography.body1.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
} 