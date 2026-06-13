import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotGridBlock extends StatelessWidget {
  static const MAX_CROSS_AXIS_EXTENT = 180.0;
  static const CHILD_ASPECT_RATIO = 7 / 12;

  static SliverGridDelegateWithMaxCrossAxisExtent getMaxCrossAxisExtent({
    double maxCrossAxisExtent = MAX_CROSS_AXIS_EXTENT,
    double childAspectRatio = CHILD_ASPECT_RATIO,
  }) {
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: maxCrossAxisExtent,
      childAspectRatio: childAspectRatio,
    );
  }

  final IconData? posterPlaceholderIcon;
  final String? posterUrl;
  final Map? posterHeaders;
  final bool posterIsSquare;
  final String? backgroundUrl;
  final Map? backgroundHeaders;
  final Color? backgroundColor;

  final bool disabled;
  final String? title;
  final TextSpan subtitle;
  final Color titleColor;

  final Function? onTap;
  final Function? onLongPress;

  const ArrPilotGridBlock({
    Key? key,
    this.disabled = false,
    required this.title,
    required this.subtitle,
    this.titleColor = Colors.white,
    this.backgroundColor,
    this.posterPlaceholderIcon,
    this.posterUrl,
    this.posterHeaders = const {},
    this.backgroundUrl,
    this.backgroundHeaders = const {},
    this.posterIsSquare = false,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotCard(
      context: context,
      margin: ArrPilotUI.MARGIN_HALF,
      color: backgroundColor,
      child: InkWell(
        child: Stack(
          children: [
            if (backgroundUrl?.isNotEmpty ?? false) _fadeInBackground(context),
            Opacity(
              opacity: disabled ? ArrPilotUI.OPACITY_DISABLED : 1.0,
              child: Padding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _poster(context),
                    _title(),
                    _subtitle(),
                    const SizedBox(height: ArrPilotUI.DEFAULT_MARGIN_SIZE),
                  ],
                ),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
        mouseCursor: onTap != null || onLongPress != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        onTap: onTap as void Function()?,
        onLongPress: onLongPress as void Function()?,
      ),
    );
  }

  Widget _fadeInBackground(BuildContext context) {
    if (backgroundUrl == null) return const SizedBox();

    final _percent = ArrPilotDatabase.THEME_IMAGE_BACKGROUND_OPACITY.read();
    if (_percent == 0) return const SizedBox(height: 0, width: 0);

    double _opacity = _percent / 100;
    if (disabled) _opacity *= ArrPilotUI.OPACITY_DISABLED;

    return Opacity(
      opacity: _opacity,
      child: FadeInImage(
        placeholder: MemoryImage(kTransparentImage),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fadeInDuration: const Duration(
          milliseconds: ArrPilotUI.ANIMATION_SPEED_IMAGES,
        ),
        fit: BoxFit.cover,
        image: ArrPilotNetworkImageProvider(
          url: backgroundUrl!,
          headers: backgroundHeaders?.cast<String, String>(),
        ).imageProvider,
        imageErrorBuilder: (context, error, stack) => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }

  Widget _poster(BuildContext context) {
    if (posterUrl == null && posterPlaceholderIcon == null) {
      throw Exception('Need a posterUrl or posterPlaceholderIcon');
    }

    return Flexible(
      child: Padding(
        child: ArrPilotNetworkImage(
          context: context,
          url: posterUrl ?? '',
          height: MAX_CROSS_AXIS_EXTENT * 1.5,
          width: MAX_CROSS_AXIS_EXTENT,
          headers: posterHeaders,
          placeholderIcon: posterPlaceholderIcon,
        ),
        padding: ArrPilotUI.MARGIN_HALF,
      ),
    );
  }

  Widget _title() {
    return Container(
      child: Padding(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: ArrPilotUI.FONT_SIZE_H3,
                color: ArrPilotColours.white,
                fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
              ),
              text: title,
            ),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ),
        padding: ArrPilotUI.MARGIN_DEFAULT_HORIZONTAL,
      ),
      alignment: Alignment.centerLeft,
      height: ArrPilotBlock.SUBTITLE_HEIGHT,
    );
  }

  Widget _subtitle() {
    return Container(
      child: Padding(
        child: SingleChildScrollView(
          controller: ScrollController(),
          scrollDirection: Axis.horizontal,
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: ArrPilotUI.FONT_SIZE_H3,
                color: ArrPilotColours.grey,
              ),
              children: [subtitle],
            ),
            overflow: TextOverflow.visible,
            softWrap: false,
          ),
        ),
        padding: ArrPilotUI.MARGIN_DEFAULT_HORIZONTAL,
      ),
      alignment: Alignment.centerLeft,
      height: ArrPilotBlock.SUBTITLE_HEIGHT,
    );
  }
}
