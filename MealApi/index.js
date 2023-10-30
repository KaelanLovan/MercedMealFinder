import firebase from "firebase/compat/app";
import "firebase/compat/database";

// TODO: Replace the following with your app's Firebase project configuration
// See: https://firebase.google.com/docs/web/learn-more#config-object
const firebaseConfig = {
  apiKey: "AIzaSyBxFr-N032PQYjw_UbCUtbUdrUz2GcJlGA",
  authDomain: "mealfinder-adbe6.firebaseapp.com",
  databaseURL: "https://mealfinder-adbe6-default-rtdb.firebaseio.com",
  projectId: "mealfinder-adbe6",
  storageBucket: "mealfinder-adbe6.appspot.com",
  messagingSenderId: "1032334118158",
  appId: "1:1032334118158:web:e51da1bb324891efb65b5f",
  measurementId: "G-7QZ27F6K3Q"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);
// Initialize Realtime Database and get a reference to the service
const database = firebase.database();


const categoryIds = {
    'breakfast': '61bd80d68b34640010e194b8',
    'lunch': '61bd80d05f2f930010bb6a81',
    'dinner': '61bd80cc5f2f930010bb6a80',
    'bakery': '62d9c7c26c04ea00104859c7',
    'cgld': '61ed97b39be79300147d3d06',
    'fogbreak': '62daecc36c04ea001048a55d',
    'fogld': '61ed885a9be79300147d3898',
}

const categories = [
  'breakfast',
  'lunch',
  'dinner',
  'bakery',
  'cgld',
  'fogbreak',
  'fogld',
]

const dcCategoryIds = {
  'lunch': '64b6fe23e615eb39f2b65a5e',
  'dinner': '64b6fe4de615eb39f2b65e9f',
  'late': '63320eb6007b6b0010480cad',
  'sydbar': '64b6fe75e615eb39f2b662c6',
  'icream': '64b6fd4a0271fe8ccf48d737',
}

const dcCategories = [
  'lunch',
  'dinner',
  'late',
  'sydbar',
  'icream',
]

const dayIds = {
    'sunday': '61bd808b5f2f930010bb6a7a',
    'monday': '61bd80908b34640010e194b3',
    'tuesday': '61bd80ab5f2f930010bb6a7d',
    'wednesday': '61bd80b08b34640010e194b4',
    'thursday': '61bd80b55f2f930010bb6a7e',
    'friday': '61bd80ba5f2f930010bb6a7f',
    'saturday': '61bd80bf8b34640010e194b6',
}

const days = [
  'sunday',
  'monday',
  'tuesday',
  'wednesday',
  'thursday',
  'friday',
  'saturday',
]

const dcDays = [
'monday',
'tuesday',
'wednesday',
'thursday',
'friday',
]

var currentDate = new Date();
var startDate = new Date(currentDate.getFullYear(), 0, 1);
var fullYear = currentDate.getFullYear();
var allDays = Math.floor((currentDate - startDate) / (24 * 60 * 60 * 1000));
var weekNumber = Math.ceil(allDays / 7);    
console.log(`${weekNumber}-${fullYear}`);


//For Pav
for (let i=0; i<days.length; i++) {
  for (let j=0; j<categories.length; j++) {
    
    fetch(`https://widget.api.eagle.bigzpoon.com/menuitems?categoryId=${categoryIds[categories[j]]}&isPreview=false&locationId=61df4a34d5507a00103ee41e&menuGroupId=${dayIds[days[i]]}&userPreferences=%7B%22allergies%22:%5B%5D,%22lifestyleChoices%22:%5B%5D,%22medicalGoals%22:%5B%5D,%22preferenceApplyStatus%22:false%7D`, {
      "headers": {
        "accept": "application/json, text/plain, */*",
        "accept-language": "en-US,en;q=0.9,ja;q=0.8",
        "device-id": "57a75016-5da8-480b-b357-8cd467942f06",
        "if-none-match": "W/\"64de-riYuXSfvvpFEEXzOnlSEn3/Jg9M\"",
        "location-id": "61df4a34d5507a00103ee41e",
        "sec-ch-ua": "\"Google Chrome\";v=\"117\", \"Not;A=Brand\";v=\"8\", \"Chromium\";v=\"117\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "sec-fetch-dest": "empty",
        "sec-fetch-mode": "cors",
        "sec-fetch-site": "same-site",
        "x-comp-id": "61bd7ecd8c760e0011ac0fac"
      },
      // "referrer": "https://uc-merced-the-pavilion.widget.eagle.bigzpoon.com/",
      // "referrerPolicy": "strict-origin-when-cross-origin",
      // "body": null,
      // "method": "GET",
      // "mode": "cors",
      // "credentials": "omit"
    }).then((response) => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error("NETWORK RESPONSE ERROR");
        }
      })
      .then(data => {
        for (let k=0; k<data['data']['menuItems'].length; k++) {
            try {
                //console.log(data['data']['menuItems'][i]['caloriesCalculationSize'][0]['calories']);
                // console.log(`${data['data']['menuItems'][i]['name']}`)
                // console.log(`${data['data']['menuItems'][i]['description']}`)
                // console.log(`${data['data']['menuItems'][i]['caloriesCalculationSize'][0]['calories']}\n`)

                writeMeal(
                  data['data']['menuItems'][k]['name'], 
                  data['data']['menuItems'][k]['description'], 
                  data['data']['menuItems'][k]['caloriesCalculationSize'][0]['calories'],
                  `${weekNumber}-${fullYear}`,
                  days[i],
                  categories[j],
                  k,
                  'pav',
                )

            }
            catch {
            }
        }
      })
      .catch((error) => console.error("FETCH ERROR:", error));
      
    }
}


//For DC
for (let i=0; i<dcDays.length; i++) {
  for (let j=0; j<dcCategories.length; j++) {
    
    fetch(`https://widget.api.eagle.bigzpoon.com/menuitems?categoryId=${dcCategoryIds[dcCategories[j]]}&isPreview=false&locationId=628672b52903a50010fa751e&menuGroupId=${dayIds[dcDays[i]]}&userPreferences=%7B%22allergies%22:%5B%5D,%22lifestyleChoices%22:%5B%5D,%22medicalGoals%22:%5B%5D,%22preferenceApplyStatus%22:false%7D`, {
      "headers": {
        "accept": "application/json, text/plain, */*",
        "accept-language": "en-US,en;q=0.9,ja;q=0.8",
        "device-id": "57a75016-5da8-480b-b357-8cd467942f06",
        "if-none-match": "W/\"64de-riYuXSfvvpFEEXzOnlSEn3/Jg9M\"",
        "location-id": "61df4a34d5507a00103ee41e",
        "sec-ch-ua": "\"Google Chrome\";v=\"117\", \"Not;A=Brand\";v=\"8\", \"Chromium\";v=\"117\"",
        "sec-ch-ua-mobile": "?0",
        "sec-ch-ua-platform": "\"Windows\"",
        "sec-fetch-dest": "empty",
        "sec-fetch-mode": "cors",
        "sec-fetch-site": "same-site",
        "x-comp-id": "61bd7ecd8c760e0011ac0fac"
      },
      // "referrer": "https://uc-merced-the-pavilion.widget.eagle.bigzpoon.com/",
      // "referrerPolicy": "strict-origin-when-cross-origin",
      // "body": null,
      // "method": "GET",
      // "mode": "cors",
      // "credentials": "omit"
    }).then((response) => {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error("NETWORK RESPONSE ERROR");
        }
      })
      .then(data => {
        for (let k=0; k<data['data']['menuItems'].length; k++) {
            try {
                //console.log(data['data']['menuItems'][i]['caloriesCalculationSize'][0]['calories']);
                // console.log(`${data['data']['menuItems'][i]['name']}`)
                // console.log(`${data['data']['menuItems'][i]['description']}`)
                // console.log(`${data['data']['menuItems'][i]['caloriesCalculationSize'][0]['calories']}\n`)

                writeMeal(
                  data['data']['menuItems'][k]['name'], 
                  data['data']['menuItems'][k]['description'], 
                  data['data']['menuItems'][k]['caloriesCalculationSize'][0]['calories'],
                  `${weekNumber}-${fullYear}`,
                  dcDays[i],
                  dcCategories[j],
                  k,
                  'dc',
                )

            }
            catch {
            }
        }
      })
      .catch((error) => console.error("FETCH ERROR:", error));
      
    }
}


function writeMeal(name, description, calories, time, day, category, index, location) {
  firebase.database().ref('allMeals/' + location + '/' + time + "/" + day + "/" + category + "/" + index).set({
    name: name,
    description: description,
    calories : calories,
  });
  console.log(location)
}