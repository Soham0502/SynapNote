import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:sahayak_ui/providers/ai_provider.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to get the analysis result
    final analysisResult = ref.watch(analysisResultProvider);

    if (analysisResult == null) {
      // Show a message if there's no result data for some reason
      return Scaffold(
        appBar: AppBar(title: const Text('Analysis Failed')),
        body: const Center(
          child: Text('Could not load analysis results. Please try again.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Results'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // Use a ListView to make the content scrollable
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            context: context,
            icon: LucideIcons.key,
            title: 'Keywords',
            content: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: analysisResult.keywords
                  .map((keyword) => Chip(label: Text(keyword)))
                  .toList(),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            context: context,
            icon: LucideIcons.fileText,
            title: 'Summary',
            content: Text(analysisResult.summary),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            context: context,
            icon: LucideIcons.lightbulb,
            title: 'Memory Aid (Mnemonic)',
            content: Text(analysisResult.mnemonics),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            context: context,
            icon: LucideIcons.brainCircuit,
            title: 'Concept Map',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: analysisResult.conceptMap.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [
                        TextSpan(
                          text: '${entry.key}: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent,
                          ),
                        ),
                        TextSpan(text: entry.value.join(', ')),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          _buildSectionCard(
            context: context,
            icon: LucideIcons.puzzle,
            title: 'Quiz',
            // For now, we'll just display the questions.
            // We can make this interactive later.
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: analysisResult.quiz.asMap().entries.map((entry) {
                int idx = entry.key;
                var question = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text('${idx + 1}. ${question.question}'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to create a consistent look for each section
  Widget _buildSectionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget content,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.cyanAccent, size: 20),
                const SizedBox(width: 8),
                Text(title, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const Divider(height: 24),
            content,
          ],
        ),
      ),
    );
  }
}
