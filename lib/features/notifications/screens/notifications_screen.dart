import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  List<NotificationItem> _notifications = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    
    _loadNotifications();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadNotifications() {
    _notifications = [
      NotificationItem(
        id: '1',
        title: 'Memory Captured',
        message: 'Your AI has captured 3 new memories from today\'s activities.',
        type: NotificationType.success,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        icon: Icons.psychology,
        action: 'View Memories',
      ),
      NotificationItem(
        id: '2',
        title: 'Translation Complete',
        message: 'Successfully translated conversation from Spanish to English.',
        type: NotificationType.info,
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        icon: Icons.translate,
        action: 'View Translation',
      ),
      NotificationItem(
        id: '3',
        title: 'Mesh Network Connected',
        message: 'Connected to 5 nearby users in your mesh network.',
        type: NotificationType.success,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        icon: Icons.wifi_tethering,
        action: 'View Network',
      ),
      NotificationItem(
        id: '4',
        title: 'Daily Summary Ready',
        message: 'Your AI has prepared a comprehensive summary of today\'s activities.',
        type: NotificationType.info,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        icon: Icons.summarize,
        action: 'View Summary',
      ),
      NotificationItem(
        id: '5',
        title: 'Storage Optimization',
        message: 'Optimized storage usage by 15%. Removed 23 old memories.',
        type: NotificationType.warning,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        icon: Icons.storage,
        action: 'Manage Storage',
      ),
      NotificationItem(
        id: '6',
        title: 'New Contact Added',
        message: 'Added "John Doe" to your favorite contacts.',
        type: NotificationType.success,
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        icon: Icons.person_add,
        action: 'View Contacts',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.backgroundLight,
              AppTheme.backgroundLight.withOpacity(0.8),
              AppTheme.primaryBlue.withOpacity(0.05),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              
              // Notifications List
              Expanded(
                child: _buildNotificationsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: AppTheme.textPrimaryLight,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.textPrimaryLight,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  '${_notifications.length} notifications',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryLight,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _markAllAsRead,
            icon: const Icon(Icons.done_all),
            color: AppTheme.primaryBlue,
          ),
        ],
      ),
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        curve: AppTheme.techCurve,
      )
      .slideY(
        begin: -0.3,
        duration: const Duration(milliseconds: 600),
        curve: AppTheme.techCurve,
      );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        return _buildNotificationCard(notification, index);
      },
    );
  }

  Widget _buildNotificationCard(NotificationItem notification, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppTheme.getGlassmorphicDecoration(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _handleNotificationTap(notification),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: _getNotificationGradient(notification.type),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: _getNotificationColor(notification.type).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    notification.icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.textPrimaryLight,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondaryLight,
                          letterSpacing: 0.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            _formatTimestamp(notification.timestamp),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondaryLight.withOpacity(0.7),
                              letterSpacing: 0.1,
                            ),
                          ),
                          const Spacer(),
                          if (notification.action.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getNotificationColor(notification.type).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _getNotificationColor(notification.type).withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                notification.action,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: _getNotificationColor(notification.type),
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Action Button
                IconButton(
                  onPressed: () => _dismissNotification(notification.id),
                  icon: const Icon(Icons.close),
                  color: AppTheme.textSecondaryLight.withOpacity(0.5),
                  iconSize: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        delay: Duration(milliseconds: index * 100),
        curve: AppTheme.techCurve,
      )
      .slideX(
        begin: 0.3,
        duration: const Duration(milliseconds: 600),
        delay: Duration(milliseconds: index * 100),
        curve: AppTheme.techCurve,
      );
  }

  Color _getNotificationColor(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return AppTheme.successGreen;
      case NotificationType.warning:
        return AppTheme.warningOrange;
      case NotificationType.error:
        return AppTheme.errorRed;
      case NotificationType.info:
        return AppTheme.primaryBlue;
    }
  }

  LinearGradient _getNotificationGradient(NotificationType type) {
    switch (type) {
      case NotificationType.success:
        return AppTheme.cyberGradient;
      case NotificationType.warning:
        return AppTheme.accentGradient;
      case NotificationType.error:
        return AppTheme.secondaryGradient;
      case NotificationType.info:
        return AppTheme.primaryGradient;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _handleNotificationTap(NotificationItem notification) {
    HapticFeedback.lightImpact();
    
    // Show action dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          notification.title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimaryLight,
            letterSpacing: 0.5,
          ),
        ),
        content: Text(
          notification.message,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondaryLight,
            letterSpacing: 0.2,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: TextStyle(
                color: AppTheme.textSecondaryLight,
                letterSpacing: 0.2,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performNotificationAction(notification);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _getNotificationColor(notification.type),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              notification.action,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _performNotificationAction(NotificationItem notification) {
    // Navigate to appropriate screen based on notification type
    switch (notification.icon) {
      case Icons.psychology:
        // Navigate to memories
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening memories...'),
            backgroundColor: AppTheme.successGreen,
          ),
        );
        break;
      case Icons.translate:
        // Navigate to translation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening translation...'),
            backgroundColor: AppTheme.primaryBlue,
          ),
        );
        break;
      case Icons.wifi_tethering:
        // Navigate to mesh network
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening mesh network...'),
            backgroundColor: AppTheme.secondaryPurple,
          ),
        );
        break;
      case Icons.summarize:
        // Show summary
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Showing daily summary...'),
            backgroundColor: AppTheme.accentCyan,
          ),
        );
        break;
      case Icons.storage:
        // Navigate to storage settings
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening storage settings...'),
            backgroundColor: AppTheme.warningOrange,
          ),
        );
        break;
      case Icons.person_add:
        // Navigate to contacts
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening contacts...'),
            backgroundColor: AppTheme.accentPink,
          ),
        );
        break;
    }
  }

  void _dismissNotification(String id) {
    setState(() {
      _notifications.removeWhere((notification) => notification.id == id);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Notification dismissed'),
        backgroundColor: AppTheme.textSecondaryLight,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _markAllAsRead() {
    HapticFeedback.lightImpact();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('All notifications marked as read'),
        backgroundColor: AppTheme.successGreen,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime timestamp;
  final IconData icon;
  final String action;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.icon,
    required this.action,
  });
}

enum NotificationType {
  success,
  warning,
  error,
  info,
} 