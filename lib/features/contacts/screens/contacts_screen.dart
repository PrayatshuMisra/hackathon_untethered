import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  String _searchQuery = '';
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    
    _loadContacts();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadContacts() {
    _contacts = [
      Contact(
        id: '1',
        name: 'Rohan Mathur',
        email: 'rohanmathur@gmail.com',
        phone: '+91 98180 49557',
        avatar: '👨‍💼',
        isFavorite: true,
        lastContact: DateTime.now().subtract(const Duration(hours: 2)),
        tags: ['Work', 'Important'],
      ),
      Contact(
        id: '2',
        name: 'Prayatshu Misra',
        email: 'prayatshumisra@gmail.com',
        phone: '+91 79856 38485',
        avatar: '👩‍💻',
        isFavorite: true,
        lastContact: DateTime.now().subtract(const Duration(days: 1)),
        tags: ['Friend', 'Tech'],
      ),
      Contact(
        id: '3',
        name: 'Advait Balachandar',
        email: 'advait@gmail.com',
        phone: '+91 99999 88888',
        avatar: '👨‍🔬',
        isFavorite: false,
        lastContact: DateTime.now().subtract(const Duration(days: 3)),
        tags: ['Family'],
      ),
      Contact(
        id: '4',
        name: 'Shreshth Kabra',
        email: 'kabro@gmail.com',
        phone: '+91 99999 77777',
        avatar: '👩‍🎨',
        isFavorite: true,
        lastContact: DateTime.now().subtract(const Duration(hours: 6)),
        tags: ['Creative', 'Friend'],
      ),
      Contact(
        id: '5',
        name: 'Viraj',
        email: 'viraj@gmail.com',
        phone: '+91 99999 66666',
        avatar: '👨‍🏫',
        isFavorite: false,
        lastContact: DateTime.now().subtract(const Duration(days: 7)),
        tags: ['Work'],
      ),
      Contact(
        id: '6',
        name: 'Afsar',
        email: 'afsar@gmail.com',
        phone: '+91 99999 55555',
        avatar: '👩‍⚕️',
        isFavorite: true,
        lastContact: DateTime.now().subtract(const Duration(hours: 1)),
        tags: ['Health', 'Important'],
      ),
    ];
    _filteredContacts = _contacts;
  }

  void _filterContacts(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredContacts = _contacts;
      } else {
        _filteredContacts = _contacts.where((contact) {
          return contact.name.toLowerCase().contains(query.toLowerCase()) ||
                 contact.email.toLowerCase().contains(query.toLowerCase()) ||
                 contact.phone.contains(query) ||
                 contact.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
        }).toList();
      }
    });
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
              
              // Search Bar
              _buildSearchBar(),
              
              // Contacts List
              Expanded(
                child: _buildContactsList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewContact,
        backgroundColor: AppTheme.accentPink,
        child: const Icon(Icons.add, color: Colors.white),
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
                  'Contacts',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppTheme.textPrimaryLight,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  '${_filteredContacts.length} contacts',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.textSecondaryLight,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _showSortOptions,
            icon: const Icon(Icons.sort),
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

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: AppTheme.getGlassmorphicDecoration(context),
      child: TextField(
        onChanged: _filterContacts,
        decoration: InputDecoration(
          hintText: 'Search contacts...',
          prefixIcon: const Icon(Icons.search, color: AppTheme.textSecondaryLight),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppTheme.textSecondaryLight),
                  onPressed: () => _filterContacts(''),
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppTheme.textPrimaryLight,
          letterSpacing: 0.2,
        ),
      ),
    ).animate()
      .fadeIn(
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 200),
        curve: AppTheme.techCurve,
      )
      .slideY(
        begin: -0.2,
        duration: const Duration(milliseconds: 600),
        delay: const Duration(milliseconds: 200),
        curve: AppTheme.techCurve,
      );
  }

  Widget _buildContactsList() {
    if (_filteredContacts.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = _filteredContacts[index];
        return _buildContactCard(contact, index);
      },
    );
  }

  Widget _buildContactCard(Contact contact, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: AppTheme.getGlassmorphicDecoration(context),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () => _showContactDetails(contact),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: contact.isFavorite 
                      ? AppTheme.accentGradient 
                      : AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (contact.isFavorite ? AppTheme.accentPink : AppTheme.primaryBlue).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      contact.avatar,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Contact Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              contact.name,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppTheme.textPrimaryLight,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          if (contact.isFavorite)
                            Icon(
                              Icons.favorite,
                              color: AppTheme.accentPink,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contact.email,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondaryLight,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          // Tags
                          ...contact.tags.take(2).map((tag) => Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppTheme.primaryBlue.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tag,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppTheme.primaryBlue,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.1,
                              ),
                            ),
                          )),
                          const Spacer(),
                          Text(
                            _formatLastContact(contact.lastContact),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppTheme.textSecondaryLight.withOpacity(0.7),
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Action Menu
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert,
                    color: AppTheme.textSecondaryLight.withOpacity(0.7),
                  ),
                  onSelected: (value) => _handleContactAction(value, contact),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'call',
                      child: Row(
                        children: [
                          Icon(Icons.call, color: AppTheme.successGreen, size: 20),
                          const SizedBox(width: 8),
                          Text('Call', style: TextStyle(color: AppTheme.textPrimaryLight)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'message',
                      child: Row(
                        children: [
                          Icon(Icons.message, color: AppTheme.primaryBlue, size: 20),
                          const SizedBox(width: 8),
                          Text('Message', style: TextStyle(color: AppTheme.textPrimaryLight)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'email',
                      child: Row(
                        children: [
                          Icon(Icons.email, color: AppTheme.accentCyan, size: 20),
                          const SizedBox(width: 8),
                          Text('Email', style: TextStyle(color: AppTheme.textPrimaryLight)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'favorite',
                      child: Row(
                        children: [
                          Icon(
                            contact.isFavorite ? Icons.favorite_border : Icons.favorite,
                            color: AppTheme.accentPink,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            contact.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                            style: TextStyle(color: AppTheme.textPrimaryLight),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: AppTheme.warningOrange, size: 20),
                          const SizedBox(width: 8),
                          Text('Edit', style: TextStyle(color: AppTheme.textPrimaryLight)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: AppTheme.errorRed, size: 20),
                          const SizedBox(width: 8),
                          Text('Delete', style: TextStyle(color: AppTheme.textPrimaryLight)),
                        ],
                      ),
                    ),
                  ],
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
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
              Icons.people_outline,
              color: Colors.white,
              size: 60,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            _searchQuery.isEmpty ? 'No Contacts Yet' : 'No Contacts Found',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: AppTheme.textPrimaryLight,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isEmpty 
              ? 'Add your first contact to get started'
              : 'Try adjusting your search terms',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondaryLight,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.center,
          ),
          if (_searchQuery.isEmpty) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _addNewContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Add Contact',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatLastContact(DateTime lastContact) {
    final now = DateTime.now();
    final difference = now.difference(lastContact);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${difference.inDays ~/ 7}w ago';
    }
  }

  void _showContactDetails(Contact contact) {
    HapticFeedback.lightImpact();
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondaryLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Contact Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Avatar and Name
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: contact.isFavorite 
                          ? AppTheme.accentGradient 
                          : AppTheme.primaryGradient,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: (contact.isFavorite ? AppTheme.accentPink : AppTheme.primaryBlue).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          contact.avatar,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      contact.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: AppTheme.textPrimaryLight,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      contact.email,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textSecondaryLight,
                        letterSpacing: 0.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handleContactAction('call', contact),
                            icon: const Icon(Icons.call),
                            label: const Text('Call'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.successGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handleContactAction('message', contact),
                            icon: const Icon(Icons.message),
                            label: const Text('Message'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handleContactAction('email', contact),
                            icon: const Icon(Icons.email),
                            label: const Text('Email'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.accentCyan,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _handleContactAction('edit', contact),
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.warningOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  void _handleContactAction(String action, Contact contact) {
    HapticFeedback.lightImpact();
    
    switch (action) {
      case 'call':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Calling ${contact.name}...'),
            backgroundColor: AppTheme.successGreen,
          ),
        );
        break;
      case 'message':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening message to ${contact.name}...'),
            backgroundColor: AppTheme.primaryBlue,
          ),
        );
        break;
      case 'email':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening email to ${contact.name}...'),
            backgroundColor: AppTheme.accentCyan,
          ),
        );
        break;
      case 'favorite':
        setState(() {
          contact.isFavorite = !contact.isFavorite;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(contact.isFavorite 
              ? '${contact.name} added to favorites' 
              : '${contact.name} removed from favorites'),
            backgroundColor: AppTheme.accentPink,
          ),
        );
        break;
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Editing ${contact.name}...'),
            backgroundColor: AppTheme.warningOrange,
          ),
        );
        break;
      case 'delete':
        _showDeleteConfirmation(contact);
        break;
    }
  }

  void _showDeleteConfirmation(Contact contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
          'Delete Contact',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppTheme.textPrimaryLight,
            letterSpacing: 0.5,
          ),
        ),
        content: Text(
          'Are you sure you want to delete ${contact.name}? This action cannot be undone.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppTheme.textSecondaryLight,
            letterSpacing: 0.2,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: AppTheme.textSecondaryLight,
                letterSpacing: 0.2,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _contacts.remove(contact);
                _filterContacts(_searchQuery);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${contact.name} deleted'),
                  backgroundColor: AppTheme.errorRed,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorRed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Delete',
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

  void _addNewContact() {
    HapticFeedback.lightImpact();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Add new contact feature coming soon!'),
        backgroundColor: AppTheme.primaryBlue,
      ),
    );
  }

  void _showSortOptions() {
    HapticFeedback.lightImpact();
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondaryLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Sort Contacts',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.textPrimaryLight,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 24),
            ListTile(
              leading: Icon(Icons.sort_by_alpha, color: AppTheme.primaryBlue),
              title: Text('Name (A-Z)', style: TextStyle(color: AppTheme.textPrimaryLight)),
              onTap: () {
                Navigator.pop(context);
                _sortContacts('name');
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite, color: AppTheme.accentPink),
              title: Text('Favorites First', style: TextStyle(color: AppTheme.textPrimaryLight)),
              onTap: () {
                Navigator.pop(context);
                _sortContacts('favorites');
              },
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: AppTheme.accentCyan),
              title: Text('Recently Contacted', style: TextStyle(color: AppTheme.textPrimaryLight)),
              onTap: () {
                Navigator.pop(context);
                _sortContacts('recent');
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _sortContacts(String sortBy) {
    setState(() {
      switch (sortBy) {
        case 'name':
          _contacts.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'favorites':
          _contacts.sort((a, b) => b.isFavorite ? 1 : -1);
          break;
        case 'recent':
          _contacts.sort((a, b) => b.lastContact.compareTo(a.lastContact));
          break;
      }
      _filterContacts(_searchQuery);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contacts sorted by ${sortBy.replaceAll('_', ' ')}'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }
}

class Contact {
  String id;
  String name;
  String email;
  String phone;
  String avatar;
  bool isFavorite;
  DateTime lastContact;
  List<String> tags;

  Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.isFavorite,
    required this.lastContact,
    required this.tags,
  });
} 