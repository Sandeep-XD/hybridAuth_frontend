import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileField extends StatefulWidget {
  //  Call back function to talk to the parent
  final Function(bool isValid) onValidationChanged;

  const MobileField({
    super.key, 
    required this.onValidationChanged, //  Require it when creating the widget
  });

  @override
  State<MobileField> createState() => _MobileFieldState();
}

class _MobileFieldState extends State<MobileField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(focusChange);
  }

  void focusChange() {
    //  user clicks AWAY from the field
    if (!_focusNode.hasFocus) {
      final text = _controller.text; 

      // if left the box before typing all 10 digits (and it's not empty)
      if (text.isNotEmpty && text.length < 10) {
        setState(() {
          _errorText = "Please enter a valid 10-digit mobile number";
        });
        //  Tell the parent it is NOT valid because they clicked away 
        widget.onValidationChanged(false);
      }
      print("focus out>>>>>>>>>>>>");
    } else {
      print("focus in>>>>>>>>>>>>");
    }
  }

  void _validate(String value) {
    String? newError;

    if (value.isEmpty) {
      newError = null;
    }
    //  Check if the first digit is wrong
    else if (!RegExp(r'^[6-9]').hasMatch(value)) {
      newError = "Number must start with 6, 7, 8, or 9";
    }
    // User is typing a valid number, but hasn't reached 10 digits yet
    else if (value.length < 10) {
      newError = null; // Stay quiet, let them type
    }
    // User hit exactly 10 digits. Check for the "all zeros" fake number
    else if (RegExp(r'^[6-9]0{9}$').hasMatch(value)) {
      newError = "Invalid mobile number";
    }
    //  Exactly 10 digits, starts with 6-9, not all zeros. It's perfect!
    else {
      newError = null;
    }

    // Only call setState if the error actually changed!
    if (_errorText != newError) {
      setState(() {
        _errorText = newError;
      });
    }

    //  Check if it's perfectly valid, and send that boolean to the parent!
    bool isPerfectlyValid = (newError == null && value.length == 10);
    widget.onValidationChanged(isPerfectlyValid);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Mobile Number",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: _validate,
          decoration: InputDecoration(
            errorText: _errorText,
            counterText: "",
            filled: true,
            fillColor: Colors.white.withOpacity(0.12),
            isDense: true,

            // Normal white border
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white),
            ),

            // Red only when error exists
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),

            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/images_flag.png",
                    height: 20,
                    width: 28,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    "+91",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
          ),
        ),
      ],
    );
  }
}