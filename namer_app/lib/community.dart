import 'package:flutter/material.dart';

int atomicId = 1;

class Community {
  int id;
  String name;
  Icon icon = Icon(Icons.person);

  Community(this.name, this.icon) : id = atomicId++;

  Community.Default()
      : icon = Icon(Icons.person),
        id = atomicId++,
        name = "Default Community";
}
