cd .. \
sudo apt-get install -y make build-essential libclang-dev ninja-build gcc git bison python3 gperf pkg-config libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libatspi2.0-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev \
sudo apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu \
sudo apt install -y libssl-dev \
sudo apt install -y rsync wget \
mkdir rpi-sysroot rpi-sysroot/usr rpi-sysroot/opt \
mkdir qt-host qt-raspi qthost-build qtpi-build \
rsync -avz --rsync-path="sudo rsync" --delete ${pi_username}@${pi_ip_address}:/lib rpi-sysroot \
rsync -avz --rsync-path="sudo rsync" --delete ${pi_username}@${pi_ip_address}:/usr/include rpi-sysroot/usr \
rsync -avz --rsync-path="sudo rsync" --delete ${pi_username}@${pi_ip_address}:/usr/lib rpi-sysroot/usr \
rsync -avz --rsync-path="sudo rsync" --delete ${pi_username}@${pi_ip_address}:/opt/vc rpi-sysroot/opt \
sudo apt install symlinks \
symlinks -rc rpi-sysroot \
git clone git://code.qt.io/qt/qt5.git qt6 \
cd qt6 \
git checkout v${QT_VERSION} \
perl init-repository -f \
cd .. \
cd qthost-build \ 
../qt6/configure -prefix /home/$USER/qt-host \
cmake --build . --parallel 8 \
cmake --install . \
cd .. \
rm -rf qthost-build \
cd .. \
--chown=qtpi:qtpi toolchain.cmake /home/${USER}/toolchain.cmake \
cd qtpi-build \
../qt6/configure -release -opengl es2 -nomake examples -nomake tests -qt-host-path $HOME/qt-host -extprefix $HOME/qt-raspi -prefix /usr/local/qt6 -device ${RPI_DEVICE} -device-option CROSS_COMPILE=aarch64-linux-gnu- -- -DCMAKE_TOOLCHAIN_FILE=$HOME/toolchain.cmake -DQT_FEATURE_xcb=ON -DFEATURE_xcb_xlib=ON -DQT_FEATURE_xlib=ON \
cmake --build . --parallel 8 \
cmake --install . \
cd .. \
rm -rf qtpi-build \
--chown=qtpi:qtpi _copyQtToRPi.sh /home/qtpi/copyQtToRPi.sh \
