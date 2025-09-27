import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_flutter/lucide_flutter.dart';
import 'package:sahayak_ui/models/analysis_models.dart';
import 'package:sahayak_ui/providers/ai_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // --- Logic to trigger analysis using Riverpod ---
  Future<void> _analyseNote() async {
    if (_noteController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter some text to analyze.")),
      );
      return;
    }

    // Clear previous results before starting a new analysis
    ref.read(analysisResultProvider.notifier).state = null;

    // Set loading state to true
    ref.read(isLoadingProvider.notifier).state = true;

    try {
      // Call the AI service via the provider
      final result = await ref
          .read(aiServiceProvider)
          .analyzeText(_noteController.text);

      // Save the result to the provider, which will update the UI
      ref.read(analysisResultProvider.notifier).state = result;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
      }
    } finally {
      // Set loading state back to false
      ref.read(isLoadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch providers to rebuild the UI when state changes
    final isLoading = ref.watch(isLoadingProvider);
    final analysisResult = ref.watch(analysisResultProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // The theme changing menu can be added back here if needed
      ),
      body: Stack(
        children: [
          // --- Your Custom Background UI ---
          Positioned(
            bottom: -100,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0xFFDBC9F5),
                borderRadius: BorderRadius.vertical(
                  top: Radius.elliptical(500, 200),
                ),
              ),
            ),
          ),
          Positioned(
            top: -50,
            left: -30,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFFE1D9FC),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // --- Main Scrollable Content ---
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // --- Your App Title UI ---
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Syn',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF7846EC),
                        ),
                      ),
                      Text(
                        'apNo',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'te',
                        style: TextStyle(
                          color: Color(0xFF3CF8D5),
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // --- Your Input Card UI ---
                  Container(
                    padding: const EdgeInsets.all(22),
                    height: 300,
                    width: 500,
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _noteController,
                            maxLines: null, // Allows multiline input
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText:
                                  'Start typing or paste your notes here...',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFF9159DB),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: const BorderSide(
                                  color: Color(0xFF9159DB),
                                  width: 2.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: isLoading ? null : _analyseNote,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9159DB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 40,
                              vertical: 12,
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3.0,
                                  ),
                                )
                              : const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Analyse',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // --- Results Section ---
                  // This section will only appear after analysis is complete
                  if (analysisResult != null)
                    ResultsSection(analysisResult: analysisResult),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- A New Widget to Contain Your Tab Bar and Results ---
class ResultsSection extends StatefulWidget {
  final AnalysisResult analysisResult;
  const ResultsSection({super.key, required this.analysisResult});

  @override
  State<ResultsSection> createState() => _ResultsSectionState();
}

class _ResultsSectionState extends State<ResultsSection> {
  int _selectedIndex = 0;
  final List<String> _tabs = ['Summary', 'Keywords', 'Quiz'];

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0: // Summary
        return Text(widget.analysisResult.summary);
      case 1: // Keywords
        return Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: widget.analysisResult.keywords
              .map((keyword) => Chip(label: Text(keyword)))
              .toList(),
        );
      case 2: // Quiz
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.analysisResult.quiz.asMap().entries.map((entry) {
            int idx = entry.key;
            var question = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text('${idx + 1}. ${question.question}'),
            );
          }).toList(),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // --- Your TabBar UI ---
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: List.generate(_tabs.length, (index) {
                final bool isSelected = _selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 300,
                      ), // Faster animation
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF9159DB)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          _tabs[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          const Divider(height: 30),
          // --- Content that changes based on the selected tab ---
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: Align(
              key: ValueKey(_selectedIndex), // Important for AnimatedSwitcher
              alignment: Alignment.topLeft,
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }
}
