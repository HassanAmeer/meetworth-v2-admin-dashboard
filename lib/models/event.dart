import 'stops.dart';
import 'usersModel.dart';

class EventModel {
  String id = "";
  int status = 1; // 0=deactive, 1=active, 2=finish, 3=cancel(not use)
  String ownerId = '';
  String ownerName = '';

  String taxIdentificationNumber = "";
  DateTime date = DateTime(1000);

  double changeCardFee = 3.00; //  Change Card Cost
  double joinFee = 5.00; // Join Price

  String pokerName = "";
  String description = "";
  String cancelReason = "";
  String eventWinner = "";
  bool isAdditionalCard = false;
  List<StopsModel> stops = [
    StopsModel(), // start
    StopsModel(),
    StopsModel(),
    StopsModel(),
    StopsModel(),
    StopsModel(),
    StopsModel() // destination
  ];
  List<UserModel> users = [];
  List<dynamic> userIds = [];
  EventModel();

  EventModel.toModel(Map<String, dynamic> jsonMap) {
    ownerId = jsonMap['ownerId'] ?? "";
    ownerName = jsonMap['ownerName'] ?? "";
    id = jsonMap['id'];
    status = jsonMap['status'];
    isAdditionalCard = jsonMap['isAdditionalCard'] ?? false;
    pokerName = jsonMap['pokerName'].toString().trim();
    cancelReason = jsonMap['cancelReason'];
    eventWinner = jsonMap['eventWinner'];
    taxIdentificationNumber = jsonMap['taxIdentificationNumber'] ?? "";
    userIds = jsonMap['userIds'] ?? [];
    description = jsonMap['description'];
    // stops = ((jsonMap['stops'] ?? []) as List)
    //     .map((e) => StopsModel.toModel(e))
    //     .toList();
    // users = ((jsonMap['users'] ?? {}) as Map)
    //     .values
    //     .toList()
    //     .map((e) => UserModel.toModel(e))
    //     .toList();
    date = jsonMap['date'] == null ? DateTime(1000) : jsonMap['date'].toDate();
    changeCardFee =
        jsonMap['changeCardFee'] == "" || jsonMap['changeCardFee'] == null
            ? 0.0
            : jsonMap['changeCardFee'] + 0.0;
    joinFee = jsonMap['joinFee'] == "" || jsonMap['joinFee'] == null
        ? 0.0
        : jsonMap['joinFee'] + 0.0;
  }

  List<String> generateArray(String pokerName) {
    pokerName = pokerName.toLowerCase();
    List<String> list = [];
    for (int i = 0; i < pokerName.length; i++) {
      list.add(pokerName.substring(0, i + 1));
    }
    return list;
  }
}
