import 'package:flutter/services.dart';
import '../../index.dart';
import '../utils/constants.dart';

class InputWidget extends StatefulWidget {
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText, initialValue;
  final int? maxLines, maxLength;
  final Widget? prefixIcon, suffixIcon;
  final bool obscureText;
  final Color? hintColor;
  final bool enabled;
  final TextEditingController? controller;
  final double? height;
  final ValueChanged<String>? onChanged;
  final bool showTimeInDatePicker;
  final TextInputType keyboardType;
  final bool isTimePicker, isDatePicker;

  const InputWidget({
    super.key,
    this.validator,
    this.onSaved,
    this.inputFormatters,
    this.hintText,
    this.initialValue,
    this.maxLines,
    this.maxLength,
    this.hintColor,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.height,
  })  : isTimePicker = false,
        isDatePicker = false,
        showTimeInDatePicker = false;

  @override
  State<InputWidget> createState() => _InputWidgetState();

  InputWidget.timePicker({
    super.key,
    this.validator,
    this.onSaved,
    this.hintText,
    this.initialValue,
    this.hintColor,
    this.prefixIcon,
    this.suffixIcon,
  })  : enabled = false,
        isTimePicker = true,
        maxLines = 1,
        obscureText = false,
        keyboardType = TextInputType.text,
        height = null,
        maxLength = null,
        controller = null,
        onChanged = null,
        isDatePicker = false,
        showTimeInDatePicker = false,
        inputFormatters = [FilteringTextInputFormatter.singleLineFormatter];

  InputWidget.datePicker({
    super.key,
    this.validator,
    this.onSaved,
    this.hintText,
    this.initialValue,
    this.hintColor,
    this.prefixIcon,
    this.onChanged,
    this.showTimeInDatePicker = false,
    this.suffixIcon,
  })  : enabled = false,
        isTimePicker = false,
        maxLines = 1,
        obscureText = false,
        keyboardType = TextInputType.text,
        height = null,
        maxLength = null,
        controller = null,
        isDatePicker = true,
        inputFormatters = [FilteringTextInputFormatter.singleLineFormatter];
}

class _InputWidgetState extends State<InputWidget> {
  bool _showPassword = true;
  late final TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController(text: widget.initialValue);
    if (widget.obscureText) _showPassword = false;
  }

  @override
  didUpdateWidget(covariant InputWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _showPassword = !_showPassword;
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (oldWidget.initialValue != widget.initialValue) {
        _editingController.text = widget.initialValue ?? '';
      }
    });
  }

  _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    ).then((value) {
      if (value != null) {
        setState(() {
          _editingController.text = value.format(context);
        });
      }
    });
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().add(const Duration(days: -365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((value) {
      if (value != null) {
        setState(() {
          DateTime date = DateTime(value.year, value.month, value.day,
              DateTime.now().hour, DateTime.now().minute);

          _editingController.text = date.format(widget.showTimeInDatePicker
              ? Constants.dateTimeFormat
              : Constants.dateFormat);
          widget.onChanged?.call(_editingController.text);
        });
      }
    });
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height,
          child: TextFormField(
            onTapOutside: (_) {
              FocusScope.of(context).unfocus();
            },
            validator: widget.validator,
            controller: widget.controller ?? _editingController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: widget.onSaved,
            textAlignVertical: TextAlignVertical.top,
            onTap: () {
              if (widget.isTimePicker) _showTimePicker();
              if (widget.isDatePicker) _showDatePicker();
            },
            cursorColor: Colors.black87,
            onChanged: widget.onChanged,
            readOnly: widget.enabled ? false : true,
            maxLength: widget.maxLength,
            decoration: InputDecoration(
              prefixIconColor: Colors.black87,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Constants.borderColor,
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Constants.secondColor,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Constants.borderColor,
                  width: 0.5,
                ),
              ),
              hintText: widget.hintText,
              alignLabelWithHint: true,
              filled: true,
              fillColor: Colors.white,
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: Icon(
                        _showPassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_rounded,
                        color: Colors.grey,
                      ),
                    )
                  : widget.suffixIcon,
            ),
            maxLines: widget.maxLines ?? 1,
            obscureText: !_showPassword,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
          ),
        ),
      ],
    );
  }
}
