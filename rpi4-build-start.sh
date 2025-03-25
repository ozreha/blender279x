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
# for Debian GNU/Linux 12 (bookworm) on Raspberry Pi 4

########## start ###########

B=$(tput bold)
R=$(tput setaf 1)
N=$(tput sgr0)
Y=$(tput setaf 3)


clear
echo "################### rpi4-build-start.sh #######################"
echo " "
echo " "
echo "${B}${Y}Blender${N} is a free and open source software created by ${B}${Y}Ton Roosendaal${N},"
echo "for modeling, 3D animation, rendering, game development and more."
echo " "
echo "Blender is being made by hundreds of contributors from around the world;"
echo "by studios and individual artists, professionals and hobbyists, scientists"
echo "and students, VFX experts and animators, and so on. All of them are united"
echo "by the desire to have access to a fully free/open source 3D creation pipeline."
echo " "
echo "${B}${Y}Blender Foundation${N} supports and facilitates these goals. Thanks to ${B}${Y}donations${N}," 
echo "the ${B}${Y}Blender Institute${N} and ${B}${Y}Blender Studio${N} projects enable a handful of people"
echo "to work full-time on Blender. For the rest Blender depend on volunteers from"
echo "the online community to achieve this goal. More help is always welcome! "
echo " "
echo " "

echo "This shell script will try to build all needed dependencies,"
echo "and build ${B}${Y}blender2.7 (experimental nightly build from July 2019)${N}"
echo "which is essentially a modern Blender 2.80 at core, with hardware accelerated render support."
echo "Blender 2.79 comes with a great 3D game engine called BGE, great tool to teach/learn python as well."
echo " "
echo "This script is going to build Blender 2.79 (blender2.7) for"
echo "Debian GNU/Linux 12 (bookworm) on ${B}${R}Raspberry Pi 4${N}"
echo " "
echo "It will took approximately 2 hours. "

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

export CFLAGS="-fPIC -O3 -march=armv8-a+fp+simd -mtune=cortex-a72"
export CXXFLAGS="-fPIC -O3 -march=armv8-a+fp+simd -mtune=cortex-a72"

#chmod +x ./autoconf_pi4.sh
#chmod +x ./build_files/build_environment/install_deps_pi4.sh

cp ./GNUmakefile_pi4 ./GNUmakefile

cd ..
sh ./blender-rpi-v2.79/autoconf_pi4.sh

#echo "MESA_GL_VERSION_OVERRIDE=3.3 \\" > hardware_gl_blender27.sh
echo "vblank_mode=0 \\" >> hardware_gl_blender27.sh
echo "./build_linux/bin/blender" >> hardware_gl_blender27.sh
chmod +x ./hardware_gl_blender27.sh

#echo "MESA_GL_VERSION_OVERRIDE=3.3 \\" > software_gl_blender27.sh
echo "LIBGL_ALWAYS_SOFTWARE=true \\" >> software_gl_blender27.sh
echo "vblank_mode=0 \\" >> software_gl_blender27.sh
echo "./build_linux/bin/blender" >> software_gl_blender27.sh
chmod +x ./software_gl_blender27.sh

echo " "
echo "################### end of start.sh #############################"
