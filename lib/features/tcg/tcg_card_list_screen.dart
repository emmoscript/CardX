import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/services/pokemon_tcg_api_service.dart';
import '../../core/services/yugioh_api_service.dart';
import '../../core/services/tcg_api_service.dart';
import '../../core/services/star_wars_unlimited_api_service.dart';
import '../../core/services/pokemon_tcg_card_converter.dart';
import '../../core/services/yugioh_card_converter.dart';
import '../../core/services/tcg_card_converter.dart';
import '../../core/services/star_wars_unlimited_card_converter.dart';
import '../../shared/models/card.dart' as card_model;
import '../../shared/widgets/card_tile.dart';
import 'tcg_card_detail_screen.dart';

class TcgCardListScreen extends StatefulWidget {
  final String tcgName;
  final Color tcgColor;
  final String tcgImage;
  final VoidCallback? onBack;

  const TcgCardListScreen({
    required this.tcgName,
    required this.tcgColor,
    required this.tcgImage,
    this.onBack,
    Key? key,
  }) : super(key: key);

  @override
  State<TcgCardListScreen> createState() => _TcgCardListScreenState();
}

class _TcgCardListScreenState extends State<TcgCardListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<card_model.Card> _cards = [];
  List<card_model.Card> _filteredCards = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchCards();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCards() async {
    setState(() => _isLoading = true);
    
    try {
      List<card_model.Card> cards = [];
      
      switch (widget.tcgName) {
        case 'Pokémon':
          final pokemonService = PokemonTcgApiService();
          final apiCards = await pokemonService.getPopularCards();
          cards = PokemonTcgCardConverter.fromApiDataList(apiCards.take(6).toList());
          break;
          
        case 'Yu-Gi-Oh!':
          final yugiohService = YugiohApiService();
          final apiCards = await yugiohService.getPopularCards();
          cards = YugiohCardConverter.fromApiDataList(apiCards.take(6).toList());
          break;
          
        case 'Magic':
          final tcgService = TcgApiService();
          final apiCards = await tcgService.getPopularCards(TcgGame.magic);
          cards = TcgCardConverter.fromApiDataList(apiCards.take(6).toList(), card_model.CardGame.mtg);
          break;
          
        case 'One Piece':
          final tcgService = TcgApiService();
          final apiCards = await tcgService.getPopularCards(TcgGame.onePiece);
          cards = TcgCardConverter.fromApiDataList(apiCards.take(6).toList(), card_model.CardGame.pokemon); // Using pokemon as placeholder
          break;
          
        case 'Dragon Ball Super':
          final tcgService = TcgApiService();
          final apiCards = await tcgService.getPopularCards(TcgGame.dragonBall);
          cards = TcgCardConverter.fromApiDataList(apiCards.take(6).toList(), card_model.CardGame.pokemon); // Using pokemon as placeholder
          break;
          
        case 'Gundam':
          final tcgService = TcgApiService();
          final apiCards = await tcgService.getPopularCards(TcgGame.gundam);
          cards = TcgCardConverter.fromApiDataList(apiCards.take(6).toList(), card_model.CardGame.pokemon); // Using pokemon as placeholder
          break;
          
        case 'Star Wars Unlimited':
          final starWarsService = StarWarsUnlimitedApiService();
          final apiCards = await starWarsService.getPopularCards();
          cards = StarWarsUnlimitedCardConverter.fromApiDataList(apiCards.take(6).toList());
          break;
          
        default:
          cards = [];
      }
      
      setState(() {
        _cards = cards;
        _filteredCards = cards;
        _isLoading = false;
      });
      
    } catch (e) {
      print('Error fetching cards for ${widget.tcgName}: $e');
      setState(() {
        _cards = _getFallbackCards();
        _filteredCards = _cards;
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
      if (value.isEmpty) {
        _filteredCards = _cards;
      } else {
        _filteredCards = _cards.where((card) =>
          card.name.toLowerCase().contains(value.toLowerCase()) ||
          (card.setName?.toLowerCase().contains(value.toLowerCase()) ?? false)
        ).toList();
      }
    });
  }

  List<card_model.Card> _getFallbackCards() {
    final now = DateTime.now();
    return List.generate(6, (index) => card_model.Card(
      id: 'fallback-$index',
      name: 'Carta de ejemplo ${index + 1}',
      game: card_model.CardGame.pokemon,
      imageUrl: 'https://via.placeholder.com/250x350/CCCCCC/FFFFFF?text=${widget.tcgName}+${index + 1}',
      setName: 'Set de ejemplo',
      rarity: card_model.CardRarity.common,
      price: 9.99 + (index * 2.0),
      isForSale: true,
      isForTrade: true,
      createdAt: now,
      updatedAt: now,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.tcgColor,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Image.asset(widget.tcgImage, height: 32),
        leading: widget.onBack != null
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: widget.onBack,
              )
            : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Buscar carta en ${widget.tcgName}...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredCards.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isEmpty 
                                ? 'No se encontraron cartas de ${widget.tcgName}'
                                : 'No se encontraron cartas que coincidan con "$_searchQuery"',
                              style: AppTypography.bodyMedium.copyWith(color: Colors.grey[600]),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.57,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 12,
                        ),
                        itemCount: _filteredCards.length > 6 ? 6 : _filteredCards.length,
                        itemBuilder: (context, index) {
                          final card = _filteredCards[index];
                          return CardTile(
                            card: card,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TcgCardDetailScreen(card: card),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
} 