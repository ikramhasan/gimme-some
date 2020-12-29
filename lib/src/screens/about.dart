import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: 'ikramhasan.dev@gmail.com',
        queryParameters: {'subject': 'Bug Report'});

    final defaultTextStyle = GoogleFonts.comfortaa();

    return Container(
      height: height * 0.5,
      width: width < 580 ? width * 0.7 : 400,
      child: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Divider(color: Colors.grey),
              SizedBox(height: 8),
              Text(
                'This app was made by',
                style: defaultTextStyle,
              ),
              SizedBox(height: 8),
              Text(
                'Ikram Hasan',
                style: TextStyle(fontFamily: 'AlbaSuper'),
              ),
              SizedBox(height: 8),
              Divider(color: Colors.grey),
              ListTile(
                leading: Icon(Icons.email),
                title: Text(
                  'Email',
                  style: defaultTextStyle,
                ),
                subtitle: Text('ikramhasan.dev@gmail.com'),
                onTap: () {
                  launch(_emailLaunchUri.toString());
                },
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.facebook),
                title: Text(
                  'Facebook',
                  style: defaultTextStyle,
                ),
                subtitle: Text('fb.com/ihni7'),
                onTap: () {
                  _launchURL('https://www.facebook.com/ihni7');
                },
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.twitter),
                title: Text(
                  'Twitter',
                  style: defaultTextStyle,
                ),
                subtitle: Text('https://twitter.com/ikramhasandev'),
                onTap: () {
                  _launchURL('https://twitter.com/ikramhasandev');
                },
              ),
              Divider(color: Colors.grey),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.github),
                title: Text(
                  'Github',
                  style: defaultTextStyle,
                ),
                subtitle: Text('https://github.com/ikramhasan'),
                onTap: () {
                  _launchURL('https://github.com/ikramhasan');
                },
              ),
              SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
