import 'package:racemate_task/app/modules/home/controllers/home_controller.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/spacers.dart';
import '../../../../../index.dart';

class TypeBottomSheet extends StatefulWidget {
  const TypeBottomSheet({super.key, required this.types});

  final List<String> types;

  @override
  State<TypeBottomSheet> createState() => _TypeBottomSheetState();
}

class _TypeBottomSheetState extends State<TypeBottomSheet> {
  String? radioGroupValue;

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
                  onPressed: () {
                    Get.find<HomeController>().types.clear();
                    Get.find<HomeController>().filterCounter--;
                    Get.find<HomeController>().filteredRaces =
                        Get.find<HomeController>().races;
                    Get.find<HomeController>().update();
                    Get.back();
                  },
                  child: Text(
                    S.current.reset,
                    style: Get.textTheme.labelLarge!.copyWith(
                      color: Constants.secondColor,
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(2),
            ListView.separated(
              itemCount: widget.types.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  value: widget.types[index],
                  groupValue: radioGroupValue,
                  onChanged: (newValue) {
                    setState(() {
                      radioGroupValue = newValue;
                    });
                  },
                  title: Text(widget.types[index]),
                );
              },
              separatorBuilder: (context, index) {
                return divider();
              },
            ),
            addVerticalSpace(2),
            ElevatedButton(
              onPressed: () {
                if (radioGroupValue != null) {
                  Get.find<HomeController>().types.add(radioGroupValue!);
                  Get.back(result: radioGroupValue);
                }
              },
              child: Text(S.of(context).done.toUpperCase()),
            ),
            addVerticalSpace(2),
          ],
        ),
      ),
    );
  }
}
