import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/constants/app_spacing.dart';
import '../../shared/models/card.dart' as card_model;
import '../../core/services/hive_database_service.dart';

class SellItemScreen extends StatefulWidget {
  @override
  _SellItemScreenState createState() => _SellItemScreenState();
}

class _SellItemScreenState extends State<SellItemScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imagePicker = ImagePicker();
  final _database = HiveDatabaseService.instance;
  
  String _selectedCategory = 'Carta';
  String _selectedGame = 'Pokémon';
  String _selectedCondition = 'Nuevo';
  bool _isForSale = true;
  bool _isForTrade = false;
  File? _selectedImageFile;
  bool _isPublishing = false;

  final List<String> _categories = ['Carta', 'Mazo', 'Paquete', 'Accesorio', 'Merchandising'];
  final List<String> _games = ['Pokémon', 'Magic: The Gathering', 'Yu-Gi-Oh!', 'One Piece', 'Dragon Ball', 'Digimon', 'Gundam', 'Star Wars Unlimited'];
  final List<String> _conditions = ['Nuevo', 'Como nuevo', 'Excelente', 'Bueno', 'Regular', 'Malo'];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vender Item', style: AppTypography.h5.copyWith(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen del item
              _buildImageSection(),
              const SizedBox(height: AppSpacing.lg),
              
              // Categoría
              _buildDropdownField(
                label: 'Categoría',
                value: _selectedCategory,
                items: _categories,
                onChanged: (value) => setState(() => _selectedCategory = value!),
              ),
              
              // Juego (solo para cartas)
              if (_selectedCategory == 'Carta')
                _buildDropdownField(
                  label: 'Juego',
                  value: _selectedGame,
                  items: _games,
                  onChanged: (value) => setState(() => _selectedGame = value!),
                ),
              
              // Título
              _buildTextField(
                controller: _titleController,
                label: 'Título del item',
                hint: 'Ej: Charizard VMAX',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              
              // Descripción
              _buildTextField(
                controller: _descriptionController,
                label: 'Descripción',
                hint: 'Describe tu item...',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una descripción';
                  }
                  return null;
                },
              ),
              
              // Condición
              _buildDropdownField(
                label: 'Condición',
                value: _selectedCondition,
                items: _conditions,
                onChanged: (value) => setState(() => _selectedCondition = value!),
              ),
              
              // Precio
              _buildTextField(
                controller: _priceController,
                label: 'Precio (\$)',
                hint: '0.00',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un precio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingresa un precio válido';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: AppSpacing.md),
              
              // Opciones de venta
              _buildSaleOptions(),
              
              const SizedBox(height: AppSpacing.xl),
              
              // Botón de publicar
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isPublishing ? null : _publishItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isPublishing
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Publicando...',
                            style: AppTypography.labelLarge.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Publicar Item',
                        style: AppTypography.labelLarge.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Imagen del item',
          style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.grey300),
          ),
          child: _selectedImageFile != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedImageFile!,
                  fit: BoxFit.cover,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate,
                    size: 48,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Toca para agregar imagen',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _selectImage,
            icon: Icon(Icons.camera_alt),
            label: Text('Seleccionar imagen'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: BorderSide(color: AppColors.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.sm),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.grey300),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
      ],
    );
  }

  Widget _buildSaleOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Opciones de venta',
          style: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.sm),
        CheckboxListTile(
          title: Text('En venta'),
          value: _isForSale,
          onChanged: (value) => setState(() => _isForSale = value!),
          activeColor: AppColors.primary,
        ),
        CheckboxListTile(
          title: Text('Para intercambio'),
          value: _isForTrade,
          onChanged: (value) => setState(() => _isForTrade = value!),
          activeColor: AppColors.primary,
        ),
      ],
    );
  }

  void _selectImage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Seleccionar imagen',
          style: AppTypography.h6.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.primary),
              title: Text('Tomar foto'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: AppColors.primary),
              title: Text('Galería'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancelar',
              style: AppTypography.body1.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _selectedImageFile = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al seleccionar imagen: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<void> _publishItem() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isPublishing = true;
      });

      try {
        print('DEBUG: Starting to publish item...');
        
        // Convert game string to CardGame enum
        card_model.CardGame game;
        switch (_selectedGame) {
          case 'Pokémon':
            game = card_model.CardGame.pokemon;
            break;
          case 'Magic: The Gathering':
            game = card_model.CardGame.mtg;
            break;
          case 'Yu-Gi-Oh!':
            game = card_model.CardGame.yugioh;
            break;
          case 'One Piece':
            game = card_model.CardGame.onePiece;
            break;
          case 'Dragon Ball':
            game = card_model.CardGame.dragonBall;
            break;
          case 'Digimon':
            game = card_model.CardGame.digimon;
            break;
          case 'Gundam':
            game = card_model.CardGame.gundam;
            break;
          case 'Star Wars Unlimited':
            game = card_model.CardGame.starWarsUnlimited;
            break;
          default:
            game = card_model.CardGame.pokemon;
        }

        // Convert condition string to CardCondition enum
        card_model.CardCondition condition;
        switch (_selectedCondition) {
          case 'Nuevo':
            condition = card_model.CardCondition.mint;
            break;
          case 'Como nuevo':
            condition = card_model.CardCondition.nearMint;
            break;
          case 'Excelente':
            condition = card_model.CardCondition.excellent;
            break;
          case 'Bueno':
            condition = card_model.CardCondition.good;
            break;
          case 'Regular':
            condition = card_model.CardCondition.lightPlayed;
            break;
          case 'Malo':
            condition = card_model.CardCondition.poor;
            break;
          default:
            condition = card_model.CardCondition.nearMint;
        }

        // Create card object
        final card = card_model.Card(
          id: 'item_${DateTime.now().millisecondsSinceEpoch}',
          name: _titleController.text,
          game: game,
          imageUrl: _selectedImageFile?.path ?? '',
          setName: _selectedCategory,
          rarity: card_model.CardRarity.common, // Default rarity
          condition: condition,
          price: double.parse(_priceController.text),
          isForSale: _isForSale,
          isForTrade: _isForTrade,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        print('DEBUG: Created card with ID: ${card.id}');
        print('DEBUG: Card name: ${card.name}');
        print('DEBUG: Card game: ${card.game}');

        // Save to Hive database
        await _database.insertCard(card);
        print('DEBUG: Card saved to database');

        // Verify the card was saved
        final savedCard = await _database.getCardById(card.id);
        print('DEBUG: Retrieved card from database: ${savedCard?.name}');

        // Get all cards to verify
        final allCards = await _database.getAllCards();
        print('DEBUG: Total cards in database: ${allCards.length}');
        print('DEBUG: Cards with item_ prefix: ${allCards.where((c) => c.id.startsWith('item_')).length}');

        setState(() {
          _isPublishing = false;
        });

        // Show success dialog
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                '¡Item publicado!',
                style: AppTypography.h6.copyWith(fontWeight: FontWeight.bold),
              ),
              content: Text(
                'Tu item ha sido publicado exitosamente.',
                style: AppTypography.body1,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: AppTypography.body1.copyWith(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        print('DEBUG: Error publishing item: $e');
        setState(() {
          _isPublishing = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al publicar item: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}
