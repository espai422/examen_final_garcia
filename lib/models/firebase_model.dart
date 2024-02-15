abstract class BaseModel {
  String? id;

  BaseModel({this.id});

  /// must override this
  factory BaseModel.fromJson(String str) {
    throw UnimplementedError();
  }

  String toJson();

  Map<String, dynamic> toMap();

  /// must override this
  factory BaseModel.fromMap(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
