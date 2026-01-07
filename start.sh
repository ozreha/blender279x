#!/bin/bash
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
# for Raspberry Pi OS (bookworm & trixie) on Raspberry Pi 4 & 5

# 
# This forked software has no affiliation with the Official Blender Institute.
# 

########## start ###########

# Renk tanımları (Eğer scriptin başında tanımlı değilse bu bloğu açmalısın)
B=$(tput bold)
Y=$(tput setaf 3)
R=$(tput setaf 1)
N=$(tput sgr0)

echo "#######################################################################"
echo "###            ${B}${Y}Blender 2.79x (Extended) Build Script${N}              ###"
echo "#######################################################################"
echo " "
echo "DISCLAIMER: This forked software has no affiliation with the official Blender Institute."
echo " "
echo "${B}${Y}Blender${N} is free and open source software, originally created by ${B}${Y}Ton Roosendaal${N},"
echo "for modeling, 3D animation, rendering, game development, and more."
echo " "
echo "Blender is made by hundreds of contributors from around the world;"
echo "united by the desire to have access to a fully free 3D creation pipeline."
echo " "
echo "The ${B}${Y}Blender Foundation${N} supports these goals. Thanks to donations,"
echo "a core team works full-time, but for the rest, Blender depends on"
echo "volunteers like you. More help is always welcome!"
echo " "
echo " -> Visit ${B}${Y}https://fund.blender.org/${N} to support/donate."
echo " -> Visit ${B}${Y}https://www.blender.org/${N} for everything else."
echo " "
echo "-----------------------------------------------------------------------"
echo " "
echo "This script will compile ${B}${Y}blender2.7 (Experimental July 2019 Branch)${N}."
echo "Essentially a modern Blender 2.80 Core with the classic 2.79 interface,"
echo "featuring the ${B}${Y}Blender Game Engine (BGE)${N} and Hardware Acceleration."
echo " "
echo "TARGET SYSTEM:"
echo "  Hardware: ${B}${R}Raspberry Pi 4 / Raspberry Pi 5${N}"
echo "  OS      : Raspberry Pi OS (Bookworm / Trixie)"
echo " "
echo "WARNING:"
echo "  This software is experimental and not for production use."
echo "  The build process is CPU intensive and will take between ${B}${R}1 - 6 HOURS.${N}"
echo "  (approximately, depending on your device's configuration)"
echo "#######################################################################"
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

RPI_MODEL_NAME=$(cat /sys/firmware/devicetree/base/model | tr -d '\0')

echo "Detected Device: $RPI_MODEL_NAME"

if [[ "$RPI_MODEL_NAME" == *"Raspberry Pi 5"* ]]; then
    MODEL_VER="5"
    echo ">> Raspberry Pi 5 modu aktif."
elif [[ "$RPI_MODEL_NAME" == *"Raspberry Pi 4"* ]]; then
    MODEL_VER="4"
    echo ">> Raspberry Pi 4 modu aktif."
else
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "ERROR: This script is only for Raspberry Pi 4 and 5."
    echo "Exiting Script."
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    exit 1
fi


echo " "

cd ..

RPI_MODEL_NAME=$(cat /sys/firmware/devicetree/base/model | tr -d '\0')

echo "Detected Device: $RPI_MODEL_NAME"

if [[ "$RPI_MODEL_NAME" == *"Raspberry Pi 5"* ]]; then
    MODEL_VER="5"
    echo ">> Raspberry Pi 5 modu aktif."
elif [[ "$RPI_MODEL_NAME" == *"Raspberry Pi 4"* ]]; then
    MODEL_VER="4"
    echo ">> Raspberry Pi 4 modu aktif."
else
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    echo "ERROR: This script is only for Raspberry Pi 4 and 5."
    echo "Exiting Script."
    echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    exit 1
fi


TOTAL_MEM=$(free -m | awk '/^Mem:/{print $2}')
echo "Total System Memory: $TOTAL_MEM MB"

if [ "$TOTAL_MEM" -le 2048 ]; then
    THREAD_COUNT=1
elif [ "$TOTAL_MEM" -le 4096 ]; then
    THREAD_COUNT=2
else
    THREAD_COUNT=3
fi

echo "Selected Build Thread Count: $THREAD_COUNT"
echo "Script To Run: install_deps_pi${MODEL_VER}.sh"
echo "-----------------------------------------"

./blender279x/build_files/build_environment/install_deps.sh \
--with-all \
--threads=$THREAD_COUNT \
 --build-python \
--skip-numpy \
 --build-boost \
 --build-ocio \
 --build-openexr \
 --build-oiio \
--skip-llvm \
--skip-osl \
--skip-osd \
--skip-openvdb \
 --build-alembic \
--skip-opencollada \
 --build-embree \
 --build-ffmpeg


echo "vblank_mode=0 \\" > hardware_gl_blender27.sh
echo "./build_linux/bin/blender" >> hardware_gl_blender27.sh
chmod +x ./hardware_gl_blender27.sh

echo "LIBGL_ALWAYS_SOFTWARE=true \\" > software_gl_blender27.sh
echo "vblank_mode=0 \\" >> software_gl_blender27.sh
echo "./build_linux/bin/blender" >> software_gl_blender27.sh
chmod +x ./software_gl_blender27.sh

echo " "
echo "################### end of start.sh #############################"
