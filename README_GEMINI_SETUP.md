# Gemini API Integration Setup

This document explains how to set up and use the Gemini API integration for SynapNote's keyword highlighting and definition features.

## Prerequisites

1. **Get a Gemini API Key**
   - Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
   - Sign in with your Google account
   - Click "Create API Key"
   - Copy the generated API key

2. **Configure the API Key**
   - Open `lib/services/gemini_service.dart`
   - Replace `YOUR_GEMINI_API_KEY_HERE` with your actual API key:
   ```dart
   static const String _apiKey = 'your_actual_api_key_here';
   ```

## Features

### 1. Keyword Extraction
The Gemini API analyzes your notes and extracts important keywords and key phrases that would be useful for students to understand and remember.

### 2. Definition Generation
For each extracted keyword, the API generates clear, concise definitions that are:
- Easy to understand for students
- Accurate and informative
- 1-3 sentences long
- Include context for technical terms

### 3. Text Highlighting
The app highlights keywords in your notes, making them easily identifiable.

### 4. Interactive Definitions
- **Long press** on any highlighted keyword to see its definition
- **Tap** on keyword chips to view definitions
- Clean popup interface for definition display

## Usage

1. **Switch to Gemini Mode**
   - In the home screen, toggle the "Analysis Mode" switch to "Gemini AI"

2. **Analyze Your Notes**
   - Type or paste your notes in the text field
   - Click the "Analyse" button
   - Wait for the AI to process your text

3. **View Results**
   - **Highlighted Text**: See your original text with keywords highlighted
   - **Keywords**: View all extracted keywords as interactive chips
   - **Definitions**: Browse all keywords and their definitions

4. **Interact with Keywords**
   - Long press any highlighted word to see its definition
   - Tap keyword chips to view definitions
   - Use the popup to learn more about specific terms

## API Rate Limits

- The service includes a 500ms delay between definition requests to avoid rate limiting
- If you encounter rate limit errors, the app will skip problematic keywords and continue processing others

## Error Handling

The app handles various error scenarios:
- **No API Key**: Shows configuration error message
- **Network Issues**: Displays connection error
- **Invalid Response**: Handles malformed API responses
- **Rate Limiting**: Gracefully skips problematic requests

## Troubleshooting

### "Gemini API key not configured" Error
- Make sure you've replaced `YOUR_GEMINI_API_KEY_HERE` with your actual API key
- Restart the app after making changes

### "No internet connection" Error
- Check your device's internet connection
- Ensure the Gemini API is accessible from your network

### Keywords Not Highlighting
- The app only highlights whole words, not partial matches
- Overlapping keywords are filtered to avoid conflicts
- Very short or common words might not be extracted as keywords

## Cost Considerations

- Gemini API has usage limits and pricing
- Each text analysis makes multiple API calls (one for keywords, one for each definition)
- Monitor your API usage in the Google AI Studio dashboard

## Privacy and Security

- Your notes are sent to Google's Gemini API for processing
- API keys should be kept secure and not shared
- Consider the privacy implications of sending sensitive notes to external services

## Development Notes

### Key Files
- `lib/services/gemini_service.dart`: Core API integration
- `lib/services/text_analyzer_service.dart`: Text analysis logic
- `lib/models/keyword_highlight.dart`: Data models
- `lib/providers/text_analysis_provider.dart`: State management
- `lib/widgets/highlighted_text_widget.dart`: UI components

### Extending the Service
You can extend the Gemini integration by:
- Adding more sophisticated prompts
- Implementing caching for definitions
- Adding support for different languages
- Customizing the keyword extraction criteria

## Future Enhancements

Potential improvements include:
- Offline caching of definitions
- Custom keyword categories
- Export functionality for analyzed notes
- Integration with spaced repetition systems
- Support for images and PDFs