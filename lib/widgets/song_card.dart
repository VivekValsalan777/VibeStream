import 'package:flutter/material.dart';

class SongCard extends StatelessWidget {
  final String title;
  final String artist;
  final String? coverUrl;
  final VoidCallback onPlay;
  final VoidCallback? onMoreOptions;

  const SongCard({
    Key? key,
    required this.title,
    required this.artist,
    this.coverUrl,
    required this.onPlay,
    this.onMoreOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[800],
              ),
              child: coverUrl != null
                  ? Image.network(
                      coverUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.music_note),
            ),
            const SizedBox(height: 8),
            // Title and artist
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              artist,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            // Play and more buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FloatingActionButton.small(
                  onPressed: onPlay,
                  heroTag: null,
                  child: const Icon(Icons.play_arrow),
                ),
                if (onMoreOptions != null)
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: onMoreOptions,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
