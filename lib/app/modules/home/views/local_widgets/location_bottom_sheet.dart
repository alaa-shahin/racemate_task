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
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                Text(
                  'Race Location',
                  style: Get.textTheme.titleLarge,
                ),
                const Spacer(),
                Text(
                  'Reset',
                  style: Get.textTheme.labelLarge!.copyWith(
                    color: Constants.secondColor,
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
              child: Text(S.of(context).done),
            ),
          ],
        ),
      ),
    );
  }
}
