import 'package:cookapp/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'recipe_detail_page.dart';

// ─────────────────────────────────────────────
//  MODELO SIMPLES (substitua pelo seu model real)
// ─────────────────────────────────────────────
class RecipeModel {
  const RecipeModel({
    required this.id,
    required this.name,
    required this.minutes,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
  });

  final int id;
  final String name;
  final int minutes;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
}

// Dados mock — substitua por chamada de API / banco de dados.
final _kMockRecipes = [
  RecipeModel(
    id: 1,
    name: 'Macarrão ao alho e óleo',
    minutes: 30,
    imageUrl:
        'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=400',
    ingredients: ['Massa', 'Alho', 'Tomate'],
    steps: [
      'Amasse bem o alho juntamente com o sal, formando uma pasta.',
      'Em uma frigideira, coloque o alho amassado e o óleo.',
      'Frite em fogo médio sem deixar o alho queimar, só dourar.',
      'Acrescente a manteiga e deixe ferver um pouco, só para incorporar bem o sabor, mexendo sempre.',
      'Coloque sobre o macarrão imediatamente.',
    ],
  ),
  RecipeModel(
    id: 2,
    name: 'Salada caprese',
    minutes: 10,
    imageUrl:
        'https://images.unsplash.com/photo-1592417817098-8fd3d9eb14a5?w=400',
    ingredients: ['Tomate', 'Queijo'],
    steps: [
      'Fatie os tomates e a mozzarella em rodelas.',
      'Intercale as fatias em um prato.',
      'Regue com azeite e tempere com sal e pimenta.',
      'Finalize com folhas de manjericão fresco.',
    ],
  ),
  RecipeModel(
    id: 3,
    name: 'Suco verde detox',
    minutes: 5,
    imageUrl:
        'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=400',
    ingredients: ['Pepino', 'Abacate'],
    steps: [
      'Corte pepino e abacate em pedaços.',
      'Bata no liquidificador com água gelada.',
      'Adicione limão a gosto.',
      'Sirva imediatamente.',
    ],
  ),
  RecipeModel(
    id: 4,
    name: 'Smoothie de banana',
    minutes: 5,
    imageUrl: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=400',
    ingredients: ['Banana', 'Mel'],
    steps: [
      'Congele as bananas por pelo menos 2 horas.',
      'Bata no liquidificador com leite.',
      'Adicione mel a gosto.',
      'Sirva gelado.',
    ],
  ),
  RecipeModel(
    id: 5,
    name: 'Omelete de queijo',
    minutes: 10,
    imageUrl:
        'https://images.unsplash.com/photo-1510693206972-df098062cb71?w=400',
    ingredients: ['Ovos', 'Queijo'],
    steps: [
      'Bata os ovos com sal e pimenta.',
      'Derreta manteiga em frigideira antiaderente.',
      'Despeje os ovos e cozinhe em fogo baixo.',
      'Adicione queijo ralado e dobre ao meio.',
      'Sirva imediatamente.',
    ],
  ),
  RecipeModel(
    id: 6,
    name: 'Cenoura assada com mel',
    minutes: 25,
    imageUrl:
        'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=400',
    ingredients: ['Cenoura', 'Mel'],
    steps: [
      'Pré-aqueça o forno a 200°C.',
      'Corte as cenouras em tiras.',
      'Misture com azeite, mel e sal.',
      'Asse por 20 minutos ou até dourar.',
    ],
  ),
];

// ─────────────────────────────────────────────
//  TELA
// ─────────────────────────────────────────────
class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key, required this.ingredients});

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    // Filtra receitas que contenham pelo menos 1 ingrediente selecionado
    final recipes = _kMockRecipes
        .where((r) => r.ingredients.any((i) => ingredients.contains(i)))
        .toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xxl),

              // ── AppBar manual
              Row(
                children: [
                  _BackButton(onTap: () => Navigator.of(context).pop()),
                  const SizedBox(width: AppSpacing.lg),
                  Text('Ingredientes', style: AppTextStyles.titleLarge),
                ],
              ),

              const SizedBox(height: AppSpacing.lg),

              // ── Chips dos ingredientes selecionados
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: ingredients.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (_, i) => _IngredientPill(ingredients[i]),
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // ── Grid de receitas
              Expanded(
                child: recipes.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhuma receita encontrada\npara esses ingredientes 😕',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subtitle,
                        ),
                      )
                    : GridView.builder(
                        itemCount: recipes.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.88,
                            ),
                        itemBuilder: (_, i) => _RecipeCard(
                          recipe: recipes[i],
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) =>
                                  RecipeDetailPage(recipe: recipes[i]),
                            ),
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
}

// ─────────────────────────────────────────────
//  WIDGETS LOCAIS
// ─────────────────────────────────────────────
class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: AppColors.grey100,
          borderRadius: BorderRadius.circular(AppRadius.card),
        ),
        child: const Icon(Icons.arrow_back, size: 20, color: AppColors.black),
      ),
    );
  }
}

class _IngredientPill extends StatelessWidget {
  const _IngredientPill(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    final emoji = AppIngredients.emojiOf(label);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (emoji.isNotEmpty) ...[
            Text(emoji, style: const TextStyle(fontSize: 13)),
            const SizedBox(width: AppSpacing.xs),
          ],
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: AppColors.primaryDark,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.recipe, required this.onTap});

  final RecipeModel recipe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.imageCard),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagem de fundo
            Image.network(
              recipe.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.grey100,
                child: const Icon(Icons.restaurant, color: AppColors.grey300),
              ),
            ),

            // Gradiente inferior
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.65),
                    ],
                    stops: const [0.45, 1.0],
                  ),
                ),
              ),
            ),

            // Texto e badge
            Positioned(
              left: AppSpacing.md,
              right: AppSpacing.md,
              bottom: AppSpacing.md,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    recipe.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.white,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  _TimeBadge(recipe.minutes),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeBadge extends StatelessWidget {
  const _TimeBadge(this.minutes);
  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: AppColors.recipeTimeBadge,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Text(
        '$minutes minutos',
        style: AppTextStyles.labelSmall.copyWith(fontSize: 11),
      ),
    );
  }
}
