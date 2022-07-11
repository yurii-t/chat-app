const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp()
exports.sendNotification = functions.firestore.document('chats/{chatId}/messages/{messageId}')
// exports.sendNotification = functions.firestore.document('chats/{chatId}/messages/{messageId}/{message}')
.onCreate((snap,context) => {
    console.log('----------------start function--------------------')

    const doc = snap.data();

    const senderId = doc.sederUID;
    const recipientId = doc.recipientUID;
    const messageText = doc.message;

    admin.firestore()
    .collection('users')
    .where('userId','==',recipientId)
    .get()
    .then(querySnapshot => {
        querySnapshot.forEach(userTo =>{
            if(userTo.data().pushToken && userTo.data().chattingWith !== senderId){
          
                admin.firestore()
                .collection('users')
                .where('userId','==',senderId)
                .get()
                .then(querySnap =>{
                    querySnap.forEach(userFrom=>{
                        const playload={
                            notification: {
                                title: `New message from "${userFrom.data().userName}"`,
                                body: messageText,
                                badge: '1',
                                sound: 'default'
                              }
                        }

                        admin.messaging()
                        .sendToDevice(userTo.data().pushToken,playload)
                        .then(response => {
                            console.log('Successfully sent message:', response)
                          })
                          .catch(error => {
                            console.log('Error sending message:', error)
                          })

                    })
                })

            }else{
                console.log('Can not find pushToken target user')
            }
        })
    })
    return null
})


///chats/tqyPM6a0UXJHoZiq1xII/messages/01jCI42TAqlyeLwVDmr8
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
