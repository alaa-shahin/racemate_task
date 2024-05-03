import 'package:racemate_task/core/widgets/input_widget.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/spacers.dart';
import '../../../../../index.dart';

class DateBottomSheet extends StatefulWidget {
  const DateBottomSheet({super.key});

  @override
  State<DateBottomSheet> createState() => _DateBottomSheetState();
}

class _DateBottomSheetState extends State<DateBottomSheet> {
  String? from;
  String? to;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Divider(
              color: Constants.textLabelColor,
              thickness: 2,
              indent: 20.h,
              endIndent: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                Text(
                  S.of(context).raceType,
                  style: Get.textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Reset',
                    style: Get.textTheme.labelLarge!.copyWith(
                      color: Constants.secondColor,
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(2),
            Text(S.of(context).from),
            InputWidget.datePicker(
              hintText: 'Mon, Oct 10, 2022',
              initialValue: from,
              onChanged: (newValue) {
                setState(() {
                  from = newValue;
                });
              },
            ),
            addVerticalSpace(2),
            Text(S.of(context).to),
            InputWidget.datePicker(
              hintText: 'Mon, Oct 10, 2022',
              initialValue: to,
              onChanged: (newValue) {
                setState(() {
                  to = newValue;
                });
              },
            ),
            addVerticalSpace(2),
            ElevatedButton(
              onPressed: () {},
              child: Text(S.of(context).done.toUpperCase()),
            ),
            addVerticalSpace(2),
          ],
        ),
      ),
    );
  }
}
