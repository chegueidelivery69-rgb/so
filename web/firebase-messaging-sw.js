importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
  apiKey: "AIzaSyAGQJPV_ydmBFtEK1ent6KMeEHX08M-its",
  authDomain: "to-chegando-motoboy-24b4a.firebaseapp.com",
  projectId: "to-chegando-motoboy-24b4a",
  storageBucket: "to-chegando-motoboy-24b4a.firebasestorage.app",
  messagingSenderId: "491950036407",
  appId: "1:491950036407:web:46dc22fe2aa3dfdb034432",
  databaseURL: "https://to-chegando-motoboy-24b4a-default-rtdb.firebaseio.com"
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
  const promiseChain = clients
    .matchAll({
      type: "window",
      includeUncontrolled: true
    })
    .then(windowClients => {
      for (let i = 0; i < windowClients.length; i++) {
        const windowClient = windowClients[i];
        windowClient.postMessage(payload);
      }
    })
    .then(() => {
      const title = payload.notification.title;
      const options = {
        body: payload.notification.body,
        icon: "/notification_icon.png"
      };
      return registration.showNotification(title, options);
    });

  return promiseChain;
});

self.addEventListener("notificationclick", function (event) {
  event.notification.close();
  console.log("Notification received: ", event);
});
