import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gimme_some/src/screens/about.dart';
import 'package:gimme_some/src/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _apiService = ApiService();

  String advice;
  bool isLoading;

  Future getAdvice() async {
    setState(() {
      isLoading = true;
    });
    var adviceObject = await _apiService.fetchAdvice();
    setState(() {
      isLoading = false;
    });
    return adviceObject.slip.advice.toString();
  }

  @override
  void initState() {
    getAdvice().then((value) => advice = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1607543551362-9c1e4f4ac287?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2000&q=80',
            height: height,
            width: width,
            fit: BoxFit.cover,
          ),
          Center(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 1,
                sigmaY: 1,
              ),
              child: Container(
                height: height * 0.4,
                width: width * 0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Center(
                        child: advice == null || isLoading
                            ? CircularProgressIndicator()
                            : Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Scrollbar(
                                  child: SingleChildScrollView(
                                    child: TypewriterAnimatedTextKit(
                                      isRepeatingAnimation: false,
                                      text: [advice],
                                      textStyle: GoogleFonts.comfortaa(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        getAdvice().then((value) {
                          setState(() {
                            advice = value;
                          });
                        });
                      },
                      child: Container(
                        height: height * 0.0598,
                        width: width < 750 ? width * 0.5 : 375,
                        child: Center(
                          child: Text(
                            'gimme',
                            style: TextStyle(
                              fontFamily: 'AlbaSuper',
                              color: Colors.blue,
                              fontSize: 22,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.0191),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 16,
            child: InkWell(
              child: FaIcon(
                FontAwesomeIcons.infoCircle,
                size: 40,
                semanticLabel: 'Info',
                color: Colors.blue,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(
                      'gimme some',
                      style: TextStyle(
                        fontFamily: 'AlbaSuper',
                        color: Colors.blue,
                      ),
                    ),
                    content: AboutPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
