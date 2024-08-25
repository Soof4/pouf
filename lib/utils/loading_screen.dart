import 'package:flutter/material.dart';

class LoadingScreen {
  LoadingScreen._();

  static OverlayEntry? _entry;

  static void show(BuildContext context) {
    _entry = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );

    Overlay.of(context).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}
