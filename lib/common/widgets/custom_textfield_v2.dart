import 'package:flutter/material.dart';
import 'package:td_shoping/constants/global_variables.dart';

// ignore: must_be_immutable
class CustomTextFielV2 extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData iconData;
  bool isShowPass;
  bool isShow;
  CustomTextFielV2({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconData,
    this.isShowPass = false,
    this.isShow = false,
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
          elevation: 8,
          shadowColor: Colors.black87,
          borderRadius: BorderRadius.circular(30),
          child: TextFormField(
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            obscureText: widget.isShowPass,
            controller: widget.controller,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              hintText: widget.hintText,
              suffixIcon: widget.isShow == false
                  ? null
                  : InkWell(
                      splashColor: Colors.transparent,
                      onTap: _toggle,
                      child: Icon(
                        isPassWord ? Icons.visibility_off : Icons.visibility,
                        color: GlobalVariables.secondaryColor,
                      )),
              prefixIcon: Icon(widget.iconData),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Không Được Để Trống ${widget.hintText}";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
