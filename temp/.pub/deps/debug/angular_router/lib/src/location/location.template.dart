// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// Generator: TemplateGenerator
// **************************************************************************

// ignore_for_file: cancel_subscriptions,constant_identifier_names,duplicate_import,non_constant_identifier_names,library_prefixes,UNUSED_IMPORT,UNUSED_SHOWN_NAME
import 'location.dart';
export 'location.dart';
import 'dart:async';
import 'package:angular/angular.dart' show Injectable;
import 'location_strategy.dart' show LocationStrategy;
// Required for initReflector().
import 'package:angular/src/di/reflector.dart' as _ngRef;
import 'location_strategy.template.dart' as _ref0;
import 'package:angular/angular.template.dart' as _ref1;

var _visited = false;
void initReflector() {
  if (_visited) {
    return;
  }
  _visited = true;
  _ref0.initReflector();
  _ref1.initReflector();
  _ngRef.registerFactory(
    Location,
    (LocationStrategy p0) => new Location(p0),
  );
  _ngRef.registerDependencies(
    Location,
    const [
      const [
        LocationStrategy,
      ],
    ],
  );
}
