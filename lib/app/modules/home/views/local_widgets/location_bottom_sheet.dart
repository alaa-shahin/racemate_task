import '../../../../../core/utils/constants.dart';
import '../../../../../core/widgets/input_widget.dart';
import '../../../../../core/widgets/spacers.dart';
import '../../../../../index.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key});

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
                itemCount: 8,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: false,
                    onChanged: (newValue) {},
                    title: const Text('Egypt (3)'),
                  );
                },
                separatorBuilder: (context, index) {
                  return divider();
                },
              ),
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
