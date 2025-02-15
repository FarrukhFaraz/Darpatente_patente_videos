class AppUrl {
  AppUrl._();
  static const String _baseurl = "https://darformazione.darpatenteapp.online/api";

  static String loginUrl = "$_baseurl/user/login";
  static String userInfoUrl = "$_baseurl/user/info";
  static String videoUrl = "$_baseurl/chapter/videos/";
  static String demoUrl = "$_baseurl/demo/category/get";
  static String getDemoChapterUrl = "$_baseurl/category/demo/get/";
  static String infoUrl = "$_baseurl/info/category/get";
  static String getInfoChapterUrl = "$_baseurl/category/info/get/";
  static String userVideoHistoryUrl = "$_baseurl/user/video/history/save";
}
