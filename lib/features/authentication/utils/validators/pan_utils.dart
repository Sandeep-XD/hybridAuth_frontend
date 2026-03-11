import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PANField extends StatefulWidget {
  // Add the callback
  final Function(bool isValid) onValidationChanged;

  const PANField({super.key, required this.onValidationChanged});

  @override
  State<PANField> createState() => _PANFieldState();
}

class _PANFieldState extends State<PANField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _validatePAN(String value) {
    value = value.toUpperCase();

    if (value.isEmpty) {
      _updateStatus(null, false);
      return;
    }

    // Do not show error for first 3 letters
    if (value.length <= 3) {
      _updateStatus(null, false);
      return;
    }

    // 4th character must be P
    if (value.length >= 4 && value[3] != 'P') {
      _updateStatus("Fourth character must be 'P' for personal PAN.", false);
      return;
    }

    // If full length reached → validate completely
    if (value.length == 10) {
      final RegExp panRegex = RegExp(r'^[A-Z]{3}P[A-Z][0-9]{4}[A-Z]$');

      if (!panRegex.hasMatch(value)) {
        _updateStatus(
          "Invalid PAN number. Please enter a valid PAN number.",
          false,
        );
        return;
      }

      // VALID CASE
      _updateStatus(null, true);
    } else {
      // If user still typing (between 5-9 chars)
      _updateStatus(null, false);
    }
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      final value = _controller.text.toUpperCase();
      if (value.isEmpty) return;

      if (value.length != 10) {
        _updateStatus("Please enter complete PAN number.", false);
        return;
      }

      final RegExp panRegex = RegExp(r'^[A-Z]{3}P[A-Z][0-9]{4}[A-Z]$');
      if (!panRegex.hasMatch(value)) {
        _updateStatus(
          "Invalid PAN number. Please enter a valid PAN number.",
          false,
        );
      }
    }
  }

  void _updateStatus(String? error, bool isValid) {
    if (_errorText != error) {
      setState(() => _errorText = error);
    }
    widget.onValidationChanged(isValid);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      textCapitalization: TextCapitalization.characters,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
        LengthLimitingTextInputFormatter(10),
        UpperCaseTextFormatter(),
      ],
      onChanged: _validatePAN,
      decoration: InputDecoration(
        isDense: true,
        hintText: "Enter your PAN number",
        errorText: _errorText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.15),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.2),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.withOpacity(0.8),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
