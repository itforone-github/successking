import 'package:permission_handler/permission_handler.dart';
class Util{
  static final String domain = 'http://everywhere2.itforone.co.kr/';
  static final String url = 'http://everywhere2.itforone.co.kr/index.php';
  static final String jsonUrl = 'adm/json/query.php';


  //권한확인
  Future<bool> checkPermission(permission) async{

    PermissionStatus storagePermissionStatus = await PermissionHandler().checkPermissionStatus(permission);
    if (storagePermissionStatus == PermissionStatus.granted) {
      print('Storage permission is granted.'); return true;
    } else {
      print('Storage permission is not granted.'); return false;
    }
  }
  //권한설정 하기
  Future<bool> requestPermission(permission) async {
    var result = await PermissionHandler().requestPermissions([permission]);
    if (result[PermissionGroup.storage] == PermissionStatus.granted) {
      print('Storage permission is granted.');
      return true;
    } else {
      print('Storage permission is not granted.'); return false;
    }
  }


}