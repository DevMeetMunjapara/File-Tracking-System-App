import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FileStatusIcon extends StatelessWidget {
  var fileStatus;
  var size = 20;
  var setSize;
  FileStatusIcon({
    super.key,
    this.setSize,
    required this.fileStatus,
  });
  Widget iconFun(String status) {
    if (status == "Reject") {
      return Icon(
        Icons.cancel,
        size: setSize == null ? size : setSize,
        color: Colors.red,
      );
    } else if (status == "Process") {
      return Icon(
        Icons.work_history,
        size: setSize != null ? setSize : size,
        color: Color.fromARGB(255, 234, 187, 17),
      );
    } else if (status == "Approved") {
      return Icon(
        Icons.verified,
        size: setSize != null ? setSize : size,
        color: Color.fromARGB(255, 15, 161, 20),
      );
    } else if (status == null) {
      return Text("data");
    }
    return Icon(Icons.abc);
  }

  @override
  Widget build(BuildContext context) {
    return iconFun(fileStatus);
  }
}
