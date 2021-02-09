import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key key, this.label, this.onPressed, this.loading = false})
      : super(key: key);

  final Function onPressed;
  final String label;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: loading ? CircularProgressIndicator() : Text(label),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
