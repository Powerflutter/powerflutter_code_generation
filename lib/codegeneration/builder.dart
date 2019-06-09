import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder powerflutterGenerator(BuilderOptions options) => SharedPartBuilder([PowerflutterGenerator()], 'powerflutterGenerator');

class PowerflutterGenerator extends GeneratorForAnnotation<Object> {
  @override
  FutureOr<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    var visitor = ModelVisitor();
    element.visitChildren(visitor);
    var buffer = StringBuffer();
    buffer.writeln("class ${visitor.className.displayName.replaceFirst('_', '')} extends ${visitor.className.displayName}{");
    for (var item in visitor.fields) {
      var name = item.name;
      var modelName = name;
      if (item.metadata.length > 0) print(item.metadata.first.computeConstantValue().type.name);
      for (var metadata in item.metadata) {
        var value = metadata.computeConstantValue();
        if (value.type.name == "ModelName") {
          modelName = value.getField("name").toStringValue();
        }
      }
      buffer.writeln("${item.type} get $name => get('$modelName', () => super.$name);");
      buffer.writeln("set $name(${item.type} value) => set('$modelName', value);");
      buffer.writeln("");
    }

    buffer.writeln("}");

    return buffer.toString();
  }
}

class ModelVisitor extends SimpleElementVisitor {
  DartType className;
  List<FieldElement> fields = [];
  @override
  visitConstructorElement(ConstructorElement element) {
    className = element.type.returnType;
  }

  @override
  visitFieldElement(FieldElement element) {
    fields.add(element);
  }
}
