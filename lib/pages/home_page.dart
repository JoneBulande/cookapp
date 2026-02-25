import 'package:cookapp/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'recipes_page.dart';

// ─────────────────────────────────────────────
//  DADOS
// ─────────────────────────────────────────────
class _Product {
  const _Product(this.emoji, this.name);
  final String emoji;
  final String name;
}

const _kProducts = [
  _Product('🥪', 'Lanches'),
  _Product('🧀', 'Queijo'),
  _Product('🥒', 'Pepino'),
  _Product('🥑', 'Abacate'),
  _Product('🥦', 'Brócolis'),
  _Product('🥥', 'Coco'),
  _Product('🥕', 'Cenoura'),
  _Product('🍅', 'Tomate'),
  _Product('🍯', 'Mel'),
  _Product('🍓', 'Morango'),
  _Product('🍉', 'Melancia'),
  _Product('🍎', 'Maça'),
  _Product('🍆', 'Berinjela'),
  _Product('🥞', 'Panqueca'),
  _Product('🧄', 'Alho'),
  _Product('🍊', 'Tangerina'),
  _Product('🍌', 'Banana'),
  _Product('🥚', 'Ovos'),
  _Product('🥓', 'Bacon'),
  _Product('🥬', 'Verduras'),
  _Product('🍝', 'Massa'),
  _Product('🥔', 'Batata'),
  _Product('🌽', 'Milho'),
  _Product('🥝', 'Kiwi'),
  _Product('🥩', 'Carne'),
  _Product('🧅', 'Cebola'),
];

// ─────────────────────────────────────────────
//  TELA
// ─────────────────────────────────────────────
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Set<String> _selected = {};

  void _toggle(String name) {
    setState(() {
      _selected.contains(name) ? _selected.remove(name) : _selected.add(name);
    });
  }

  void _navigate() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecipesPage(ingredients: _selected.toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // ── conteúdo principal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.xxl),

                  // Título
                  Text('Escolha', style: AppTextStyles.displayBold),
                  Text('os produtos', style: AppTextStyles.displayRegular),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'Descubra receitas baseadas nos\nprodutos que você escolheu.',
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: AppSpacing.xxl),

                  // Grid
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.only(
                        bottom: _selected.isNotEmpty ? 90 : 16,
                      ),
                      itemCount: _kProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 8,
                            childAspectRatio: 2.5,
                          ),
                      itemBuilder: (_, i) {
                        final p = _kProducts[i];
                        final selected = _selected.contains(p.name);
                        return _ProductChip(
                          product: p,
                          isSelected: selected,
                          onTap: () => _toggle(p.name),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ── Barra inferior de seleção (aparece quando há seleção)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 280),
              curve: Curves.easeOutCubic,
              bottom: _selected.isNotEmpty ? 0 : -120,
              left: 0,
              right: 0,
              child: _BottomSelectionBar(
                count: _selected.length,
                onTap: _navigate,
                onClear: () => setState(() => _selected.clear()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  CHIP DE PRODUTO
// ─────────────────────────────────────────────
class _ProductChip extends StatelessWidget {
  const _ProductChip({
    required this.product,
    required this.isSelected,
    required this.onTap,
  });

  final _Product product;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.chipBorderDefault,
            width: isSelected ? 2.0 : 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(product.emoji, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                product.name,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isSelected ? AppColors.primaryDark : AppColors.grey900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  BARRA INFERIOR DE SELEÇÃO
// ─────────────────────────────────────────────
class _BottomSelectionBar extends StatelessWidget {
  const _BottomSelectionBar({
    required this.count,
    required this.onTap,
    required this.onClear,
  });

  final int count;
  final VoidCallback onTap;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppSpacing.lg),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.bottomSheetBg,
        borderRadius: BorderRadius.circular(AppRadius.bottomSheet),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          // Contador
          Expanded(
            child: Text(
              '$count ${count == 1 ? 'ingrediente selecionado' : 'ingredientes selecionados'}',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.white.withOpacity(0.7),
              ),
            ),
          ),

          // Botão limpar
          GestureDetector(
            onTap: onClear,
            child: Icon(
              Icons.close,
              color: AppColors.white.withOpacity(0.6),
              size: 20,
            ),
          ),

          const SizedBox(width: AppSpacing.lg),

          // Botão encontrar
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xxl,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppRadius.button),
              ),
              child: Text('Encontrar', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}
