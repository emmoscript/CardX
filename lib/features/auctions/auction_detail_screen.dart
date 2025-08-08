import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/models/auction.dart';
import '../../shared/widgets/google_ads_widget.dart';
import '../../core/services/auction_service.dart';
import 'package:hive/hive.dart';

class AuctionDetailScreen extends ConsumerStatefulWidget {
  final Auction auction;

  const AuctionDetailScreen({
    super.key,
    required this.auction,
  });

  @override
  ConsumerState<AuctionDetailScreen> createState() => _AuctionDetailScreenState();
}

class _AuctionDetailScreenState extends ConsumerState<AuctionDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _bidController = TextEditingController();
  bool _isWatching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _checkWatchStatus();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bidController.dispose();
    super.dispose();
  }

  Future<void> _checkWatchStatus() async {
    // TODO: Implementar verificación de estado de vigilancia
    setState(() {
      _isWatching = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.auction.title,
          style: AppTypography.h5.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isWatching ? Icons.favorite : Icons.favorite_border,
              color: _isWatching ? Colors.red : AppColors.textPrimary,
            ),
            onPressed: _toggleWatch,
          ),
          IconButton(
            icon: Icon(Icons.share, color: AppColors.textPrimary),
            onPressed: _shareAuction,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Auction Image
            _buildAuctionImage(),
            const SizedBox(height: 24),
            
            // Auction Info
            _buildAuctionInfo(),
            const SizedBox(height: 24),
            
            // Tabs
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: 'Detalles'),
                  Tab(text: 'Pujas'),
                  Tab(text: 'Vendedor'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            
            // Tab Content
            SizedBox(
              height: 400,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildDetailsTab(),
                  _buildBidsTab(),
                  _buildSellerTab(),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Google Ads
            GoogleAdsWidget(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomActionBar(),
    );
  }

  Widget _buildAuctionImage() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.surface,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
                      widget.auction.imageUrl ?? '',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppColors.surface,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48, color: AppColors.textSecondary),
                    const SizedBox(height: 8),
                    Text(
                      'Error al cargar imagen',
                      style: AppTypography.body2.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAuctionInfo() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Puja actual',
                      style: AppTypography.body2.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${widget.auction.currentPrice.toStringAsFixed(2)} USD',
                      style: AppTypography.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: widget.auction.isActive ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.auction.isActive ? 'Activa' : 'Finalizada',
                  style: AppTypography.body2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                widget.auction.timeRemainingText,
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.gavel, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(
                '${widget.auction.bidCount} pujas',
                style: AppTypography.body2.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Descripción',
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.auction.description,
            style: AppTypography.body1.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Detalles del producto',
            style: AppTypography.h6.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          _buildDetailRow('Condición', widget.auction.condition ?? 'N/A'),
          _buildDetailRow('Rareza', widget.auction.rarity ?? 'N/A'),
          _buildDetailRow('Set', widget.auction.setName ?? 'N/A'),
          _buildDetailRow('TCG', widget.auction.tcg),
        ],
      ),
    );
  }

  Widget _buildBidsTab() {
    return Consumer(
      builder: (context, ref, child) {
        // TODO: Implementar provider de pujas
        // final bidsAsync = ref.watch(auctionBidsProvider(widget.auction.id));
        
        // Mock data por ahora
        final bids = widget.auction.bids ?? [];
        
        if (bids.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.gavel_outlined, size: 48, color: AppColors.textSecondary),
                const SizedBox(height: 8),
                Text(
                  'No hay pujas aún',
                  style: AppTypography.body1.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }
        
        return ListView.builder(
          itemCount: bids.length,
          itemBuilder: (context, index) {
            final bid = bids[index];
            return Container(
              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bid.bidderName ?? 'Anónimo',
                        style: AppTypography.body1.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        bid.timestamp.toString(),
                        style: AppTypography.caption.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$${bid.amount.toStringAsFixed(2)}',
                    style: AppTypography.body1.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSellerTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primary,
              child: Text(
                (widget.auction.sellerName ?? 'U')[0].toUpperCase(),
                style: AppTypography.h6.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.auction.sellerName ?? 'Usuario',
                    style: AppTypography.h6.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'Miembro desde ${widget.auction.sellerJoinDate?.year ?? DateTime.now().year}',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildSellerStat('Ventas', '127'),
            const SizedBox(width: AppSpacing.md),
            _buildSellerStat('Calificación', '4.8★'),
            const SizedBox(width: AppSpacing.md),
            _buildSellerStat('Tiempo', '2-3 días'),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _contactSeller,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Contactar vendedor',
            style: AppTypography.body1.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: AppTypography.body1.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerStat(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.body1.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionBar() {
    if (!widget.auction.isActive) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(color: AppColors.grey300),
          ),
        ),
        child: Text(
          'Subasta finalizada',
          style: AppTypography.body1.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.grey300),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _bidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Tu puja',
                prefixText: '\$',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.sm,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          ElevatedButton(
            onPressed: _placeBid,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Pujar',
              style: AppTypography.body1.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleWatch() {
    setState(() {
      _isWatching = !_isWatching;
    });
    
    // TODO: Implementar toggle de vigilancia
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isWatching ? 'Agregado a vigilados' : 'Removido de vigilados'),
      ),
    );
  }

  void _shareAuction() {
    // TODO: Implementar compartir subasta
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Compartir subasta')),
    );
  }

  void _placeBid() {
    final bidAmount = double.tryParse(_bidController.text);
    if (bidAmount == null || bidAmount <= widget.auction.currentPrice) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('La puja debe ser mayor al precio actual'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Implementar puja real
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Puja de \$${bidAmount.toStringAsFixed(2)} realizada'),
      ),
    );
    _bidController.clear();
  }

  void _contactSeller() {
    // TODO: Implementar contacto con vendedor
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Función de contacto próximamente')),
    );
  }
} 