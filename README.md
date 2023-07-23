# qt6pi3a
Cross-compiling Qt 6 Raspberry pi
# ENG
## About
Cross-compilation is very well known in embedded circles. Also QT, due to its popularity, is often used in various projects. However, the latest version requires cmake, which at first glance should not be a problem, but problem appears with older hardware (in this case, raspberry). The official QT wiki doesn't help either, as its wiki only lists the process on Rpi4. This tutorial shows how to "cross" your program for Rpi3A+ and Ubuntu 20.04, furthermore with basic  knowledge in this matter, you will be able to repeat this process for other architectures/microcontrollers.
## Getting Started
* **Raspberry**

Let's start with raspberry. Install the operating system on raspberry pi (in this case raspibian). The installer can be downloaded: https://www.raspberrypi.com/software/operating-systems/

Then update and upgrade to the newest version.
```
sudo apt update
sudo apt full-upgrade
sudo reboot
```
After successfully rebboting system, proceed to install packages and dependencies, also create a folder for compiled programs.
```
sudo apt-get install -y libboost-all-dev libudev-dev libinput-dev libts-dev libmtdev-dev libjpeg-dev libfontconfig1-dev libssl-dev libdbus-1-dev libglib2.0-dev libxkbcommon-dev libegl1-mesa-dev libgbm-dev libgles2-mesa-dev mesa-common-dev libasound2-dev libpulse-dev gstreamer1.0-omx libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev  gstreamer1.0-alsa libvpx-dev libsrtp2-dev libsnappy-dev libnss3-dev "^libxcb.*" flex bison libxslt-dev ruby gperf libbz2-dev libcups2-dev libatkmm-1.6-dev libxi6 libxcomposite1 libfreetype6-dev libicu-dev libsqlite3-dev libxslt1-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libx11-dev freetds-dev libsqlite3-dev libpq-dev libiodbc2-dev firebird-dev libgst-dev libxext-dev libxcb1 libxcb1-dev libx11-xcb1 libx11-xcb-dev libxcb-keysyms1 libxcb-keysyms1-dev libxcb-image0 libxcb-image0-dev libxcb-shm0 libxcb-shm0-dev libxcb-icccm4 libxcb-icccm4-dev libxcb-sync1 libxcb-sync-dev libxcb-render-util0 libxcb-render-util0-dev libxcb-xfixes0-dev libxrender-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-glx0-dev libxi-dev libdrm-dev libxcb-xinerama0 libxcb-xinerama0-dev libatspi2.0-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxss-dev libxtst-dev libpci-dev libcap-dev libxrandr-dev libdirectfb-dev libaudio-dev libxkbcommon-x11-dev
sudo mkdir /usr/local/qt6
```
Last but not least, it is worth checking the architecture we are working with by typing `uname -m` command in shell. In my case it is aarch64.
* **Host**

Update the system on linux, as it was done in microcontroller.
```
sudo apt update 
sudo apt upgrade -y 
```
# PL
## Wstęp
Temat "cross-kompilacji" jest bardzo dobrze znany w kręgach embedded. Również QT ze względu na swoją popularność jest często wykorzystywana w różnych projektach. Jednakże najnowsza wersja wymaga użycia cmake, co na pierwszy rzut oka nie powinno być problem, aczkolwiek przy urzywaniu starszego hardwaru (w tym przypadku raspberry) może napsuć krwi. Oficjalna strona wiki QT również nie pomaga, gdyż w swojej wiki zawierte jest jedynie przeprowadzenie procesu na Rpi4. Poniżej przedstwione jest jak "skrosować" swój program dla Rpi3A+ i systemie Ubuntu 20.04, aczkolwiek rozumiejąc pewne zależności będzie się w stanie powtórzyć ten proces dla innych architektur/mikrokontrolerów.
## Przygotowanie
* **Raspberry**
  
Zacznijmy od "Maliny". Instalujemy na niej system operacyjny, w tym przypadku raspibian. Instalator można pobrać: https://www.raspberrypi.com/software/operating-systems/

Natępnie przeprowadzamy update systemu.
```
sudo apt update
sudo apt full-upgrade
sudo reboot
```
Po rebbocie należy zainstalować odpowiednie pakiety oraz stworzyć folder do którego będziemy przesyłać skompilowane programy.
```
sudo apt-get install -y libboost-all-dev libudev-dev libinput-dev libts-dev libmtdev-dev libjpeg-dev libfontconfig1-dev libssl-dev libdbus-1-dev libglib2.0-dev libxkbcommon-dev libegl1-mesa-dev libgbm-dev libgles2-mesa-dev mesa-common-dev libasound2-dev libpulse-dev gstreamer1.0-omx libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev  gstreamer1.0-alsa libvpx-dev libsrtp2-dev libsnappy-dev libnss3-dev "^libxcb.*" flex bison libxslt-dev ruby gperf libbz2-dev libcups2-dev libatkmm-1.6-dev libxi6 libxcomposite1 libfreetype6-dev libicu-dev libsqlite3-dev libxslt1-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libx11-dev freetds-dev libsqlite3-dev libpq-dev libiodbc2-dev firebird-dev libgst-dev libxext-dev libxcb1 libxcb1-dev libx11-xcb1 libx11-xcb-dev libxcb-keysyms1 libxcb-keysyms1-dev libxcb-image0 libxcb-image0-dev libxcb-shm0 libxcb-shm0-dev libxcb-icccm4 libxcb-icccm4-dev libxcb-sync1 libxcb-sync-dev libxcb-render-util0 libxcb-render-util0-dev libxcb-xfixes0-dev libxrender-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-glx0-dev libxi-dev libdrm-dev libxcb-xinerama0 libxcb-xinerama0-dev libatspi2.0-dev libxcursor-dev libxcomposite-dev libxdamage-dev libxss-dev libxtst-dev libpci-dev libcap-dev libxrandr-dev libdirectfb-dev libaudio-dev libxkbcommon-x11-dev
sudo mkdir /usr/local/qt6
```
Warto na sam koniec sprawdzić architekture systemu na jakim pracujemy poprzez komendę `uname -m`. W moim przypadku jest to aarch64.
* **Host**

Tak samo jak w przypadku raspberry robimy update systemu.
```
sudo apt update 
sudo apt upgrade -y 
```
Jak już wcześniej wspomniałem  wspomniałem QT6 wymaga cmake. Instalacja prze `apt-install` nie instaluje najnowszej wersji. Dlatego instalujemy cmake bezpośrednio z repozytorium.
```
sudo apt-get install -y build-essential libssl-dev
wget https://github.com/Kitware/CMake/releases/download/v3.25.0/cmake-3.25.0.tar.gz
tar -zxvf cmake-3.25.0.tar.gz
cd cmake-3.25.0
./bootstrap
make
sudo make install -y
cd ..
```
Po wszystkim sprawdzamy czy wszystko poszło po naszej myśli wpisując `cmake --version`. Jeżeli cmake version to 3.25.0, oznacza to że proces przeszedło pomyślnie.
Dla ułatwienia sprway możemy w bashu zadeklarować parę zmiennych, które przydadzą nam się w dalszym procesie.
```
QT_VERSION="6.5.1"
pi_username="pi"
pi_ip_address="192.168.2.153"
USER="user"
```
Instalujemy pakiety wymagane do "cross-kompilacji". Tworzymy też foldery w których będzimy mieli kompilator dla QT oraz sysroot.
```
cd ..
sudo apt-get install -y make build-essential libclang-dev ninja-build gcc git bison python3 gperf pkg-config libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libatspi2.0-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev
sudo apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
sudo apt install -y libssl-dev
sudo apt install -y rsync wget
mkdir rpi-sysroot rpi-sysroot/usr rpi-sysroot/opt 
mkdir qt-host qt-raspi qthost-build qtpi-build
```
Wykorzystując rsync, budujemy sysroot z mikrokontrolera na naszym PC. Jeżeli pliki z katalogu `opt` nie będą chciały sie przekopiować, to możemy je pominąć. Rsync wykorzystuje SSH, dlatego polecam kontrolnie się skomunikować z kontrolerem po tym protokole. Jeżeli nie znasz IP swojego urządzenia, polecam The Adafruit Raspberry Pi Finder, który można pobrać: https://learn.adafruit.com/the-adafruit-raspberry-pi-finder/finding-and-connecting
```
rsync -avz --rsync-path="sudo rsync" --delete ${pi_username}@${pi_ip_address}:/lib rpi-sysroot 
rsync -avz --rsync-path="sudo rsync" --delete ${pi_username}@${pi_ip_address}:/usr/include rpi-sysroot/usr 
rsync -avz --rsync-path="sudo rsync" --delete ${pi_username}@${pi_ip_address}:/usr/lib rpi-sysroot/usr 
rsync -avz --rsync-path="sudo rsync" --delete ${pi_username}@${pi_ip_address}:/opt/vc rpi-sysroot/opt 
sudo apt install symlinks
symlinks -rc rpi-sysroot
```
## Instalacja QT
QT instalujemy według poniższego kodu. Na stronie wiki QT instalacja korzysta z Gninja, podczas kilku prób instalacji QT na hoście zauważyłem że korzystanie z niej może stworzyć wiele problemu, dlatego w tym poradniku prowadzimy instalacje bez Gninja.
```
git clone git://code.qt.io/qt/qt5.git qt6
cd qt6
git checkout v${QT_VERSION}
perl init-repository -f
cd ..
cd qthost-build
../qt6/configure -prefix /home/$USER/qt-host
cmake --build . --parallel 8
cmake --install .
cd ..
rm -rf qthost-build
```
W następnej części korzystamy z toolchaina jaki został zamieszczony na stronie wiki. Należy jednak pamiętać o zmianie ścieżki do sysroota. Wykonujemy dalej kolejne czynności.
```
cd ..
--chown=qtpi:qtpi toolchain.cmake /home/${USER}/toolchain.cmake
cd qtpi-build 
../qt6/configure -release -opengl es2 -nomake examples -nomake tests -qt-host-path $HOME/qt-host -extprefix $HOME/qt-raspi -prefix /usr/local/qt6 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=aarch64-linux-gnu- -- -DCMAKE_TOOLCHAIN_FILE=$HOME/toolchain.cmake -DQT_FEATURE_xcb=ON -DFEATURE_xcb_xlib=ON -DQT_FEATURE_xlib=ON 
cmake --build . --parallel 8
cmake --install . 
cd .. 
rm -rf qtpi-build
--chown=qtpi:qtpi _copyQtToRPi.sh /home/qtpi/copyQtToRPi.sh
```
**UWAGA!**
Jeżeli nasz program korzysta z innych bibliotek niż te bazowe to należy je również zainstalować. Przykładowo jeżeli nasz program wykorzystuje bluetooth, to musimy zainstalować qtconnectivity. Zatem pobieramy pakiet przez `wget https://download.qt.io/archive/qt/6.5/6.5.1/submodules/qtconnectivity-everywhere-src-6.5.1.tar.xz`, następnie wypakowywujemy `tar -zxvf qtconnectivity-everywhere-src-6.5.1.tar.xz` i instalujemy w nastepujący sposób:
```
cd qtconnectivity-everywhere-src-6.5.1
../qt6/configure -release -opengl es2 -nomake examples -nomake tests -qt-host-path $HOME/qt-host -extprefix $HOME/qt-raspi -prefix /usr/local/qt6 -device linux-rasp-pi3-g++ -device-option CROSS_COMPILE=aarch64-linux-gnu- -- -DCMAKE_TOOLCHAIN_FILE=$HOME/toolchain.cmake -DQT_FEATURE_xcb=ON -DFEATURE_xcb_xlib=ON -DQT_FEATURE_xlib=ON
cmake --build . --parallel 4
cmake --install .
cd ..
rm -rf qtconnectivity-everywhere-src-6.5.1
```
## Podsumowanie
W poradniku https://github.com/PhysicsX/QTonRaspberryPi/blob/main/README.md zawarte są przykladowe programy za pomocą których możemy sprawdzić czy proces przebiegł pomyślnie.
# Links
[1] https://wiki.qt.io/Cross-Compile_Qt_6_for_Raspberry_Pi

[2] https://github.com/kevin-strobel/qt6pi3b/tree/master

[3] https://github.com/PhysicsX/QTonRaspberryPi/tree/main
