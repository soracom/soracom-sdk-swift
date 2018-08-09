#! /bin/sh
#
# This script should be run from the ./Whatever/swaggen/ directory.
#
# It uses SwagGen to generate code from our template.

swaggen generate soracom-sandbox-api.en.json \
  --template Template \
  --destination auto-generated-code-output

swaggen generate soracom-api.en.json \
  --template Template \
  --destination auto-generated-code-output


./copy-generated-code-into-place.sh
