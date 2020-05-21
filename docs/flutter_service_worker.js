'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "4c2d215acd63990d1918555997b30569",
"assets/assets/images/breath.png": "ffe2893ec7cdd17621341043961a2910",
"assets/assets/images/breath_mirror.png": "42b42fc96b45e40d581ce6f758117791",
"assets/assets/images/call_hospital.png": "ac647f7dca5efb882581356cf75b2d97",
"assets/assets/images/close_cough.png": "c115df87a0fc61b226db715e3388554a",
"assets/assets/images/coronavirus.png": "170a38891e8953e226fc9067ab99256c",
"assets/assets/images/cough.png": "344c89a6ea9765118f654990ee1b6e61",
"assets/assets/images/crowd.png": "45b5d8f3408cec7f2c466e121f6721f6",
"assets/assets/images/face_mask.png": "b1ef1e1a35433d5fab5a1f33a01d2d7d",
"assets/assets/images/fever.png": "ed09178d06b1c83e021c57dc151dc3f1",
"assets/assets/images/hand_wash.png": "dec60563b13377b1b88ee0504cffbad6",
"assets/assets/images/social_distance.png": "61cb56d1d31edaae03f62fa05fcb4001",
"assets/assets/images/stay_home.png": "29226dd421b3bed57830f7e8ea6ca661",
"assets/assets/images/virus.png": "16fe9da92e527d04170d42d0210efc2d",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/LICENSE": "1d9f99df080d81ce31c674417308a4d2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "d1404151ea07297ba962bb4eb4050a0c",
"/": "d1404151ea07297ba962bb4eb4050a0c",
"main.dart.js": "a8d567e4087fb61c7d6fe950b9a4b5c5",
"manifest.json": "3bb08ed51a53c37bde31e4dca6c0cb64"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
