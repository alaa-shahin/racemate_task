import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/input_widget.dart';
import '../../../../../core/widgets/spacers.dart';
import '../../../../../index.dart';
import '../../controllers/home_controller.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key, required this.countries});

  final List<String> countries;

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  List<String> selectedIndexes = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 3.w),
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
                  S.of(context).raceLocation,
                  style: Get.textTheme.titleLarge,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    Get.find<HomeController>().duplicateCountries.clear();
                    Get.find<HomeController>().filterCounter--;
                    Get.find<HomeController>().filteredRaces =
                        Get.find<HomeController>().races;
                    Get.find<HomeController>().update();
                    Get.back();
                  },
                  child: Text(
                    S.of(context).reset,
                    style: Get.textTheme.labelLarge!.copyWith(
                      color: Constants.secondColor,
                    ),
                  ),
                ),
              ],
            ),
            addVerticalSpace(2),
            InputWidget(
              hintText: S.of(context).search,
              suffixIcon: const Icon(
                Icons.search,
                color: Constants.mainColor,
              ),
            ),
            addVerticalSpace(3),
            SizedBox(
              height: 30.h,
              child: ListView.separated(
                itemCount: widget.countries.length,
                itemBuilder: (context, index) {
                  var country = widget.countries[index];
                  return CheckboxListTile(
                    value: selectedIndexes.contains(country),
                    onChanged: (newValue) {
                      setState(() {
                        if (selectedIndexes.contains(country)) {
                          selectedIndexes.remove(country); // unselect
                        } else {
                          selectedIndexes.add(country); // select
                        }
                      });
                    },
                    title: Text(country),
                    tileColor: selectedIndexes.contains(country)
                        ? Constants.selectedTileColor
                        : null,
                  );
                },
                separatorBuilder: (context, index) {
                  return divider();
                },
              ),
            ),
            addVerticalSpace(2),
            ElevatedButton(
              onPressed: () {
                if (selectedIndexes.isNotEmpty) {
                  const pattern = r"\(.*?\)";
                  final cleanedTexts = selectedIndexes
                      .map(
                          (text) => text.replaceAll(RegExp(pattern), "").trim())
                      .toList();
                  Get.back(result: cleanedTexts);
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
