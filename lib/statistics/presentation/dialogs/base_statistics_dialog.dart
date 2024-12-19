import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class BaseStatisticsDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final Function() onShowGraph;

  const BaseStatisticsDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onShowGraph,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(child: content),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('cancel'.tr()),
        ),
        ElevatedButton(
          onPressed: onShowGraph,
          child: Text('refresh_graphs'.tr()),
        ),
      ],
    );
  }
}
