import 'package:flutter/material.dart';

/// the list of dismissible backgrounds, collected in a readable manner
class DismissibleBackGround {
  /// `done`
  static const done = ColoredBox(
    color: Colors.green,
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
    ),
  );

  /// `delete`
  static const delete = ColoredBox(
    color: Colors.red,
    child: Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    ),
  );

  /// `restore`
  static const restore = ColoredBox(
    color: Colors.lightBlue,
    child: Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: Icon(
          Icons.restore,
          color: Colors.white,
        ),
      ),
    ),
  );
}
