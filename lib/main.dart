import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isToggleEnabled = false;
  //Height Controllers
  final TextEditingController widgetHeightController = TextEditingController();
  final TextEditingController screenHeightController = TextEditingController();

  //width Controllers
  final TextEditingController widgetWidthController = TextEditingController();
  final TextEditingController screenWidthController = TextEditingController();

  double mediaQueryHeight = 0.0;
  double mediaQueryWidth = 0.0;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the input fields and update responsive dimensions.
    //height Controllers Listner
    widgetHeightController.addListener(calculateResponsiveHeight);
    screenHeightController.addListener(calculateResponsiveWidth);
    //width Controllers Listner
    widgetWidthController.addListener(calculateResponsiveHeight);
    screenWidthController.addListener(calculateResponsiveWidth);
  }

  //height Controllers Value Check
  void calculateResponsiveHeight() {
    if (widgetHeightController.text.isEmpty ||
        screenHeightController.text.isEmpty) {
      return;
    }
    double widgetWidth = double.parse(widgetWidthController.text);
    double screenWidth = double.parse(screenWidthController.text);
    setState(() {
      mediaQueryWidth = isToggleEnabled == false
          ? widgetWidth / screenWidth
          : screenWidth / widgetWidth;
    });
  }

//width Controllers Value Check
  void calculateResponsiveWidth() {
    if (widgetWidthController.text.isEmpty ||
        screenWidthController.text.isEmpty) {
      return;
    }
//height Controllers Value Parse
    double widgetHeight = double.parse(widgetHeightController.text);
    double screenHeight = double.parse(screenHeightController.text);
//width Controllers Value Parse

    setState(() {
      mediaQueryHeight = isToggleEnabled == false
          ? widgetHeight / screenHeight
          : screenHeight / widgetHeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define a background gradient for the theme
        canvasColor: Color.fromARGB(
            236, 255, 255, 255), // Make the canvas color transparent
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(213, 255, 255, 255),
          title: const Text(
            'Widget Responsive Calculator',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    isToggleEnabled == false
                        ? const Text("Enable Divide Method")
                        : const Text("Disable Divide Method"),
                    Switch(
                      value: isToggleEnabled,
                      onChanged: (newValue) {
                        setState(() {
                          isToggleEnabled = newValue;
                        });
                        print('Toggle button is $newValue');
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          // color: Colors.amber,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              isToggleEnabled == false
                                  ? buildTextField(
                                      "Widget Height", widgetHeightController)
                                  : buildTextField(
                                      "Screen Height", screenHeightController),
                              const Text(
                                "DIVIDED BY",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              isToggleEnabled == false
                                  ? buildTextField(
                                      "Screen Height", screenHeightController)
                                  : buildTextField(
                                      "Widget Height", widgetHeightController),
                              const SizedBox(height: 30),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Responsive Widget Height \n ${(mediaQueryHeight).toStringAsFixed(4)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 204, 20, 20),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          // color: Colors.amber,
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              isToggleEnabled == false
                                  ? buildTextField(
                                      "Widget Width", widgetWidthController)
                                  : buildTextField(
                                      "Screen Width", screenWidthController),
                              const Text(
                                "DIVIDED BY",
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              isToggleEnabled == false
                                  ? buildTextField(
                                      "Screen Width", screenWidthController)
                                  : buildTextField(
                                      "Widget Width", widgetWidthController),
                              const SizedBox(height: 30),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Responsive Widget Width \n ${(mediaQueryWidth).toStringAsFixed(4)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 204, 20, 20),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Note:-",
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 20, 20),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isToggleEnabled == false
                    ? const Text(
                        "Multiply Result with MediaQuery.of(context).size.height")
                    : const Text(
                        "Divide Result with MediaQuery.of(context).size.height"),
                const SizedBox(height: 10),
                const Text(
                  "Example:-",
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 20, 20),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isToggleEnabled == false
                    ? const Text(
                        "height: MediaQuery.of(context).size.height * 0.05")
                    : const Text(
                        "height: MediaQuery.of(context).size.height / 0.05"),
                const SizedBox(height: 10),
                const Text(
                  "Formula:-",
                  style: TextStyle(
                    color: Color.fromARGB(255, 204, 20, 20),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isToggleEnabled == false
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("size= MediaQuery.of(context).size"),
                            SizedBox(height: 5),
                            Text(
                              "For Height",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "widget height / size.height = result",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "For Width",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "widget width / size.Width = result ",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("size= MediaQuery.of(context).size"),
                            SizedBox(height: 5),
                            Text(
                              "For Height",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "size.height / widget height = result",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "For Width",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w900),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "size.Width / widget width = result",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                width: 2, color: const Color.fromARGB(255, 46, 46, 46))),
        child: TextFormField(
          style: const TextStyle(fontSize: 20),
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
          // inputFormatters: [
          //   FilteringTextInputFormatter.digitsOnly, // Allow only digits.
          // ],
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              // This makes the label text bold
            ),
          ),
          onChanged: (value) {
            calculateResponsiveHeight();
            calculateResponsiveHeight();
          },
        ),
      ),
    );

    //  Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: TextFormField(
    //     controller: controller,
    //     keyboardType: TextInputType.number,
    //     decoration: InputDecoration(
    //       labelText: labelText,
    //     ),
    //     onChanged: (value) {
    //       calculateResponsiveHeight();
    //       calculateResponsiveHeight();
    //     },
    //   ),
    // );
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    widgetHeightController.dispose();
    screenHeightController.dispose();

    widgetWidthController.dispose();
    screenWidthController.dispose();

    super.dispose();
  }
}
