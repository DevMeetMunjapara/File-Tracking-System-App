import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InfoStatus extends StatelessWidget {
  const InfoStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: const [
              Text(
                "File Reject ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.cancel,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "|",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            children: [
              Text(
                "In Procces ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.work_history,
                color: Color.fromARGB(255, 234, 187, 17),
              ),
            ],
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "|",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            children: [
              Text(
                "File Approve ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.verified,
                color: Color.fromARGB(255, 15, 161, 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
