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


B=$(tput bold)
R=$(tput setaf 1)
N=$(tput sgr0)
Y=$(tput setaf 3)



clear
echo "################### start.sh #############################"
echo " "
echo " "
echo "${B}${Y}Blender${N} is a free and open source software created by ${B}${Y}Ton Roosendaal${N},"
echo "for 3D animation, modeling, rendering, and more."
echo "Blender is being developed by the magicians at ${B}${Y}Blender Institute${N},"
echo "who are passionate about making Blender the best tool for 3D artists"
echo "They are supported by a large and active ${B}${Y}community${N} of users and developers from all over the world."
echo " "
echo "I want to thank all of them for creating such an amazing software."
echo " "
echo " "
echo " "
echo "This shell script will try to build all needed dependencies and,"
echo "build ${B}${Y}blender2.7 (experimental nightly build from July 2019)${N}"
echo "which is essentially a modern Blender 2.80 at core, with hardware accelerated render support."
echo "Blender 2.79x comes with a great 3D game engine called BGE, great for python education as well."
echo " "
echo "This script is intended to build Blender 2.79x (blender2.7) for"
echo "Debian GNU/Linux 12 (bookworm) on ${B}${R}All Raspberry Pi models${N}"
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

chmod +x ./autoconf.sh
chmod +x ./build_files/build_environment/install_deps_rpi.sh

cd ..
./blender/autoconf.sh

echo "MESA_GL_VERSION_OVERRIDE=3.3 \\" > hardgl_blender.sh
echo "vblank_mode=0 \\" >> hardgl_blender.sh
echo "./build_linux/bin/blender" >> hardgl_blender.sh
chmod +x ./hardgl_blender.sh

echo "MESA_GL_VERSION_OVERRIDE=3.3 \\" > softgl_blender.sh
echo "LIBGL_ALWAYS_SOFTWARE=true \\" >> softgl_blender.sh
echo "vblank_mode=0 \\" >> softgl_blender.sh
echo "./build_linux/bin/blender" >> softgl_blender.sh
chmod +x ./softgl_blender.sh


echo " "
echo "################### end of start.sh #############################"

