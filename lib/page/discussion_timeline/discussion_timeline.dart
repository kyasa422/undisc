import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:undisc/lang/lang.dart';
import 'package:undisc/themes/themes.dart';

class DiscussionTimeline extends StatelessWidget {
  const DiscussionTimeline({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Lang().discussionTimeline),
        elevation: 0.0,
        backgroundColor: Themes().transparent,
        foregroundColor: Themes().primary,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          children: [
            TimelineTile(
              isFirst: true,
              alignment: TimelineAlign.center,
              indicatorStyle: const IndicatorStyle(
                indicator: FaIcon(FontAwesomeIcons.paperPlane),
                drawGap: true,
                indicatorXY: 0.0
              ),
              startChild: Text(
                "19 Oct 2022 23:00",
                style: TextStyle(
                  color: Themes().grey400
                ),
              ),
              endChild: Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Diskusi berhasil terkirim"),
                    Text(
                      "Menunggu persetujuan oleh pihak Himpunan Mahasiswa.\nDiskusi akan difilter apakah layak diproses ketahap berikutnya.",
                      style: TextStyle(
                        color: Themes().grey400,
                        fontSize: 12.0
                      ),
                    )
                  ],
                ),
              ),
            ),



            TimelineTile(
              isFirst: false,
              alignment: TimelineAlign.center,
              indicatorStyle: IndicatorStyle(
                indicator: CircleAvatar(
                  backgroundColor: Themes().transparent,
                  backgroundImage: const NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png")
                ),
                drawGap: true,
                indicatorXY: 0.0
              ),
              startChild: Text(
                "19 Oct 2022 23:05",
                style: TextStyle(
                  color: Themes().grey400
                ),
              ),
              endChild: Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Diskusi telah disetujui."),
                    Text(
                      "Diskusi telah disetujui oleh pihak Himpunan Mahasiswa.\nDiskusi akan segera ditindak lanjuti oleh pihak kampus.",
                      style: TextStyle(
                        color: Themes().grey400,
                        fontSize: 12.0
                      ),
                    )
                  ],
                ),
              ),
            ),


            TimelineTile(
              isFirst: false,
              alignment: TimelineAlign.center,
              indicatorStyle: const IndicatorStyle(
                indicator: FaIcon(FontAwesomeIcons.school),
                drawGap: true,
                indicatorXY: 0.0
              ),
              startChild: Text(
                "19 Oct 2022 23:08",
                style: TextStyle(
                  color: Themes().grey400
                ),
              ),
              endChild: Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Diskusi telah ditindak lanjuti."),
                    Text(
                      "Diskusi yang anda kirimkan sudah ditindak lanjuti oleh pihak kampus.\n",
                      style: TextStyle(
                        color: Themes().grey400,
                        fontSize: 12.0
                      ),
                    )
                  ],
                ),
              ),
            ),


            TimelineTile(
              isFirst: false,
              isLast: true,
              alignment: TimelineAlign.center,
              indicatorStyle: const IndicatorStyle(
                indicator: FaIcon(FontAwesomeIcons.check),
                drawGap: true,
                indicatorXY: 0.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}