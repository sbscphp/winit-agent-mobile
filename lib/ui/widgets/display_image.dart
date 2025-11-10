import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:winit_agent/core/constants/app_theme/custom_color_scheme.dart';
import 'package:winit_agent/core/constants/color_path.dart';
import 'package:winit_agent/core/utilities/utilities.dart';
import 'package:winit_agent/ui/widgets/lgbtq_container.dart';
import 'package:winit_agent/ui/widgets/media_placeholder.dart';

class DisplayImage extends StatefulWidget {
  final String? imageUrl;
  final String firstName;
  final String lastName;
  final double? size;
  final double? initialsSize;

  const DisplayImage({
    super.key,
    required this.imageUrl,
    required this.firstName,
    required this.lastName,
    this.initialsSize,
    this.size
  });

  @override
  State<DisplayImage> createState() => _DisplayImageState();
}

class _DisplayImageState extends State<DisplayImage> {
  ImageProvider? _imageProvider;

  @override
  void initState() {
    super.initState();
    if (_hasImage(widget.imageUrl)) {
      _imageProvider = CachedNetworkImageProvider(widget.imageUrl!);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_imageProvider != null) {
      precacheImage(_imageProvider!, context);
    }
  }

  @override
  void didUpdateWidget(covariant DisplayImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl && _hasImage(widget.imageUrl)) {
      setState(() {
        _imageProvider = CachedNetworkImageProvider(widget.imageUrl!);
      });
      precacheImage(_imageProvider!, context);
    } else if (!_hasImage(widget.imageUrl)) {
      setState(() {
        _imageProvider = null;
      });
    }
  }

  bool _hasImage(String? url) {
    return url != null && url.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return LgbtqContainer(
      child: Container(
        height: widget.size?.h ?? 80.h,
        width: widget.size?.w ?? 80.w,
        color: _imageProvider != null
            ? Theme.of(context).colorScheme.textPrimary
            : Colors.white,
        child: _imageProvider != null
            ? Image(
          image: _imageProvider!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _noImage(context),
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: MediaPlaceholder());
          },
        )
            : _noImage(context),
      ),
    );
  }

  _noImage(BuildContext context) {
    return Center(
      child: Text(
        Utilities.getNameInitials(firstName: widget.firstName, lastName: widget.lastName),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: widget.initialsSize?.sp ?? 24.sp,
            fontWeight: FontWeight.w800,
            color: ColorPath.curiousBlue
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
