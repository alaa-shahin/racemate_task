import '../../index.dart';

Widget addVerticalSpace(double height) => SizedBox(
      height: height.h,
    );

Widget addHorizontalSpace(double width) => SizedBox(
      width: width.w,
    );

Widget divider() => Divider(
      indent: 8.w,
      endIndent: 8.w,
      color: Colors.grey[300],
    );
