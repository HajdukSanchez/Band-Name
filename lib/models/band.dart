class Band {
  String id;
  String name;
  int votes;

  Band({required this.id, required this.name, required this.votes});

  // Factory constructor has the object to return a new instance of our class
  factory Band.fromMap(Map<String, dynamic> obj) => Band(
        id: obj['id'],
        name: obj['name'],
        votes: obj['votes'],
      );
}
