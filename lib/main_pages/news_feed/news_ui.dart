import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsUI extends StatelessWidget {
  NewsUI(
      this.newsTitle,
      this.newsDate,
      this.newsLink,
      this.newsImage,
      );

  final String newsTitle;
  final String newsDate;
  final String newsLink;
  final String newsImage;

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var url = newsLink;
        launchURL(url);
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        margin: EdgeInsets.only(bottom: 20.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsTitle,
                      style: GoogleFonts.openSans(
                        fontSize: 18.0,
                        color: Color(0xff0d47a1),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      width: 400.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(newsImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      newsDate,
                      style: GoogleFonts.openSans(
                        fontSize: 18.0,
                        color: Color(0xff0d47a1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
