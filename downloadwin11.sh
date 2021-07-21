#!/bin/bash
#Generated on 2021-07-21 16:14:48 GMT

# Proxy configuration
# If you need to configure a proxy to be able to connect to the internet,
# then you can do this by configuring the all_proxy environment variable.
# By default this variable is empty, configuring aria2c to not use any proxy.
#
# Usage: export all_proxy="proxy_address"
# For example: export all_proxy="127.0.0.1:8888"
#
# More information how to use this can be found at:
# https://aria2.github.io/manual/en/html/aria2c.html#cmdoption-all-proxy
# https://aria2.github.io/manual/en/html/aria2c.html#environment

export all_proxy=""

# End of proxy configuration

if ! which aria2c >/dev/null \
|| ! which cabextract >/dev/null \
|| ! which wimlib-imagex >/dev/null \
|| ! which chntpw >/dev/null \
|| ! which genisoimage >/dev/null \
&& ! which mkisofs >/dev/null; then
  echo "One of required applications is not installed."
  echo "The following applications need to be installed to use this script:"
  echo " - aria2c"
  echo " - cabextract"
  echo " - wimlib-imagex"
  echo " - chntpw"
  echo " - genisoimage or mkisofs"
  echo ""
  if [ `uname` == "Linux" ]; then
    # Linux
    echo "If you use Debian or Ubuntu you can install these using:"
    echo "sudo apt-get install aria2 cabextract wimtools chntpw genisoimage"
    echo ""
    echo "If you use Arch Linux you can install these using:"
    echo "sudo pacman -S aria2 cabextract wimlib chntpw cdrtools"
  elif [ `uname` == "Darwin" ]; then
    # macOS
    echo "macOS requires Homebrew (https://brew.sh) to install the prerequisite software."
    echo "If you use Homebrew, you can install these using:"
    echo "brew tap sidneys/homebrew"
    echo "brew install aria2 cabextract wimlib cdrtools sidneys/homebrew/chntpw"
  fi
  exit 1
fi

destDir="UUPs"
tempScript="aria2_script.$RANDOM.txt"

echo "Retrieving aria2 script..."
aria2c --no-conf --log-level=info --log="aria2_download.log" -o"$tempScript" --allow-overwrite=true --auto-file-renaming=false "https://uupdump.net/get.php?id=f19ccfd6-d64a-4f0d-8895-c663949fb7e9&pack=en-us&edition=professional&aria2=2"
if [ $? != 0 ]; then
  echo "Failed to retrieve aria2 script"
  exit 1
fi

detectedError=`grep '#UUPDUMP_ERROR:' "$tempScript" | sed 's/#UUPDUMP_ERROR://g'`
if [ ! -z $detectedError ]; then
    echo "Unable to retrieve data from Windows Update servers. Reason: $detectedError"
    echo "If this problem persists, most likely the set you are attempting to download was removed from Windows Update servers."
    exit 1
fi

echo ""
echo "Attempting to download files..."
aria2c --no-conf --log-level=info --log="aria2_download.log" -x16 -s16 -j5 -c -R -d"$destDir" -i"$tempScript"
if [ $? != 0 ]; then
  echo "We have encountered an error while downloading files."
  exit 1
fi

echo ""
if [ -e ./files/convert.sh ]; then
  chmod +x ./files/convert.sh
  ./files/convert.sh wim "$destDir" 0
fi
