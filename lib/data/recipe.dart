import 'package:flutter/material.dart';
import 'items.dart';

class Recipe{
  const Recipe({
    this.icon,
    this.ingredients  = const <Item>[],
  });

  final Icon icon;
  final List<Item> ingredients;
  static final Map<String, int> ing = {};

  Map get getIng{
    Map<String, int> m = Map<String, int>();
    m.addAll(ing);
    return m;
  }

}

class IronPlateR extends Item{
  const IronPlateR({
    this.icon = const Icon(Icons.wb_iridescent)
  });

  final Icon icon;
}

class CopperPlateR extends Item{
  const CopperPlateR({
    this.icon
  });

  final Icon icon;
}

class IronGearR extends Recipe{
  const IronGearR({
    this.icon = const Icon(Icons.brightness_low),
    this.ingredients = const <Item>[Iron(), Iron(), Iron(), Iron(), Iron()],
  }) : super(
    icon:icon,
  );

  final Icon icon;
  final List<Item> ingredients;
  static final Map<String, int> ing = {'Iron': 5};

}

class CircuitR extends Recipe{
  const CircuitR({
    this.icon = const Icon(Icons.blur_on),
    this.ingredients = const <Item>[Iron(), Copper()]
  });

  final Icon icon;
  final List<Item> ingredients;
}

class BeltItemR extends Recipe{
  BeltItemR({
    this.icon = const Icon(Icons.arrow_forward),
    this.ingredients = const <Item>[IronGear(),IronGear(),IronGear(),IronGear(),IronGear(),Iron(),Iron()]
  });

  final Icon icon;
  final List<Item> ingredients;
}

class RoboticArmItemR extends Recipe{
  RoboticArmItemR({
    this.icon = const Icon(Icons.input),
    this.ingredients = const <Item>[Circuit(),Circuit(),IronGear(),IronGear(),IronGear(),Iron(),Iron()]
  });

  final Icon icon;
  final List<Item> ingredients;
}