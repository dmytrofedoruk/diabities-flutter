class AppUrl {
  static const String baseURL = 'http://18.185.238.239:3000/';

  static const String signupInLightHouse = '${baseURL}signup';
  static const String loginInLightHouse = '${baseURL}login';
  static const String emergencyNumbers = '${baseURL}emergency-numbers';
  static const String emergencyActive = '${baseURL}emergency/active';
  static const String emergencyInActive = '${baseURL}emergency/inactive';
  static const String emergencyCallingStatus = '${baseURL}emergency/status';
  static const String subscriptionCheckLightHouse = '${baseURL}check-subscription';
  static const String config = '${baseURL}config';
  static const String devicesList = '${baseURL}deviceList';
  static const String devicesListFromServer = '${baseURL}user/hue-lights/';
  static const String activateOrDeactivatedevice = '${baseURL}user/';

  static const String light = '${baseURL}light/';
  static const String lights = '${baseURL}lights/';
  static const String getUserName = '${baseURL}username/';
  // static const String libreLogin = '${baseURL}libre-view/auth/login';
  // static const String libreSendOtp = '${baseURL}libre-view/auth/continue/2fa/sendcode';
  // static const String libreVerifyOtp = '${baseURL}libre-view/auth/continue/2fa/result';
  // static const String libreGetData = '${baseURL}libre-view/glucoseHistory';

  static const String libreLinkupLogin = '${baseURL}libre-linkup/auth/login';
  static const String libreLinkupConnection = '${baseURL}libre-linkup/connections';
  static const String libreLinkupMeasurement = '${baseURL}libre-linkup/measurement';
  static const String libreLinkupMeasurementFromServer = '${baseURL}libre-data/';
  static const String smartLightSyncActive = '${baseURL}user-light-sync/on';
  static const String smartLightSyncINActive = '${baseURL}user-light-sync/off';
  static const String smartLightSyncStaus = '${baseURL}user-light-sync/';

  static const String nightScoutUrl = '${baseURL}user/';
}
