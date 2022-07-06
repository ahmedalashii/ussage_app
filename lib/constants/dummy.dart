import '../app/data/models/user.dart';
import '../global_presentation/global_features/images_manager.dart';

int noOfUsers = 0;

// Me - Current User
final User currentUser = User(
  id: noOfUsers++,
  name: "Ahmed Alashi",
  imageUrl: ImagesManager.me,
  connectionStatus: false,
);

// Other Users:
final User theresa = User(
  id: noOfUsers++,
  imageUrl: ImagesManager.person4,
  name: "Theresa Webb",
  connectionStatus: true,
);
final User calvin = User(
  id: noOfUsers++,
  imageUrl: ImagesManager.person3,
  name: "Calvin Flores",
);
final User gregory = User(
  id: noOfUsers++,
  imageUrl: ImagesManager.person2,
  name: "Gregory Bell",
);
final User soham = User(
  id: noOfUsers++,
  imageUrl: ImagesManager.person5,
  name: "Soham Henry",
);
final User mother = User(
  id: noOfUsers++,
  imageUrl: ImagesManager.person4,
  name: "Mother ❤",
);
final User brother = User(
  id: noOfUsers++,
  imageUrl: ImagesManager.person2,
  name: "Brother",
);
