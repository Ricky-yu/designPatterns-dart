## Chain of Responsibility Pattern
In object-oriented design, the chain-of-responsibility pattern is a design pattern consisting of a source of command objects and a series of processing objects. Each processing object contains logic that defines the types of command objects that it can handle; the rest are passed to the next processing object in the chain. A mechanism also exists for adding new processing objects to the end of this chain. Thus, the chain of responsibility is an object oriented version of the if ... else if ... else if ....... else ... endif idiom, with the benefit that the condition–action blocks can be dynamically rearranged and reconfigured at runtime.

In a variation of the standard chain-of-responsibility model, some handlers may act as dispatchers, capable of sending commands out in a variety of directions, forming a tree of responsibility. In some cases, this can occur recursively, with processing objects calling higher-up processing objects with commands that attempt to solve some smaller part of the problem; in this case recursion continues until the command is processed, or the entire tree has been explored. An XML interpreter might work in this manner.

This pattern promotes the idea of loose coupling.

The chain-of-responsibility pattern is structurally nearly identical to the decorator pattern, the difference being that for the decorator, all classes handle the request, while for the chain of responsibility, exactly one of the classes in the chain handles the request.

[Wikipedia: Chain of Responsibility](https://en.wikipedia.org/wiki/Chain-of-responsibility_pattern)

[YouTube: Chain of Responsibility](https://www.youtube.com/watch?v=jDX6x8qmjbA&ab_channel=DerekBanas)

``` dart
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
    
    return dominFromStr == dominToStr;
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
```
```
#####OUTPUT######
Message to joe@example.com sent locally
Message to alice@acme.com sent remotely
Message to all@example.com sent as priority
```
