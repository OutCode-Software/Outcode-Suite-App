class InAppNotification {
  InAppNotification(this.title, this.message, this.payload);
  final String? title;
  final String? message;
  final Map<String, dynamic> payload;
  String get notificationTitle {
    return title ?? 'title';
  }

  String get notificationBody {
    return message ?? '';
  }

  String? get chatRoomId {
    if (payload['chatRoomId'] != null) {
      return payload['chatRoomId'];
    }
    return null;
  }

  String? get teamId {
    if (payload['teamId'] != null) {
      return payload['teamId'];
    }
    return null;
  }
}
