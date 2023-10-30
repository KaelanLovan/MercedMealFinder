import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

const categoryIds = {
  'breakfast': '61bd80d68b34640010e194b8',
  'lunch': '61bd80d05f2f930010bb6a81',
  'dinner': '61bd80cc5f2f930010bb6a80',
  'bakery': '62d9c7c26c04ea00104859c7',
  'cgld': '61ed97b39be79300147d3d06',
  'fogbreak': '62daecc36c04ea001048a55d',
  'fogld': '61ed885a9be79300147d3898',
};

const dayIds = {
  'sunday': '61bd808b5f2f930010bb6a7a',
  'monday': '61bd80908b34640010e194b3',
  'tuesday': '61bd80ab5f2f930010bb6a7d',
  'wednesday': '61bd80b08b34640010e194b4',
  'thursday': '61bd80b55f2f930010bb6a7e',
  'friday': '61bd80ba5f2f930010bb6a7f',
  'saturday': '61bd80bf8b34640010e194b6',
};

int weeksBetween(DateTime from, DateTime to) {
  from = DateTime.utc(from.year, from.month, from.day);
  to = DateTime.utc(to.year, to.month, to.day);
  return (to.difference(from).inDays / 7).ceil();
}

Future fetchData(
  String category,
  String day,
  String location,
) async {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = database.ref();

  final now = DateTime.now();
  final firstJan = DateTime(now.year, 1, 1);
  final year = DateFormat.y().format(now);
  final weekNumber = weeksBetween(firstJan, now);

  var range = 20;
  var index = 0;

  var foodItems = [];
  while (index < range) {
    final snapshot = await ref
        .child('allMeals/$location/$weekNumber-$year/$day/$category/$index')
        .get();
    if (snapshot.exists) {
      foodItems.add(snapshot.value);
    }
    index += 1;
  }

  return foodItems;
}
