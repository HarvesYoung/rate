class NotificationItemModel {
  final String? picture;
  final String title;
  final String subtitle;

  const NotificationItemModel({
    required this.title,
    required this.subtitle,
    this.picture
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      picture: json['picture'],
      title: json['title'],
      subtitle: json['subtitle']
    );
  }
}