import '../widget/constant_color.dart';
import 'package:flutter/material.dart';

class FormContainer extends StatefulWidget {
  @override
  _FormContainerState createState() => _FormContainerState();
  final TextEditingController? controller;
  final Key? fieldkey;
  final bool? isPasswordField;
  final String? hintText;
  final String? helperText;
  final String? labelText;
  final FormFieldSetter<String>? onsaved;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final ValueChanged<String>? onfieldSubmitted;
  final Icon? prefixIcon;
  final int widthLength=500;
  final int heightLength=600;

  const FormContainer({
    super.key,
    this.controller,
    this.fieldkey,
    this.helperText,
    this.hintText,
    this.inputType,
    this.isPasswordField,
    this.labelText,
    this.onfieldSubmitted,
    this.onsaved,
    this.validator,
    this.prefixIcon,
  });
}

class _FormContainerState extends State<FormContainer> {
  bool _obsecure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border(bottom: BorderSide(width: 2, color: themeblue)),
        ),
        child: TextFormField(
          controller: widget.controller,
          key: widget.fieldkey,
          keyboardType: widget.inputType,
          validator: widget.validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onFieldSubmitted: widget.onfieldSubmitted,
          obscureText: widget.isPasswordField == true ? _obsecure : false,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: const Color.fromARGB(123, 0, 0, 0),
              fontFamily: "Ubuntu",
              fontSize: 15,
            ),
            prefixIcon: widget.prefixIcon,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            errorMaxLines: 1,
            errorStyle: TextStyle(
              color: themegreydarker,
              fontFamily: "Ubuntu",
              fontSize: 10,
            ),
            suffixIcon:
                widget.isPasswordField == true
                    ? IconButton(
                      onPressed: () {
                        setState(() {
                          _obsecure = !_obsecure;
                        });
                      },
                      icon: Icon(
                        _obsecure ? Icons.visibility_off : Icons.visibility,
                        color: _obsecure ? themegreydarker : themedark,
                      ),
                    )
                    : null,
          ),
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Ubuntu",
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
