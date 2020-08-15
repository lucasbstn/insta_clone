import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileButton extends StatelessWidget {
  final String label;
  final Function onClick;
  final Color color;
  const ProfileButton({
    Key key,
    this.label,
    this.onClick,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Center(
        child: SizedBox(
          width: Get.width * 0.9,
          height: 30,
          child: RaisedButton(
            color: color,
            child: Text(
              label,
              style: TextStyle(
                color: color == Colors.blue ? Colors.white : Colors.black,
              ),
            ),
            onPressed: onClick,
          ),
        ),
      ),
    );
  }
}
