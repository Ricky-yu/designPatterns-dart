class Message {
  final String from;
  final String to;
  final String subject;

  const Message({required this.from, required this.to, required this.subject});
}

abstract class Transmitter {
  Transmitter? nextLink;

  void sendMessage(Message message) {
    if (nextLink != null) {
      nextLink!.sendMessage(message);
    } else {
      print("End of chain reached. Message not sent");
    }
  }

  bool sameEmailDomin(Message message) {
    String dominFromStr = message.from.split('@').last;
    String dominToStr = message.to.split('@').last;
    if (dominFromStr == dominToStr) {
      return true;
    } else {
      return false;
    }
  }
}

class LocalTransmitter extends Transmitter {
  @override
  void sendMessage(Message message) {
    if (sameEmailDomin(message)) {
      print("Message to ${message.to} sent locally");
    } else {
      super.sendMessage(message);
    }
  }
}

class RemoteTransmitter extends Transmitter {
  @override
  void sendMessage(Message message) {
    if (!sameEmailDomin(message)) {
      print("Message to ${message.to} sent remotely");
    } else {
      super.sendMessage(message);
    }
  }
}

class PriorityTransmitter extends Transmitter {
  @override
  void sendMessage(Message message) {
    if (message.subject.contains("Priority")) {
      print("Message to ${message.to} sent as priority");
    } else {
      super.sendMessage(message);
    }
  }
}

void main() {
  final List<Message> messages = [
    Message(
        from: "bob@example.com",
        to: "joe@example.com",
        subject: "go to lunch?"),
    Message(
        from: "bob@example.com",
        to: "alice@acme.com",
        subject: "New Contracts"),
    Message(
        from: "pete@example.com",
        to: "all@example.com",
        subject: "Priority: All-Hands Meeting")
  ];

  var priorityT = PriorityTransmitter();
  var remoteT = RemoteTransmitter();
  var localT = LocalTransmitter();

  priorityT.nextLink = remoteT;
  remoteT.nextLink = localT;

  for (final m in messages) {
    priorityT.sendMessage(m);
  }
}
