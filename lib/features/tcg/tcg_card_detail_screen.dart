import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/models/card.dart';
import '../../shared/widgets/card_tile.dart';
import '../../shared/widgets/google_ads_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hive/hive.dart';

class TcgCardDetailScreen extends StatefulWidget {
  final Card card;
  final Widget? bottomNavBar;

  const TcgCardDetailScreen({
    super.key,
    required this.card,
    this.bottomNavBar,
  });

  @override
  State<TcgCardDetailScreen> createState() => _TcgCardDetailScreenState();
}

class _TcgCardDetailScreenState extends State<TcgCardDetailScreen>
    with TickerProviderStateMixin {
  late TabController _periodController;
  String _selectedPeriod = '1M';
  bool _isDescriptionExpanded = false;

  @override
  void initState() {
    super.initState();
    _periodController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _periodController.dispose();
    super.dispose();
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
          widget.card.name,
          style: AppTypography.h5.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Implementar favoritos
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Agregado a favoritos')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: AppColors.textPrimary),
            onPressed: () {
              // TODO: Implementar compartir
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Compartir carta')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Image and Basic Info
            _buildCardImageSection(),
            const SizedBox(height: 24),
            
            // Price and Action Section
            _buildPriceActionSection(),
            const SizedBox(height: 24),
            
            // Price History Chart
            Text(
              'Historial de precios',
              style: AppTypography.h5.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            _buildPeriodTabs(),
            const SizedBox(height: 8),
            _buildPriceChart(),
            const SizedBox(height: 8),
            _buildPriceStatsTable(),
            const SizedBox(height: 24),
            
            // Related Products
            Text(
              'Productos relacionados',
              style: AppTypography.h5.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            _buildRelatedProducts(),
            const SizedBox(height: 24),
            
            // Product Details
            Text(
              'Detalles del producto',
              style: AppTypography.h5.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            _buildProductDetailsTable(),
            const SizedBox(height: 24),
            
            // Description
            if (widget.card.description != null && widget.card.description!.isNotEmpty) ...[
              Text(
                'Descripción',
                style: AppTypography.h5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              _buildExpandableDescription(),
              const SizedBox(height: 18),
            ],
            
            // Recently Viewed
            Text(
              'Vistos recientemente',
              style: AppTypography.h5.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            _buildRecentlyViewed(),
            const SizedBox(height: 32),
            
            // Info Tags
            _buildInfoTagsStacked(),
            const SizedBox(height: 24),
            
            // Google Ads
            GoogleAdsWidget(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: widget.bottomNavBar,
    );
  }

  Widget _buildCardImageSection() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.surface,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          widget.card.imageUrl ?? 'https://via.placeholder.com/250x350/CCCCCC/FFFFFF?text=No+Image',
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
                color: AppColors.primary,
              ),
            );
          },
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

  Widget _buildPriceActionSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Precio actual',
                    style: AppTypography.body2.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${widget.card.price?.toStringAsFixed(2) ?? '0.00'} USD',
                    style: AppTypography.h4.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '+5.2%',
                  style: AppTypography.body2.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implementar compra/oferta
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Función de compra próximamente')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Comprar o Hacer Oferta',
                style: AppTypography.body1.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodTabs() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TabBar(
        controller: _periodController,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        indicatorColor: AppColors.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [
          Tab(text: '1M'),
          Tab(text: '3M'),
          Tab(text: '6M'),
          Tab(text: '1A'),
        ],
      ),
    );
  }

  Widget _buildPriceChart() {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            horizontalInterval: 1,
            verticalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: AppColors.grey300,
                strokeWidth: 1,
              );
            },
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: AppColors.grey300,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  Widget text;
                  switch (value.toInt()) {
                    case 0:
                      text = const Text('Ene', style: style);
                      break;
                    case 1:
                      text = const Text('Feb', style: style);
                      break;
                    case 2:
                      text = const Text('Mar', style: style);
                      break;
                    case 3:
                      text = const Text('Abr', style: style);
                      break;
                    case 4:
                      text = const Text('May', style: style);
                      break;
                    case 5:
                      text = const Text('Jun', style: style);
                      break;
                    default:
                      text = const Text('', style: style);
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: text,
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  const style = TextStyle(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  );
                  return Text('\$${value.toInt()}', style: style, textAlign: TextAlign.center);
                },
                reservedSize: 42,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: AppColors.grey300),
          ),
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: 6,
          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 3),
                FlSpot(1, 2),
                FlSpot(2, 5),
                FlSpot(3, 3.1),
                FlSpot(4, 4),
                FlSpot(5, 3),
              ],
              isCurved: true,
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withOpacity(0.5),
                ],
              ),
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.3),
                    AppColors.primary.withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: AppColors.surface,
              tooltipRoundedRadius: 8,
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  return LineTooltipItem(
                    '\$${barSpot.y.toStringAsFixed(2)}',
                    const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceStatsTable() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildStatRow('Precio más alto', '\$45.99', '+12.5%'),
          const Divider(color: AppColors.grey300),
          _buildStatRow('Precio más bajo', '\$28.50', '-8.2%'),
          const Divider(color: AppColors.grey300),
          _buildStatRow('Precio promedio', '\$35.25', '+2.1%'),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, String change) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.body2.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Row(
            children: [
              Text(
                value,
                style: AppTypography.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: change.startsWith('+') ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  change,
                  style: AppTypography.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: AppSpacing.sm),
            child: CardTile(
              card: widget.card, // Usar la misma carta como ejemplo
              onTap: () {
                // TODO: Navegar a otra carta
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductDetailsTable() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildDetailRow('Nombre', widget.card.name),
          const Divider(color: AppColors.grey300, height: 1),
          _buildDetailRow('Juego', _getGameDisplayName(widget.card.game)),
          const Divider(color: AppColors.grey300, height: 1),
          _buildDetailRow('Set', widget.card.setName ?? 'N/A'),
          const Divider(color: AppColors.grey300, height: 1),
          _buildDetailRow('Rareza', _getRarityDisplayName(widget.card.rarity)),
          const Divider(color: AppColors.grey300, height: 1),
          if (widget.card.type != null)
            _buildDetailRow('Tipo', widget.card.type!),
          if (widget.card.attribute != null) ...[
            const Divider(color: AppColors.grey300, height: 1),
            _buildDetailRow('Atributo', widget.card.attribute!),
          ],
          if (widget.card.level != null) ...[
            const Divider(color: AppColors.grey300, height: 1),
            _buildDetailRow('Nivel', widget.card.level.toString()),
          ],
          if (widget.card.atk != null) ...[
            const Divider(color: AppColors.grey300, height: 1),
            _buildDetailRow('ATK', widget.card.atk.toString()),
          ],
          if (widget.card.def != null) ...[
            const Divider(color: AppColors.grey300, height: 1),
            _buildDetailRow('DEF', widget.card.def.toString()),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
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

  Widget _buildExpandableDescription() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              widget.card.description ?? 'Sin descripción disponible.',
              style: AppTypography.body1.copyWith(
                color: AppColors.textPrimary,
              ),
              maxLines: _isDescriptionExpanded ? null : 3,
              overflow: _isDescriptionExpanded ? null : TextOverflow.ellipsis,
            ),
          ),
          if ((widget.card.description?.length ?? 0) > 100)
            TextButton(
              onPressed: () {
                setState(() {
                  _isDescriptionExpanded = !_isDescriptionExpanded;
                });
              },
              child: Text(
                _isDescriptionExpanded ? 'Ver menos' : 'Ver más',
                style: AppTypography.body2.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewed() {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: AppSpacing.sm),
            child: CardTile(
              card: widget.card, // Usar la misma carta como ejemplo
              onTap: () {
                // TODO: Navegar a otra carta
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoTagsStacked() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildInfoTag('Envío gratis', Icons.local_shipping),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildInfoTag('Garantía', Icons.verified),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _buildInfoTag('Devolución', Icons.undo),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _buildInfoTag('Seguro', Icons.security),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoTag(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: AppTypography.caption.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  String _getGameDisplayName(CardGame game) {
    switch (game) {
      case CardGame.pokemon:
        return 'Pokémon';
      case CardGame.yugioh:
        return 'Yu-Gi-Oh!';
      case CardGame.mtg:
        return 'Magic: The Gathering';
      case CardGame.onePiece:
        return 'One Piece';
      case CardGame.dragonBall:
        return 'Dragon Ball Super';
      case CardGame.digimon:
        return 'Digimon';
      case CardGame.gundam:
        return 'Gundam';
      case CardGame.starWars:
        return 'Star Wars';
      case CardGame.starWarsUnlimited:
        return 'Star Wars Unlimited';
      default:
        return 'Desconocido';
    }
  }

  String _getRarityDisplayName(CardRarity rarity) {
    switch (rarity) {
      case CardRarity.common:
        return 'Común';
      case CardRarity.uncommon:
        return 'Poco común';
      case CardRarity.rare:
        return 'Rara';
      case CardRarity.rareHolo:
        return 'Rara Holográfica';
      case CardRarity.ultraRare:
        return 'Ultra Rara';
      case CardRarity.secretRare:
        return 'Secreta Rara';
      case CardRarity.mythic:
        return 'Mítica';
      default:
        return 'Desconocida';
    }
  }
} 