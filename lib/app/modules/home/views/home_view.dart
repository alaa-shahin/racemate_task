import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:racemate_task/core/widgets/spacers.dart';
import '../../../../core/utils/constants.dart';
import '../../../../index.dart';
import '../controllers/home_controller.dart';
import 'local_widgets/clear_filter_sheet.dart';
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
      extendBody: true,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          addVerticalSpace(3),
          SizedBox(
            height: 10.w,
            child: GetBuilder<HomeController>(
              builder: (controller) {
                return ListView(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  scrollDirection: Axis.horizontal,
                  children: [
                    if (controller.filterCounter > 0)
                      GestureDetector(
                        onTap: () async {
                          Get.bottomSheet(
                            const ClearFilterBottomSheet(),
                            backgroundColor: Colors.white,
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Constants.mainColor),
                            color: Constants.mainColor,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.filter_alt,
                                color: Colors.white,
                              ),
                              addHorizontalSpace(1),
                              Container(
                                width: 5.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amberAccent,
                                ),
                                child: Center(
                                  child: Text(
                                    controller.filterCounter.toString(),
                                    style: Get.textTheme.titleSmall,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (controller.filterCounter > 0) addHorizontalSpace(3),
                    GestureDetector(
                      onTap: () async {
                        var response = await Get.bottomSheet(
                          TypeBottomSheet(types: controller.getType()),
                          backgroundColor: Colors.white,
                        );
                        if (response != null) {
                          controller.filterType(response);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Constants.mainColor),
                          color: controller.types.isNotEmpty
                              ? Constants.mainColor
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).type,
                              style: Get.textTheme.titleSmall!.copyWith(
                                color: controller.types.isNotEmpty
                                    ? Colors.white
                                    : Constants.mainColor,
                              ),
                            ),
                            addHorizontalSpace(2),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: controller.types.isNotEmpty
                                  ? Colors.white
                                  : Constants.mainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    addHorizontalSpace(3),
                    GestureDetector(
                      onTap: () async {
                        await controller.getAllCountries();
                        var response = await Get.bottomSheet(
                          LocationBottomSheet(
                            countries: controller.duplicateCountries,
                          ),
                          isScrollControlled: true,
                          backgroundColor: Colors.white,
                        );
                        if (response != null) {
                          controller.filterLocation(response);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Constants.mainColor),
                          color: controller.duplicateCountries.isNotEmpty
                              ? Constants.mainColor
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).location,
                              style: Get.textTheme.titleSmall!.copyWith(
                                color: controller.duplicateCountries.isNotEmpty
                                    ? Colors.white
                                    : Constants.mainColor,
                              ),
                            ),
                            addHorizontalSpace(2),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: controller.duplicateCountries.isNotEmpty
                                  ? Colors.white
                                  : Constants.mainColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    addHorizontalSpace(3),
                    GestureDetector(
                      onTap: () async {
                        var response = await Get.bottomSheet(
                          DistanceBottomSheet(
                            maxNumber: controller.getDistance(),
                          ),
                          backgroundColor: Colors.white,
                        );
                        if (response != null) {
                          controller.filterDistance(response);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Constants.mainColor),
                          color: controller.filteredDistance.isNotEmpty
                              ? Constants.mainColor
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).distance,
                              style: Get.textTheme.titleSmall!.copyWith(
                                color: controller.filteredDistance.isNotEmpty
                                    ? Colors.white
                                    : Constants.mainColor,
                              ),
                            ),
                            addHorizontalSpace(2),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: controller.filteredDistance.isNotEmpty
                                  ? Colors.white
                                  : Constants.mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    addHorizontalSpace(3),
                    GestureDetector(
                      onTap: () async {
                        var response = await Get.bottomSheet(
                          const DateBottomSheet(),
                          backgroundColor: Colors.white,
                        );
                        if (response != null) {
                          controller.filterDate(response);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Constants.mainColor),
                          color: controller.filteredDates.isNotEmpty
                              ? Constants.mainColor
                              : Colors.white,
                        ),
                        child: Row(
                          children: [
                            Text(
                              S.of(context).date,
                              style: Get.textTheme.titleSmall!.copyWith(
                                color: controller.filteredDates.isNotEmpty
                                    ? Colors.white
                                    : Constants.mainColor,
                              ),
                            ),
                            addHorizontalSpace(2),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: controller.filteredDates.isNotEmpty
                                  ? Colors.white
                                  : Constants.mainColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    addHorizontalSpace(3),
                  ],
                );
              },
            ),
          ),
          addVerticalSpace(3),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _autoSearchField(),
                  addVerticalSpace(3),
                  GetBuilder<HomeController>(
                    builder: (controller) {
                      return RaceWidget(races: controller.filteredRaces);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _autoSearchField() {
    return TypeAheadField(
      hideSuggestionsOnKeyboardHide: true,
      suggestionsBoxController: controller.suggestionsBoxController,
      noItemsFoundBuilder: (context) {
        return Center(
          child: Text(
            S.of(context).noResultFound,
            style: Get.textTheme.titleMedium!.copyWith(
              color: Constants.textLabelColor,
            ),
          ),
        );
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(
            suggestion,
            style: suggestion == S.current.countries ||
                    suggestion == S.current.races
                ? Get.textTheme.titleLarge
                : Get.textTheme.titleSmall,
          ),
        );
      },
      suggestionsCallback: (value) {
        return controller.getSuggestions(value);
      },
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        color: Colors.white,
        elevation: 4.0,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      textFieldConfiguration: TextFieldConfiguration(
        controller: controller.textController,
        decoration: InputDecoration(
          hintText: S.current.searchRaceNameOrCountry,
          suffixIcon: controller.textController.text == ''
              ? const Text('')
              : IconButton(
                  onPressed: () async {
                    controller.textController.clear();
                    controller.suggestionsBoxController.close();
                    controller.filteredRaces = controller.races;
                    controller.update();
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Constants.borderColor,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Constants.secondColor,
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Constants.borderColor,
              width: 0.5,
            ),
          ),
          errorBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: Colors.grey.shade200)),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey.shade200,
            ),
          ),
        ),
      ),
      onSuggestionSelected: (String suggestion) {
        controller.textController.text = suggestion;
        controller.filterSearch(suggestion);
      },
    );
  }
}
