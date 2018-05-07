#!/bin/bash
# Test script for running png_test on Willem van Schaik's PNG test suite.
#
# The script assumes that the PngSuite directory containing the test images
# is in the current directory. It writes the output images to a sub-directory
# named 'out', to facilitate deletion of the output images after the test.
# It also assumes that compiled executables of png_test.adb and png_compare.adb
# are in the current folder.
#
# Some of the test files do not give a useful test (e.g. the auxiliary
# chunk tests), but PNG_IO should be able to read them and extract the
# pixel data correctly and write a PNG file of the same name with x
# appended to the out directory. The script then runs png_compare on
# both files to verify that PNG_IO writes the pixel data correctly to
# the output file. The last batch of files tested are illegal, and should
# give meaningful errors.
#
#                                                       Steve Sangwine
#                                       sangwine@users.sourceforge.net
#                                                        November 2011
ln -sf bin/* .
mkdir -f PngSuite
cd PngSuite
mkdir out
if
echo '********************************************'
echo '* Basic format test files (non-interlaced) *'
echo '********************************************'
#
for f in $( ls basn*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '***********************************************'
echo '* Basic format test files (Adam-7 interlaced) *'
echo '***********************************************'
#
for f in $( ls basi*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '********************'
echo '* Sizes test files *'
echo '********************'
#
for f in $( ls s*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '**************************************'
echo '* Background test files (with alpha) *'
echo '**************************************'
#
for f in $( ls bg*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '********************************************'
echo '* Transparency (and background) test files *'
echo '********************************************'
#
for f in $( ls t*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '********************'
echo '* Gamma test files *'
echo '********************'
#
for f in $( ls g*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '************************'
echo '* Filtering test files *'
echo '************************'
#
for f in $( ls f*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '********************************************'
echo '* Additional palette chunk test files .... *'
echo '********************************************'
#
for f in $( ls p*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '*******************************'
echo '* Ancillary chunks test files *'
echo '*******************************'
#
for f in $( ls c*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '******************'
echo '* Chunk ordering *'
echo '******************'
#
for f in $( ls o*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '*********************'
echo '* Compression level *'
echo '*********************'
#
for f in $( ls z*.png ); do
  ../png_test    $f out/$f
  ../png_compare $f out/$f
done
#
echo '*********************'
echo '* The PngSuite logo *'
echo '*********************'
#
../png_test    PngSuite.png out/PngSuite.png
../png_compare PngSuite.png out/PngSuite.png
#
then
  echo "*********************************************************";
  echo "All legal test files were read and written without error.";
  echo "*********************************************************";
else
  echo "At least one of the legal test files was not read and written correctly.";
fi
#
echo '********************************************************'
echo '* Illegal files - these should raise meaningful errors *'
echo '********************************************************'
#
for f in $( ls x*.png ); do
  ../png_test    $f out/$f
done

cd ..
