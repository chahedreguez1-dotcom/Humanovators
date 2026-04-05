import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MediRouteApp());
}

class MediRouteApp extends StatelessWidget {
  const MediRouteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediRoute',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE53935),
          brightness: Brightness.light,
        ),
        fontFamily: 'Inter',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// ─── SPLASH SCREEN ───────────────────────────────────────────────────────────

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _scaleAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _controller.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '✚',
                      style: TextStyle(
                        fontSize: 48,
                        color: Color(0xFFE53935),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'MediRoute',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Medical Aid, Delivered in Minutes',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── ONBOARDING ──────────────────────────────────────────────────────────────

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> _slides = [
    {
      'icon': '🚨',
      'title': 'Chaque minute compte',
      'subtitle':
          'En situation d\'urgence médicale, le délai de livraison peut faire la différence entre la vie et la mort.',
      'color': Color(0xFFFCEBEB),
      'accent': Color(0xFFE53935),
    },
    {
      'icon': '🚁',
      'title': 'Comment ça marche',
      'subtitle':
          'Commandez en 3 secondes. Un drone autonome livre vos médicaments directement à votre position GPS.',
      'color': Color(0xFFE3F2FD),
      'accent': Color(0xFF1565C0),
    },
    {
      'icon': '❤️',
      'title': 'Rejoignez MediRoute',
      'subtitle':
          'Patient ou professionnel de santé — MediRoute est conçu pour vous. Inscrivez-vous maintenant.',
      'color': Color(0xFFE8F5E9),
      'accent': Color(0xFF2E7D32),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => _goToLogin(),
                child: const Text('Passer', style: TextStyle(color: Colors.grey)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: slide['color'],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              slide['icon'],
                              style: const TextStyle(fontSize: 64),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          slide['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: slide['accent'],
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          slide['subtitle'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? const Color(0xFFE53935)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _slides.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _goToLogin();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == _slides.length - 1
                        ? 'Commencer'
                        : 'Suivant',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }
}

// ─── LOGIN / REGISTER ────────────────────────────────────────────────────────

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPatient = true;
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _codeController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              // Logo
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53935),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text('✚',
                          style:
                              TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'MediRoute',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFE53935)),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                _isLogin ? 'Bon retour 👋' : 'Créer un compte',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isLogin
                    ? 'Connectez-vous pour continuer'
                    : 'Rejoignez MediRoute dès aujourd\'hui',
                style:
                    const TextStyle(fontSize: 15, color: Colors.black45),
              ),
              const SizedBox(height: 28),
              // Type selector
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _typeTab('Patient', true, '👤'),
                    _typeTab('Staff Médical', false, '🏥'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Email
              _inputField(
                controller: _emailController,
                label: 'Email',
                hint: 'votre@email.com',
                icon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),
              // Password
              _passwordField(),
              if (!_isPatient && !_isLogin) ...[
                const SizedBox(height: 16),
                _inputField(
                  controller: _codeController,
                  label: 'Code établissement',
                  hint: 'Ex: CHU-2024-XXX',
                  icon: Icons.business_outlined,
                ),
              ],
              const SizedBox(height: 32),
              // CTA
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleAuth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE53935),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _isLogin ? 'Se connecter' : 'S\'inscrire',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Toggle login/register
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _isLogin = !_isLogin),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black54),
                      children: [
                        TextSpan(
                            text: _isLogin
                                ? 'Pas encore de compte ? '
                                : 'Déjà un compte ? '),
                        TextSpan(
                          text: _isLogin ? 'S\'inscrire' : 'Se connecter',
                          style: const TextStyle(
                            color: Color(0xFFE53935),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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

  Widget _typeTab(String label, bool isPatient, String icon) {
    final selected = _isPatient == isPatient;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isPatient = isPatient),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight:
                      selected ? FontWeight.w700 : FontWeight.w400,
                  color:
                      selected ? const Color(0xFFE53935) : Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black54)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, size: 20, color: Colors.black38),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE53935), width: 1.5),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  Widget _passwordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mot de passe',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black54)),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            hintText: '••••••••',
            prefixIcon: const Icon(Icons.lock_outline,
                size: 20, color: Colors.black38),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: Colors.black38,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Color(0xFFE53935), width: 1.5),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }

  void _handleAuth() {
    if (_isPatient) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PatientHomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const StaffHomeScreen()),
      );
    }
  }
}

// ─── PATIENT HOME ─────────────────────────────────────────────────────────────

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bonjour, Ahmed 👋',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87)),
                        const SizedBox(height: 4),
                        Text(
                          'Comment puis-je vous aider ?',
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE53935).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('👤',
                          style: TextStyle(fontSize: 22)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Profile rapide
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade100),
                ),
                child: Row(
                  children: [
                    _profileTag('🩸', 'A+', 'Groupe sanguin'),
                    const SizedBox(width: 12),
                    _profileTag('⚠️', 'Pénicilline', 'Allergie'),
                    const SizedBox(width: 12),
                    _profileTag('💊', '45 kg', 'Poids'),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Bouton URGENCE
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const EmergencySelectScreen()),
                ),
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE53935), Color(0xFFB71C1C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFE53935).withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🚨', style: TextStyle(fontSize: 36)),
                      SizedBox(height: 8),
                      Text(
                        'URGENCE',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'Appuyer pour commander',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Statut drone actif
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3F2FD),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Text('🚁', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Drone DR-042 en route',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                  color: Color(0xFF1565C0))),
                          const SizedBox(height: 4),
                          Text('Insuline • ETA : 4 min',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.blue.shade400)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const DeliveryTrackingScreen(isStaff: false)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1565C0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text('Suivre',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Historique
              const Text('Livraisons récentes',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: Colors.black87)),
              const SizedBox(height: 12),
              _historyItem('💉', 'Insuline', 'Livré', '2h ago', true),
              _historyItem('🩹', 'Kit premiers secours', 'Livré', 'Hier', true),
              _historyItem(
                  '💊', 'Médicaments cardiaques', 'Livré', '3 jours', true),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(0, context, isPatient: true),
    );
  }

  Widget _profileTag(String icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Text(value,
                style: const TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w700)),
            Text(label,
                style:
                    const TextStyle(fontSize: 10, color: Colors.black45)),
          ],
        ),
      ),
    );
  }

  Widget _historyItem(String icon, String title, String status,
      String time, bool delivered) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14)),
                Text(time,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.black45)),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: delivered
                  ? const Color(0xFFE8F5E9)
                  : const Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: delivered
                    ? const Color(0xFF2E7D32)
                    : const Color(0xFFE65100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── EMERGENCY SELECT ─────────────────────────────────────────────────────────

class EmergencySelectScreen extends StatefulWidget {
  const EmergencySelectScreen({super.key});
  @override
  State<EmergencySelectScreen> createState() => _EmergencySelectScreenState();
}

class _EmergencySelectScreenState extends State<EmergencySelectScreen> {
  int _selected = -1;
  final _noteController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'icon': '💉', 'label': 'Insuline', 'desc': 'Injection rapide'},
    {'icon': '🫀', 'label': 'Cardiaques', 'desc': 'Médicaments cœur'},
    {'icon': '🩹', 'label': 'Premiers secours', 'desc': 'Kit complet'},
    {'icon': '💊', 'label': 'Autres', 'desc': 'Précisez ci-dessous'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Que vous faut-il ?',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black87)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Urgence banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFCEBEB),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: const Color(0xFFE53935).withOpacity(0.2)),
              ),
              child: const Row(
                children: [
                  Text('🚨', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Text('Mode urgence activé',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE53935))),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('Catégorie de médicament',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.3,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final cat = _categories[i];
                final isSelected = _selected == i;
                return GestureDetector(
                  onTap: () => setState(() => _selected = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFE53935)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFE53935)
                            : Colors.grey.shade200,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFFE53935)
                                    .withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(cat['icon'],
                            style: const TextStyle(fontSize: 32)),
                        const SizedBox(height: 6),
                        Text(
                          cat['label'],
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color:
                                isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                        Text(
                          cat['desc'],
                          style: TextStyle(
                            fontSize: 11,
                            color: isSelected
                                ? Colors.white70
                                : Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text('Note (optionnel)',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87)),
            const SizedBox(height: 10),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Précisez votre besoin spécifique...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // GPS Confirmation
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Text('📍', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Localisation GPS confirmée',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2E7D32))),
                        Text('36.8189° N, 10.1658° E — Tunis Centre',
                            style: TextStyle(
                                fontSize: 12, color: Colors.black45)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selected == -1
                    ? null
                    : () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DeliveryTrackingScreen(
                                  isStaff: false)),
                        ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text('Envoyer la demande',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── DELIVERY TRACKING ────────────────────────────────────────────────────────

class DeliveryTrackingScreen extends StatefulWidget {
  final bool isStaff;
  const DeliveryTrackingScreen({super.key, required this.isStaff});
  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen>
    with SingleTickerProviderStateMixin {
  int _statusIndex = 1;
  late AnimationController _droneAnim;

  final List<Map<String, dynamic>> _statuses = [
    {'label': 'En préparation', 'icon': '📦'},
    {'label': 'En vol', 'icon': '🚁'},
    {'label': 'Arrivée imminente', 'icon': '📍'},
    {'label': 'Livré', 'icon': '✅'},
  ];

  @override
  void initState() {
    super.initState();
    _droneAnim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _droneAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.isStaff ? 'Suivi demande' : 'Suivi livraison',
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.black87),
        ),
      ),
      body: Column(
        children: [
          // Map placeholder
          Container(
            height: 240,
            color: const Color(0xFFE8F5E9),
            child: Stack(
              children: [
                // Grid lines (fake map)
                CustomPaint(
                  size: const Size(double.infinity, 240),
                  painter: _MapPainter(),
                ),
                // Drone animated
                AnimatedBuilder(
                  animation: _droneAnim,
                  builder: (_, __) {
                    return Positioned(
                      left: 100 + (_droneAnim.value * 80),
                      top: 80 + (_droneAnim.value * 40),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE53935),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFE53935)
                                      .withOpacity(0.4),
                                  blurRadius: 12,
                                )
                              ],
                            ),
                            child: const Text('🚁',
                                style: TextStyle(fontSize: 20)),
                          ),
                          Container(
                            width: 2,
                            height: 8,
                            color: const Color(0xFFE53935),
                          ),
                          const Text('DR-042',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w700)),
                        ],
                      ),
                    );
                  },
                ),
                // Destination pin
                const Positioned(
                  right: 80,
                  bottom: 60,
                  child: Column(
                    children: [
                      Text('📍', style: TextStyle(fontSize: 28)),
                      Text('Vous',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                // ETA bubble
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8)
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('⏱',
                            style: TextStyle(fontSize: 14)),
                        SizedBox(width: 4),
                        Text('4 min',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                                color: Color(0xFFE53935))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Status stepper
          Container(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: List.generate(_statuses.length, (i) {
                final done = i <= _statusIndex;
                return Expanded(
                  child: Row(
                    children: [
                      if (i > 0)
                        Expanded(
                          child: Container(
                            height: 2,
                            color: done
                                ? const Color(0xFFE53935)
                                : Colors.grey.shade200,
                          ),
                        ),
                      Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: done
                                  ? const Color(0xFFE53935)
                                  : Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                _statuses[i]['icon'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _statuses[i]['label'],
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: done
                                  ? const Color(0xFFE53935)
                                  : Colors.black38,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Details
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _infoCard('🚁', 'Drone DR-042', '87% batterie • 5 km/h'),
                  const SizedBox(height: 12),
                  if (widget.isStaff) ...[
                    _infoCard('🏥', 'Source : CHU La Rabta',
                        'Tunis, Bab Saadoun'),
                    const SizedBox(height: 12),
                    _infoCard('🩸', 'Sang O+ — 2 poches', 'Urgence haute'),
                    const SizedBox(height: 12),
                  ] else ...[
                    _infoCard(
                        '💉', 'Insuline Novorapid', 'Dose : 10 unités'),
                    const SizedBox(height: 12),
                  ],
                  // Annuler button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton(
                      onPressed: () => _showCancelDialog(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFE53935)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                      ),
                      child: const Text('Annuler la demande',
                          style: TextStyle(
                              color: Color(0xFFE53935),
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ConfirmationScreen(
                                isStaff: widget.isStaff)),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: const Text('Confirmer réception',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard(String icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 14)),
              Text(subtitle,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.black45)),
            ],
          ),
        ],
      ),
    );
  }

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Annuler la demande ?'),
        content:
            const Text('Le drone va être rappelé. Cette action est définitive.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Oui, annuler',
                style: TextStyle(color: Color(0xFFE53935))),
          ),
        ],
      ),
    );
  }
}

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withOpacity(0.1)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Fake roads
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(0, 120), Offset(size.width, 120), roadPaint);
    canvas.drawLine(
        const Offset(160, 0), const Offset(160, 240), roadPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}

// ─── CONFIRMATION ─────────────────────────────────────────────────────────────

class ConfirmationScreen extends StatefulWidget {
  final bool isStaff;
  const ConfirmationScreen({super.key, required this.isStaff});
  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  int _rating = 0;
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              // Success icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                    child: Text('✅', style: TextStyle(fontSize: 48))),
              ),
              const SizedBox(height: 24),
              const Text(
                'Livraison arrivée !',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                widget.isStaff
                    ? 'Veuillez confirmer la réception du colis médical.'
                    : 'Avez-vous bien reçu votre livraison ?',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 15, color: Colors.black45),
              ),
              const SizedBox(height: 32),
              if (!widget.isStaff) ...[
                const Text('Votre satisfaction',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    5,
                    (i) => GestureDetector(
                      onTap: () => setState(() => _rating = i + 1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          '⭐',
                          style: TextStyle(
                            fontSize: i < _rating ? 36 : 28,
                            color: i < _rating
                                ? Colors.amber
                                : Colors.grey.shade300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
              if (widget.isStaff) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    children: [
                      _reportRow('Drone', 'DR-042'),
                      _reportRow('Produit', 'Sang O+ — 2 poches'),
                      _reportRow('Durée vol', '7 min 32s'),
                      _reportRow('Établissement', 'CHU La Rabta'),
                      _reportRow('Heure livraison', '14:32'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _confirmed = true);
                    Future.delayed(const Duration(milliseconds: 800), () {
                      if (mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => widget.isStaff
                                ? const StaffHomeScreen()
                                : const PatientHomeScreen(),
                          ),
                          (_) => false,
                        );
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E7D32),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    _confirmed ? 'Merci !' : 'Confirmer la réception',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reportRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 13, color: Colors.black45)),
          Text(value,
              style: const TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

// ─── STAFF HOME ───────────────────────────────────────────────────────────────

class StaffHomeScreen extends StatelessWidget {
  const StaffHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('CHU Charles Nicolle',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87)),
                        Row(
                          children: [
                            const Text('📍', style: TextStyle(fontSize: 12)),
                            const SizedBox(width: 4),
                            Text('Tunis, Bab Saadoun',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text('Staff ✔',
                        style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontWeight: FontWeight.w700,
                            fontSize: 13)),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Drone fleet status
              const Text('Flotte de drones',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87)),
              const SizedBox(height: 12),
              Row(
                children: [
                  _droneStatus('DR-041', 'Disponible', '100%',
                      const Color(0xFF2E7D32)),
                  const SizedBox(width: 10),
                  _droneStatus(
                      'DR-042', 'En vol', '87%', const Color(0xFFE53935)),
                  const SizedBox(width: 10),
                  _droneStatus('DR-043', 'Charge', '34%',
                      const Color(0xFFE65100)),
                ],
              ),
              const SizedBox(height: 24),

              // Nouvelle demande button
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const StaffRequestScreen()),
                ),
                child: Container(
                  width: double.infinity,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1565C0).withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('➕', style: TextStyle(fontSize: 22)),
                      SizedBox(width: 10),
                      Text('Nouvelle Demande',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Demandes en cours
              const Text('Demandes en cours',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87)),
              const SizedBox(height: 12),
              _requestItem(
                  context, '🩸', 'Sang O+ — 2 poches', 'DR-042', 'En vol',
                  true, const Color(0xFFE53935)),
              _requestItem(
                  context, '💊', 'Médicaments rares x4', 'DR-041', 'Préparation',
                  false, const Color(0xFFE65100)),
              _requestItem(
                  context, '🧪', 'Équipements chir.', 'DR-043', 'En attente',
                  false, Colors.grey),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(0, context, isPatient: false),
    );
  }

  Widget _droneStatus(
      String id, String status, String battery, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('🚁', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 6),
            Text(id,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 12)),
            Text(status,
                style: TextStyle(fontSize: 11, color: color)),
            Text('🔋 $battery',
                style: const TextStyle(fontSize: 11, color: Colors.black45)),
          ],
        ),
      ),
    );
  }

  Widget _requestItem(BuildContext context, String icon, String title,
      String drone, String status, bool inFlight, Color color) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                const DeliveryTrackingScreen(isStaff: true)),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14)),
                  Text(drone,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.black45)),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(status,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── STAFF REQUEST ────────────────────────────────────────────────────────────

class StaffRequestScreen extends StatefulWidget {
  const StaffRequestScreen({super.key});
  @override
  State<StaffRequestScreen> createState() => _StaffRequestScreenState();
}

class _StaffRequestScreenState extends State<StaffRequestScreen> {
  int _selectedType = -1;
  String _urgency = 'Normale';
  final _qtyController = TextEditingController();

  final List<Map<String, dynamic>> _types = [
    {'icon': '🩸', 'label': 'Sang', 'desc': 'Groupe requis'},
    {'icon': '💊', 'label': 'Méd. rares', 'desc': 'Ordonnance'},
    {'icon': '🧪', 'label': 'Équipements', 'desc': 'Médicaux'},
    {'icon': '🫁', 'label': 'Organes', 'desc': 'Urgence absolue'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Nouvelle Demande',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black87)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Type de ressource',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
              ),
              itemCount: _types.length,
              itemBuilder: (context, i) {
                final type = _types[i];
                final isSelected = _selectedType == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedType = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1565C0)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF1565C0)
                            : Colors.grey.shade200,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF1565C0)
                                    .withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(type['icon'],
                            style: const TextStyle(fontSize: 30)),
                        const SizedBox(height: 6),
                        Text(type['label'],
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black87)),
                        Text(type['desc'],
                            style: TextStyle(
                                fontSize: 11,
                                color: isSelected
                                    ? Colors.white70
                                    : Colors.black45)),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            const Text('Quantité / Spécifications',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87)),
            const SizedBox(height: 10),
            TextField(
              controller: _qtyController,
              decoration: InputDecoration(
                hintText: 'Ex: 2 poches sang O+, 500ml...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade200),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      color: Color(0xFF1565C0), width: 1.5),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            const Text("Niveau d'urgence",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87)),
            const SizedBox(height: 12),
            Row(
              children: [
                _urgencyBtn('Normale', Colors.green),
                const SizedBox(width: 10),
                _urgencyBtn('Haute', Colors.orange),
                const SizedBox(width: 10),
                _urgencyBtn('Critique', Colors.red),
              ],
            ),
            const SizedBox(height: 24),
            // Source auto-suggested
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Établissement source (auto-suggéré)',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black45)),
                  const SizedBox(height: 8),
                  const Text('CHU La Rabta — 2.4 km',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text('Stock disponible • ETA estimé : 8 min',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade500)),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _selectedType == -1
                    ? null
                    : () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const DeliveryTrackingScreen(
                                  isStaff: true)),
                        ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1565C0),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text('Envoyer la demande',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _urgencyBtn(String label, MaterialColor color) {
    final isSelected = _urgency == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _urgency = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color:
                isSelected ? color.shade100 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? color.shade400 : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isSelected ? color.shade800 : Colors.black45,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── BOTTOM NAV (shared helper) ───────────────────────────────────────────────

Widget _buildBottomNav(int currentIndex, BuildContext context,
    {required bool isPatient}) {
  final items = isPatient
      ? [
          const BottomNavigationBarItem(icon: Text('🏠'), label: 'Accueil'),
          const BottomNavigationBarItem(icon: Text('📦'), label: 'Livraisons'),
          const BottomNavigationBarItem(icon: Text('👤'), label: 'Profil'),
        ]
      : [
          const BottomNavigationBarItem(icon: Text('🏠'), label: 'Accueil'),
          const BottomNavigationBarItem(icon: Text('📋'), label: 'Demandes'),
          const BottomNavigationBarItem(icon: Text('🚁'), label: 'Drones'),
        ];

  return BottomNavigationBar(
    currentIndex: currentIndex,
    selectedItemColor: isPatient
        ? const Color(0xFFE53935)
        : const Color(0xFF1565C0),
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 12,
    items: items,
    onTap: (_) {},
  );
}
