#!/usr/bin/env bash

# USAGE: bash scripts/generate-api.bash

dart run pigeon --input pigeons/apple_color_list_api.dart
dart format lib/
