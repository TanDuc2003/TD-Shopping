import 'package:flutter/material.dart';
import 'package:td_shoping/constants/global_variables.dart';

// ignore: must_be_immutable
class CustomTextFielV2 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData iconData;
  bool isShowPass;
  bool isShow;
  TextInputType keyboardType;
  CustomTextFielV2({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconData,
    this.isShowPass = false,
    this.isShow = false,
    this.keyboardType = TextInputType.text,
  });
  @override
  State<CustomTextFielV2> createState() => _CustomTextFielV2State();
}

class _CustomTextFielV2State extends State<CustomTextFielV2> {
  bool isPassWord = false;

  void _toggle() {
    setState(() {
      isPassWord = !isPassWord;
      widget.isShowPass = !widget.isShowPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      keyboardType: widget.keyboardType,
      obscureText: widget.isShowPass,
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        labelText: widget.hintText,
        filled: true,
        suffixIcon: widget.isShow == false
            ? Icon(widget.iconData)
            : InkWell(
                splashColor: Colors.transparent,
                onTap: _toggle,
                child: Icon(
                  isPassWord ? Icons.visibility_off : Icons.visibility,
                  color: GlobalVariables.secondaryColor,
                )),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Không Được Để Trống ${widget.hintText}";
        }
        return null;
      },
    );
  }
}
