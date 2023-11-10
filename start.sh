#!/usr/bin/env bash
# ##### BEGIN GPL LICENSE BLOCK #####
#
#  This program is free software; you can redistribute it and/or
#  modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation; either version 2
#  of the License, or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software Foundation,
#  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
# ##### END GPL LICENSE BLOCK #####

# A shell script installing/building all needed dependencies and,
# building Blender 2.7 ("experimental nightly build from July 2019")
# for Debian GNU/Linux 12 (bookworm) on Raspberry Pi 5

########## start ###########

Y=$(tput setaf 3)
B=$(tput bold)
N=$(tput sgr0)


clear
echo "################### start.sh #############################"
echo " "
echo " "
echo "${B}${Y}Blender${N} is a free and open source software created by ${B}${Y}Ton Roosendaal${N},"
echo "for 3D animation, modeling, rendering, and more."
echo "Blender is being developed by the people at ${B}${Y}Blender Institute${N},"
echo "who are passionate about making Blender the best tool for 3D artists"
echo "They are supported by a large and active ${B}${Y}community${N} of users and developers from all over the world."
echo " "
echo "I want to thank all of them for creating such an amazing software."
echo " "
echo " "
echo " "
echo "This shell script will try to build all needed dependencies and,"
echo "build ${B}${Y}Blender 2.7 (experimental nightly build from July 2019)${N}"
echo "which is essentially a modern Blender 2.80 at core, with hardware accelerated render engine."
echo " "
echo "For Debian GNU/Linux 12 (bookworm) on Raspberry Pi 5"
echo " "

while true; do
    echo " "
    read -p "Do you wish to continue? (y/n): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo " "

export CFLAGS="-fPIC -O3 -march=armv8.2-a+fp+simd -mtune=cortex-a76"
export CXXFLAGS="-fPIC -O3 -march=armv8.2-a+fp+simd -mtune=cortex-a76"

chmod +x ./autoconf.sh
chmod +x ./build_files/build_environment/install_deps_rpi.sh

cd ..
./blender/autoconf.sh

echo "vblank_mode=0 \\" > run_blender_279x.sh
echo "./build_linux/bin/blender" >> run_blender_279x.sh

chmod +x ./run_blender_279x.sh

echo " "
echo "################### end of start.sh #############################"

