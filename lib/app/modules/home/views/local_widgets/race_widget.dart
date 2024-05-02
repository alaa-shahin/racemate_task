import 'package:flutter_svg/flutter_svg.dart';
import 'package:racemate_task/core/utils/constants.dart';
import 'package:racemate_task/core/widgets/spacers.dart';

import '../../../../../index.dart';
import '../../../../data/race_model.dart';

class RaceWidget extends StatelessWidget {
  const RaceWidget({super.key, required this.races});

  final List<RaceModel> races;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: races.length,
      itemBuilder: (context, index) {
        var race = races[index];
        return SizedBox(
          height: 35.h,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            // color: const Color(0xffF1F4FD),
            surfaceTintColor: const Color(0xffF1F4FD),
            child: Row(
              children: [
                Container(
                  width: 35.w,
                  height: double.infinity,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(8),
                      bottomStart: Radius.circular(8),
                    ),
                  ),
                  child: Image.asset(
                    "assets/images/${race.image}",
                    fit: BoxFit.cover,
                  ),
                ),
                addHorizontalSpace(2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      addVerticalSpace(1),
                      const Icon(
                        Icons.stars,
                        color: Constants.mainColor,
                      ),
                      addVerticalSpace(1),
                      Text(
                        race.name,
                        style: Get.textTheme.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      addVerticalSpace(1),
                      if (race.organizer != null)
                        Text(
                          'Organized by',
                          style: Get.textTheme.labelLarge,
                        ),
                      if (race.organizer != null)
                        Text(
                          race.organizer!,
                          style: Get.textTheme.titleSmall!.copyWith(
                            color: Constants.textHintColor,
                          ),
                        ),
                      addVerticalSpace(1),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/distance.svg'),
                                    addHorizontalSpace(1),
                                    Text(
                                      race.distances,
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                addVerticalSpace(1),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/calendar.svg'),
                                    addHorizontalSpace(1),
                                    Text(
                                      race.date,
                                      style: Get.textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                addVerticalSpace(1),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/location.svg'),
                                    addHorizontalSpace(1),
                                    Expanded(
                                      child: Text(
                                        '${race.city}, ${race.country}',
                                        style: Get.textTheme.titleSmall,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child:
                                  SvgPicture.asset('assets/icons/share.svg')),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return addVerticalSpace(3);
      },
    );
  }
}
