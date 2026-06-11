import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../widgets/gradient_background.dart';
import '../widgets/glass_container.dart';
import '../widgets/flip_card.dart';
import 'package:flutter_tarot/l10n/app_localizations.dart';
import '../data/tarot_data.dart';

enum ReadingState { intro, picking, result }

class ReadingScreen extends StatefulWidget {
  final bool isForChat;
  final void Function(List<String>)? onCardsPicked;

  const ReadingScreen({
    super.key,
    this.isForChat = false,
    this.onCardsPicked,
  });

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> with TickerProviderStateMixin {
  ReadingState _currentState = ReadingState.intro;
  late AnimationController _introAnimController;
  late AnimationController _lightningAnimController;
  late Animation<double> _scaleAnimation;
  
  // Card Picking State
  bool _isFanSpread = true; // 레이아웃 토글
  bool _showLightning = false; // 번개 이펙트 토글
  final int _totalCards = 78; // 전체 78장
  final List<int> _selectedCardIndices = [];
  
  late List<TarotCardData> _shuffledDeck;
  late List<bool> _shuffledReversed;

  @override
  void initState() {
    super.initState();
    if (widget.isForChat) {
      _currentState = ReadingState.picking;
    }
    _introAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _lightningAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100), // 매우 빠르게 번쩍임
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _introAnimController, curve: Curves.easeInOut),
    );
    
    if (!widget.isForChat) {
      _introAnimController.repeat(reverse: true);
    }
    
    _lightningAnimController.repeat(reverse: true);
    
    // 전체 덱 셔플 및 정/역방향 셔플
    _shuffledDeck = List.from(tarotDeck)..shuffle();
    _shuffledReversed = List.generate(78, (_) => math.Random().nextBool());
  }

  @override
  void dispose() {
    _introAnimController.dispose();
    _lightningAnimController.dispose();
    super.dispose();
  }

  void _startPicking() {
    setState(() {
      _currentState = ReadingState.picking;
    });
    _introAnimController.stop();
  }

  void _onCardTapped(int index) {
    if (_currentState != ReadingState.picking) return;
    if (_selectedCardIndices.contains(index)) return;
    if (_selectedCardIndices.length >= 3) return;

    setState(() {
      _selectedCardIndices.add(index);
    });

    if (_selectedCardIndices.length == 3) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (mounted) {
          setState(() {
            _showLightning = true;
          });
          
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              setState(() {
                _showLightning = false;
                _currentState = ReadingState.result;
              });
            }
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      useSafeArea: false,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        child: _buildCurrentState(),
      ),
    );
  }

  Widget _buildCurrentState() {
    switch (_currentState) {
      case ReadingState.intro:
        return _buildIntroView();
      case ReadingState.picking:
        return _buildPickingView();
      case ReadingState.result:
        return _buildResultView();
    }
  }

  Widget _buildIntroView() {
    return Stack(
      key: const ValueKey('intro'),
      children: [
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _scaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Image.asset(
                  'assets/images/fortune_teller.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.error, color: Colors.white54, size: 50),
                  ),
                ),
              );
            },
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Color(0x99120024),
                  Color(0xFF120024),
                ],
                stops: [0.0, 0.5, 1.0],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  AppLocalizations.of(context)!.readingIntroTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.8),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.readingIntroSubtitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: _startPicking,
                  child: GlassContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    borderRadius: 30,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.readingIntroButton,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPickingView() {
    return SafeArea(
      key: const ValueKey('picking'),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double screenWidth = constraints.maxWidth;
          final double screenHeight = constraints.maxHeight;
          final double slotWidth = 90.0;
          final double slotHeight = 140.0;
          final double spacing = (screenWidth - (slotWidth * 3)) / 4;
          
          // 상단 빈 슬롯이 시작되는 정확한 Y 좌표
          // Padding top 20 + 상단 텍스트Row 대략 30 + SizedBox 20 = 70
          final double slotsTopY = 70.0; 

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. 배경 및 UI 요소 레이어
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '3장의 카드를 뽑으세요',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _isFanSpread = !_isFanSpread;
                            });
                          },
                          icon: const Icon(Icons.swap_horiz, color: Colors.white),
                          label: Text(
                            _isFanSpread ? '부채꼴' : '겹친 모양',
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white24,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // 슬롯 컨테이너 (정확히 slotsTopY 위치에 맞춰짐)
                  SizedBox(
                    height: slotHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(3, (index) {
                        return Container(
                          width: slotWidth,
                          height: slotHeight,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white30, width: 2, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white10,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white54, fontSize: 24),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              
              // 2. 인터랙티브 카드 레이어 (전체 화면 기준 절대 좌표로 애니메이션)
              ...List.generate(_totalCards, (index) {
                final isSelected = _selectedCardIndices.contains(index);
                final selectedOrder = _selectedCardIndices.indexOf(index);
                
                double targetTop;
                double targetLeft;
                double targetAngle = 0;

                if (isSelected) {
                  // 선택된 경우: 정확히 빈 슬롯의 x, y 좌표로 이동
                  targetTop = slotsTopY; 
                  targetLeft = spacing + (selectedOrder * (slotWidth + spacing));
                  targetAngle = 0;
                } else {
                  // 바닥에 펼쳐지는 위치 (화면 하단 기준)
                  final baseY = screenHeight - slotHeight - 40; 
                  if (_isFanSpread) {
                    double normalized = (index - (_totalCards - 1) / 2) / ((_totalCards - 1) / 2);
                    targetAngle = normalized * math.pi / 3.5;
                    targetLeft = (screenWidth / 2) - (slotWidth / 2) + (normalized * 140);
                    targetTop = baseY + (normalized * normalized * 60);
                  } else {
                    double normalized = (index - (_totalCards - 1) / 2) / ((_totalCards - 1) / 2);
                    targetAngle = 0;
                    targetLeft = (screenWidth / 2) - (slotWidth / 2) + (normalized * 130);
                    targetTop = baseY + 20;
                  }
                }

                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOutBack,
                  top: targetTop,
                  left: targetLeft,
                  child: AnimatedRotation(
                    turns: targetAngle / (math.pi * 2),
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutBack,
                    child: GestureDetector(
                      onTap: () => _onCardTapped(index),
                      child: Container(
                        width: slotWidth,
                        height: slotHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          image: const DecorationImage(
                            image: AssetImage('assets/images/card_back.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              
              // 3. 번개 이펙트 레이어 (카드가 모두 선택된 후 3초간 표시)
              if (_showLightning) ...[
                // 화면 전체가 어두워지는 효과 (검은 배경 매칭)
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _lightningAnimController,
                    builder: (context, child) {
                      return Container(
                        color: Colors.black.withOpacity(0.85 + (_lightningAnimController.value * 0.15)), // 0.85 ~ 1.0
                      );
                    },
                  ),
                ),
                // 번개 이미지
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: _lightningAnimController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: 0.6 + (_lightningAnimController.value * 0.4),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/lightning2.jpg'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }



  Widget _buildResultView() {
    return SafeArea(
      key: const ValueKey('result'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.readingSpreadTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.readingSpreadSubtitle,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            
            // 3장의 카드가 뒤집히는 뷰
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(3, (index) {
                final cardIndex = _selectedCardIndices[index];
                final card = _shuffledDeck[cardIndex];
                final isRev = _shuffledReversed[cardIndex];

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FlipCardWidget(
                      frontImagePath: card.imagePath,
                      isReversed: isRev,
                      backImagePath: 'assets/images/card_back.jpg',
                      isFlipped: true, // 상태 진입 시 바로 플립 애니메이션 시작
                      width: 90,
                      height: 140,
                      duration: Duration(milliseconds: 600 + (index * 200)), // 순차적으로 뒤집어짐
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 90,
                      child: Text(
                        card.name.split(" (").first,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              }),
            ),
            
            const Spacer(),
            
            // 결과 메시지 또는 챗봇 복귀 버튼
            if (widget.isForChat)
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: GestureDetector(
                  onTap: () {
                    if (widget.onCardsPicked != null) {
                      final List<String> pickedInfos = [];
                      for (int i = 0; i < 3; i++) {
                        final cardIndex = _selectedCardIndices[i];
                        final card = _shuffledDeck[cardIndex];
                        final isRev = _shuffledReversed[cardIndex];
                        pickedInfos.add('${card.name} (${isRev ? "역방향" : "정방향"})');
                      }
                      widget.onCardsPicked!(pickedInfos);
                    }
                    Navigator.of(context).pop();
                  },
                  child: GlassContainer(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    borderRadius: 30,
                    child: Center(
                      child: Text(
                        '해석 듣기',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              )
            else
              GlassContainer(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.readingSpreadMessageTitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.readingSpreadMessageBody,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
