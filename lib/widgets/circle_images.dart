// ignore: import_of_legacy_library_into_null_safe
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleImageFromFile extends StatelessWidget {
  final fileName;

  CircleImageFromFile(this.fileName);

  @override
  Widget build(BuildContext context) {
    double _size = 120.0;

    return new Container(
      height: _size,
      width: _size,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0x33A6A6A6)),
        // image: new Image.asset(_image.)
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(_size),
          child: new Image.file(fileName)),
    );
  }
}

class CircleImageFromNetwork extends StatelessWidget {
  final url;
  final placeholder;
  final errorHolder;
  double? size;
  Color? borderColor;
  double? clipSize;
  dynamic fit;
  String? text;

  CircleImageFromNetwork(this.url, this.placeholder, this.errorHolder,
      {size, borderColor, clipSize, fit, text}) {
    this.size = double.parse(size.toString());
    this.borderColor = borderColor;
    this.fit = fit;
    this.text = text;
    this.clipSize = clipSize != null ? double.parse(clipSize.toString()) : null;
  }

  @override
  Widget build(BuildContext context) {
    double _size = size ?? 120.0;
    double _clipSize = clipSize ?? 100;
    if (url.toString().isEmpty || url.toString().toLowerCase() == "null") {
      return CircleProfileImageText(text.toString(), size: _size,);
    }
    return new Container(
      height: _size,
      width: _size,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor ?? Color(0x33A6A6A6)),
        /*image: new DecorationImage(
          fit: BoxFit.fill,
          image: new CachedNetworkImageProvider(url),
        ),*/
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_size),
        child: CachedNetworkImage(
          height: _clipSize,
          width: _clipSize,
          fit: fit ?? BoxFit.contain,
          imageUrl: "https://api.dhoro.io$url",
          placeholder: (context, url) => SvgPicture.asset(
            placeholder,
            height: _clipSize,
            width: _clipSize,
            fit: fit ?? BoxFit.contain,
          ),
          errorWidget: (context, url, error) => SvgPicture.asset(
            errorHolder,
            height: _clipSize,
            width: _clipSize,
            fit: fit ?? BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class CircleProfileImageText extends StatelessWidget {
  String text;
  double? size;

  CircleProfileImageText(this.text, {size}) {
    if(text.isEmpty || text.toLowerCase()=="null"){
      this.text = "**";
    }
    this.size = double.parse(size.toString());
  }

  @override
  Widget build(BuildContext context) {
    double _size = size ?? 120.0;

    return new Container(
      height: _size,
      width: _size,
      decoration:
          new BoxDecoration(shape: BoxShape.circle, color: Pallet.colorBlue),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_size),
        child: Center(
          child: AppFontsStyle.getAppTextViewBold(text,
              color: Pallet.colorWhite, size: 20.0),
        ),
      ),
    );
  }
}
