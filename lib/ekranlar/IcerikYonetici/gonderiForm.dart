import 'package:flutter/material.dart';

class GonderiForm extends StatefulWidget {
  const GonderiForm({key}) : super(key: key);

  @override
  _GonderiFormState createState() => _GonderiFormState();
}

class _GonderiFormState extends State<GonderiForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Gönderi Oluşturma ve Düzenleme Formu"),
    );
  }
}
