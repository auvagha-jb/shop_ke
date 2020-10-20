class Ticket {
  String username;
  String ticket;
  String timestamp;
  bool active;

  Ticket.fromMap(Map<String, dynamic> map) {
    username = map['username'];
    ticket = map['ticket'];
    timestamp = map['timestamp'];
    active = map['active'];
  }

  Map<String, dynamic> toMap(Ticket ticket) {
    return {
      'username': ticket.username,
      'ticket': ticket.ticket,
      'timestamp': ticket.timestamp,
      'active': ticket.active,
    };
  }
}
