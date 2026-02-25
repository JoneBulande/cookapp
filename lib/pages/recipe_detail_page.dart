import 'package:cookapp/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'recipes_page.dart' show RecipeModel;

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Hero com imagem
          _RecipeSliverAppBar(recipe: recipe),

          // ── Conteúdo
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.xxl),

                  // Título e tempo
                  Text(recipe.name, style: AppTextStyles.titleLarge),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${recipe.minutes} minutos de preparo',
                    style: AppTextStyles.bodySmall,
                  ),

                  const SizedBox(height: AppSpacing.xxl),
                  const _Divider(),
                  const SizedBox(height: AppSpacing.xxl),

                  // ── Ingredientes
                  Text('Ingredientes', style: AppTextStyles.titleMedium),
                  const SizedBox(height: AppSpacing.lg),
                  Wrap(
                    spacing: AppSpacing.sm,
                    runSpacing: AppSpacing.sm,
                    children: recipe.ingredients
                        .map((i) => _IngredientChip(i))
                        .toList(),
                  ),

                  const SizedBox(height: AppSpacing.xxl),
                  const _Divider(),
                  const SizedBox(height: AppSpacing.xxl),

                  // ── Modo de preparo
                  Text('Modo de preparo', style: AppTextStyles.titleMedium),
                  const SizedBox(height: AppSpacing.lg),

                  ...recipe.steps.asMap().entries.map(
                    (e) => _StepItem(number: e.key + 1, text: e.value),
                  ),

                  const SizedBox(height: AppSpacing.xxxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  SLIVER APP BAR COM IMAGEM HERO
// ─────────────────────────────────────────────
class _RecipeSliverAppBar extends StatelessWidget {
  const _RecipeSliverAppBar({required this.recipe});
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      pinned: true,
      backgroundColor: AppColors.background,
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(AppRadius.card),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 20,
              color: AppColors.black,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(AppRadius.bottomSheet),
            bottomRight: Radius.circular(AppRadius.bottomSheet),
          ),
          child: Image.network(
            recipe.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.grey100,
              child: const Icon(
                Icons.restaurant,
                size: 64,
                color: AppColors.grey300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CHIP DE INGREDIENTE
// ─────────────────────────────────────────────
class _IngredientChip extends StatelessWidget {
  const _IngredientChip(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.xs + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelMedium.copyWith(color: AppColors.primaryDark),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  ITEM DE PASSO
// ─────────────────────────────────────────────
class _StepItem extends StatelessWidget {
  const _StepItem({required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xl),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Número
          SizedBox(
            width: 28,
            child: Text(
              '$number',
              style: AppTextStyles.titleMedium.copyWith(
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          // Texto
          Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  DIVIDER
// ─────────────────────────────────────────────
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: AppColors.grey100);
  }
}
