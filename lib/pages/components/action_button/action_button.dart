import 'package:flutter/material.dart';
import 'package:my_app1/pages/ressources/dimensions/constants.dart';

class ActionButton extends StatelessWidget {
  Function onPressed;
  Color color;
  String label;
  ActionButton({Key? key, required this.color, required this.onPressed, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Constants.screenHeight * 0.001, horizontal: Constants.screenWidth * 0.07),
      child: Container(
        height: Constants.screenHeight * 0.07,
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => onPressed(),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ),
    );
  }
}
