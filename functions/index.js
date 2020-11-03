const functions = require('firebase-functions');
const admin = require('firebase-admin');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

exports.onChatCreated = functions.firestore
    .document('chat/{chatMessages}')
    .onCreate((snapshot, ctx) => {
        const newValue = snapshot.data();

        console.log('newValue..... ', newValue);

        admin.messaging().sendToTopic('chat', {
            notification: {
                title: snapshot.data().userEmail,
                body: snapshot.data().text,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            },
        });

        return;
    });