import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/functions/responsive.dart';
import 'image_item.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.imageUrl,
    required this.pageController,
    this.allImages,
    this.initialIndex = 0,
  });

  final String imageUrl;
  final List<String>? allImages;
  final PageController pageController;
  final int initialIndex;

  static void show(
    BuildContext context,
    String imageUrl, {
    List<String>? allImages,
    int initialIndex = 0,
  }) {
    final images = allImages ?? [imageUrl];
    final clampedIndex = initialIndex.clamp(0, images.length - 1);
    final pageController = PageController(initialPage: clampedIndex);

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.45),
      builder: (dialogContext) => ImageViewer(
        imageUrl: imageUrl,
        allImages: allImages,
        initialIndex: clampedIndex,
        pageController: pageController,
      ),
    ).then((_) => pageController.dispose());
  }

  @override
  Widget build(BuildContext context) {
    final images = allImages ?? [imageUrl];
    final size = MediaQuery.sizeOf(context);
    final hasMultiple = images.length > 1;

    return SizedBox.expand(
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.paddingOf(context).top + 4.height,
              left: 8.width,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.black.withValues(alpha: 0.35),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.width,
                  vertical: 48.height,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ShrinkWrapImageCarousel(
                      images: images,
                      pageController: pageController,
                      initialIndex: initialIndex,
                      maxWidth: size.width * 0.9,
                      maxHeight: size.height * 0.68,
                    ),
                    if (hasMultiple) ...[
                      SizedBox(height: 12.height),
                      _PageIndicator(
                        pageController: pageController,
                        count: images.length,
                        fallbackIndex: initialIndex,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShrinkWrapImageCarousel extends StatefulWidget {
  const _ShrinkWrapImageCarousel({
    required this.images,
    required this.pageController,
    required this.initialIndex,
    required this.maxWidth,
    required this.maxHeight,
  });

  final List<String> images;
  final PageController pageController;
  final int initialIndex;
  final double maxWidth;
  final double maxHeight;

  @override
  State<_ShrinkWrapImageCarousel> createState() =>
      _ShrinkWrapImageCarouselState();
}

class _ShrinkWrapImageCarouselState extends State<_ShrinkWrapImageCarousel> {
  Size? _displaySize;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _activeIndex = widget.initialIndex;
    _resolveSizeForIndex(_activeIndex);
    widget.pageController.addListener(_onPageScroll);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_onPageScroll);
    super.dispose();
  }

  void _onPageScroll() {
    if (!widget.pageController.hasClients) return;
    final page = widget.pageController.page;
    if (page == null) return;
    final index = page.round().clamp(0, widget.images.length - 1);
    if (index != _activeIndex) {
      _activeIndex = index;
      _resolveSizeForIndex(index);
    }
  }

  Future<void> _resolveSizeForIndex(int index) async {
    final intrinsic = await _resolveImageSize(widget.images[index]);
    if (!mounted) return;
    setState(() {
      _displaySize = intrinsic != null
          ? _fitSize(intrinsic, widget.maxWidth, widget.maxHeight)
          : Size(widget.maxWidth, widget.maxWidth * 0.56);
    });
  }

  @override
  Widget build(BuildContext context) {
    final frameSize = _displaySize ?? Size(widget.maxWidth, widget.maxWidth * 0.56);

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.radius),
        child: Material(
          color: Colors.white,
          child: SizedBox(
            width: frameSize.width,
            height: frameSize.height,
            child: PageView.builder(
              controller: widget.pageController,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  maxScale: 4,
                  child: ImageItem(
                    widget.images[index],
                    width: frameSize.width,
                    height: frameSize.height,
                    fit: BoxFit.contain,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

Size _fitSize(Size intrinsic, double maxW, double maxH) {
  var w = intrinsic.width;
  var h = intrinsic.height;
  if (w <= 0 || h <= 0) return Size(maxW, maxW * 0.56);

  if (w > maxW) {
    h *= maxW / w;
    w = maxW;
  }
  if (h > maxH) {
    w *= maxH / h;
    h = maxH;
  }
  return Size(w, h);
}

Future<Size?> _resolveImageSize(String source) async {
  if (source.isEmpty) return null;

  final completer = Completer<Size?>();
  ImageProvider provider;

  if (source.contains('assets/')) {
    provider = AssetImage(source);
  } else {
    provider = NetworkImage(source);
  }

  final stream = provider.resolve(ImageConfiguration.empty);
  late ImageStreamListener listener;

  listener = ImageStreamListener(
    (ImageInfo info, bool _) {
      if (!completer.isCompleted) {
        completer.complete(
          Size(
            info.image.width.toDouble(),
            info.image.height.toDouble(),
          ),
        );
      }
      stream.removeListener(listener);
    },
    onError: (Object _, StackTrace? _) {
      if (!completer.isCompleted) completer.complete(null);
      stream.removeListener(listener);
    },
  );

  stream.addListener(listener);

  try {
    return await completer.future.timeout(const Duration(seconds: 8));
  } catch (_) {
    stream.removeListener(listener);
    return null;
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.pageController,
    required this.count,
    required this.fallbackIndex,
  });

  final PageController pageController;
  final int count;
  final int fallbackIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, _) {
        final current = pageController.hasClients
            ? (pageController.page ?? fallbackIndex.toDouble()).round()
            : fallbackIndex;

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(count, (index) {
            final active = index == current;
            return Container(
              width: active ? 8.width : 6.width,
              height: 6.height,
              margin: EdgeInsets.symmetric(horizontal: 3.width),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: active ? 1 : 0.45),
                borderRadius: BorderRadius.circular(3.radius),
              ),
            );
          }),
        );
      },
    );
  }
}
