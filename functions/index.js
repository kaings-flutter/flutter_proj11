const functions = require('firebase-functions');
const admin = require('firebase-admin');
const fs = require('fs');

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

        // fs.writeFile('dummy.csv', newValue, (err) => {
        //     if(err)
        //     console.log("ERROR creating file!!!!!", err);
        // });

        fs.writeFileSync('dummy.csv', 'username,email\n');

        const userRef = admin.firestore().collection('users');
        userRef.get().then((res) => {
            res.docs.map(doc => {
                console.log('res..... ', doc.data());

                fs.appendFile('dummy.csv', doc.data().username + ',' + doc.data().email + '\n', (err) => {
                    if(err)
                    console.log("ERROR creating file!!!!!", err);
                });
            });
        });

        // fs.appendFile('dummy.csv', newValue.text, (err) => {
        //     if(err)
        //     console.log("ERROR creating file!!!!!", err);
        // });

        admin.messaging().sendToTopic('chat', {
            notification: {
                title: snapshot.data().userEmail,
                body: snapshot.data().text,
                clickAction: 'FLUTTER_NOTIFICATION_CLICK',
            },
        });

        return;
    });