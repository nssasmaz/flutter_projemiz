import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormInput extends StatefulWidget {
  Icon fieldIcon;
  String hintText;

  FormInput(this.fieldIcon, this.hintText, {key}) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final _text = TextEditingController();
  final bool _validate = false;

  @override
  Widget build(BuildContext context) {
    Size boyut = MediaQuery.of(context).size;
    print(boyut);
    return Container(
      width: boyut.width * 0.8,
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.all(Radius.circular(18.0)),
        color: Colors.pink,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.fieldIcon,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0)),
              ),
              width: boyut.width * 0.7,
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: Form(
                  child: TextField(
                    //TestField
                    controller: _text,

                    decoration: InputDecoration(
                      errorText: _validate ? "Kullanıcı Adı" : null,
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
