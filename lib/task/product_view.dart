import 'package:flutter/material.dart';
import 'package:project/task/SeatBookingScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SeatBookingScreen.dart';

class ProductView extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductView({super.key, required this.product});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          ),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open $url'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = widget.product['images']?['jpg']?['large_image_url'];
    final title = widget.product['title'] ?? "Unknown Title";
    final year = widget.product['year']?.toString() ?? "N/A";
    final type = widget.product['type'] ?? "N/A";
    final episodes = widget.product['episodes']?.toString() ?? "N/A";
    final rating = widget.product['rating'] ?? "N/A";
    final score = widget.product['score']?.toString() ?? "N/A";
    final synopsis = widget.product['synopsis'] ?? "No description available.";
    final malUrl = widget.product['url'] ?? "";
    final duration = widget.product['duration'] ?? "N/A";
    final status = widget.product['status'] ?? "N/A";

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom AppBar with image
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            stretch: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (imageUrl != null)
                    Hero(
                      tag: 'movie-${widget.product['mal_id']}',
                      child: Image.network(imageUrl, fit: BoxFit.cover),
                    ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).scaffoldBackgroundColor.withOpacity(0.9),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).scaffoldBackgroundColor.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.05),
                        Theme.of(context).scaffoldBackgroundColor,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            if (score != 'N/A')
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star_rounded,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      score,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: _getStatusColor(status),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                status,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            _buildInfoChip(
                              context,
                              Icons.calendar_today_rounded,
                              "Year",
                              year,
                            ),
                            _buildInfoChip(
                              context,
                              Icons.movie_rounded,
                              "Type",
                              type,
                            ),
                            _buildInfoChip(
                              context,
                              Icons.playlist_play_rounded,
                              "Episodes",
                              episodes,
                            ),
                            _buildInfoChip(
                              context,
                              Icons.timer_rounded,
                              "Duration",
                              duration,
                            ),
                            _buildInfoChip(
                              context,
                              Icons.child_care_rounded,
                              "Rating",
                              rating,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surface.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).colorScheme.outline.withOpacity(0.1),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.description_rounded,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    "Synopsis",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                synopsis,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      height: 1.6,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withOpacity(0.8),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 32),

                        // UPDATED: Book Seats Button (replaces Watchlist/Watched)
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SeatBookingScreen(movie: widget.product),
                                ),
                              );
                            },
                            icon: const Icon(Icons.event_seat_rounded),
                            label: const Text(
                              "Book Seats",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6B5B95),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // View on MyAnimeList button
                        if (malUrl.isNotEmpty)
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: OutlinedButton.icon(
                              onPressed: () => _launchURL(malUrl),
                              icon: const Icon(Icons.open_in_new_rounded),
                              label: const Text("View on MyAnimeList"),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF6B5B95),
                                side: const BorderSide(
                                  color: Color(0xFF6B5B95),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'finished':
        return Colors.green;
      case 'airing':
        return Colors.blue;
      case 'upcoming':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
