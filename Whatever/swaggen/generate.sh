#! /bin/bash
#
# This script should be run from the ./Whatever/swaggen/ directory.
#
# It uses SwagGen to generate code from our template.

file="SwagGen/.build/debug/swaggen"
if [ ! -f "$file" ]
then
echo "$0: File '${file}' not found."
echo "Looks like you have not built the custom fork of the"
echo "SwagGen code generator that this project uses. This is"
echo "not expected to be necessary for long, but for now, it"
echo "is."
echo ""
echo " This script will now try to cd in there and build it,"
echo "but if anything goes wrong, just cd ./SwagGen and try"
echo "to swift build it yourself."
echo ""
echo "NOTE: BUILDING THE CODE GENERATOR EMITS MANY DEPRECATION"
echo "ERRORS, BUT THAT IS NORMAL. This is just a temporary fix."
echo ""

cd SwagGen; swift build; cd ..

fi

SwagGen/.build/debug/swaggen generate soracom-sandbox-api.en.json \
  --template Template \
  --destination auto-generated-code-output

SwagGen/.build/debug/swaggen generate soracom-api.en.json \
  --template Template \
  --destination auto-generated-code-output


./copy-generated-code-into-place.sh
