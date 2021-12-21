import 'package:dhoro_mobile/utils/app_fonts.dart';
import 'package:dhoro_mobile/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFormField extends StatefulWidget {
  bool? focus;
  TextEditingController? controller = new TextEditingController();

  /**
   * Look at the decorator declared here before duplicating and passing your own
   */
  InputDecoration? decorator;
  double? height;
  String label;
  Widget? icon;
  Function()? onTap;
  FormFieldValidator<String>? validator;
  Function(String)? onChanged;
  bool? enabled = true;

  AppFormField(
      {this.controller,
        this.decorator,
        this.height,
        required this.label,
        this.icon,
        this.onTap,
        this.enabled,
        this.validator,
        this.onChanged});

  @override
  _AppFormFieldState createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  void _onFocusChange(bool focus) {
    setState(() {
      widget.focus = focus;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
      height: widget.height ?? null,
      decoration: BoxDecoration(
        border: widget.focus == true
            ? Border.all(width: 1.0, color: Pallet.colorBlue)
            : Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: FocusScope(
          child: Focus(
              onFocusChange: (focus) => _onFocusChange(focus),
              child: TextFormField(
                enabled: widget.enabled ?? true,
                controller: widget.controller,
                onTap: widget.onTap ??
                        () {
                      _onFocusChange(true);
                    },
                onChanged: widget.onChanged,
                validator: widget.validator,
                maxLines: null,
                style: GoogleFonts.manrope(
                  color: Pallet.colorBlue,
                  fontSize: AppFontsStyle.textFontSize14,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
                decoration: widget.decorator ??
                    InputDecoration(
                      suffixIcon: widget.icon,
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: widget.label,
                      contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                      labelStyle: GoogleFonts.manrope(
                        color: Pallet.colorGrey,
                        fontWeight: FontWeight.w200,
                        backgroundColor: null,
                        background: null,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
              ))),
    );
  }
}



class AmountFormField extends StatefulWidget {
  bool? focus;
  TextEditingController? controller = new TextEditingController();

  /**
   * Look at the decorator declared here before duplicating and passing your own
   */
  InputDecoration? decorator;
  double? height;
  String label;
  Widget? icon;
  Function()? onTap;
  FormFieldValidator<String>? validator;
  Function(String)? onChanged;
  bool? enabled = true;

  AmountFormField(
      {this.controller,
        this.decorator,
        this.height,
        required this.label,
        this.icon,
        this.onTap,
        this.enabled,
        this.validator,
        this.onChanged});

  @override
  _AmountFormFieldState createState() => _AmountFormFieldState();
}

class _AmountFormFieldState extends State<AmountFormField> {
  void _onFocusChange(bool focus) {
    setState(() {
      widget.focus = focus;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, top: 4, bottom: 4),
      height: widget.height ?? null,
      decoration: BoxDecoration(
        border: widget.focus == true
            ? Border.all(width: 1.0, color: Pallet.colorBlue)
            : Border.all(width: 1.0, color: Pallet.colorBlue),
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Row(
        children: [
          Expanded(
            child: FocusScope(
                child: Focus(
                    onFocusChange: (focus) => _onFocusChange(focus),
                    child: TextFormField(
                      enabled: widget.enabled ?? true,
                      controller: widget.controller,
                      onTap: widget.onTap ??
                              () {
                            _onFocusChange(true);
                          },
                      onChanged: widget.onChanged,
                      validator: widget.validator,
                      maxLines: null,
                      style: GoogleFonts.manrope(
                        color: Pallet.colorBlue,
                        fontSize: AppFontsStyle.textFontSize14,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                      decoration: widget.decorator ??
                          InputDecoration(
                            suffixIcon: widget.icon,
                            floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelText: widget.label,
                            contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                            labelStyle: GoogleFonts.manrope(
                              color: Pallet.colorGrey,
                              fontWeight: FontWeight.w200,
                              backgroundColor: null,
                              background: null,
                            ),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                    ))),
          ),
          AppFontsStyle.getAppTextViewBold("DHR",
              weight: FontWeight.w500,
              size: AppFontsStyle.textFontSize12),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Pallet.colorBackground,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: AppFontsStyle.getAppTextViewBold("Max",
                    weight: FontWeight.w400,
                    size: AppFontsStyle.textFontSize10),
              ),
            ),
          )
        ],
      ),
    );
  }
}