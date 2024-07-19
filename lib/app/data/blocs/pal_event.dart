abstract class PalEvent {}

class GetPals extends PalEvent {
  final String? searchName;

  GetPals({required this.searchName});
}