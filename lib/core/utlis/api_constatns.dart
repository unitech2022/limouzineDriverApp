class ApiConstants {
  // static const baseUrl ="";
  static const baseUrl = "https://3080-197-38-53-207.eu.ngrok.io";
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
  static const updateDeviceTokenPath =
      "$baseUrl/update-device-token";

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