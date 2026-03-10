import 'package:flutter/material.dart';
import '../../../utils/validators/dob_utils.dart';
import '../../../utils/validators/pan_utils.dart';

class IdentifySection extends StatefulWidget {
  // Callback to notify the LoginCard
  final Function(bool isValid) onValidationChanged;

  const IdentifySection({
    super.key,
    required this.onValidationChanged,
  });

  @override
  State<IdentifySection> createState() => _IdentifySectionState();
}

class _IdentifySectionState extends State<IdentifySection> {
  String selected = 'dob';
  // Track the validity of each field locally
  bool isDobValid = false;
  bool isPanValid = false;

  // Helper to notify LoginCard based on the current selection
  void _notifyParent() {
    if (selected == 'dob') {
      widget.onValidationChanged(isDobValid);
    } else {
      widget.onValidationChanged(isPanValid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Identify Using",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),

        // Radio Section
        if (isMobile)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                value: 'dob',
                groupValue: selected,
                title: const Text("Date of Birth"),
                onChanged: (value) {
                  setState(() => selected = value!);
                  _notifyParent();
                },
              ),
              RadioListTile<String>(
                contentPadding: EdgeInsets.zero,
                value: 'pan',
                groupValue: selected,
                title: const Text("PAN"),
                onChanged: (value) {
                  setState(() => selected = value!);
                  _notifyParent();
                },
              ),
            ],
          )
        else
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: 'dob',
                    groupValue: selected,
                    onChanged: (value) {
                      setState(() => selected = value!);
                      _notifyParent();
                    },
                  ),
                  const Text("Date of Birth", style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(width: 80),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: 'pan',
                    groupValue: selected,
                    onChanged: (value) {
                      setState(() => selected = value!);
                      _notifyParent();
                    },
                  ),
                  const Text("PAN", style: TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),

        const SizedBox(height: 12),

        /// Using 'if/else' inside the list to avoid the 'Object' type error
        if (selected == 'dob')
          DOBField(
            onValidationChanged: (isValid) {
              isDobValid = isValid;
              _notifyParent();
            },
          )
        else
          PANField(
            onValidationChanged: (isValid) {
              isPanValid = isValid;
              _notifyParent();
            },
          ),
      ],
    );
  }
}