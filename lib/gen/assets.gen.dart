/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/activity.svg
  SvgGenImage get activity => const SvgGenImage('assets/icons/activity.svg');

  /// File path: assets/icons/arrow_left.svg
  SvgGenImage get arrowLeft => const SvgGenImage('assets/icons/arrow_left.svg');

  /// File path: assets/icons/camera.svg
  SvgGenImage get camera => const SvgGenImage('assets/icons/camera.svg');

  /// File path: assets/icons/chat.svg
  SvgGenImage get chat => const SvgGenImage('assets/icons/chat.svg');

  /// File path: assets/icons/delete.svg
  SvgGenImage get delete => const SvgGenImage('assets/icons/delete.svg');

  /// File path: assets/icons/delete_1.svg
  SvgGenImage get delete1 => const SvgGenImage('assets/icons/delete_1.svg');

  /// File path: assets/icons/filter_2.svg
  SvgGenImage get filter2 => const SvgGenImage('assets/icons/filter_2.svg');

  /// File path: assets/icons/google.svg
  SvgGenImage get google => const SvgGenImage('assets/icons/google.svg');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/icons/logo.svg');

  /// File path: assets/icons/logout.svg
  SvgGenImage get logout => const SvgGenImage('assets/icons/logout.svg');

  /// File path: assets/icons/message.svg
  SvgGenImage get message => const SvgGenImage('assets/icons/message.svg');

  /// File path: assets/icons/more.svg
  SvgGenImage get more => const SvgGenImage('assets/icons/more.svg');

  /// File path: assets/icons/more_circle.svg
  SvgGenImage get moreCircle =>
      const SvgGenImage('assets/icons/more_circle.svg');

  /// File path: assets/icons/notes.svg
  SvgGenImage get notes => const SvgGenImage('assets/icons/notes.svg');

  /// File path: assets/icons/notification.svg
  SvgGenImage get notification =>
      const SvgGenImage('assets/icons/notification.svg');

  /// File path: assets/icons/paper.svg
  SvgGenImage get paper => const SvgGenImage('assets/icons/paper.svg');

  /// File path: assets/icons/person.svg
  SvgGenImage get person => const SvgGenImage('assets/icons/person.svg');

  /// File path: assets/icons/plus.svg
  SvgGenImage get plus => const SvgGenImage('assets/icons/plus.svg');

  /// File path: assets/icons/search.svg
  SvgGenImage get search => const SvgGenImage('assets/icons/search.svg');

  /// File path: assets/icons/send.svg
  SvgGenImage get send => const SvgGenImage('assets/icons/send.svg');

  /// File path: assets/icons/sent.svg
  SvgGenImage get sent => const SvgGenImage('assets/icons/sent.svg');

  /// File path: assets/icons/setting.svg
  SvgGenImage get setting => const SvgGenImage('assets/icons/setting.svg');

  /// File path: assets/icons/side_line.svg
  SvgGenImage get sideLine => const SvgGenImage('assets/icons/side_line.svg');

  /// File path: assets/icons/task.svg
  SvgGenImage get task => const SvgGenImage('assets/icons/task.svg');

  /// File path: assets/icons/task_item.svg
  SvgGenImage get taskItem => const SvgGenImage('assets/icons/task_item.svg');

  /// File path: assets/icons/timeline.svg
  SvgGenImage get timeline => const SvgGenImage('assets/icons/timeline.svg');

  /// File path: assets/icons/voice_1.svg
  SvgGenImage get voice1 => const SvgGenImage('assets/icons/voice_1.svg');

  /// File path: assets/icons/voice_2.svg
  SvgGenImage get voice2 => const SvgGenImage('assets/icons/voice_2.svg');

  /// List of all assets
  List<SvgGenImage> get values => [
        activity,
        arrowLeft,
        camera,
        chat,
        delete,
        delete1,
        filter2,
        google,
        home,
        logo,
        logout,
        message,
        more,
        moreCircle,
        notes,
        notification,
        paper,
        person,
        plus,
        search,
        send,
        sent,
        setting,
        sideLine,
        task,
        taskItem,
        timeline,
        voice1,
        voice2
      ];
}

class $AssetsIlluGen {
  const $AssetsIlluGen();

  /// File path: assets/illu/freelancer.svg
  SvgGenImage get freelancer => const SvgGenImage('assets/illu/freelancer.svg');

  /// File path: assets/illu/office.svg
  SvgGenImage get office => const SvgGenImage('assets/illu/office.svg');

  /// File path: assets/illu/plan.png
  AssetGenImage get planPng => const AssetGenImage('assets/illu/plan.png');

  /// File path: assets/illu/plan.svg
  SvgGenImage get planSvg => const SvgGenImage('assets/illu/plan.svg');

  /// File path: assets/illu/question.png
  AssetGenImage get question => const AssetGenImage('assets/illu/question.png');

  /// File path: assets/illu/stay_org.png
  AssetGenImage get stayOrg => const AssetGenImage('assets/illu/stay_org.png');

  /// List of all assets
  List<dynamic> get values =>
      [freelancer, office, planPng, planSvg, question, stayOrg];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsIlluGen illu = $AssetsIlluGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
