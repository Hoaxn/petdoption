class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://localhost:3000/";
  // static const String baseUrl = "http://192.168.1.67:3000/";
  // static const String baseUrl = "http://172.26.1.253:3000/";
  static String baseImageUrl(String? image) {
    return "http://localhost:3000/uploads/$image";
  }

  // ====================== Auth Routes ======================
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String getAllUsers = "/auth/users";
  static const String deleteUser = "/auth/users";
  static const String updateUser = "/auth/users";
  // static const String uploadImage = "auth/uploadImage";

  // ====================== Pet Routes ======================
  static const String createPet = "/pets";
  static const String deletePet = "/pets";
  static const String getAllPets = "/pets";
  static const String imageUrl = "http://localhost:3000/uploads/";

  // ====================== Adoption Form Routes ======================
  static const String postAdoptionForm = "/form/adoptionForm";
  static const String getAdoptionFormsByUserId = "/form/adoptionForm";
  static const String deleteAdoptionForm = "/form/adoptionForm";

  // ====================== Liked Pet Routes ======================
  static const String saveLikedPet = "/liked-pets";
  static const String getLikedPetsByUserId = "/liked-pets";
  static const String removeLikedPet = "/liked-pets";
}
