// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:meal_finder/functions/fetch_data.dart';
import 'package:meal_finder/pages/meal_item.dart';
import 'package:meal_finder/utils/theme.dart';

enum Location { pav, dc }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: "sunday",
        enabled: location == 'pav',
        child: location == 'pav'
            ? Text("Sunday")
            : Text('Sunday',
                style: TextStyle(color: DarkColors.secondary.withOpacity(0.7))),
      ),
      DropdownMenuItem(value: "monday", child: Text("Monday")),
      DropdownMenuItem(value: "tuesday", child: Text("Tuesday")),
      DropdownMenuItem(value: "wednesday", child: Text("Wednesday")),
      DropdownMenuItem(value: "thursday", child: Text("Thursday")),
      DropdownMenuItem(value: "friday", child: Text("Friday")),
      DropdownMenuItem(
        value: "saturday",
        enabled: location == 'pav',
        child: location == 'pav'
            ? Text("Saturday")
            : Text('Saturdary',
                style: TextStyle(color: DarkColors.secondary.withOpacity(0.7))),
      ),
    ];
    return menuItems;
  }

  List weekDays = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'sunday'
  ];
  var currentDay = DateTime.now().weekday;
  late String selectedDay = weekDays[currentDay - 1];
  String selectedCat = 'breakfast';
  String selectedCatName = 'Breakfast';
  String location = 'pav';

  var _fetchData = fetchData('breakfast', 'sunday', 'pav');

  @override
  void initState() {
    super.initState();
    _fetchData = fetchData('breakfast', 'sunday', 'pav');
  }

  Location diningLoc = Location.pav;

  List pavCats = [
    'bakery',
    'breakfast',
    'cgld',
    'dinner',
    'fogbreak',
    'fogld',
    'lunch',
  ];

  List fullPavCats = [
    'Bakery',
    'Breakfast',
    'CG Lunch & Dinner',
    'Dinner',
    'FOG Breakfast',
    'FOG Lunch & Dinner',
    'Lunch',
  ];

  List dcCats = [
    'lunch',
    'dinner',
    'late',
    'sydbar',
    'icream',
  ];

  List fullDcCats = [
    'Lunch',
    'Dinner',
    'Late Night',
    'Salad-Yogurt-Deli Bar',
    'Ice Cream Bar',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DarkColors.main,
      appBar: AppBar(
        iconTheme: IconThemeData(color: DarkColors.secondary),
        backgroundColor: Colors.transparent,
        title: Center(
          child: DropdownButton(
            iconEnabledColor: DarkColors.secondary,
            dropdownColor: DarkColors.accent,
            value: selectedDay,
            items: dropdownItems,
            onChanged: (String? newValue) {
              setState(() {
                selectedDay = newValue!;
                //Function to Load Data Based on selectedDay
                _fetchData = fetchData(selectedCat, selectedDay, location);
              });
            },
            borderRadius: BorderRadius.circular(10),
            underline: SizedBox(),
            focusColor: DarkColors.accent,
            style: TextStyle(
              color: DarkColors.secondary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: DarkColors.secondary,
        child: Column(
          children: [
            SizedBox(height: 40),
            Text(
              'Current: $selectedCatName',
              style: TextStyle(
                color: DarkColors.accent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: location == 'pav' ? pavCats.length : dcCats.length,
                itemBuilder: (context, index) {
                  if (location == 'pav') {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 9, 16, 8),
                      child: ListTile(
                        title: Text(
                          fullPavCats[index],
                          style: TextStyle(
                            color: DarkColors.secondary,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        tileColor: fullPavCats[index] == selectedCatName
                            ? DarkColors.main
                            : DarkColors.main,
                        trailing: fullPavCats[index] == selectedCatName
                            ? Icon(
                                Icons.check,
                                color: DarkColors.secondary,
                              )
                            : Text(''),
                        onTap: () {
                          setState(() {
                            selectedCatName = fullPavCats[index];
                            selectedCat = pavCats[index];
                            _fetchData =
                                fetchData(selectedCat, selectedDay, location);
                          });
                        },
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 9, 16, 8),
                      child: ListTile(
                        title: Text(
                          fullDcCats[index],
                          style: TextStyle(
                            color: DarkColors.secondary,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        tileColor: fullDcCats[index] == selectedCatName
                            ? DarkColors.main
                            : DarkColors.main,
                        trailing: fullDcCats[index] == selectedCatName
                            ? Icon(
                                Icons.check,
                                color: DarkColors.secondary,
                              )
                            : Text(''),
                        onTap: () {
                          setState(() {
                            selectedCatName = fullDcCats[index];
                            selectedCat = dcCats[index];
                            _fetchData =
                                fetchData(selectedCat, selectedDay, location);
                          });
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: SegmentedButton(
                  segments: const [
                    ButtonSegment<Location>(
                      value: Location.pav,
                      label: Text('Pavillion'),
                      icon: Icon(Icons.dining),
                    ),
                    ButtonSegment<Location>(
                      value: Location.dc,
                      label: Text('Dining Hall'),
                      icon: Icon(Icons.dining),
                    ),
                  ],
                  selected: <Location>{diningLoc},
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return DarkColors.secondary;
                      }
                      return DarkColors.accent;
                    },
                  ), iconColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return DarkColors.accent;
                      }
                      return DarkColors.secondary;
                    },
                  ), foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return DarkColors.accent;
                      }
                      return DarkColors.secondary;
                    },
                  )),
                  onSelectionChanged: (Set<Location> newLocation) {
                    setState(() {
                      diningLoc = newLocation.first;
                      if (location == 'pav') {
                        location = 'dc';
                        selectedCat = 'lunch';
                        selectedCatName = 'Lunch';
                        selectedDay = currentDay < 6
                            ? weekDays[currentDay - 1]
                            : 'monday';
                        _fetchData =
                            fetchData(selectedCat, selectedDay, location);
                      } else {
                        location = 'pav';
                        selectedCat = 'breakfast';
                        selectedCatName = 'Breakfast';
                        selectedDay = weekDays[currentDay - 1];
                        _fetchData =
                            fetchData(selectedCat, selectedDay, location);
                      }
                    });
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: FutureBuilder(
                  future: _fetchData,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: DarkColors.secondary));
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return MealItem(
                            name: snapshot.data[index]['name'],
                            calories:
                                snapshot.data[index]['calories'].toString(),
                            description: snapshot.data[index]['description'],
                          );
                        },
                      );
                    } else {
                      return Text('No Data Available');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
