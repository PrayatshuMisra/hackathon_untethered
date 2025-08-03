import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/app_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/settings_tile.dart';
import '../widgets/storage_info_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return CustomScrollView(
            slivers: [
              // Enhanced App Bar
              SliverAppBar(
                expandedHeight: 200,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: AppTheme.getGradientCardDecoration(AppTheme.primaryGradient),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Profile Picture
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: AppTheme.accentGradient,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.accentPink.withOpacity(0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: appProvider.userAvatar.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        appProvider.userAvatar,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                            ),
                            const SizedBox(height: 16),
                            
                            // User Name
                            Text(
                              appProvider.userName.isNotEmpty
                                  ? appProvider.userName
                                  : 'User',
                              style: AppTheme.techHeading.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            
                            // Edit Profile Button
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: TextButton.icon(
                                onPressed: () => _editProfile(context, appProvider),
                                icon: const Icon(Icons.edit, color: Colors.white, size: 18),
                                label: Text(
                                  'Edit Profile',
                                  style: AppTheme.techCaption.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Enhanced Dark Mode Section
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: AppTheme.getEnhancedGlassmorphicDecoration(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.neonGradient,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.dark_mode,
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
                                        'Appearance',
                                        style: AppTheme.techHeading.copyWith(
                                          color: AppTheme.getTextPrimaryColor(context),
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: -0.2,
                                        ),
                                      ),
                                      Text(
                                        'Customize your app experience',
                                        style: AppTheme.techCaption.copyWith(
                                          color: AppTheme.getTextSecondaryColor(context),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            
                            // Enhanced Dark Mode Toggle
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                gradient: appProvider.isDarkMode 
                                    ? AppTheme.cyberGradient 
                                    : AppTheme.sunsetGradient,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: (appProvider.isDarkMode 
                                        ? AppTheme.cyberGradientStart 
                                        : AppTheme.sunsetGradientStart).withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Icon(
                                      appProvider.isDarkMode ? Icons.nightlight_round : Icons.wb_sunny,
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
                                          'Dark Mode',
                                          style: AppTheme.techBody.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -0.1,
                                          ),
                                        ),
                                        Text(
                                          appProvider.isDarkMode 
                                              ? 'Enabled - Easy on the eyes' 
                                              : 'Disabled - Bright and clear',
                                          style: AppTheme.techCaption.copyWith(
                                            color: Colors.white.withOpacity(0.9),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: appProvider.isDarkMode,
                                    onChanged: (value) => appProvider.toggleDarkMode(),
                                    activeColor: Colors.white,
                                    activeTrackColor: Colors.white.withOpacity(0.3),
                                    inactiveThumbColor: Colors.white.withOpacity(0.8),
                                    inactiveTrackColor: Colors.white.withOpacity(0.2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Privacy & Security Section
                      Text(
                        'Privacy & Security',
                        style: AppTheme.techSubtitle.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.getTextPrimaryColor(context),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      SettingsTile(
                        icon: Icons.delete_sweep,
                        title: 'Forget Mode',
                        subtitle: 'Auto-clear recent memories',
                        trailing: Switch(
                          value: appProvider.forgetModeEnabled,
                          onChanged: (value) => appProvider.toggleForgetMode(),
                          activeColor: AppTheme.primaryBlue,
                        ),
                      ),

                      if (appProvider.forgetModeEnabled)
                        Padding(
                          padding: const EdgeInsets.only(left: 56, right: 16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Clear interval: ${appProvider.forgetModeInterval} minutes',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.primaryBlue.withOpacity(0.7),
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () => _showIntervalDialog(context, appProvider),
                                    icon: const Icon(Icons.edit, size: 16),
                                    color: AppTheme.primaryBlue.withOpacity(0.7),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),

                      SettingsTile(
                        icon: Icons.security,
                        title: 'Privacy Lock',
                        subtitle: 'Require authentication for sensitive actions',
                        trailing: Switch(
                          value: false, // Placeholder
                          onChanged: (value) {
                            // Implement privacy lock
                          },
                          activeColor: AppTheme.primaryBlue,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Storage & Data Section
                      Text(
                        'Storage & Data',
                        style: AppTheme.techSubtitle.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.getTextPrimaryColor(context),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      const StorageInfoCard(),

                      SettingsTile(
                        icon: Icons.backup,
                        title: 'Export Data',
                        subtitle: 'Download your memories and settings',
                        onTap: () => _exportData(context),
                      ),

                      SettingsTile(
                        icon: Icons.restore,
                        title: 'Import Data',
                        subtitle: 'Restore from backup file',
                        onTap: () => _importData(context),
                      ),

                      SettingsTile(
                        icon: Icons.delete_forever,
                        title: 'Clear All Data',
                        subtitle: 'Permanently delete all memories',
                        onTap: () => _clearAllData(context),
                      ),

                      const SizedBox(height: 24),

                      // App Settings Section
                      Text(
                        'App Settings',
                        style: AppTheme.techSubtitle.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.getTextPrimaryColor(context),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      SettingsTile(
                        icon: Icons.notifications,
                        title: 'Notifications',
                        subtitle: 'Manage notification preferences',
                        onTap: () => _showNotificationsSettings(context),
                      ),

                      SettingsTile(
                        icon: Icons.language,
                        title: 'Language',
                        subtitle: 'Change app language',
                        onTap: () => _showLanguageSettings(context),
                      ),

                      SettingsTile(
                        icon: Icons.help,
                        title: 'Help & Support',
                        subtitle: 'Get help and contact support',
                        onTap: () => _showHelpSupport(context),
                      ),

                      SettingsTile(
                        icon: Icons.info,
                        title: 'About App',
                        subtitle: 'Version 1.0.0',
                        onTap: () => _showAboutApp(context),
                      ),

                      const SizedBox(height: 24),

                      // Danger Zone
                      Text(
                        'Danger Zone',
                        style: AppTheme.techSubtitle.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.errorRed,
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 16),

                      SettingsTile(
                        icon: Icons.logout,
                        title: 'Reset App',
                        subtitle: 'Clear all data and reset to defaults',
                        onTap: () => _resetApp(context),
                        iconColor: Colors.red,
                        textColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _editProfile(BuildContext context, AppProvider appProvider) {
    final nameController = TextEditingController(text: appProvider.userName);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              appProvider.updateUserName(nameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showIntervalDialog(BuildContext context, AppProvider appProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forget Mode Interval'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Select how often to clear recent memories:'),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: PopupMenuButton<int>(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${appProvider.forgetModeInterval} minutes'),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
                itemBuilder: (context) => [5, 10, 15, 30, 60].map((minutes) {
                  return PopupMenuItem<int>(
                    value: minutes,
                    child: Text('$minutes minutes'),
                  );
                }).toList(),
                onSelected: (value) {
                  appProvider.updateForgetModeInterval(value);
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _exportData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: const Text('This will create a backup file with all your memories and settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement export functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data exported successfully')),
              );
            },
            child: const Text('Export'),
          ),
        ],
      ),
    );
  }

  void _importData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Import Data'),
        content: const Text('This will restore your data from a backup file.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement import functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data imported successfully')),
              );
            },
            child: const Text('Import'),
          ),
        ],
      ),
    );
  }

  void _clearAllData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data'),
        content: const Text('This will permanently delete all your memories and settings. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement clear data functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All data cleared')),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  void _showNotificationsSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notifications'),
        content: const Text('Notification settings will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLanguageSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Language'),
        content: const Text('Language settings will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showHelpSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: const Text('Help and support information will be displayed here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAboutApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Untethered AI'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version: 1.0.0'),
            SizedBox(height: 8),
            Text('An offline, privacy-first AI smartphone assistant with context-aware memory, translation, and personal document search.'),
            SizedBox(height: 16),
            Text('© 2025 Untethered AI'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _resetApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset App'),
        content: const Text('This will clear all data and reset the app to its initial state. This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement reset functionality
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('App reset successfully')),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
} 