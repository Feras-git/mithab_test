import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAnimatedButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Color btnFirstColor;
  final Color btnLastColor;
  final Duration duration;
  final Size btnFirstSize;
  final Size btnLastSize;
  final Color? textColor;
  final Function onPressed;

  CustomAnimatedButton({
    required this.text,
    required this.btnFirstColor,
    required this.btnLastColor,
    required this.duration,
    required this.btnFirstSize,
    required this.btnLastSize,
    required this.icon,
    required this.textColor,
    required this.onPressed,
  });

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton> {
  late Size _btnSize;
  late Color _btnColor;

  @override
  void initState() {
    _btnSize = widget.btnFirstSize;
    _btnColor = widget.btnFirstColor;
    Future.delayed(Duration.zero, () {
      setState(() {
        _btnSize = widget.btnLastSize;
        _btnColor = widget.btnLastColor;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressed(),
      child: AnimatedContainer(
        duration: widget.duration,
        width: _btnSize.width,
        height: _btnSize.height,
        decoration: BoxDecoration(
          color: _btnColor,
          borderRadius: BorderRadius.all(Radius.circular(25.sp)),
        ),
        curve: Curves.decelerate,
        onEnd: () {
          setState(() {
            _btnSize = _btnSize == widget.btnFirstSize
                ? widget.btnLastSize
                : widget.btnFirstSize;
            _btnColor = _btnColor == widget.btnFirstColor
                ? widget.btnLastColor
                : widget.btnFirstColor;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: widget.textColor ?? Colors.white,
            ),
            Text(
              '  ' + widget.text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: widget.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
