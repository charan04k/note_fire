importScripts("https://www.gstatic.com/firebasejs/10.13.2/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.13.2/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyAlTS2blGY9Fies7o3rNO4Ldj3BqZ7QBtM",
    authDomain: "firenote-86373.firebaseapp.com",
    projectId: "firenote-86373",
    storageBucket: "firenote-86373.firebasestorage.app",
    messagingSenderId: "717135808565",
    appId: "1:717135808565:web:8b849ccfbeb780076ac97c",
});



const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  self.registration.showNotification(
    payload.notification.title,
    {
      body: payload.notification.body,
      icon: "/icons/Icon-192.png",
    }
  );
});