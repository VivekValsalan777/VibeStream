import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../../providers/auth_provider.dart';
import '../../providers/storage_provider.dart';
import '../../theme/app_theme.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({Key? key}) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  File? _selectedAudioFile;
  File? _selectedCoverImage;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );

      if (result != null) {
        setState(() {
          _selectedAudioFile = File(result.files.single.path!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking audio: $e')),
      );
    }
  }

  Future<void> _pickCoverImage() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null) {
        setState(() {
          _selectedCoverImage = File(result.files.single.path!);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _handleUpload() async {
    if (_titleController.text.isEmpty || _selectedAudioFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a title and select an audio file'),
        ),
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final storageProvider = Provider.of<StorageProvider>(context, listen: false);

    if (authProvider.currentUser == null) return;

    setState(() {
      _isUploading = true;
    });

    final audioUrl = await storageProvider.uploadAudio(
      audioFile: _selectedAudioFile!,
      userId: authProvider.currentUser!.uid,
      songTitle: _titleController.text,
    );

    if (audioUrl != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Song uploaded successfully!')),
      );
      Navigator.of(context).pop();
    } else if (mounted) {
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(storageProvider.error ?? 'Upload failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image Section
              Text(
                'Cover Image',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _isUploading ? null : _pickCoverImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: _selectedCoverImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _selectedCoverImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.image_outlined,
                              size: 48,
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Tap to select cover image',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppTheme.primaryColor),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 32),

              // Song Title
              Text(
                'Song Title',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Enter song title',
                  prefixIcon: const Icon(Icons.music_note),
                ),
                enabled: !_isUploading,
              ),
              const SizedBox(height: 24),

              // Description
              Text(
                'Description',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Describe your song',
                  prefixIcon: const Icon(Icons.description),
                ),
                maxLines: 4,
                enabled: !_isUploading,
              ),
              const SizedBox(height: 24),

              // Audio File Section
              Text(
                'Audio File',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _isUploading ? null : _pickAudioFile,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedAudioFile != null
                          ? AppTheme.successColor
                          : AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _selectedAudioFile != null
                            ? Icons.check_circle
                            : Icons.upload_file,
                        size: 48,
                        color: _selectedAudioFile != null
                            ? AppTheme.successColor
                            : AppTheme.primaryColor,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _selectedAudioFile != null
                            ? _selectedAudioFile!.path.split('/').last
                            : 'Tap to select audio file',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                              color: _selectedAudioFile != null
                                  ? AppTheme.successColor
                                  : AppTheme.primaryColor,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Upload Progress
              Consumer<StorageProvider>(
                builder: (context, storageProvider, _) {
                  return Column(
                    children: [
                      if (storageProvider.isUploading) ...
                        [
                          LinearProgressIndicator(
                            value: storageProvider.uploadProgress,
                            minHeight: 8,
                            backgroundColor: AppTheme.surfaceColor,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            '${(storageProvider.uploadProgress * 100).toStringAsFixed(0)}%',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 32),
                        ],
                    ],
                  );
                },
              ),

              // Upload Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isUploading ? null : _handleUpload,
                  child: _isUploading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text('Upload Song'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
