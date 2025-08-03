import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/providers/app_provider.dart';
import '../../../core/providers/memory_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/quick_action_button.dart';
import '../widgets/mood_indicator.dart';
import '../../journal/screens/journal_screen.dart';
import '../../translation/screens/translation_screen.dart';
import '../../mesh/screens/mesh_screen.dart';
import '../../profile/screens/profile_screen.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../contacts/screens/contacts_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late AnimationController _glowController;

  final List<Widget> _screens = [
    const HomeDashboard(),
    const JournalScreen(),
    const TranslationScreen(),
    const MeshScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _floatController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.getSurfaceColor(context),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, -10),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
            spreadRadius: 0,
          ),
        ],
        border: Border(
          top: BorderSide(
            color: AppTheme.getGlassBorderColor(context),
            width: 1.5,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: isSmallScreen ? 70 : 80, // Responsive height
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 4 : 8, 
            vertical: isSmallScreen ? 6 : 8
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home', AppTheme.primaryGradient, isSmallScreen),
              _buildNavItem(1, Icons.book_outlined, Icons.book, 'Journal', AppTheme.accentGradient, isSmallScreen),
              _buildNavItem(2, Icons.translate_outlined, Icons.translate, 'Translate', AppTheme.cyberGradient, isSmallScreen),
              _buildNavItem(3, Icons.wifi_tethering_outlined, Icons.wifi_tethering, 'Mesh', AppTheme.neonGradient, isSmallScreen),
              _buildNavItem(4, Icons.person_outline, Icons.person, 'Profile', AppTheme.secondaryGradient, isSmallScreen),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label, LinearGradient gradient, bool isSmallScreen) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _currentIndex = index);
        HapticFeedback.lightImpact();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: AppTheme.springCurve,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 4 : 8, 
          vertical: isSmallScreen ? 6 : 8
        ),
        decoration: BoxDecoration(
          gradient: isSelected ? gradient : null,
          color: isSelected ? null : AppTheme.getGlassBackgroundColor(context),
          borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 16),
          border: isSelected 
            ? Border.all(color: Colors.white.withOpacity(0.5), width: 1.5)
            : Border.all(color: AppTheme.getGlassBorderColor(context), width: 1),
          boxShadow: isSelected ? [
            BoxShadow(
              color: gradient.colors.first.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 6),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: gradient.colors.last.withOpacity(0.3),
              blurRadius: 25,
              offset: const Offset(0, 12),
              spreadRadius: 0,
            ),
          ] : [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: isSelected ? _glowController : const AlwaysStoppedAnimation(0),
              builder: (context, child) {
                return Container(
                  padding: EdgeInsets.all(isSmallScreen ? 4 : 6),
                  decoration: isSelected ? BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
                  ) : BoxDecoration(
                    color: AppTheme.getGlassBackgroundColor(context),
                    borderRadius: BorderRadius.circular(isSmallScreen ? 6 : 8),
                    border: Border.all(
                      color: AppTheme.getGlassBorderColor(context),
                      width: 0.5,
                    ),
                  ),
                  child: Icon(
                    isSelected ? activeIcon : icon,
                    color: isSelected 
                      ? Colors.white 
                      : AppTheme.getTextSecondaryColor(context),
                    size: isSmallScreen ? 18 : 20,
                  ),
                );
              },
            ),
            SizedBox(height: isSmallScreen ? 2 : 4),
            Text(
              label,
              style: AppTheme.techLabel.copyWith(
                color: isSelected ? Colors.white : AppTheme.getTextSecondaryColor(context),
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                fontSize: isSmallScreen ? 9 : 10,
                letterSpacing: 0.2,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ).animate()
        .scale(
          duration: const Duration(milliseconds: 300),
          curve: AppTheme.bounceCurve,
          begin: const Offset(1.0, 1.0),
          end: Offset(isSelected ? 1.1 : 1.0, isSelected ? 1.1 : 1.0),
        )
        .then()
        .shimmer(
          duration: isSelected ? const Duration(milliseconds: 1500) : Duration.zero,
          color: Colors.white.withOpacity(0.2),
        ),
    );
  }
}

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _contentController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Enhanced Animated Background
          AnimatedBuilder(
            animation: _backgroundController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.getBackgroundColor(context),
                      AppTheme.getBackgroundColor(context).withOpacity(0.8),
                      AppTheme.primaryBlue.withOpacity(0.05),
                      AppTheme.secondaryPurple.withOpacity(0.03),
                      AppTheme.accentPink.withOpacity(0.02),
                    ],
                    stops: const [0.0, 0.2, 0.5, 0.8, 1.0],
                    transform: GradientRotation(_backgroundController.value * 2 * 3.14159),
                  ),
                ),
                child: CustomPaint(
                  painter: BackgroundParticlesPainter(
                    animation: _backgroundController.value,
                    context: context,
                  ),
                  size: Size.infinite,
                ),
              );
            },
          ),
          
          // Content
          SafeArea(
            child: CustomScrollView(
              slivers: [
                // App Bar
                _buildAppBar(context),
                
                // Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Welcome Section
                        _buildWelcomeSection(context),
                        
                        const SizedBox(height: 32),
                        
                        // Mood Indicator
                        _buildMoodSection(context),
                        
                        const SizedBox(height: 32),
                        
                        // Quick Actions
                        _buildQuickActionsSection(context),
                        
                        const SizedBox(height: 32),
                        
                        // Recent Activity
                        _buildRecentActivitySection(context),
                        
                        const SizedBox(height: 32),
                        
                        // Stats Cards
                        _buildStatsSection(context),
                        
                        // Add bottom padding to prevent overflow
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: AppTheme.getGlassmorphicDecoration(context),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              // User Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppTheme.accentGradient,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.accentPink.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Consumer<AppProvider>(
                  builder: (context, appProvider, child) {
                    return appProvider.userAvatar.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(28),
                            child: Image.asset(
                              appProvider.userAvatar,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 28,
                          );
                  },
                ),
              ),
              
              const SizedBox(width: 20),
              
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<AppProvider>(
                      builder: (context, appProvider, child) {
                        return Text(
                          'Welcome back, ${appProvider.userName.isNotEmpty ? appProvider.userName : 'User'}!',
                          style: AppTheme.techHeading.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.getTextPrimaryColor(context),
                            letterSpacing: -0.2,
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        );
                      },
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ready to explore your AI companion?',
                      style: AppTheme.techBody.copyWith(
                        color: AppTheme.getTextSecondaryColor(context),
                        letterSpacing: -0.1,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Settings Button
              Container(
                decoration: AppTheme.getGlassmorphicDecoration(context),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => const ProfileScreen(),
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
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.settings_outlined,
                    color: AppTheme.getTextPrimaryColor(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: AppTheme.getGradientCardDecoration(AppTheme.primaryGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Status',
                      style: AppTheme.techHeading.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      'All systems operational',
                      style: AppTheme.techCaption.copyWith(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppTheme.successGreen,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.successGreen.withOpacity(0.5),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Your AI companion is ready and running offline with enhanced privacy protection.',
                    style: AppTheme.techBody.copyWith(
                      color: Colors.white.withOpacity(0.95),
                      height: 1.5,
                      letterSpacing: -0.1,
                    ),
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
        curve: AppTheme.gentleCurve,
      )
      .slideY(
        begin: 0.4,
        duration: const Duration(milliseconds: 800),
        curve: AppTheme.gentleCurve,
      )
      .then()
      .shimmer(
        duration: const Duration(milliseconds: 3000),
        color: Colors.white.withOpacity(0.08),
      );
  }

  Widget _buildMoodSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Mood',
          style: AppTheme.techSubtitle.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.getTextPrimaryColor(context),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        const MoodIndicator(),
      ],
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 200),
        curve: AppTheme.techCurve,
      )
      .slideY(
        begin: 0.3,
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 200),
        curve: AppTheme.techCurve,
      );
  }

  Widget _buildQuickActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTheme.techSubtitle.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.getTextPrimaryColor(context),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 20),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: [
            QuickActionButton(
              title: 'Record My Day',
              icon: Icons.mic,
              secondaryIcon: Icons.camera_alt,
              color: AppTheme.primaryBlue,
              onTap: () => _showDaySummary(context),
            ),
            QuickActionButton(
              title: 'Summarize Day',
              icon: Icons.summarize,
              color: AppTheme.accentCyan,
              onTap: () => _showDaySummary(context),
            ),
            QuickActionButton(
              title: 'Translate Live',
              icon: Icons.translate,
              color: AppTheme.accentPink,
              onTap: () => _navigateToTranslate(context),
            ),
            QuickActionButton(
              title: 'Personal Search',
              icon: Icons.search,
              color: AppTheme.secondaryPurple,
              onTap: () => _navigateToSearch(context),
            ),
            QuickActionButton(
              title: 'Forget Mode',
              icon: Icons.delete_sweep,
              color: AppTheme.warningOrange,
              onTap: () => _toggleForgetMode(context),
            ),
            QuickActionButton(
              title: 'Favorite Contacts',
              icon: Icons.favorite,
              color: AppTheme.errorRed,
              onTap: () => _navigateToContacts(context),
            ),
          ],
        ),
      ],
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 400),
        curve: AppTheme.techCurve,
      )
      .slideY(
        begin: 0.3,
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 400),
        curve: AppTheme.techCurve,
      );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: AppTheme.techSubtitle.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.getTextPrimaryColor(context),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: AppTheme.getGlassmorphicDecoration(context),
          child: Column(
            children: [
              _buildActivityItem(context, '📝', 'Recorded 3 memories today', '2 hours ago'),
              _buildActivityItem(context, '🌍', 'Translated 5 conversations', '4 hours ago'),
              _buildActivityItem(context, '🔍', 'Searched personal documents', '6 hours ago'),
            ],
          ),
        ),
      ],
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 600),
        curve: AppTheme.techCurve,
      )
      .slideY(
        begin: 0.3,
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 600),
        curve: AppTheme.techCurve,
      );
  }

  Widget _buildActivityItem(BuildContext context, String emoji, String title, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.techBody.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.getTextPrimaryColor(context),
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  time,
                  style: AppTheme.techCaption.copyWith(
                    color: AppTheme.getTextSecondaryColor(context),
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Today\'s Stats',
          style: AppTheme.techSubtitle.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.getTextPrimaryColor(context),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Memories',
                '12',
                Icons.psychology,
                AppTheme.primaryGradient,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                'Translations',
                '8',
                Icons.translate,
                AppTheme.accentGradient,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Contacts',
                '6',
                Icons.people,
                AppTheme.cyberGradient,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                context,
                'Notifications',
                '3',
                Icons.notifications,
                AppTheme.secondaryGradient,
              ),
            ),
          ],
        ),
      ],
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 800),
        curve: AppTheme.techCurve,
      )
      .slideY(
        begin: 0.3,
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 800),
        curve: AppTheme.techCurve,
      );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, LinearGradient gradient) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Today',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: AppTheme.techTitle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            title,
            style: AppTheme.techBody.copyWith(
              color: Colors.white.withOpacity(0.9),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    ).animate()
      .scale(
        duration: const Duration(milliseconds: 300),
        curve: AppTheme.bounceCurve,
      )
      .then()
      .shimmer(
        duration: const Duration(milliseconds: 1500),
        color: Colors.white.withOpacity(0.1),
      );
  }

  void _showDaySummary(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.getSurfaceColor(context),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.summarize, color: AppTheme.primaryBlue, size: 24),
            const SizedBox(width: 12),
            Text(
              'Day Summary',
              style: AppTheme.techHeading.copyWith(
                color: AppTheme.getTextPrimaryColor(context),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your AI has analyzed today\'s activities and created a comprehensive summary.',
              style: AppTheme.techBody.copyWith(
                color: AppTheme.getTextSecondaryColor(context),
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📊 Today\'s Highlights',
                    style: AppTheme.techButton.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• 3 memories captured\n• 5 conversations translated\n• 2 documents processed\n• 1 new contact added',
                    style: AppTheme.techCaption.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: AppTheme.techCaption.copyWith(
                color: AppTheme.getTextSecondaryColor(context),
                letterSpacing: 0.2,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showDetailedSummary(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'View Full Summary',
              style: AppTheme.techButton.copyWith(
                fontSize: 14,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailedSummary(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: AppTheme.getSurfaceColor(context),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.getTextSecondaryColor(context).withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Detailed Day Summary',
                      style: AppTheme.techSubtitle.copyWith(
                        color: AppTheme.getTextPrimaryColor(context),
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildSummaryCard(
                            'Memories Captured',
                            '3 new memories',
                            Icons.psychology,
                            AppTheme.primaryGradient,
                          ),
                          _buildSummaryCard(
                            'Translations',
                            '5 conversations',
                            Icons.translate,
                            AppTheme.accentGradient,
                          ),
                          _buildSummaryCard(
                            'Documents Processed',
                            '2 files analyzed',
                            Icons.description,
                            AppTheme.cyberGradient,
                          ),
                          _buildSummaryCard(
                            'Contacts Updated',
                            '1 new contact',
                            Icons.people,
                            AppTheme.secondaryGradient,
                          ),
                        ],
                      ),
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

  Widget _buildSummaryCard(String title, String subtitle, IconData icon, LinearGradient gradient) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.techButton.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTheme.techCaption.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToTranslate(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const TranslationScreen(),
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
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _navigateToSearch(BuildContext context) {
    // Navigate to notifications screen
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const NotificationsScreen(),
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
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  void _toggleForgetMode(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.toggleForgetMode();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          appProvider.forgetModeEnabled 
              ? 'Forget Mode enabled' 
              : 'Forget Mode disabled',
          style: TextStyle(
            letterSpacing: 0.2,
          ),
        ),
        backgroundColor: appProvider.forgetModeEnabled 
            ? AppTheme.successGreen 
            : AppTheme.warningOrange,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _navigateToContacts(BuildContext context) {
    // Navigate to contacts screen
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ContactsScreen(),
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
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

// Enhanced Background Particles Painter
class BackgroundParticlesPainter extends CustomPainter {
  final double animation;
  final BuildContext context;

  BackgroundParticlesPainter({required this.animation, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryBlue.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // Draw floating particles
    for (int i = 0; i < 30; i++) {
      final x = (size.width * (i * 0.1 + animation * 0.1)) % size.width;
      final y = (size.height * (i * 0.05 + animation * 0.1)) % size.height;
      
      canvas.drawCircle(
        Offset(x, y),
        2 + (i % 3) * 1.0,
        paint,
      );
    }

    // Draw gradient circles
    final gradientPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.primaryBlue.withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawCircle(
      Offset(size.width * 0.2, size.height * 0.3),
      100 + 50 * animation,
      gradientPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.8, size.height * 0.7),
      80 + 40 * animation,
      gradientPaint,
    );

    // Draw tech grid lines
    final gridPaint = Paint()
      ..color = AppTheme.primaryBlue.withOpacity(0.03)
      ..strokeWidth = 1;

    for (int i = 0; i < 10; i++) {
      final x = (size.width / 10) * i;
      final y = (size.height / 10) * i;
      
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}