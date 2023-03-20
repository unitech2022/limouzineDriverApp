class ApiConstants {
  // static const baseUrl ="";
  static const baseUrl = "https://d084-197-38-0-252.eu.ngrok.io";
  static const baseUrlImages = "$baseUrl/images/";
  static const checkUserPath = "$baseUrl/check-username";
  static const loginPath = "$baseUrl/user-login";
  static const signUpPath =
      "$baseUrl/signup";
  static const uploadImagesPath =
      "$baseUrl/image/upload/image";

  static const addDriverPath =
      "$baseUrl/driver/add-driver";

        static const homeDriverPath =
      "$baseUrl/driver/get-driver-home?";

      static const changeStatusTripPath =
      "$baseUrl/trips/change_status_trip";

         static const changeStatusDriverPath =
      "$baseUrl/driver/update-status-driver";
  static const updateDeviceTokenPath =
      "$baseUrl/update-device-token";

  static const getUserPath =
      "$baseUrl/get-user";

        static const updateUserPath =
      "$baseUrl/update-user";
static const getHistoriesPath =
    "$baseUrl/trips/histories-driver";

 static const updateDriverPath =
      "$baseUrl/driver/update-driver";

 static const getDriverByIDPath =
      "$baseUrl/driver/get-driver-by-id?driverId=";

 static const getNotificationsPath =
      "$baseUrl/notification/get-notifications?UserId=";


    
  static const getCityDetailsPath = "$baseUrl/cities/get-city-details?";
  static const getPlaceDetailsPath = "$baseUrl/places/get-placeDetails?";

  static const searchCitiesPath = "$baseUrl/cities/search_city?";

  static const getFavoritesPath = "$baseUrl/Favorite/get-favorites?";
  static String imageUrl(path) => baseUrlImages+path;

  // local Storage constants
  static const langKey = "lang";
  static const tokenKey = "token";
  static const phoneKey = "phone";
  static const userIdKey = "id";
  static const emailKey = "email";
  static const roleKey = "role";
  static const imageKey = "image";
  static const nameKey = "name";
}