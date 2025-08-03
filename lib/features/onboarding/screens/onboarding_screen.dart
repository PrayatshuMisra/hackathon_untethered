import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../home/screens/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _backgroundController;
  late AnimationController _contentController;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _features = [
    {
      'title': 'AI Memory Assistant',
      'description': 'Your personal AI companion that remembers everything important to you, from conversations to daily activities.',
      'icon': Icons.psychology,
      'color': AppTheme.primaryBlue,
      'gradient': AppTheme.primaryGradient,
    },
    {
      'title': 'Real-time Translation',
      'description': 'Break language barriers with instant translation in over 100 languages, powered by advanced AI.',
      'icon': Icons.translate,
      'color': AppTheme.accentPink,
      'gradient': AppTheme.accentGradient,
    },
    {
      'title': 'Smart Journaling',
      'description': 'Automatically capture and organize your thoughts, memories, and experiences with intelligent categorization.',
      'icon': Icons.book,
      'color': AppTheme.accentCyan,
      'gradient': AppTheme.cyberGradient,
    },
    {
      'title': 'Mesh Network',
      'description': 'Connect with other users through our secure mesh network for collaborative AI experiences.',
      'icon': Icons.wifi_tethering,
      'color': AppTheme.secondaryPurple,
      'gradient': AppTheme.secondaryGradient,
    },
    {
      'title': 'Privacy First',
      'description': 'Your data stays on your device. No cloud storage, no tracking, complete privacy and control.',
      'icon': Icons.security,
      'color': AppTheme.successGreen,
      'gradient': AppTheme.neonGradient,
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _backgroundController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated Background
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.backgroundLight,
                      AppTheme.backgroundLight.withOpacity(0.8),
                      AppTheme.primaryBlue.withOpacity(0.05),
                      AppTheme.secondaryPurple.withOpacity(0.03),
                      AppTheme.accentPink.withOpacity(0.02),
                    ],
                    stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                    transform: GradientRotation(_backgroundController.value * 2 * 3.14159),
                  ),
                ),
              );
            },
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),
                
                // Feature Showcase
                Expanded(
                  child: _buildFeatureShowcase(),
                ),
                
                // Bottom Section
                _buildBottomSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // App Logo/Title
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.getGlassmorphicDecoration(context),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryBlue.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Untethered AI',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppTheme.textPrimaryLight,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2.0,
                  ),
                ),
                Text(
                  'Your Personal AI Companion',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.textSecondaryLight,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 800),
        curve: AppTheme.techCurve,
      )
      .slideY(
        begin: -0.3,
        duration: const Duration(milliseconds: 800),
        curve: AppTheme.techCurve,
      );
  }

  Widget _buildFeatureShowcase() {
    return Column(
      children: [
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Discover Our Features',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppTheme.textPrimaryLight,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 24),
        
        // Feature Cards
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemCount: _features.length,
            itemBuilder: (context, index) {
              final feature = _features[index];
              return _buildFeatureCard(feature, index);
            },
          ),
        ),
        
        // Page Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_features.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                gradient: _currentPage == index 
                  ? AppTheme.primaryGradient 
                  : null,
                color: _currentPage == index 
                  ? null 
                  : AppTheme.textSecondaryLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildFeatureCard(Map<String, dynamic> feature, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: feature['gradient'],
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: feature['color'].withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                feature['icon'],
                color: Colors.white,
                size: 50,
              ),
            ),
            const SizedBox(height: 24),
            
            // Title
            Text(
              feature['title'],
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            
            // Description
            Text(
              feature['description'],
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        delay: Duration(milliseconds: index * 100),
        curve: AppTheme.techCurve,
      )
      .scale(
        duration: const Duration(milliseconds: 600),
        delay: Duration(milliseconds: index * 100),
        curve: AppTheme.bounceCurve,
      );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Platform Info
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppTheme.getGlassmorphicDecoration(context),
            child: Column(
              children: [
                Text(
                  'Platform Overview',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppTheme.textPrimaryLight,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Built with Flutter for cross-platform compatibility. Runs offline with local AI processing for maximum privacy and performance.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryLight,
                    height: 1.5,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Get Started Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: AppTheme.techCurve,
                        )),
                        child: child,
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                foregroundColor: Colors.white,
                elevation: 12,
                shadowColor: AppTheme.primaryBlue.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
                textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0,
                ),
              ),
              child: const Text('Get Started'),
            ),
          ),
        ],
      ),
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 800),
        delay: const Duration(milliseconds: 400),
        curve: AppTheme.techCurve,
      )
      .slideY(
        begin: 0.3,
        duration: const Duration(milliseconds: 800),
        delay: const Duration(milliseconds: 400),
        curve: AppTheme.techCurve,
      );
  }
}

 