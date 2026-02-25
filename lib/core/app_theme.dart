import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  CORES
// ─────────────────────────────────────────────
class AppColors {
  AppColors._();

  // Primária
  static const Color primary = Color(0xFF2E7D32); // verde escuro
  static const Color primaryLight = Color(
    0xFFE8F5E9,
  ); // verde clarinho (chip selecionado)
  static const Color primaryDark = Color(0xFF1B5E20); // texto chip selecionado

  // Neutros
  static const Color black = Color(0xFF111111);
  static const Color grey900 = Color(0xFF222222);
  static const Color grey500 = Color(0xFF9E9E9E);
  static const Color grey300 = Color(0xFFD0D0D0);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color white = Color(0xFFFFFFFF);

  // Superfícies
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color bottomSheetBg = Color(0xFF1A1A1A);

  // Outros
  static const Color chipBorderDefault = Color(0xFFD0D0D0);
  static const Color recipeTimeBadge = Color(0xFF2E7D32);
}

// ─────────────────────────────────────────────
//  TIPOGRAFIA
// ─────────────────────────────────────────────
/// Dependência necessária no pubspec.yaml:
/// ```yaml
/// dependencies:
///   google_fonts: ^6.2.1
/// ```
///
/// Fonte utilizada: DM Sans (display) — moderna, limpa, ótima legibilidade.
/// Fallback: sans-serif do sistema.
class AppTextStyles {
  AppTextStyles._();

  // Display / Títulos grandes
  static const TextStyle displayBold = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 1.05,
    color: AppColors.black,
    letterSpacing: -1,
  );

  static const TextStyle displayRegular = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 38,
    fontWeight: FontWeight.w400,
    height: 1.1,
    color: AppColors.black,
    letterSpacing: -0.5,
  );

  // Título de seção
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.2,
    color: AppColors.black,
    letterSpacing: -0.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.black,
  );

  // Corpo
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.55,
    color: AppColors.grey900,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.grey500,
  );

  // Labels / chips
  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.grey900,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  // Botão
  static const TextStyle button = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    color: AppColors.white,
  );

  // Subtítulo / descrição
  static const TextStyle subtitle = TextStyle(
    fontFamily: 'DMSans',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.grey500,
  );
}

// ─────────────────────────────────────────────
//  ESPAÇAMENTOS
// ─────────────────────────────────────────────
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
}

// ─────────────────────────────────────────────
//  BORDER RADIUS
// ─────────────────────────────────────────────
class AppRadius {
  AppRadius._();

  static const double chip = 50;
  static const double card = 16;
  static const double button = 16;
  static const double bottomSheet = 24;
  static const double imageCard = 14;
}

// ─────────────────────────────────────────────
//  MAPA DE INGREDIENTES (nome → emoji)
//  Fonte da verdade única — usada em todas as telas.
// ─────────────────────────────────────────────
class AppIngredients {
  AppIngredients._();

  static const Map<String, String> emojiMap = {
    'Lanches': '🥪',
    'Queijo': '🧀',
    'Pepino': '🥒',
    'Abacate': '🥑',
    'Brócolis': '🥦',
    'Coco': '🥥',
    'Cenoura': '🥕',
    'Tomate': '🍅',
    'Mel': '🍯',
    'Morango': '🍓',
    'Melancia': '🍉',
    'Maça': '🍎',
    'Berinjela': '🍆',
    'Panqueca': '🥞',
    'Alho': '🧄',
    'Tangerina': '🍊',
    'Banana': '🍌',
    'Ovos': '🥚',
    'Bacon': '🥓',
    'Verduras': '🥬',
    'Massa': '🍝',
    'Batata': '🥔',
    'Milho': '🌽',
    'Kiwi': '🥝',
    'Carne': '🥩',
    'Cebola': '🧅',
  };

  /// Retorna o emoji do ingrediente, ou '' se não encontrado.
  static String emojiOf(String name) => emojiMap[name] ?? '';
}

// ─────────────────────────────────────────────
//  TEMA GLOBAL (ThemeData)
// ─────────────────────────────────────────────
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      surface: AppColors.surface,
    ),
    fontFamily: 'DMSans',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: AppColors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
        minimumSize: const Size(double.infinity, 54),
        textStyle: AppTextStyles.button,
      ),
    ),
  );
}
