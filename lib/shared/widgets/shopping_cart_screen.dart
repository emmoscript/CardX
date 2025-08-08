import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../models/card.dart' as card_model;

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  List<Map<String, dynamic>> _cartItems = [
    {
      'card': card_model.Card(
        id: 'cart-1',
        name: 'Blue-Eyes White Dragon',
        game: card_model.CardGame.yugioh,
        imageUrl: 'https://images.ygoprodeck.com/images/cards/89631139.jpg',
        price: 25.99,
        isForSale: true,
        isForTrade: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      'quantity': 1,
    },
    {
      'card': card_model.Card(
        id: 'cart-2',
        name: 'Charizard',
        game: card_model.CardGame.pokemon,
        imageUrl: 'https://images.pokemontcg.io/base1/4.png',
        price: 299.99,
        isForSale: true,
        isForTrade: false,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      'quantity': 1,
    },
  ];

  double get _totalPrice {
    return _cartItems.fold(0.0, (sum, item) {
      return sum + (item['card'].price * item['quantity']);
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
          'Carrito de Compras',
          style: AppTypography.h5.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline, color: AppColors.sellRed),
            onPressed: _clearCart,
          ),
        ],
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(AppSpacing.md),
                    itemCount: _cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartItems[index];
                      final card = item['card'] as card_model.Card;
                      final quantity = item['quantity'] as int;
                      
                      return Card(
                        margin: EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              card.imageUrl ?? '',
                              width: 60,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 60,
                                height: 80,
                                color: AppColors.grey100,
                                child: Icon(Icons.image, color: AppColors.grey400),
                              ),
                            ),
                          ),
                          title: Text(
                            card.name,
                            style: AppTypography.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '\$${card.price?.toStringAsFixed(2)}',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.buyGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle_outline),
                                onPressed: () => _updateQuantity(index, quantity - 1),
                              ),
                              Text(
                                '$quantity',
                                style: AppTypography.bodyMedium,
                              ),
                              IconButton(
                                icon: Icon(Icons.add_circle_outline),
                                onPressed: () => _updateQuantity(index, quantity + 1),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: AppColors.sellRed),
                                onPressed: () => _removeItem(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _buildCheckoutSection(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: AppColors.grey400,
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            'Tu carrito está vacío',
            style: AppTypography.h5.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          Text(
            'Agrega algunos productos para comenzar',
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: AppSpacing.lg),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
            ),
            child: Text(
              'Explorar Productos',
              style: AppTypography.bodyMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection() {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: AppTypography.h5.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${_totalPrice.toStringAsFixed(2)}',
                style: AppTypography.h5.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.buyGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _checkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buyGreen,
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Proceder al Pago',
                style: AppTypography.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity > 0) {
      setState(() {
        _cartItems[index]['quantity'] = newQuantity;
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _cartItems.removeAt(index);
    });
  }

  void _clearCart() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Vaciar Carrito'),
        content: Text('¿Estás seguro de que quieres vaciar el carrito?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _cartItems.clear();
              });
              Navigator.pop(context);
            },
            child: Text('Vaciar', style: TextStyle(color: AppColors.sellRed)),
          ),
        ],
      ),
    );
  }

  void _checkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Procesando Pago'),
        content: Text('Redirigiendo a la pasarela de pagos...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

