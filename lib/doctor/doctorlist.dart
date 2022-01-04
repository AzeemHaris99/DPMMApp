import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter_test_login_register/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class Doctor_List extends StatefulWidget {
  @override
  _Doctor_ListState createState() => _Doctor_ListState();
}

class _Doctor_ListState extends State<Doctor_List> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Text(
            'Certification of Origin',
            style: GoogleFonts.openSans(
              fontSize: 18.0,
              color: Color(0xff0d47a1),
              fontWeight: FontWeight.w500,
            )
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xff0d47a1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GFAccordion(
                title: "WHAT IS CERTIFICATE OF ORIGIN (COO)?",
                textStyle: GoogleFonts.openSans(color: Colors.white),
                content: "The Certificate of Origin (CO) is a document to certify the place of growth, production or manufacture of goods. It is required when exporting to specific countries, when requested by the consignee for customs clearance, or when it’s stipulated in a letter of credit.\n \nThe CO identifies goods and contains a certification by a government authority, or other empowered body, that the goods in question originate in a specific country. Certificates of Origin can be broadly classified into types, namely Preferential Certificates of Origin and Non-Preferential Certificates of Origin.\n \nThe issuance and acceptance of Certificates of Origin is governed by the International Convention on the Simplification and Harmonisation of Customs Procedures.\n \nThe criteria used in determining the origin of goods namely:\nManufacturers, exporters or traders must be registered with Suruhanjaya Syarikat Malaysia(Companies Commission of Malaysia).\n \nProducts that are:\nManufactured in Malaysia and use 100% local content; or\nManufactured in Malaysia through a transformation process which changes the tariff code classification at six (6) digit level; or\nManufactured in Malaysia and contains at least 25% local content",
                collapsedTitleBackgroundColor: Color(0xff0d47a1),
                expandedTitleBackgroundColor: Color(0xff0d47a1),
                collapsedIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.red,),
                expandedIcon: Icon(Icons.keyboard_arrow_up_rounded, size: 20, color: Colors.red,),
                titleBorderRadius: BorderRadius.circular(10),
              ),GFAccordion(
                title: "WHERE TO OBTAIN A CERTIFICATE OF ORIGIN?",
                textStyle: GoogleFonts.openSans(color: Colors.white),
                content: "Malay Chambers of Commerce (MCCM) is authorized by the Ministry of International Trade & Industry (MITI) to issue Certificates of Origin for goods exported to any country in the world. They can be applied for at our main office or at any of MICCI regional offices in Malaysia. Certificates of Origin issued by MICCI are referred to as Non-Preferential Certificate of Origin.",
                collapsedTitleBackgroundColor: Color(0xff0d47a1),
                expandedTitleBackgroundColor: Color(0xff0d47a1),
                collapsedIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.red,),
                expandedIcon: Icon(Icons.keyboard_arrow_up_rounded, size: 20, color: Colors.red,),
                titleBorderRadius: BorderRadius.circular(10),
              ),GFAccordion(
                title: "HOW TO APPLY FOR A CERTIFICATE OF ORIGIN?",
                textStyle: GoogleFonts.openSans(color: Colors.white),
                content: "Two stages to be done in applying Certificate of Origin.\n \nFIRST STAGE : Qualifying\n\n(MUST be submitted 1 week before getting the COO endorsement and valid for 1 year)\n\n1. Letter of Indemnity (should be typed using the Company’s letterhead)\n2. Statutory Declaration (should be typed using the Company’s letterhead)\n3. Copy of Company Registration (Form 9), Form 24 & Form 49. Business Registration (Form D)\n4. SSM Corporate Information\n5. Manufacturing License/ Business License (applicable for manufacturer)\n6. Manufacturer’s / Supplier’s Invoices (applicable for trader)\n7. Copy of Director’s IC\n8. Picture/Product Catalogue/Brochures\n9. License form Majlis Perbandaran\n10. Specimen Signature\n11. Exporter Particular\n12. Cost Analysis Of the Finished Product ( for Manufacturing Only)\n\nNote: The Document Must Be Submitted In Original And Certified True Copy\n\nSECOND STAGE : Endorsing\n\n1. Certificate of Origin – MCCM’s Form\n2. Commercial Invoice\n3. Packing List\n4. Bill of Lading/ Airway Bill\n5. Custom Declaration Form (K2)\n6. Certificate of Origin of exporting country (applicable for Re-Export or Direct Shipment from Second Country to Third Country )\n7. Custom Declaration Form ( K1.or K8. Or ZB/ ZB2)\n8. Other related documents in respect of exports and re-exports from Malaysia (export declaration that required by the MCCM)\n9. Supplier invoice & License form supplier\n\nNote: The documents must be produced additionally as a copy for MCCM retention)",
                collapsedTitleBackgroundColor: Color(0xff0d47a1),
                expandedTitleBackgroundColor: Color(0xff0d47a1),
                collapsedIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.red,),
                expandedIcon: Icon(Icons.keyboard_arrow_up_rounded, size: 20, color: Colors.red,),
                titleBorderRadius: BorderRadius.circular(10),
              ),GFAccordion(
                title: "HOW TO APPLY FOR ENDORSEMENT OF NON-PREFERENTIAL CERTIFICATES OF ORIGIN?",
                textStyle: GoogleFonts.openSans(color: Colors.white),
                content: "Submit the following documents:\n\nMANUFACTURER:\n1. Commercial Invoice & Packing list\n2. Customs export declaration (Borang K2) & Bill of Lading/Airway Bill\n3. Any other documents deemed necessary (if applicable)\n4. Checklist (as stipulated by MITI).\n\nTRADER:\n1. Commercial Invoice & Packing list\n2. Customs export declaration (Borang K2) & Bill of Lading/Airway Bill\n3. Manufacturers’ invoice\n4. Any other documents deemed necessary (if applicable)\n5. Checklist (as stipulated by MITI)\n\nNote: MCCM will only accept applications for endorsement of Certificates of Origin for shipment(s) within a month after the date of export. Applications for endorsement of Certificates of Origin before the date of export will not be entertained with the exception of air-shipment(s).",
                collapsedTitleBackgroundColor: Color(0xff0d47a1),
                expandedTitleBackgroundColor: Color(0xff0d47a1),
                collapsedIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.red,),
                expandedIcon: Icon(Icons.keyboard_arrow_up_rounded, size: 20, color: Colors.red,),
                titleBorderRadius: BorderRadius.circular(10),
              ),GFAccordion(
                title: "FEES",
                textStyle: GoogleFonts.openSans(color: Colors.white),
                content: "RATES FOR ENDORSEMENTS AND FORMS\n\n1. REGISTRATION: RM100.00\n2. RENEW (1 YEAR): RM50.00\n3. COO Form (50pcs): RM30.00\n4. COO endorsement (Malaysia Origin): RM10.00/signature\n4. COO endorsement (Non-Malaysia Origin): RM15.00/signature\n5. COO amendments: RM2.00/signature\n6. Small Chop: RM2.00/signature\n7. Photostat/fax: RM0.50/pcs",
                collapsedTitleBackgroundColor: Color(0xff0d47a1),
                expandedTitleBackgroundColor: Color(0xff0d47a1),
                collapsedIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Colors.red,),
                expandedIcon: Icon(Icons.keyboard_arrow_up_rounded, size: 20, color: Colors.red,),
                titleBorderRadius: BorderRadius.circular(10),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () => openFile(
                  url: 'https://download1501.mediafire.com/j6aunb4pusvg/jlfx576mkdqhpk5/LI+and+Declaration+by+the+exporter+-+DPMMS.doc',
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: GoogleFonts.openSans(
                    color: Colors.white,
                  )
                ),
                child: Text('View Letter of Indemnity'),
              ),
              ElevatedButton(
                onPressed: () => openFile(
                  url: 'https://download1072.mediafire.com/zns6295aorrg/nkjo55mi9xnedub/Attachment+II+-+Sample+of+Statutory+Declaration.doc',
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    textStyle: GoogleFonts.openSans(
                      color: Colors.white,
                    )
                ),
                child: Text('View Statutory Declaration'),
              ),
            ]
          ),
        ),
    );
  }

  Future openFile({String url, String fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if(file == null) return;
    print('Path: ${file.path}');
    OpenFile.open(file.path);
  }

  Future<File> downloadFile(String url, String name) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}/$name');
      try {
        final response = await Dio().get(
            url,
            options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0,
            )
        );

        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();

        return file;
      } catch (e) {
        return null;
      }
    }
  }

}

