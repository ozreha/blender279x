chmod +x ./autoconf.sh
chmod +x ./build_files/build_environment/install_deps_rpi.sh
cd ..
./blender/autoconf.sh


echo "vblank_mode=0 \\" > run_blender_279x.sh
echo "./build_linux/bin/blender" >> run_blender_279x.sh

chmod +x ./run_blender_279x.sh



