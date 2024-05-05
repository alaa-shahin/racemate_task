import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/spacers.dart';
import '../../../../../index.dart';
import '../../controllers/home_controller.dart';

class DistanceBottomSheet extends StatefulWidget {
  const DistanceBottomSheet({super.key, required this.maxNumber});

  final double maxNumber;

  @override
  State<DistanceBottomSheet> createState() => _DistanceBottomSheetState();
}

class _DistanceBottomSheetState extends State<DistanceBottomSheet> {
  double start = 0;
  double end = 45;

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
                  S.of(context).raceDistance,
                  style: Get.textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Get.find<HomeController>().filteredDistance.clear();
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
            Text('$start - ${end.toStringAsFixed(1)} K'),
            addVerticalSpace(3),
            RangeSlider(
              max: widget.maxNumber,
              divisions: 20,
              activeColor: Constants.secondColor,
              inactiveColor: Constants.borderColor,
              onChanged: (newValue) {
                setState(() {
                  start = newValue.start;
                  end = newValue.end;
                });
              },
              values: RangeValues(start, end),
            ),
            addVerticalSpace(2),
            ElevatedButton(
              onPressed: () {
                List<String> result = [];
                result.add(start.toString());
                result.add(end.toString());
                Get.back(result: result);
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
