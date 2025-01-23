import 'package:kualiva/review/model/author_model.dart';
import 'package:kualiva/review/model/review_place_model.dart';

class ReviewFaker {
  static ReviewPlaceModel myReviewGetByPlace() {
    return ReviewPlaceModel(
      id: 4,
      description: 'Saya suka kalo bawa pacar kesini sambil buka laptop',
      rating: 4.5,
      photoFiles: [],
      createdAt: DateTime.parse('20240809'),
      updatedAt: DateTime.parse('20240809'),
      author: AuthorModel(
        userId: '7',
        username: 'JohnDoe99',
        photoFile: 'https://picsum.photos/id/9/200/200',
      ),
    );
  }

  static List<ReviewPlaceModel> otherReviewGetByPlace() {
    final List<ReviewPlaceModel> data = [];

    data.addAll([
      ReviewPlaceModel(
        id: 1,
        description: 'Tempatnya bagus sekalii',
        rating: 4.5,
        photoFiles: [],
        createdAt: DateTime.parse('20240512'),
        updatedAt: DateTime.parse('20240628'),
        author: AuthorModel(
          userId: '1',
          username: 'lerucco',
          photoFile: 'https://picsum.photos/id/21/200/200',
        ),
      ),
      ReviewPlaceModel(
        id: 2,
        description: 'Tempatnya bagus, tapi kurang instagramable',
        rating: 3.0,
        photoFiles: [],
        createdAt: DateTime.parse('20240421'),
        updatedAt: DateTime.parse('20240421'),
        author: AuthorModel(
          userId: '2',
          username: 'anret',
          photoFile: 'https://picsum.photos/id/19/200/200',
        ),
      ),
      ReviewPlaceModel(
        id: 3,
        description: 'Cocok kalo ajak keluarga kesini',
        rating: 3.0,
        photoFiles: [],
        createdAt: DateTime.parse('20240203'),
        updatedAt: DateTime.parse('20240203'),
        author: AuthorModel(
          userId: '3',
          username: 'asep',
          photoFile: 'https://picsum.photos/id/13/200/200',
        ),
      ),
    ]);

    return data;
  }
}
