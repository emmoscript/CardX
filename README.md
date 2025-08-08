# CardX 🃏

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Hive-FF6B35?style=for-the-badge&logo=flutter&logoColor=white" alt="Hive">
  <img src="https://img.shields.io/badge/Riverpod-0066FF?style=for-the-badge" alt="Riverpod">
</div>

<div align="center">
  <h3>La plataforma definitiva para el trading de cartas coleccionables</h3>
  <p>Marketplace completo desarrollado en Flutter para Pokémon, Yu-Gi-Oh!, Magic y más</p>
</div>

---

## 📱 Capturas de Pantalla

> *Añade capturas de pantalla aquí para mostrar la UI de tu aplicación*

---

## 🚀 Características Principales

### 🔐 **Autenticación Completa**
- Sistema de registro y login seguro
- Persistencia local con Hive
- Perfil personalizable con estadísticas

### 🏠 **Home Screen Interactivo**
- Hero sections con sliders animados
- Categorías de TCG (Pokémon, Yu-Gi-Oh!, Magic, One Piece)
- Últimos singles y actualizaciones de precios
- Subastas destacadas con Google Ads integrado

### 🔍 **Búsqueda y Catálogo**
- Filtros avanzados por TCG
- Grid 2x2 con CardTile optimizado
- Integración con APIs reales
- Navegación fluida a detalles

### 📊 **Análisis de Precios**
- Historial de precios con gráficos interactivos
- Estadísticas completas (máximo, mínimo, promedio)
- Sistema de tracking de precios

### 🔨 **Sistema de Subastas**
- Creación y gestión de subastas
- Sistema de pujas en tiempo real
- Filtros por precio, rareza y condición
- Estadísticas del vendedor

### ⭐ **Favoritos Personalizados**
- Listas personalizadas
- Integración con perfil de usuario
- Call-to-action para estados vacíos

---

## 🏗️ Arquitectura

```
CardX/
├── lib/
│   ├── core/
│   │   ├── constants/
│   │   ├── theme/
│   │   └── utils/
│   ├── data/
│   │   ├── database/
│   │   ├── models/
│   │   └── services/
│   ├── providers/
│   ├── screens/
│   └── widgets/
├── assets/
└── test/
```

### 🧠 State Management
- **Riverpod** para gestión de estado global
- **ChangeNotifier** para AuthService
- **Providers** para servicios de datos

### 💾 Persistencia
- **Hive** para base de datos local y configuración
- **Cached Network Image** para optimización de imágenes

---

## 🔌 APIs Integradas

| TCG | API | Características |
|-----|-----|----------------|
| **Pokémon** | Pokémon TCG API | Cartas populares, búsqueda avanzada |
| **Yu-Gi-Oh!** | YGOPRODeck v7 | Cartas con precios actualizados |
| **Star Wars** | Scryfall API | Unlimited cards |

---

## 🗄️ Base de Datos

```dart
// Estructura con Hive
@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)  
  String? email;
  @HiveField(2)
  String? displayName;
  // ...
}

@HiveType(typeId: 1)
class Card extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? game;
  // ...
}

@HiveType(typeId: 2)
class Auction extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  double? currentPrice;
  // ...
}
```

---

## 🚀 Instalación

### Prerrequisitos
- Flutter SDK >= 3.0.0
- Dart SDK >= 2.17.0
- Android Studio / VS Code

### Pasos

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/cardx.git
   cd cardx
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Generar código (si es necesario)**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

---

## 📦 Dependencias Principales

```yaml
dependencies:
  flutter_riverpod: ^2.4.0    # State management
  hive: ^2.2.3                # Base de datos local
  hive_flutter: ^1.1.0
  fl_chart: ^0.65.0           # Gráficos interactivos
  cached_network_image: ^3.3.0 # Optimización de imágenes
  http: ^1.1.0                # Llamadas HTTP
  google_mobile_ads: ^4.0.0   # Publicidad
```

---

## 📱 Pantallas

| Pantalla | Descripción |
|----------|-------------|
| `AuthScreen` | Sistema de login/registro |
| `HomeScreen` | Pantalla principal con sliders |
| `SearchScreen` | Búsqueda avanzada de cartas |
| `AuctionsScreen` | Gestión de subastas |
| `TcgCardDetailScreen` | Detalle completo de carta |
| `FavoritesScreen` | Listas de favoritos |
| `ProfileScreen` | Perfil y configuración |

---

## ✅ Estado del Proyecto

### Completado
- [x] Sistema de autenticación completo
- [x] Navegación fluida con Bottom Navigation
- [x] Home screen con sliders animados
- [x] Búsqueda y catálogo de cartas
- [x] Sistema de subastas funcional
- [x] Gestión de favoritos
- [x] Perfil de usuario completo
- [x] Base de datos local
- [x] Integración con múltiples APIs
- [x] UI consistente y responsive

### En Desarrollo
- [ ] Sistema de pagos con Stripe
- [ ] Notificaciones push
- [ ] Chat entre usuarios
- [ ] Analytics avanzados

### Roadmap
- [ ] Modo oscuro
- [ ] Exportación de datos
- [ ] Sistema de reputación
- [ ] Compartir listas de favoritos

---

## 🎨 Características de Diseño

- **Material Design 3** con tema personalizado
- **Animaciones fluidas** en transiciones
- **Gráficos interactivos** para análisis de precios
- **Responsive design** para múltiples dispositivos
- **Loading states** optimizados
- **Gradientes** y efectos visuales modernos

---

## 🤝 Contribuir

1. Fork el proyecto
2. Crea tu rama (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

---

<div align="center">
  <p>⭐ Si te gusta este proyecto, ¡dale una estrella en GitHub! ⭐</p>
</div>
