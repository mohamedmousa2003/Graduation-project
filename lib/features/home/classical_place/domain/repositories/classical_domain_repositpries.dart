import '../../../tourist_place/data/models/tourist_place.dart';
import '../../data/models/classical_place.dart';

abstract class ClassicalDomainRepositories {
  Future<List<ClassicalPlace>> getClassical();
}