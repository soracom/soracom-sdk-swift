#! /bin/sh
#
# This script should be run from the ./Whatever/swaggen/ directory.
#
# It copies generated code into place.

rm -rf ../../Sources/SoracomAPI/AutoGeneratedCode/Models \
       ../../Sources/SoracomAPI/AutoGeneratedCode/Requests \
       ../../Sources/SoracomAPI/AutoGeneratedCode/*.swift

mkdir -p ../../Sources/SoracomAPI/AutoGeneratedCode
mkdir -p ../../Sources/SoracomAPI/AutoGeneratedCode/Models
mkdir -p ../../Sources/SoracomAPI/AutoGeneratedCode/Requests

cp -R auto-generated-code-output/Sources/Models/* ../../Sources/SoracomAPI/AutoGeneratedCode/Models/
cp -R auto-generated-code-output/Sources/Requests/* ../../Sources/SoracomAPI/AutoGeneratedCode/Requests/
cp auto-generated-code-output/Sources/AnyCodable.swift ../../Sources/SoracomAPI/AutoGeneratedCode/
cp auto-generated-code-output/Sources/API.swift ../../Sources/SoracomAPI/AutoGeneratedCode/
cp auto-generated-code-output/Sources/Coding.swift ../../Sources/SoracomAPI/AutoGeneratedCode/
cp auto-generated-code-output/Sources/ResponseDecoder.swift ../../Sources/SoracomAPI/AutoGeneratedCode/