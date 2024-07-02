import 'dart:async';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

class RefreshWidget extends StatelessWidget {
  final Widget child;
  final FutureOr Function()? onRefresh;
  final FutureOr Function()? onLoad;
  final EasyRefreshController? controller;

  const RefreshWidget(
      {super.key,
      required this.child,
      this.onRefresh,
      this.onLoad,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      header: const ClassicHeader(
        dragText: 'Pull to refresh',
        armedText: 'Release ready',
        readyText: 'Refreshing...',
        processingText: 'Refreshing...',
        processedText: 'Succeeded',
        noMoreText: 'No more',
        failedText: 'Failed',
        messageText: 'Last updated at %T',
        safeArea: false,
      ),
      footer: const ClassicFooter(
        position: IndicatorPosition.locator,
        dragText: 'Pull to load',
        armedText: 'Release ready',
        readyText: 'Loading...',
        processingText: 'Loading...',
        processedText: 'Succeeded',
        noMoreText: 'No more',
        failedText: 'Failed',
        messageText: 'Last updated at %T',
      ),
      callRefreshOverOffset: 60,
      controller: controller,
      onRefresh: () => onRefresh?.call(),
      onLoad: () => onLoad?.call(),
      child: child,
    );
  }
}
