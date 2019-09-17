import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Body mass index (BMI) Calculator",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Fill with your data!";

  void _resetField() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Fill with your data!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double bmi = weight / (height * height);
      print(bmi);
      if (bmi < 16) {
        _infoText = "Severe Thinness (${bmi.toStringAsPrecision(2)})";
      } else if (bmi >= 16 && bmi < 17) {
        _infoText = "Moderate Thinness (${bmi.toStringAsPrecision(2)})";
      } else if (bmi >= 17 && bmi < 18.5) {
        _infoText = "Mild Thinness (${bmi.toStringAsPrecision(2)})";
      } else if (bmi >= 18.5 && bmi < 25) {
        _infoText = "Normal (${bmi.toStringAsPrecision(2)})";
      } else if (bmi >= 25 && bmi < 30) {
        _infoText = "Overweight (${bmi.toStringAsPrecision(2)})";
      } else if (bmi >= 30 && bmi < 35) {
        _infoText = "Obese Class I (${bmi.toStringAsPrecision(2)})";
      } else if (bmi >= 35 && bmi < 40) {
        _infoText = "Obese Class II (${bmi.toStringAsPrecision(2)})";
      } else if (bmi > 40) {
        _infoText = "Obese Class III (${bmi.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        elevation: 10,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetField,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_outline,
                size: 120.0,
                color: Colors.green,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Weight (kg)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: weightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insert your Weight!";
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Height (cm)",
                  labelStyle: TextStyle(
                    color: Colors.green,
                  ),
                ),
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                ),
                controller: heightController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Insert your Height!";
                  }
                },
              ),
              Padding(
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _calculate();
                      }
                    },
                    child: Text(
                      "Calculate",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                    color: Colors.green,
                  ),
                ),
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 25.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
