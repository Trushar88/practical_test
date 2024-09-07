// ignore_for_file: file_names

import 'package:flutter/material.dart';

extension CustomUITheme on BuildContext {
  double screenWidth() {
    return MediaQuery.sizeOf(this).width;
  }

  double screenHeight() {
    return MediaQuery.sizeOf(this).height;
  }

  EdgeInsets get bodyPadding {
    return const EdgeInsets.only(left: 25, right: 25);
  }

  EdgeInsets get bodyLeftOnly {
    return const EdgeInsets.only(left: 20);
  }

  EdgeInsets get bodyAllPadding {
    return const EdgeInsets.all(20);
  }
}
