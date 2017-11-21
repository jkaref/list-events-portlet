##
## Copyright (C) 2017 [j]karef GmbH
## 
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to deal
## in the Software without restriction, including without limitation the rights
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
## copies of the Software, and to permit persons to whom the Software is
## furnished to do so, subject to the following conditions:
## 
## The above copyright notice and this permission notice shall be included in
## all copies or substantial portions of the Software.
## 
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
## SOFTWARE.
##
#!/usr/bin/env bash

BASENAME=$0
BASEDIR=$1
PATTERN=$2
PARAMS=${@:3}

# #
# #
# #
function translate_language_properties()
{
echo -n "- running translate_language_properties"

NATIVE2ASCII_BIN=`which native2ascii`
NATIVE2ASCII_OPT="-reverse"

SED_BIN=`which sed`

if [[ -z ${PATTERN} ]]; then
PATTERN="-esc"
fi

REPLACE=""
LANGUAGES_SED_OPT="-e s/${PATTERN}/${REPLACE}/"

LANGUAGE_FILES="Language-esc.properties Language-esc_de_DE.properties"
LANGUAGES_PATH="${BASEDIR}/src/main/resources/languages"

for INPUT in ${LANGUAGE_FILES}; do
OUTPUT=`echo ${INPUT} | ${SED_BIN} ${LANGUAGES_SED_OPT}`
${NATIVE2ASCII_BIN} ${NATIVE2ASCII_OPT} ${LANGUAGES_PATH}/${INPUT} ${LANGUAGES_PATH}/${OUTPUT}
done
}

echo "BUILD HELPER 1.0"
echo "----------------"

translate_language_properties
