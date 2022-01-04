import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class EventUI extends StatelessWidget {
  EventUI(
      this.eventTitle,
      this.eventDate,
      this.eventLink,
      this.eventImage,
      this.eventFee,
      );

  final String eventTitle;
  final String eventDate;
  final String eventLink;
  final String eventImage;
  final String eventFee;

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
        var url = eventLink;
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
                      eventTitle,
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
                          image: NetworkImage(eventImage),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      eventFee,
                      style: GoogleFonts.openSans(
                        fontSize: 18.0,
                        color: Color(0xff0d47a1),
                      ),
                    ),
                    Text(
                      eventDate,
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
