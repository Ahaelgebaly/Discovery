import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

Center circularProgress(context) {
  return Center(child: CircularProgressIndicator(color: Color(0xff3e97bd)));
}

Container linearProgress(context) {
  return Container(
    child: LinearProgressIndicator(
      valueColor:
          AlwaysStoppedAnimation(Theme.of(context).colorScheme.secondary),
    ),
  );
}
