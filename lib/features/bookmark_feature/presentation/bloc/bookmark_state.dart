part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final GetCityStatus getCityStatus;
  final SaveCityStatus saveCityStatus;
  final GetAllCityStatus getAllCityStatus;
  final DeleteCityStatus deleteCityStatus;

  const BookmarkState(
      {required this.getCityStatus,
      required this.saveCityStatus,
      required this.getAllCityStatus,
      required this.deleteCityStatus});

  /*
  getCityStatus = old state
  saveCityStatus = old state
  getAllCityStatus = old state
  deleteCityStatus = old state
  newGetCityStatus = new state
  newSaveCityStatus = new state
  newGetAllCityStatus = new state
  newDeleteCityStatus = new state
  */
  BookmarkState copyWith(
      {GetCityStatus? newGetCityStatus,
      SaveCityStatus? newSaveCityStatus,
      GetAllCityStatus? newGetAllCityStatus,
      DeleteCityStatus? newDeleteCityStatus}) {
    return BookmarkState(
      getCityStatus: newGetCityStatus ?? getCityStatus,
      saveCityStatus: newSaveCityStatus ?? saveCityStatus,
      getAllCityStatus: newGetAllCityStatus ?? getAllCityStatus,
      deleteCityStatus: newDeleteCityStatus ?? deleteCityStatus,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        getCityStatus,
        saveCityStatus,
        getAllCityStatus,
        deleteCityStatus,
      ];
}
