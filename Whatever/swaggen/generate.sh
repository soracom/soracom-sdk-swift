#! /bin/sh

swaggen generate soracom-api.en.json \
  --template Template \
  --option name:SoracomAPI \
  --destination auto-generated-models
