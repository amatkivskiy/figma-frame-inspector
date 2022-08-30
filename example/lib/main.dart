import 'package:figma_frame_inspector/figma_frame_inspector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return FigmaFrameInspector(
      frameUrl:
          "https://www.figma.com/file/6E14t4azafuLcz2hUpedeL/Login-%26-Signup-Screen-(Community)?node-id=1%3A2",
      figmaToken: '<figma_access_token>',
      scale: 3,
      initialOpacity: .3,
      enabled: true,
      isTouchToChangeOpacityEnabled: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              child: Image.asset('assets/top_image.png'),
            ),
            const Positioned(
              left: 20,
              top: 48,
              child: Icon(
                Icons.chevron_left,
                color: Colors.white,
                size: 32,
              ),
            ),
            Positioned(
              top: 365,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 35,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Forgot Password ?',
                      style: TextStyle(
                        color: Color(0xFF313131),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFF07635D),
                      ),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 150,
                          padding: const EdgeInsets.all(18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFDADADA),
                          ),
                          child: const Icon(
                            Icons.facebook,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        Container(
                          width: 150,
                          padding: const EdgeInsets.all(18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFFDADADA),
                          ),
                          child: const Icon(
                            Icons.apple,
                            color: Colors.black,
                            size: 30,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 19),
                  color: const Color(0xFFFF7A30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Text(
                        'Don\'t have account?',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Color(0xFF07635D),
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
