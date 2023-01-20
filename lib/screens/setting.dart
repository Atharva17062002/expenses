import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dash.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  late Double budget;
  final myController = TextEditingController();
  final limitController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    limitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff010001),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff010001),
        title: const Text(
          'Set Preferences',
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 20,
            left: 10,
            right: 10,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff181919),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:  [
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Text(
                      'BUDGET',
                      style: TextStyle(fontSize: 30),
                    ),
                    Flexible(
                        child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: myController,
                        // onChanged: set,
                        decoration: InputDecoration(
                            hintText: '500',
                            hintStyle: TextStyle(fontSize: 35),
                            border: InputBorder.none),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 35),
                        keyboardType:TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 10,
            right: 10,
            top: 130,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff181919),
                    borderRadius: BorderRadius.circular(10)),
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(
                    //   width: 0,
                    // ),
                    Text(
                      'LIMIT',
                      style: TextStyle(fontSize: 30),
                    ),
                    Flexible(
                        child: SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: limitController ,
                        decoration: const InputDecoration(
                          hintText: '500',
                          hintStyle: TextStyle(fontSize: 35),
                          border: InputBorder.none),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 35),
                        keyboardType:TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).size.height*0.02,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff03efc4).withOpacity(0.7)),
              child: TextButton(
                onPressed: () async {
                  print('Tap');
                  Navigator.pop(context);
                  SharedPreferences shared = await SharedPreferences.getInstance();
                  shared.setString('budget', myController.text);

                  shared.setString('limit', limitController.text);
                },
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
