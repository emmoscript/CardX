import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../features/tcg/tcg_card_list_screen.dart';
import 'search_screen.dart';
import '../../features/home/home_screen.dart';

class TcgCategorySlider extends StatelessWidget {
  final List<_TcgCategory> categories = const [
    _TcgCategory(
      name: 'Pokémon',
      color: Color(0xFFFFDE4A),
      image: 'assets/images/pokemon_logo.png',
    ),
    _TcgCategory(
      name: 'One Piece',
      color: Color(0xFF1E90FF),
      image: 'assets/images/onepiece_logo.png',
    ),
    _TcgCategory(
      name: 'Magic',
      color: Color(0xFFB97A56),
      image: 'assets/images/magic_logo.png',
    ),
    _TcgCategory(
      name: 'Yu-Gi-Oh!',
      color: Color(0xFFB22222),
      image: 'assets/images/yugioh_logo.png',
    ),
    _TcgCategory(
      name: 'Dragon Ball Super',
      color: Color(0xFFFF6B35),
      image: 'assets/images/dbs_logo.png',
    ),
    _TcgCategory(
      name: 'Gundam',
      color: Color(0xFF1A1A1A),
      image: 'assets/images/gundam_logo.png',
    ),
    _TcgCategory(
      name: 'Star Wars Unlimited',
      color: Color(0xFFF4D03F),
      image: 'assets/images/starwarsunlimited_logo.png',
    ),
    _TcgCategory(
      name: 'Ver todos',
      color: AppColors.grey200,
      image: '',
      isAll: true,
    ),
  ];

  final VoidCallback onSeeAll;
  final void Function(String, Color, String) onSeeTcgGrid;

  const TcgCategorySlider({Key? key, required this.onSeeAll, required this.onSeeTcgGrid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text('Explora tu TCG favorito', style: AppTypography.h4.copyWith(fontWeight: FontWeight.bold)),
              Spacer(),
              TextButton(
                onPressed: onSeeAll,
                child: Text('Ver todos', style: AppTypography.labelLarge.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 16),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return GestureDetector(
                onTap: () {
                  if (!cat.isAll) {
                    final info = getTcgInfo(cat.name);
                    onSeeTcgGrid(info.name, info.color, info.image);
                  }
                },
                child: Container(
                  width: 160,
                  height: 64,
                  decoration: BoxDecoration(
                    color: cat.color.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: cat.color.withOpacity(0.3)),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Center(
                    child: !cat.isAll
                      ? Image.asset(
                          cat.image,
                          height: 48,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => Icon(Icons.image, size: 40, color: cat.color),
                        )
                      : Icon(Icons.grid_view, size: 40, color: AppColors.grey600),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TcgCategory {
  final String name;
  final Color color;
  final String image;
  final bool isAll;
  const _TcgCategory({required this.name, required this.color, required this.image, this.isAll = false});
} 