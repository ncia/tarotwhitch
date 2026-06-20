import 'package:flutter/material.dart';
import 'package:flutter_tarot/l10n/app_localizations.dart';
import '../data/tarot_data.dart';
import '../services/favorite_service.dart';
import '../widgets/gradient_background.dart';
import '../widgets/tarot_card.dart';
import 'card_detail_screen.dart';

class FavoriteCardsScreen extends StatefulWidget {
  const FavoriteCardsScreen({super.key});

  @override
  State<FavoriteCardsScreen> createState() => _FavoriteCardsScreenState();
}

class _FavoriteCardsScreenState extends State<FavoriteCardsScreen> {
  List<TarotCardData> _favoriteCards = [];
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isLoading) {
      _loadFavorites();
    }
  }

  Future<void> _loadFavorites() async {
    final favIds = await FavoriteService.getFavoriteCards();
    if (mounted) {
      final allCards = getTarotDeck(context);
      setState(() {
        _favoriteCards = allCards.where((card) => favIds.contains(card.id)).toList();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.favoriteCardsTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.white))
            : _favoriteCards.isEmpty
                ? Center(
                    child: Text(
                      AppLocalizations.of(context)!.favoriteCardsEmpty,
                      style: const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, kToolbarHeight + 40, 16, 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: _favoriteCards.length,
                    itemBuilder: (context, index) {
                      final card = _favoriteCards[index];
                      return GestureDetector(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardDetailScreen(card: card),
                            ),
                          );
                          // 돌아왔을 때 즐겨찾기 상태 변경될 수 있으므로 다시 로드
                          _loadFavorites();
                        },
                        child: TarotCardWidget(
                          imagePath: card.imagePath,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
