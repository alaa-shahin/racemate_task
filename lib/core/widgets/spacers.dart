import '../../index.dart';

Widget addVerticalSpace(double height) => SizedBox(
      height: height.h,
    );

Widget addHorizontalSpace(double width) => SizedBox(
      width: width.w,
    );

Widget divider() => Divider(
      color: Colors.grey[300],
    );
