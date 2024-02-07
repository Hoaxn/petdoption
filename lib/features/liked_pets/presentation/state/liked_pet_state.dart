// import 'package:pet_adoption_app/features/liked_pets/domain/entity/liked_pet_entity.dart';

// class LikedPetState {
//   final bool isLoading;
//   final String? error;
//   final List<LikedPetEntity> likedPetEntity;

//   const LikedPetState({
//     required this.isLoading,
//     required this.error,
//     required this.likedPetEntity,
//   });

//   factory LikedPetState.initial() => const LikedPetState(
//         isLoading: false,
//         error: null,
//         likedPetEntity: [],
//       );

//   LikedPetState copyWith({
//     bool? isLoading,
//     String? error,
//     List<LikedPetEntity>? likedPetEntity,
//   }) {
//     return LikedPetState(
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//       likedPetEntity: likedPetEntity ?? this.likedPetEntity,
//     );
//   }

//   LikedPetState updatePetz(List<LikedPetEntity> newLikedPetEntity) {
//     return copyWith(likedPetEntity: newLikedPetEntity);
//   }
// }
