import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:yoauto_task/constants/constant.dart';

void MapMyIndiaConfigs() {
  MapmyIndiaAccountManager.setMapSDKKey(mapMyIndiaSdkKey);
  MapmyIndiaAccountManager.setRestAPIKey(mapMyIndiaResetKey);
  MapmyIndiaAccountManager.setAtlasClientId(mapMyIndiaAtlasClientId);
  MapmyIndiaAccountManager.setAtlasClientSecret(mapMyIndiaAtlasClientSecret);
}
