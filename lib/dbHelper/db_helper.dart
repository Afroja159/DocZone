import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doczone/models/user_model.dart';
import '../auth/auth_service.dart';
import '../models/medi_alarm_model.dart';
import '../models/message_model.dart';
import '../models/notification_model.dart';
import '../models/request_blood_model.dart';

class DbHelper {
  static const String collectionMedicineAlarm = 'MedicineAlarm';
  static const String collectionBloodRequest = 'BloodRequest';
  static const String collectionNotification = 'Notifications';
  static const String collectionChatRoomMassages = 'ChatRoomMassages';
  UserModel? _profileModel;
  bool _fetchSuccess = false;
  UserModel? get profileModel => _profileModel;


  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<bool> addMedicineAlarm(MediAlarmModel mediAlarmModel) async {
    String userId = AuthService.user!.uid;

    try {
      // final doc = _db.collection(collectionMedicineAlarm).doc();
      // mediAlarmModel.id=doc.id;
      // await doc.set(mediAlarmModel.toMap());
      final doc = _db
          .collection('Users')
          .doc(userId)
          .collection(collectionMedicineAlarm)
          .doc();
      mediAlarmModel.id = doc.id;
      await doc.set(mediAlarmModel.toMap());
      return true;
    } catch (e) {
      print('Error adding medicine alarm: $e');
      return false;
    }
  }

  // static Future<bool> addNotification(NotificationModel notificationModel) async {
  //   String userId = AuthService.user!.uid;
  //
  //   try {
  //     final doc = _db
  //         .collection('Users')
  //         .doc(userId)
  //         .collection(collectionNotification)
  //         .doc();
  //
  //     notificationModel.notificationId = doc.id;
  //     await doc.set(notificationModel.toMap());
  //     return true;
  //   } catch (e) {
  //     print('Error adding new notification: $e');
  //     return false;
  //   }
  // }

  static Future<bool> addNotification(NotificationModel notificationModel,
      {bool createCollectionForAllUsers = false}) async {
    String userId = AuthService.user!.uid;

    try {
      if (createCollectionForAllUsers) {
        // Create notification collection for all users
        final allUsersQuerySnapshot = await _db.collection('Users').get();
        final allUsersDocs = allUsersQuerySnapshot.docs;

        for (var userDoc in allUsersDocs) {
          final userDocRef = userDoc.reference;
          final notificationCollectionRef = userDocRef.collection(collectionNotification);
          final notificationDocRef = notificationCollectionRef.doc();

          notificationModel.notificationId = notificationDocRef.id;
          await notificationDocRef.set(notificationModel.toMap());
        }
      }
      else {
        // Create notification collection for the current user
        // final userDoc = _db.collection('Users').doc(userId);
        // final notificationCollectionRef = userDoc.collection(collectionNotification);
        // final notificationDocRef = notificationCollectionRef.doc();
        //
        // notificationModel.notificationId = notificationDocRef.id;
        // await notificationDocRef.set(notificationModel.toMap());

        final userDoc = _db.collection('Users').doc(userId);
        final notificationCollectionRef = userDoc.collection(collectionNotification);

// Get the notifications for the current user
        final QuerySnapshot snapshot = await notificationCollectionRef.get();

// Check if any notification was created today
        final today = DateTime.now().toLocal();
        final todayNotifications = snapshot.docs.where((doc) {
          final notificationTime = (doc.data() as Map<String, dynamic>)['notificationCreationTime'] as Timestamp;
          final notificationDateTime = notificationTime.toDate().toLocal();
          return notificationDateTime.year == today.year &&
              notificationDateTime.month == today.month &&
              notificationDateTime.day == today.day;
        });

        if (todayNotifications.isNotEmpty) {
          // A notification was already created today
          print('Notification already exists for today');
        } else {
          // Create a new notification
          final notificationDocRef = notificationCollectionRef.doc();

          notificationModel.notificationId = notificationDocRef.id;
          notificationModel.notificationCreationTime = Timestamp.fromDate(today); // Set the notification creation time
          await notificationDocRef.set(notificationModel.toMap());
          print('New notification created');
        }
      }

      return true;
    } catch (e) {
      print('Error adding new notification: $e');
      return false;
    }
  }



  static Future<bool> addBloodRequest(RequestBloodModel requestBloodModel) async {
    try {
      final doc = _db.collection(collectionBloodRequest).doc();
      requestBloodModel.id=doc.id;
      await doc.set(requestBloodModel.toMap());
      return true;
    } catch (e) {
      print('Error adding blood request: $e');
      return false;
    }
  }



  static Future<List<MediAlarmModel>> fetchMedicineAlarms() async {
    String userId = AuthService.user!.uid;

    try {
      final snapshot = await _db.collection("Users").doc(userId).collection(collectionMedicineAlarm).get();
      final data = snapshot.docs.map((doc) => MediAlarmModel.fromMap(doc.data())).toList();
      return data;
    } catch (e) {
      print('Error fetching medicine alarms: $e');
      return []; // Return an empty list if an error occurred during fetching
    }
  }




  static Future<List<UserModel>> fetchAvailableDonor() async {
    DateTime currentDate = DateTime.now();
    DateTime thresholdDate = currentDate.subtract(Duration(days: 90));
    Timestamp thresholdTimestamp = Timestamp.fromDate(thresholdDate);


    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('bloodDonationDate', isLessThan: thresholdTimestamp)
          .get();

      List<UserModel> donors = snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
      return donors;
    } catch (e) {
      print('Error fetching Available Donor: $e');
      return []; // Return an empty list if an error occurred during fetching
    }
  }



  static Future<List<RequestBloodModel>> fetchRequestBloodData() async {
    try {
      final snapshot = await _db
          .collection(collectionBloodRequest)
          .where('isAccepted', isEqualTo: false)
          .get();

      final data = snapshot.docs
          .where((doc) => doc.data()['isAccepted'] != null) // Filter out null values
          .map((doc) => RequestBloodModel.fromMap(doc.data()))
          .toList();

      return data;
    } catch (e) {
      print('Error fetching request blood data: $e');
      return []; // Return an empty list if an error occurred during fetching
    }
  }


  static Future<List<RequestBloodModel>> fetchRequestBloodSubmittedData() async {
    final uid = AuthService.user!.uid;
    try {

      final snapshot = await _db
          .collection(collectionBloodRequest)
          .where('requestById', isEqualTo: uid)
          .get();
      final data = snapshot.docs.map((doc) => RequestBloodModel.fromMap(doc.data())).toList();
      return data;
    } catch (e) {
      print('Error fetching request blood data: $e');
      return []; // Return an empty list if an error occurred during fetching
    }
  }



  static Future<List<NotificationModel>> fetchNotificationData() async {
    final uid = AuthService.user!.uid;

    try {
      final snapshot = await _db
          .collection("Users")
          .doc(uid)
          .collection(collectionNotification)
          .orderBy('notificationCreationTime', descending: false)
          .get();

      final data = snapshot.docs.map((doc) => NotificationModel.fromMap(doc.data())).toList();
      return data.reversed.toList(); // Reverse the list to have the latest data first
    } catch (e) {
      print('Error fetching NotificationModel data: $e');
      return []; // Return an empty list if an error occurred during fetching
    }
  }


  static Future<List<RequestBloodModel>> fetchAcceptRequestBloodData() async {
    final uid = AuthService.user!.uid;

    try {
      final snapshot = await _db
          .collection(collectionBloodRequest)
          .where('acceptedById', isEqualTo: uid)
          .where('isAccepted', isEqualTo: true)
          .where('isBloodDonated', isEqualTo: false)
          .get();

      final List<RequestBloodModel> acceptedData = [];

      snapshot.docs.forEach((doc) {
        final data = doc.data();
        if (data['isAccepted'] == true && data['isBloodDonated'] == false) {
          final requestBloodModel = RequestBloodModel.fromMap(data);
          acceptedData.add(requestBloodModel);
        }
      });

      return acceptedData;
    } catch (e) {
      print('Error fetching accepted request blood data: $e');
      return []; // Return an empty list if an error occurred during fetching
    }
  }
  //
  // static Future<List<RequestBloodModel>> fetchDonatedBloodData() async {
  //   try {
  //     final snapshot = await _db
  //         .collection("BloodRequest")
  //         .where('isBloodDonated', isEqualTo: true)
  //         .get();
  //
  //     final List<RequestBloodModel> donatedBloodData = [];
  //
  //     snapshot.docs.forEach((doc) {
  //       final data = doc.data();
  //       if ( data['isBloodDonated'] == true) {
  //         final requestBloodModel = RequestBloodModel.fromMap(data);
  //         donatedBloodData.add(requestBloodModel);
  //       }
  //     });
  //
  //     return donatedBloodData;
  //   } catch (e) {
  //     print('Error fetching accepted request blood data: $e');
  //     return []; // Return an empty list if an error occurred during fetching
  //   }
  // }


  static Future<List<RequestBloodModel>> fetchDonatedBloodData() async {
    final uid = AuthService.user!.uid;
    try {

      final snapshot = await _db
          .collection(collectionBloodRequest)
          .where('isBloodDonated', isEqualTo: true)
          .where('acceptedById', isEqualTo: uid)
          .get();
      final data = snapshot.docs.map((doc) => RequestBloodModel.fromMap(doc.data())).toList();
      return data;
    } catch (e) {
      print('Error fetching isBloodDonated  data: $e');
      return []; // Return an empty list if an error occurred during fetching
    }
  }




  static Future<void> addMsg(MessageModel messageModel) =>
      _db.collection(collectionChatRoomMassages)
          .doc().set(messageModel.toMap());

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatRoomMessages() =>
      _db.collection(collectionChatRoomMassages)
          .orderBy('msgId', descending: true)
          .snapshots();
}
