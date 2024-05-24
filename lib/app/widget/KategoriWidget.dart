import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class KategoriWidget extends StatelessWidget {
  final String icon_path;
  final String title;
  final String link;
  const KategoriWidget(
      {super.key,
      required this.icon_path,
      required this.title,
      required this.link});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) {
        print(p1.maxHeight);
        return InkWell(
          onTap: () {
            Get.toNamed(link);
          },
          splashColor: Color(0xff87CEEB).withOpacity(0.3),
          child: Column(
            children: [
              Container(
                height: p1.maxHeight * 0.7,
                width: p1.maxWidth * 0.7,
                decoration: BoxDecoration(
                  color: Color(0xff87CEEB).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    icon_path,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }
}
