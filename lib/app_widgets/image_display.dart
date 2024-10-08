import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageDisplay extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorBuilder;
  final Color? color;
  final int? maxCacheWidth;
  final String? placeHolder;

  const ImageDisplay(this.url, {Key? key, this.color, this.width, this.height, this.errorBuilder, this.fit, this.maxCacheWidth, this.placeHolder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.contains(".svg")) {
      if (url.contains("http")) {
        return SizedBox(
          width: width,
          height: height,
          child: SvgPicture.network(
            url,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            color: color,
          ),
        );
      } else {
        return SizedBox(
          width: width,
          height: height,
          child: SvgPicture.asset(
            url,
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            color: color,
          ),
        );
      }
    } else {
      if (url.contains("http")) {
        return SizedBox(
          width: width,
          height: height,
          child: CachedNetworkImage(
            maxWidthDiskCache: maxCacheWidth != null ? maxCacheWidth! : 712,
            imageUrl: url,
            width: width,
            height: height,
            fit: fit,
            color: color,
            errorWidget: (_, __, ___) {
              return errorBuilder ?? Container();
            },
            placeholder: (context, string) {
              return Container(
                  width: width,
                  height: height ?? width,
                  child: placeHolder != null ? Image.asset(placeHolder!, width: width, height: height ?? width) : CupertinoActivityIndicator());
            },
          ),
        );
      } else {
        return SizedBox(
          width: width,
          height: height,
          child: Image.asset(
            url,
            width: width,
            height: height,
            fit: fit,
            color: color,
            errorBuilder: (_, __, ___) {
              return errorBuilder ?? Container();
            },
          ),
        );
      }
    }
  }
}
