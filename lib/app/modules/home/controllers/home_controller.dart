import 'dart:collection';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:racemate_task/app/data/base_request.dart';

import '../../../../core/utils/utils.dart';
import '../../../../index.dart';
import '../../../data/race_model.dart';

class HomeController extends GetxController {
  List<RaceModel> races = [];
  List<RaceModel> filteredRaces = [];
  List<RaceModel> filteredDistance = [];
  List<RaceModel> filteredDates = [];
  List<String> duplicateCountries = [];
  List<String> types = [];
  int filterCounter = 0;
  final TextEditingController textController = TextEditingController();
  final SuggestionsBoxController suggestionsBoxController =
      SuggestionsBoxController();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    var response = await BaseRequest.dynamicRequest();
    races = List.from(response.map((race) => RaceModel.fromJson(race)));
    filteredRaces = races;
    update();
  }

  getAllCountries() {
    List<String> countries = [];
    races.map((e) => countries.add(e.country)).toList();
    duplicateCountries = countCountriesDuplicates(countries);
  }

  double getDistance() {
    List<String> distances = [];
    races.map((e) => distances.add(e.distances)).toList();
    double maxNumber = double.negativeInfinity;
    for (final range in distances) {
      final numbers = range.split(',').map((str) => double.parse(str)).toList();
      final maxInRange =
          numbers.reduce((a, b) => a > b ? a : b); // Find max within range
      maxNumber =
          maxNumber > maxInRange ? maxNumber : maxInRange; // Update global max
    }
    return maxNumber;
  }

  List<String> getSuggestions(String pattern) {
    List<String> suggestions = <String>[];
    suggestions.add(S.current.countries);
    var res = countCountriesDuplicates(races.map((e) => e.country).toList());
    suggestions.addAll(res);
    suggestions.add(S.current.races);
    races.map((e) => suggestions.add(e.name)).toList();
    suggestions.retainWhere((text) {
      if (text == S.current.countries || text == S.current.races) {
        return true;
      }
      return text.toLowerCase().contains(pattern.toLowerCase());
    });
    if (suggestions.length > 2) {
      return suggestions;
    } else {
      return [];
    }
  }

  List<String> getType() {
    List<String> tempTypes = [];
    races.map((element) => tempTypes.add(element.type)).toList();
    tempTypes = LinkedHashSet<String>.from(tempTypes).toList();
    tempTypes.add('Virtual');
    tempTypes.add('All');
    tempTypes;
    return tempTypes;
  }

  List<String> countCountriesDuplicates(List<String> list, [String? text]) {
    final counts = <String, int>{};
    List<String> result = [];
    for (final item in list) {
      counts[item] = (counts[item] ?? 0) + 1;
    }
    for (var count in counts.entries) {
      result.add('${count.key} (${count.value} ${text ?? ''})');
    }
    return result;
  }

  filterDistance(List<String> ranges) {
    filteredDistance = races.where((range) {
      final numbers =
          range.distances.split(',').map((str) => double.parse(str)).toList();
      // Check if all numbers in the range are between 0 and maxNumber
      return numbers.every((number) =>
          double.tryParse(ranges.first)! <= number &&
          number <= double.tryParse(ranges.last)!);
    }).toList();
    filteredRaces =
        races.where((element) => filteredDistance.contains(element)).toList();
    countNonEmptyArrays();
    update();
  }

  filterLocation(List<String> filter) {
    filteredRaces =
        races.where((element) => filter.contains(element.country)).toList();
    countNonEmptyArrays();
    update();
  }

  filterSearch(String filter) {
    const pattern = r"\(.*?\)";
    final cleanedText = filter.replaceAll(RegExp(pattern), "").trim();
    filteredRaces = races.where((element) {
      return cleanedText.contains(element.country) ||
          cleanedText.contains(element.name);
    }).toList();
    countNonEmptyArrays();
    update();
  }

  filterType(String type) {
    filteredRaces = races
        .where((element) => element.type == type || type == 'All')
        .toList();
    countNonEmptyArrays();
    update();
  }

  filterDate(List<String> date) {
    date = date.map((e) => formatDateToYYYYMMDD(e)).toList();
    final startDate = DateFormat("d MMMM, yyyy").parse(date.first);
    filteredDates = races.where((dateString) {
      final parsedDate = DateFormat("d MMMM, yyyy").parse(dateString.date);
      return parsedDate.isAfter(startDate) ||
          parsedDate.isAtSameMomentAs(startDate);
    }).toList();
    filteredRaces =
        races.where((element) => filteredDates.contains(element)).toList();
    countNonEmptyArrays();
    update();
  }

  int countNonEmptyArrays() {
    filterCounter = 0;
    if (filteredDates.isNotEmpty) {
      filterCounter++;
    }
    if (types.isNotEmpty) {
      filterCounter++;
    }
    if (filteredDistance.isNotEmpty) {
      filterCounter++;
    }
    if (duplicateCountries.isNotEmpty) {
      filterCounter++;
    }
    return filterCounter;
  }
}
