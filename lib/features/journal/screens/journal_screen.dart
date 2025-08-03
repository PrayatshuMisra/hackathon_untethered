import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../core/providers/memory_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/memory_card.dart';
import '../widgets/memory_filter.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = ['All', 'Work', 'Personal', 'General'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Memory Journal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Show search dialog
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Buttons
          MemoryFilter(
            filters: _filters,
            selectedFilter: _selectedFilter,
            onFilterChanged: (filter) {
              setState(() {
                _selectedFilter = filter;
              });
            },
          ),
          const SizedBox(height: 16),

          // Timeline
          Expanded(
            child: Consumer<MemoryProvider>(
              builder: (context, memoryProvider, child) {
                final memories = memoryProvider.getMemoriesByCategory(_selectedFilter);

                if (memories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.book_outlined,
                          size: 64,
                          color: AppTheme.primaryBlue.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No memories yet',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.primaryBlue.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Start recording your day to see memories here',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.primaryBlue.withOpacity(0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: memories.length,
                  itemBuilder: (context, index) {
                    final memory = memories[index];
                    final isFirst = index == 0;
                    final isLast = index == memories.length - 1;

                    return Column(
                      children: [
                        // Timeline connector
                        if (!isFirst)
                          Container(
                            width: 2,
                            height: 20,
                            color: AppTheme.primaryBlue.withOpacity(0.3),
                            margin: const EdgeInsets.only(left: 24),
                          ),
                        
                        // Memory Card
                        MemoryCard(
                          memory: memory,
                          onTap: () => _showMemoryDetails(context, memory),
                          onDelete: () => _deleteMemory(context, memory.id),
                        ),

                        // Timeline connector
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 20,
                            color: AppTheme.primaryBlue.withOpacity(0.3),
                            margin: const EdgeInsets.only(left: 24),
                          ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'summarize',
            onPressed: () => _summarizeDay(context),
            backgroundColor: AppTheme.secondaryTeal,
            child: const Icon(Icons.summarize, color: Colors.white),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'forget',
            onPressed: () => _forgetLastMinutes(context),
            backgroundColor: Colors.red,
            child: const Icon(Icons.delete_sweep, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final controller = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Memories'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: 'Enter keywords to search...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (query) {
            Navigator.of(context).pop();
            _searchMemories(context, query);
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _searchMemories(context, controller.text);
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _searchMemories(BuildContext context, String query) {
    if (query.isEmpty) return;
    
    final memoryProvider = context.read<MemoryProvider>();
    final results = memoryProvider.searchMemories(query);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Search Results for "$query"'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: results.isEmpty
              ? const Center(child: Text('No results found'))
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final memory = results[index];
                    return ListTile(
                      title: Text(memory.transcript),
                      subtitle: Text(
                        DateFormat('MMM dd, HH:mm').format(memory.timestamp),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _showMemoryDetails(context, memory);
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showMemoryDetails(BuildContext context, memory) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Memory Details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time: ${DateFormat('MMM dd, yyyy HH:mm').format(memory.timestamp)}'),
            const SizedBox(height: 8),
            Text('Transcript: ${memory.transcript}'),
            if (memory.detectedObjects.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Detected Objects: ${memory.detectedObjects.join(', ')}'),
            ],
            if (memory.mood != 'neutral') ...[
              const SizedBox(height: 8),
              Text('Mood: ${memory.mood}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _deleteMemory(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Memory'),
        content: const Text('Are you sure you want to delete this memory?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<MemoryProvider>().deleteMemory(id);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _summarizeDay(BuildContext context) {
    final memoryProvider = context.read<MemoryProvider>();
    final summary = memoryProvider.getDaySummary();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Today\'s Summary'),
        content: Text(summary),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _forgetLastMinutes(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forget Last 5 Minutes'),
        content: const Text('This will delete all memories from the last 5 minutes. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<MemoryProvider>().deleteLastMinutes(5);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
} 