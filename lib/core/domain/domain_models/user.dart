import 'package:app/base/common_widgets/selectable_listview.dart';
import 'package:app/core/domain/domain_models/asset.dart';
import 'package:uuid/uuid.dart';

class User implements ListItem {
  User(
      {required this.id,
      required this.name,
      this.avatar,
      this.selected = false});
  final String id;
  final String name;
  final Asset? avatar;
  bool selected = false;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode;

  static User getDummyUser() {
    return User(
      id: const Uuid().v4(),
      name: 'Ashwin Shrestha',
      avatar: Asset(
        id: const Uuid().v4(),
        url: 'https://ashwinshrestha.com/images/protfolio1.jpeg',
      ),
    );
  }

  static List<User> getDummyUsers() {
    return List.generate(10, (index) => User.getDummyUser());
  }

  @override
  String? get imageUrl => avatar?.url;

  @override
  bool get isSelected => selected;

  @override
  String get listTitle => name;
}
