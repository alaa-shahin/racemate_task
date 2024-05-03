import 'package:flutter_svg/flutter_svg.dart';
import 'package:racemate_task/core/widgets/input_widget.dart';
import 'package:racemate_task/core/widgets/spacers.dart';

import '../../../../core/utils/constants.dart';
import '../../../../index.dart';
import '../controllers/home_controller.dart';
import 'local_widgets/date_bottom_sheet.dart';
import 'local_widgets/distance_bottom_sheet.dart';
import 'local_widgets/location_bottom_sheet.dart';
import 'local_widgets/race_widget.dart';
import 'local_widgets/type_bottom_sheet.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const Image(
          image: AssetImage('assets/images/app_bar_background.png'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        leadingWidth: 35.w,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
            fit: BoxFit.fill,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          SvgPicture.asset('assets/icons/notification.svg'),
          addHorizontalSpace(5),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SvgPicture.asset('assets/icons/account.svg'),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Constants.mainColor,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 5,
              controller: controller.tabController,
              indicatorColor: Constants.secondColor,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(
                  child: Text(S.of(context).run),
                ),
                Tab(
                  child: Text(S.of(context).community),
                ),
                Tab(
                  child: Text(S.of(context).races),
                ),
              ],
            ),
          ),
          addVerticalSpace(3),
          SizedBox(
            height: 10.w,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      const TypeBottomSheet(),
                      backgroundColor: Colors.white,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Constants.mainColor),
                    ),
                    child: Row(
                      children: [
                        Text(S.of(context).type),
                        addHorizontalSpace(2),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Constants.mainColor,
                        ),
                      ],
                    ),
                  ),
                ),
                addHorizontalSpace(3),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      const LocationBottomSheet(),
                      backgroundColor: Colors.white,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Constants.mainColor),
                    ),
                    child: Row(
                      children: [
                        Text(S.of(context).location),
                        addHorizontalSpace(2),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                addHorizontalSpace(3),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      const DistanceBottomSheet(),
                      backgroundColor: Colors.white,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Constants.mainColor),
                    ),
                    child: Row(
                      children: [
                        Text(S.of(context).distance),
                        addHorizontalSpace(2),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                addHorizontalSpace(3),
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      const DateBottomSheet(),
                      backgroundColor: Colors.white,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Constants.mainColor),
                    ),
                    child: Row(
                      children: [
                        Text(S.of(context).date),
                        addHorizontalSpace(2),
                        const Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  ),
                ),
                addHorizontalSpace(3),
              ],
            ),
          ),
          addVerticalSpace(3),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                children: [
                  InputWidget(
                    hintText: S.of(context).searchRaceNameOrCountry,
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Constants.mainColor,
                    ),
                  ),
                  addVerticalSpace(3),
                  Expanded(
                    child: GetBuilder<HomeController>(
                      builder: (controller) {
                        return TabBarView(
                          controller: controller.tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            RaceWidget(races: controller.races),
                            RaceWidget(races: controller.races),
                            RaceWidget(races: controller.races),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
