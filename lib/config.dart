enum Environments {
  TEST,
  DEV,
  BETA,
  PROD
}
class AppSettings {
 late String apiBaseUrl;
  late String apiAccessToken;
  late String apiClientSecret;

  factory AppSettings.byEnvironment(Environments env){
    switch (env) {
      case Environments.DEV:
        return AppSettings(
          apiBaseUrl: "http://akwasi.jimahtech.com",
          apiAccessToken: "reg67yu20cve98hty47h28ffr3er3uf0dfg4re7fg0wdJYdiX3bbCQazUjAU5qRhiLFXAG6l1",
        );
      case Environments.BETA:
        return AppSettings(
            apiBaseUrl: "http://akwasi.jimahtech.com",
            apiAccessToken: "6ZbwfUS9upDsOYvIXNER0YjMU2cGNq"
        );
      case Environments.PROD:
        return AppSettings(
          apiBaseUrl: "http://akwasi.jimahtech.com",
          apiAccessToken: "reg67yu20cve98hty47h28ffr3er3uf0dfg4re7fg0wdJYdiX3bbCQazUjAU5qRhiLFXAG6l1",
        );

      case Environments.TEST:
        return AppSettings(
          apiBaseUrl: "http://akwasi.jimahtech.com",
          apiAccessToken: "2d0dc247-f1b0-4406-a688-931911526d17",
        );
    }
  }

  AppSettings({
    required this.apiBaseUrl,
    required this.apiAccessToken,
  });
}

class Strings{

  static const int appId = 3;
  static const int pageTeam = 1;
  static const int pageFixtureList = 2;
  static const int pageGalleryList = 3;
  static const int pageGalleryDisplay = 4;
  static const int pageNewsDetails = 5;
  static const int pageSecondSplash = 6;
  static const int pageNewsList = 7;
  static const int pageSticky = 8;


  //App Labels
  static const String apiKey = 'AIzaSyDrfj5iE_Mas6zoSGP0BS0V60SFEZDM5Hs';
  static const String appName = 'Akwasi Awuah';
  static const String Lbl_Advert = "Advertisement";
  static const String radioImage = 'http://akwasi.jimahtech.com/logo.png';
  static const String jimah_ads_news_details = "https://api.jimahads.com/api/v1/ads/page/$pageNewsDetails/app/$appId/type/1";

}