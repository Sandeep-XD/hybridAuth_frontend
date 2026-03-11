import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DOBField extends StatefulWidget {
  final Function(bool isValid) onValidationChanged;

  const DOBField({super.key, required this.onValidationChanged});

  @override
  State<DOBField> createState() => _DOBFieldState();
}

class _DOBFieldState extends State<DOBField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      final text = _controller.text;

      // CHECK LENGTH ON FOCUS OUT (Exactly like your mobile field)
      if (text.isNotEmpty && text.length < 10) {
        _updateStatus("Please enter a valid  DOB (DD/MM/YYYY)", false);
      } else {
        // If it is 10 characters, run the final date logic check
        _validateDOB(text);
      }
    }
  }

  void _validateDOB(String value) {
    String errorMessage =
        "Invalid Date of Birth. Please enter a valid date of birth.";
    List<String> parts = value.split('/');

    // Local variable to track if it's currently valid
    bool isValid = false;

    //  Validate DAY
    if (parts.isNotEmpty && parts[0].length == 2) {
      int? day = int.tryParse(parts[0]);
      if (day == null || day < 1 || day > 31) {
        _updateStatus(errorMessage, false);
        return;
      }
    }

    //  Validate MONTH
    if (parts.length > 1 && parts[1].length == 2) {
      int? month = int.tryParse(parts[1]);
      if (month == null || month < 1 || month > 12) {
        _updateStatus(errorMessage, false);
        return;
      }
    }

    //  Validate YEAR and Final check
    if (parts.length > 2 && parts[2].length == 4) {
      int? year = int.tryParse(parts[2]);
      if (year == null || year < 1950 || year > 2020) {
        _updateStatus(errorMessage, false);
        return;
      }

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int maxDays = _daysInMonth(month, year);

      if (day > maxDays) {
        _updateStatus(errorMessage, false);
        return;
      }

      //  we reached here, the date is full (10 chars) and valid!
      isValid = true;
    }

    _updateStatus(null, isValid);
  }

  int _daysInMonth(int month, int year) {
    if (month == 2) {
      bool isLeap = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
      return isLeap ? 29 : 28;
    }
    const monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return monthDays[month - 1];
  }

  // Helper to update both local error UI and parent status
  void _updateStatus(String? error, bool validStatus) {
    if (_errorText != error) {
      setState(() => _errorText = error);
    }
    widget.onValidationChanged(validStatus);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DOBInputFormatter(),
      ],
      onChanged: _validateDOB,
      decoration: InputDecoration(
        hintText: "DD/MM/YYYY",
        errorText: _errorText,
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        // suffixIcon: const Icon(Icons.calendar_today_outlined),
      ),
    );
  }
}

class DOBInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.length > 8) {
      digits = digits.substring(0, 8);
    }

    String formatted = '';
    for (int i = 0; i < digits.length; i++) {
      formatted += digits[i];
      if ((i == 1 || i == 3) && i != digits.length - 1) {
        formatted += '/';
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
