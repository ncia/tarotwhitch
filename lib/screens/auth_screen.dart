import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/gradient_background.dart';
import '../widgets/glass_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import '../data/nickname_data.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthScreen extends StatefulWidget {
  final bool isInline;
  const AuthScreen({super.key, this.isInline = false});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nicknameController = TextEditingController();
  bool _isLogin = true;
  bool _isLoading = false;
  bool _isAdmin = false; // 관리자 가입 여부
  bool _obscurePassword = true; // 비밀번호 숨김 여부
  bool _agreedToTerms = false; // 약관 동의 여부 (기본 체크 해제)
  bool _agreedToPush = false; // 마케팅/푸시 알림 동의 여부 (기본 체크 해제)
  bool _keepLoggedIn = true; // 자동 로그인 유지 여부

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _generateRandomNickname() {
    final random = Random();
    final prefix = nicknamePrefixes[random.nextInt(nicknamePrefixes.length)];
    final suffix = nicknameSuffixes[random.nextInt(nicknameSuffixes.length)];
    _nicknameController.text = '$prefix $suffix';
  }

  void _showTermsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('최종 사용자 라이선스 계약 (EULA)', style: TextStyle(color: Colors.white, fontSize: 18)),
          content: const SingleChildScrollView(
            child: Text(
              '제1조 (라이선스 허여)\n'
              '본 앱("타로마녀")은 개인적, 비상업적 용도에 한해 사용 권한을 부여하며, 앱의 소유권이나 지적재산권은 이전되지 않습니다.\n\n'
              '제2조 (금지된 사용)\n'
              '사용자는 본 서비스를 불법적이거나 타인의 권리를 침해하는 목적으로 사용할 수 없으며, 시스템이나 데이터를 임의로 조작하거나 리버스 엔지니어링할 수 없습니다.\n\n'
              '제3조 (데이터 수집 및 보관 기간)\n'
              '원활한 서비스 제공을 위해 사용자가 작성한 타로 일기 및 관련 점괘 데이터는 작성일로부터 기본 3년간 안전하게 보관됩니다.\n\n'
              '제4조 (장기 미접속 휴면 계정 처리)\n'
              '사용자가 1년(365일) 이상 서비스에 접속하지 않을 경우 휴면 계정으로 전환되며, 개인정보 보호 및 원활한 서버 환경 유지를 위해 해당 사용자의 모든 데이터는 사전 고지 없이 자동 삭제 처리됩니다.\n\n'
              '제5조 (데이터 파기 및 복구 불가)\n'
              '제3조의 보관 기간이 경과하거나 제4조에 의해 삭제된 데이터는 영구 파기되며 어떠한 경우에도 복구할 수 없습니다.\n\n'
              '제6조 (보증 부인 및 면책)\n'
              '본 앱이 제공하는 타로 점괘 및 해석은 오락 목적으로만 제공되며, 법적, 의학적, 재정적 조언을 대체하지 않습니다. 서비스 이용으로 인해 발생하는 어떠한 직간접적인 손해에 대해서도 개발자는 책임을 지지 않습니다.\n\n'
              '위 EULA 내용 및 데이터 관리 정책은 앱 사용을 위해 필수적으로 동의해야 하는 항목입니다.',
              style: TextStyle(color: Colors.white70, height: 1.5, fontSize: 13),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기', style: TextStyle(color: Colors.amberAccent)),
            ),
          ],
        );
      },
    );
  }

  void _showPushTermsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text('이벤트 및 마케팅 알림 수신 동의', style: TextStyle(color: Colors.white, fontSize: 18)),
          content: const SingleChildScrollView(
            child: Text(
              '제1조 (목적)\n'
              '본 동의는 타로마녀 서비스가 사용자에게 유익한 이벤트, 프로모션, 새로운 운세 업데이트 등의 광고성 정보를 푸시 알림으로 전송하기 위함입니다.\n\n'
              '제2조 (수신 철회)\n'
              '사용자는 본 수신 동의를 언제든지 앱 내 [내 메뉴 > 앱 설정]에서 철회할 수 있습니다. 동의를 철회하더라도 서비스의 기본 기능(필수 서비스)은 정상적으로 이용 가능합니다.\n\n'
              '제3조 (알림의 내용)\n'
              '전송되는 알림에는 앱 내 특별 할인 혜택, 기간 한정 이벤트, 맞춤형 운세 추천 등 광고 및 마케팅 성격의 내용이 포함될 수 있습니다.\n\n'
              '위 내용은 사용자의 선택적 동의 사항이며, 미동의 시에도 타로 서비스 이용에는 불이익이 없습니다.',
              style: TextStyle(color: Colors.white70, height: 1.5, fontSize: 13),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기', style: TextStyle(color: Colors.amberAccent)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _signInWithGoogle() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('미리보기 환경(Windows)에서는 구글 로그인을 지원하지 않습니다. 안드로이드 기기나 웹을 이용해주세요.')),
        );
      }
      return;
    }

    if (!_isLogin && !_agreedToTerms) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('회원가입을 진행하려면 데이터 보관 약관에 동의해야 합니다.')),
        );
      }
      return;
    }

    setState(() => _isLoading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final docSnapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (!docSnapshot.exists) {
          final random = Random();
          final prefix = nicknamePrefixes[random.nextInt(nicknamePrefixes.length)];
          final suffix = nicknameSuffixes[random.nextInt(nicknameSuffixes.length)];
          
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'email': user.email,
            'nickname': '$prefix $suffix',
            'role': 'user',
            'pushEnabled': _agreedToPush,
            'createdAt': FieldValue.serverTimestamp(),
            'lastLoginAt': FieldValue.serverTimestamp(),
            'deleteEligibleAt': Timestamp.fromDate(DateTime.now().add(const Duration(days: 365))), // 1년 뒤 삭제 대상
            'retentionExpiresAt': Timestamp.fromDate(DateTime.now().add(const Duration(days: 365 * 3))), // 3년 뒤 영구 파기
          });
          
          if (_agreedToPush) {
            await FirebaseMessaging.instance.requestPermission();
          }
        }
        
        // 로그인 성공 시 유지 여부 저장
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('keepLoggedIn', _keepLoggedIn);

        if (mounted) {
          if (!widget.isInline) {
            Navigator.pop(context);
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('구글 로그인 오류: ${e.message}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('구글 로그인 중 알 수 없는 오류가 발생했습니다.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _submit() async {
    setState(() => _isLoading = true);
    
    if (Firebase.apps.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('미리보기 환경(Windows)에서는 파이어베이스 로그인을 지원하지 않습니다.')),
        );
        setState(() => _isLoading = false);
      }
      return;
    }

    try {
      if (_isLogin) {
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        
        if (userCredential.user != null && !userCredential.user!.emailVerified) {
          // 이메일 미인증 상태
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('이메일 인증이 필요합니다. 가입하신 이메일함을 확인해주세요.'),
                action: SnackBarAction(
                  label: '재발송',
                  onPressed: () async {
                    await userCredential.user!.sendEmailVerification();
                    if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('인증 메일이 재발송되었습니다.')));
                  },
                ),
                duration: const Duration(seconds: 5),
              ),
            );
          }
          await FirebaseAuth.instance.signOut(); // 인증 안되었으므로 강제 로그아웃
          return;
        }

        // 로그인 성공 시 유지 여부 저장
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('keepLoggedIn', _keepLoggedIn);
      } else {
        if (_passwordController.text != _confirmPasswordController.text) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('비밀번호가 일치하지 않습니다. 다시 확인해 주세요.')),
            );
          }
          setState(() => _isLoading = false);
          return;
        }

        if (!_agreedToTerms) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('회원가입을 진행하려면 데이터 보관 약관에 동의해야 합니다.')),
            );
          }
          setState(() => _isLoading = false);
          return;
        }

        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
        
        final user = userCredential.user;
        if (user != null) {
          // Firestore에 유저 정보 및 권한(role) 저장
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'email': user.email,
            'nickname': _nicknameController.text.trim(),
            'role': _isAdmin ? 'admin' : 'user', // 관리자 여부에 따라 role 부여
            'pushEnabled': _agreedToPush,
            'createdAt': FieldValue.serverTimestamp(),
            'lastLoginAt': FieldValue.serverTimestamp(),
            'deleteEligibleAt': Timestamp.fromDate(DateTime.now().add(const Duration(days: 365))), // 1년 뒤 자동 삭제 대상
            'retentionExpiresAt': Timestamp.fromDate(DateTime.now().add(const Duration(days: 365 * 3))), // 3년 뒤 완전 파기
          });
          
          if (_agreedToPush) {
            await FirebaseMessaging.instance.requestPermission();
          }
          
          // 인증 메일 발송
          await user.sendEmailVerification();
          await FirebaseAuth.instance.signOut(); // 가입 직후 로그아웃 처리하여 인증 유도
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('회원가입이 완료되었습니다. 발송된 이메일을 확인하여 인증을 완료해주세요.'),
                duration: Duration(seconds: 5),
              ),
            );
            setState(() {
              _isLogin = true; // 로그인 화면으로 전환
              _passwordController.clear();
              _isAdmin = false; // 초기화
            });
            return;
          }
        }
      }
      if (mounted && !widget.isInline) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? '인증 오류가 발생했습니다.')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final formContent = Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: GlassContainer(
              padding: const EdgeInsets.all(24),
              borderRadius: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isLogin ? '로그인' : '회원가입',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 24),
                  if (!_isLogin) ...[
                    TextField(
                      controller: _nicknameController,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        labelText: '타로 세계의 닉네임',
                        labelStyle: const TextStyle(color: Colors.amberAccent),
                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.amberAccent)),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.refresh, color: Colors.amberAccent),
                          onPressed: () => setState(() => _generateRandomNickname()),
                          tooltip: '닉네임 다시 뽑기',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextField(
                    controller: _emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: '이메일',
                      labelStyle: TextStyle(color: Colors.white70),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.amberAccent)),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: '비밀번호',
                      labelStyle: const TextStyle(color: Colors.white70),
                      enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                      focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.amberAccent)),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  const SizedBox(height: 16),

                  if (!_isLogin) ...[
                    TextField(
                      controller: _confirmPasswordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: '비밀번호 확인',
                        labelStyle: const TextStyle(color: Colors.white70),
                        enabledBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
                        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.amberAccent)),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      obscureText: _obscurePassword,
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_isLogin) ...[
                    Row(
                      children: [
                        Checkbox(
                          value: _keepLoggedIn,
                          onChanged: (val) {
                            setState(() => _keepLoggedIn = val ?? true);
                          },
                          activeColor: Colors.amberAccent,
                          checkColor: Colors.black,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _keepLoggedIn = !_keepLoggedIn);
                            },
                            child: const Text(
                              '로그인 상태 유지',
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (!_isLogin) ...[
                    Row(
                      children: [
                        Checkbox(
                          value: _agreedToTerms,
                          onChanged: (val) {
                            setState(() => _agreedToTerms = val ?? false);
                          },
                          activeColor: Colors.amberAccent,
                          checkColor: Colors.black,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _agreedToTerms = !_agreedToTerms);
                            },
                            child: const Text(
                              '최종 사용자 라이선스 계약(EULA)에 동의합니다. (필수)',
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _showTermsDialog,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            minimumSize: Size.zero,
                          ),
                          child: const Text('[내용 보기]', style: TextStyle(color: Colors.amberAccent, fontSize: 12)),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreedToPush,
                          onChanged: (val) {
                            setState(() => _agreedToPush = val ?? false);
                          },
                          activeColor: Colors.amberAccent,
                          checkColor: Colors.black,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _agreedToPush = !_agreedToPush);
                            },
                            child: const Text(
                              '새로운 타로점 및 이벤터 알림수신에 동의합니다. (선택)',
                              style: TextStyle(color: Colors.white70, fontSize: 13),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: _showPushTermsDialog,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            minimumSize: Size.zero,
                          ),
                          child: const Text('[내용 보기]', style: TextStyle(color: Colors.amberAccent, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],

                  if (_isLoading)
                    const CircularProgressIndicator(color: Colors.amberAccent)
                  else
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text(_isLogin ? '로그인하기' : '가입하기', style: const TextStyle(fontSize: 16)),
                    ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                        if (!_isLogin && _nicknameController.text.isEmpty) {
                          _generateRandomNickname();
                        }
                      });
                    },
                    child: Text(
                      _isLogin ? '계정이 없으신가요? 회원가입' : '이미 계정이 있으신가요? 로그인',
                      style: const TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.white24, thickness: 1),
                  const SizedBox(height: 8),
                  if (!_isLoading)
                    ElevatedButton(
                      onPressed: _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/google_logo.png', width: 24, height: 24),
                          const SizedBox(width: 8),
                          const Text('Google로 시작하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        );

    if (widget.isInline) {
      return formContent;
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: GradientBackground(
        child: formContent,
      ),
    );
  }
}
