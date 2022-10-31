import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFormCurrency extends StatelessWidget {
  final String Title;
  final String HintText;
  final TextEditingController Controller;
  final String Function(String) ControllerValidator;

  const InputFormCurrency({
    this.Title,
    this.HintText,
    this.Controller,
    this.ControllerValidator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$Title",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          inputFormatters: [
            CurrencyTextInputFormatter(
                decimalDigits: 0, locale: 'in', symbol: 'Rp. ')
          ],
          controller: Controller,
          autocorrect: false,
          validator: ControllerValidator,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(9),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(9),
              ),
              hintText: "$HintText",
              filled: true,
              fillColor: Colors.blue[50]),
          style: GoogleFonts.montserrat(),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
