#!/bin/sh -
ALICEPATH="/Applications/Alice 2.4.app/Contents/Required"

if [ ! -d "$ALICEPATH" ] ; then
   echo "could not find installed Alice 2.4"
   exit 3
fi

echo "creating backup copy of alice.jar inside Alice 2.4.app"
cp -p "$ALICEPATH/lib/alice.jar" "$ALICEPATH/lib/alice.jar.bak"

TMPPATH=/tmp/alicenew.$$
mkdir $TMPPATH

cp alice_with_german.jar $TMPPATH
cp German.properties $TMPPATH
cp default_German.a2w $TMPPATH
cp "Alice Style.py" $TMPPATH
cp "Java Style.py" $TMPPATH
cp "Java Text Style.py" $TMPPATH
cp "AliceSplash_German.png" $TMPPATH
cp "aboutAlice_German.png" $TMPPATH

cd $TMPPATH
mkdir alice
cd alice
jar -xf ../alice_with_german.jar 

echo "replacing files"
cp "../AliceSplash_German.png" edu/cmu/cs/stage3/alice/authoringtool/images/
cp "../aboutAlice_German.png" edu/cmu/cs/stage3/alice/authoringtool/images/
cp ../German.properties edu/cmu/cs/stage3/lang/

echo "builing new jar file"
jar cf ../alice.jar Manifest -C . *

cd ..
echo "now patching Alice2.4.app"
cp alice.jar "$ALICEPATH/lib/"
mkdir "$ALICEPATH/resources/German"
cp *.py "$ALICEPATH/resources/German/"
cp default_German.a2w "$ALICEPATH/etc/"
