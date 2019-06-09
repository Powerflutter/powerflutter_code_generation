# powerflutter_code_generation

Powerflutter Code Generation Library

## Getting Started

1. Add `powerflutter_code_generation` to your dev_dependencies.
2. Run `flutter packages pub run build_runner watch` in the terminal of the project
3. Add Annotations to your code like `@powermodel` and the `part 'filename.g.dart';` to the top of the file

## Annotations 

`@powermodel`: Used on a private (start it with underscore `_` ) model class a public class will be generated that inherits the private class and overrides every field with a setter and getter needed for Powerflutter databinding.

`@ModelName("test")` Used on a field of a `@powermodel` class sets the Name used in serialization etc. for this field

##Example

In the Powerflutter Examples we use the following simple :

```
import 'package:powerflutter/powerflutter.dart';

part 'counter.g.dart';

@powermodel
class _CounterModel with PowerModel {
  int counter = 0;
}
```

This will generate a `CounterModel` Class that has the Getters and Setters needed for Poweflutter. 