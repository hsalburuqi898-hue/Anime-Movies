import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                  // Gradient overlay
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
                  onPressed: () {
                    // Add to favorites functionality
                  },
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
                  onPressed: () {
                    // Share functionality
                  },
                ),
              ),
            ],
          ),
          // Content
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
                        // Title with animation
                        Text(
                          title,
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                        ),
                        const SizedBox(height: 16),

                        // Score and status row
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

                        // Info chips with modern design
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

                        // Synopsis section with modern design
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

                        // Action buttons
                        if (malUrl.isNotEmpty) ...[
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton.icon(
                              onPressed: () => _launchURL(malUrl),
                              icon: const Icon(Icons.open_in_new_rounded),
                              label: const Text(
                                "View on MyAnimeList",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    // Add to watchlist
                                  },
                                  icon: const Icon(Icons.add_rounded),
                                  label: const Text("Watchlist"),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    // Mark as watched
                                  },
                                  icon: const Icon(Icons.check_rounded),
                                  label: const Text("Watched"),
                                  style: OutlinedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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






















/*  

//مشروع الاصلي 
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductView extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductView({Key? key, required this.product}) : super(key: key);

  // فتح الرابط في المتصفح
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = product['images']?['jpg']?['large_image_url'];
    final title = product['title'] ?? "Unknown Title";
    final year = product['year']?.toString() ?? "N/A";
    final type = product['type'] ?? "N/A";
    final episodes = product['episodes']?.toString() ?? "N/A";
    final rating = product['rating'] ?? "N/A";
    final synopsis = product['synopsis'] ?? "No description available.";
    final malUrl = product['url'] ?? "";

    return Scaffold(
      appBar: AppBar(
        title: Text(title, overflow: TextOverflow.ellipsis),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                Chip(label: Text("Year: $year")),
                Chip(label: Text("Type: $type")),
                Chip(label: Text("Episodes: $episodes")),
                Chip(label: Text("Rating: $rating")),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Synopsis",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              synopsis,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            if (malUrl.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () => _launchURL(malUrl),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text(
                    "View on MyAnimeList",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

*/























/*
import 'package:flutter/material.dart';
import 'cart.dart'; // global cart list
import 'cart_view.dart'; // CartView widget

class ProductView extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List images = product['images'] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text(product['title'] ?? "Product")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الصورة الرئيسية
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  product['thumbnail'], // الصورة الرئيسية
                  height: 250,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // صور متعددة (سطر أفقي)
            if (images.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final imgUrl = images[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imgUrl,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

            const SizedBox(height: 16),

            // اسم المنتج
            Text(
              product['title'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            // السعر
            Text(
              "\$${product['price']}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            // الوصف
            Text(product['description'], style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 16),

            // الفئة
            Chip(label: Text(product['category'])),

            const SizedBox(height: 24),

            // زر إضافة للسلة
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  cart.add(product);
                  debugPrint("Product added to cart: ${product['title']}");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartView(cartItems: cart),
                    ),
                  );
                },
                child: const Text("Add to Cart"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/