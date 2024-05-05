import 'package:racemate_task/app/modules/home/controllers/home_controller.dart';

import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/spacers.dart';
import '../../../../../index.dart';

class ClearFilterBottomSheet extends StatelessWidget {
  const ClearFilterBottomSheet({super.key});

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
            addVerticalSpace(2),
            Center(
              child: Text(
                S.of(context).clearFilter.toUpperCase(),
                style: Get.textTheme.titleLarge,
              ),
            ),
            addVerticalSpace(2),
            ElevatedButton(
              onPressed: () {
                Get.find<HomeController>().types.clear();
                Get.find<HomeController>().duplicateCountries.clear();
                Get.find<HomeController>().filteredDistance.clear();
                Get.find<HomeController>().filteredDates.clear();
                Get.find<HomeController>().filterCounter = 0;
                Get.find<HomeController>().filteredRaces =
                    Get.find<HomeController>().races;
                Get.find<HomeController>().update();
                Get.back();
              },
              child: Text(
                S.of(context).yesClearFilters.toUpperCase(),
              ),
            ),
            addVerticalSpace(2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: Constants.mainColor,
                    width: 0.5,
                  ),
                ),
              ),
              onPressed: () {
                Get.back();
              },
              child: Text(S.of(context).cancel.toUpperCase()),
            ),
            addVerticalSpace(2),
          ],
        ),
      ),
    );
  }
}
