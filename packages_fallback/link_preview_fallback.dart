import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';

/// Fallback implementation for link_preview_generator package
/// Fetches and displays link previews with title, description, and image
class LinkPreviewFallback extends StatefulWidget {
  final String link;
  final LinkPreviewStyle style;
  final bool showGraphic;
  final bool showBody;
  final BoxFit graphicFit;
  final int bodyMaxLines;
  final TextOverflow bodyTextOverflow;
  final double borderRadius;
  final Widget? placeholderWidget;
  final VoidCallback? onTap;

  const LinkPreviewFallback({
    Key? key,
    required this.link,
    this.style = LinkPreviewStyle.small,
    this.showGraphic = true,
    this.showBody = true,
    this.graphicFit = BoxFit.cover,
    this.bodyMaxLines = 2,
    this.bodyTextOverflow = TextOverflow.ellipsis,
    this.borderRadius = 16.0,
    this.placeholderWidget,
    this.onTap,
  }) : super(key: key);

  @override
  State<LinkPreviewFallback> createState() => _LinkPreviewFallbackState();
}

class _LinkPreviewFallbackState extends State<LinkPreviewFallback> {
  LinkPreviewData? _previewData;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchPreview();
  }

  Future<void> _fetchPreview() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      final uri = Uri.parse(widget.link);
      final response = await http.get(uri).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Request timeout');
        },
      );

      if (response.statusCode == 200) {
        final html = response.body;
        final data = _parseHtml(html, widget.link);
        setState(() {
          _previewData = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _hasError = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('LinkPreviewFallback error: $e');
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    }
  }

  LinkPreviewData _parseHtml(String html, String url) {
    String? title;
    String? description;
    String? imageUrl;

    // Extract title from <title> tag or og:title
    final titleMatch = RegExp(r'<title[^>]*>([^<]+)</title>', caseSensitive: false).firstMatch(html);
    if (titleMatch != null) {
      title = titleMatch.group(1)?.trim();
    }

    // Extract og:title - try different quote styles
    var ogTitleMatch = RegExp(r'<meta[^>]*property="og:title"[^>]*content="([^"]+)"', caseSensitive: false).firstMatch(html);
    if (ogTitleMatch == null) {
      ogTitleMatch = RegExp(r"<meta[^>]*property='og:title'[^>]*content='([^']+)'", caseSensitive: false).firstMatch(html);
    }
    if (ogTitleMatch == null) {
      ogTitleMatch = RegExp(r'<meta[^>]*property=og:title[^>]*content=([^\s>]+)', caseSensitive: false).firstMatch(html);
    }
    if (ogTitleMatch != null) {
      title = ogTitleMatch.group(1)?.trim();
    }

    // Extract description from meta description or og:description
    var descMatch = RegExp(r'<meta[^>]*name="description"[^>]*content="([^"]+)"', caseSensitive: false).firstMatch(html);
    if (descMatch == null) {
      descMatch = RegExp(r"<meta[^>]*name='description'[^>]*content='([^']+)'", caseSensitive: false).firstMatch(html);
    }
    if (descMatch == null) {
      descMatch = RegExp(r'<meta[^>]*name=description[^>]*content=([^\s>]+)', caseSensitive: false).firstMatch(html);
    }
    if (descMatch != null) {
      description = descMatch.group(1)?.trim();
    }

    var ogDescMatch = RegExp(r'<meta[^>]*property="og:description"[^>]*content="([^"]+)"', caseSensitive: false).firstMatch(html);
    if (ogDescMatch == null) {
      ogDescMatch = RegExp(r"<meta[^>]*property='og:description'[^>]*content='([^']+)'", caseSensitive: false).firstMatch(html);
    }
    if (ogDescMatch == null) {
      ogDescMatch = RegExp(r'<meta[^>]*property=og:description[^>]*content=([^\s>]+)', caseSensitive: false).firstMatch(html);
    }
    if (ogDescMatch != null) {
      description = ogDescMatch.group(1)?.trim();
    }

    // Extract image from og:image
    var imageMatch = RegExp(r'<meta[^>]*property="og:image"[^>]*content="([^"]+)"', caseSensitive: false).firstMatch(html);
    if (imageMatch == null) {
      imageMatch = RegExp(r"<meta[^>]*property='og:image'[^>]*content='([^']+)'", caseSensitive: false).firstMatch(html);
    }
    if (imageMatch == null) {
      imageMatch = RegExp(r'<meta[^>]*property=og:image[^>]*content=([^\s>]+)', caseSensitive: false).firstMatch(html);
    }
    if (imageMatch != null) {
      imageUrl = imageMatch.group(1)?.trim();
      // Handle relative URLs
      if (imageUrl != null && !imageUrl.startsWith('http')) {
        final baseUri = Uri.parse(url);
        imageUrl = '${baseUri.scheme}://${baseUri.host}${imageUrl.startsWith('/') ? '' : '/'}$imageUrl';
      }
    }

    return LinkPreviewData(
      title: title ?? _extractDomain(url),
      description: description ?? '',
      imageUrl: imageUrl,
      url: url,
    );
  }

  String _extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceAll('www.', '');
    } catch (e) {
      return url;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return widget.placeholderWidget ??
          Container(
            height: widget.style == LinkPreviewStyle.large ? 200.h : 120.h,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(widget.borderRadius.r),
            ),
            child: Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          );
    }

    if (_hasError || _previewData == null) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: widget.onTap ?? () => gotToUrl(widget.link),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(widget.borderRadius.r),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 0.5,
          ),
        ),
        child: widget.style == LinkPreviewStyle.large
            ? _buildLargePreview(context)
            : _buildSmallPreview(context),
      ),
    );
  }

  Widget _buildLargePreview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showGraphic && _previewData!.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius.r),
              topRight: Radius.circular(widget.borderRadius.r),
            ),
            child: CachedNetworkImage(
              imageUrl: _previewData!.imageUrl!,
              fit: widget.graphicFit,
              height: 200.h,
              width: double.infinity,
              placeholder: (context, url) => Container(
                height: 200.h,
                color: Theme.of(context).dividerColor,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200.h,
                color: Theme.of(context).dividerColor,
                child: Icon(
                  Icons.image_not_supported,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
        Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_previewData!.title != null)
                Text(
                  _previewData!.title!,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              if (widget.showBody && _previewData!.description != null && _previewData!.description!.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(
                  _previewData!.description!,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: widget.bodyMaxLines,
                  overflow: widget.bodyTextOverflow,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSmallPreview(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showGraphic && _previewData!.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(widget.borderRadius.r),
              bottomLeft: Radius.circular(widget.borderRadius.r),
            ),
            child: CachedNetworkImage(
              imageUrl: _previewData!.imageUrl!,
              fit: widget.graphicFit,
              width: 120.w,
              height: 120.h,
              placeholder: (context, url) => Container(
                width: 120.w,
                height: 120.h,
                color: Theme.of(context).dividerColor,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: 120.w,
                height: 120.h,
                color: Theme.of(context).dividerColor,
                child: Icon(
                  Icons.image_not_supported,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_previewData!.title != null)
                  Text(
                    _previewData!.title!,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (widget.showBody && _previewData!.description != null && _previewData!.description!.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Text(
                    _previewData!.description!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: widget.bodyMaxLines,
                    overflow: widget.bodyTextOverflow,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LinkPreviewData {
  final String? title;
  final String? description;
  final String? imageUrl;
  final String url;

  LinkPreviewData({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.url,
  });
}

enum LinkPreviewStyle {
  small,
  large,
}

/// Alias for compatibility
typedef LinkPreviewGenerator = LinkPreviewFallback;

