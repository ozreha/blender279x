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

########## start ############
echo " "
echo "This shell script will try to install/build all needed dependencies and,"
echo "build Blender 2.7 (experimental nightly build from July 2019)" 
echo "for Debian GNU/Linux 12 (bookworm) on Raspberry Pi 5"
echo " "



while true; do
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

echo "#!/usr/bin/env bash" > run_blender_279x.sh
echo "# ##### BEGIN GPL LICENSE BLOCK #####" > run_blender_279x.sh
echo "#" > run_blender_279x.sh
echo "#  This program is free software; you can redistribute it and/or" > run_blender_279x.sh
echo "#  modify it under the terms of the GNU General Public License" > run_blender_279x.sh
echo "#  as published by the Free Software Foundation; either version 2" > run_blender_279x.sh
echo "#  of the License, or (at your option) any later version." > run_blender_279x.sh
echo "#" > run_blender_279x.sh
echo "#  This program is distributed in the hope that it will be useful," > run_blender_279x.sh
echo "#  but WITHOUT ANY WARRANTY; without even the implied warranty of" > run_blender_279x.sh
echo "#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the" > run_blender_279x.sh
echo "#  GNU General Public License for more details." > run_blender_279x.sh
echo "#" > run_blender_279x.sh
echo "#  You should have received a copy of the GNU General Public License" > run_blender_279x.sh
echo "#  along with this program; if not, write to the Free Software Foundation," > run_blender_279x.sh
echo "#  Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA." > run_blender_279x.sh
echo "#" > run_blender_279x.sh
echo "# ##### END GPL LICENSE BLOCK #####" > run_blender_279x.sh

echo "vblank_mode=0 \\" > run_blender_279x.sh
echo "./build_linux/bin/blender" >> run_blender_279x.sh

chmod +x ./run_blender_279x.sh

