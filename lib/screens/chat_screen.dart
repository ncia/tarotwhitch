import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glass_container.dart';
import 'package:flutter_tarot/l10n/app_localizations.dart';
import 'reading_screen.dart';
import '../services/tarot_ai_service.dart';
import '../data/witch_data.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final bool isButton;

  ChatMessage({required this.text, required this.isUser, this.isButton = false});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final TarotAiService _aiService = TarotAiService();
  
  bool _isWaitingForCards = false;
  bool _isTyping = false;
  String _currentQuestion = '';
  Witch _selectedWitch = witches.first;

  @override
  void initState() {
    super.initState();
    // 초기 AI 메시지
    _messages.add(ChatMessage(
      text: "안녕하세요. 저는 타로 마녀 ${_selectedWitch.name}입니다. 우주의 기운이 당신을 이곳으로 이끌었군요. 어떤 고민이 있으신가요?",
      isUser: false,
    ));
  }

  void _changeWitch(Witch witch) {
    setState(() {
      _selectedWitch = witch;
      _messages.add(ChatMessage(
        text: "[마녀가 ${witch.name}(으)로 교체되었습니다.]\n안녕하세요. 새로운 당신의 영적 안내자, ${witch.name}입니다. 어떤 고민이 있으신가요?",
        isUser: false,
      ));
    });
    _scrollToBottom();
  }

  void _showWitchProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GlassContainer(
            padding: const EdgeInsets.all(24),
            borderRadius: 24,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.purpleAccent,
                  backgroundImage: AssetImage(_selectedWitch.imagePath),
                ),
                const SizedBox(height: 16),
                Text(
                  _selectedWitch.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  _selectedWitch.title,
                  style: const TextStyle(fontSize: 14, color: Colors.pinkAccent),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProfileInfo('나이', '${_selectedWitch.age}세'),
                    _buildProfileInfo('혈액형', _selectedWitch.bloodType),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProfileInfo('키', _selectedWitch.height),
                    _buildProfileInfo('몸무게', _selectedWitch.weight),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  '성장 배경',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  _selectedWitch.backgroundStory,
                  style: const TextStyle(fontSize: 14, color: Colors.white70, height: 1.5),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple.shade700,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('닫기', style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white54)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_textController.text.trim().isEmpty) return;
    
    final question = _textController.text.trim();
    setState(() {
      _messages.add(ChatMessage(text: question, isUser: true));
      _currentQuestion = question;
      _textController.clear();
      _isWaitingForCards = true;
      
      // AI의 카드 뽑기 안내 메시지
      _messages.add(ChatMessage(
        text: "당신의 고민을 우주에 전달했습니다. 마음을 담은 타로 카드를 3장 뽑아주세요.",
        isUser: false,
      ));
    });
    _scrollToBottom();
    
    // 약간의 지연 후 바로 카드 뽑기 화면으로 자동 진입
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _navigateToPicking();
      }
    });
  }

  void _navigateToPicking() {
    setState(() {
      _isWaitingForCards = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReadingScreen(
          isForChat: true,
          onCardsPicked: _handleCardsPicked,
        ),
      ),
    );
  }

  void _handleCardsPicked(List<String> cards) async {
    setState(() {
      _messages.add(ChatMessage(
        text: "카드를 모두 뽑으셨군요. 당신이 뽑은 카드의 기운을 엮어 점괘를 읽어보겠습니다...",
        isUser: false,
      ));
      _isTyping = true;
      _messages.add(ChatMessage(text: "", isUser: false)); // 스트리밍 결과를 담을 빈 메시지
    });
    _scrollToBottom();

    final stream = _aiService.getTarotReadingStream(_currentQuestion, cards, _selectedWitch.personalityPrompt);
    
    await for (final chunk in stream) {
      if (mounted) {
        setState(() {
          final lastMsg = _messages.last;
          _messages[_messages.length - 1] = ChatMessage(
            text: lastMsg.text + chunk,
            isUser: false,
          );
        });
        _scrollToBottom();
      }
    }

    if (mounted) {
      setState(() {
        _isTyping = false;
      });
      _scrollToBottom();
    }
  }

  Widget _buildMessage(ChatMessage message) {
    if (message.isButton) {
      return Align(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            onPressed: _navigateToPicking,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade700,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('타로 카드 뽑기 ✨', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      );
    }

    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.purple.withOpacity(0.6) : Colors.white12,
          borderRadius: BorderRadius.circular(20).copyWith(
            bottomRight: message.isUser ? const Radius.circular(0) : null,
            bottomLeft: !message.isUser ? const Radius.circular(0) : null,
          ),
        ),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        child: Text(
          message.text,
          style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                borderRadius: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _showWitchProfile,
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.purpleAccent,
                            backgroundImage: AssetImage(_selectedWitch.imagePath),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _selectedWitch.name,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _selectedWitch.title,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.pinkAccent),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                '프로필 사진을 탭하여 상세 정보 보기',
                                style: TextStyle(fontSize: 11, color: Colors.white54),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Witch>(
                          value: _selectedWitch,
                          dropdownColor: Colors.deepPurple.shade900,
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                          isExpanded: true,
                          style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                          onChanged: (Witch? newValue) {
                            if (newValue != null && newValue != _selectedWitch) {
                              _changeWitch(newValue);
                            }
                          },
                          items: witches.map<DropdownMenuItem<Witch>>((Witch witch) {
                            return DropdownMenuItem<Witch>(
                              value: witch,
                              child: Text('${witch.name} - ${witch.title}'),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Message List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessage(_messages[index]);
                },
              ),
            ),
            
            // Typing Indicator
            if (_isTyping && _messages.isNotEmpty && _messages.last.text.isEmpty)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: Colors.purpleAccent),
              ),

            // Input Area
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassContainer(
                borderRadius: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        style: const TextStyle(color: Colors.white),
                        minLines: 1,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: _isWaitingForCards ? '먼저 카드를 뽑아주세요.' : '고민을 적어보세요...',
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        enabled: !_isWaitingForCards && !_isTyping,
                        // onSubmitted는 엔터키 동작이므로 멀티라인에서는 줄바꿈 역할로 변경될 수 있습니다.
                        // 보통 멀티라인 모드에서는 전송 버튼으로만 보내게 하거나 별도 처리가 필요할 수 있습니다.
                        // 기본적으로 키보드의 '완료/엔터' 키를 줄바꿈으로 사용하도록 onSubmitted를 제거하는 것이 좋습니다.
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.pinkAccent),
                      onPressed: (_isWaitingForCards || _isTyping) ? null : _sendMessage,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
