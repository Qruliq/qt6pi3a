# qt6pi3a
Cross-compiling Qt 6 Raspberry pi
# PL
## Wstęp
Temat "cross-kompilacji" jest bardzo dobrze znany w kręgach embedded. Również QT ze względu na swoją popularność jest często wykorzystywana w różnych projektach. Jednakże najnowsza wersja wymaga użycia cmake, co na pierwszy rzut oka nie powinno być problem, aczkolwiek przy urzywaniu starszego hardwaru (w tym przypadku raspberry) może napsuć krwi. Oficjalna strona wiki QT również nie pomaga, gdyż w swojej wiki zawierte jest jedynie przeprowadzenie procesu na Rpi4. Poniżej przedstwione jest jak "skrosować" swój program dla Rpi3A+ i systemie Ubuntu 20.04, aczkolwiek rozumiejąc pewne zależności będzie się w stanie powtórzyć ten proces dla innych architektur/mikrokontrolerów.
## Przygotowanie
* **Raspberry**
  
Zacznijmy od "Maliny". Instalujemy na niej system operacyjny, w tym przypadku raspibian. Instalator można pobrać: https://www.raspberrypi.com/software/operating-systems/

Natępnie przeprowadzamy update systemu 
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
Warto na sam koniec sprawdzić architekture systemu na jakim pracujemy poprzez komendę `uname -m`. W moim przypadku jest to aarch64
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
QT_MODULES="qtbase,qtshadertools,qtdeclarative"
PARALLELIZATION="8"
TZ="Warsaw"
USER="user"
```
Instalujemy pakiety wymagane do "cross-kompilacji". Tworzymy też foldery
```
sudo apt-get install -y make build-essential libclang-dev ninja-build gcc git bison python3 gperf pkg-config libfontconfig1-dev libfreetype6-dev libx11-dev libx11-xcb-dev libxext-dev libxfixes-dev libxi-dev libxrender-dev libxcb1-dev libxcb-glx0-dev libxcb-keysyms1-dev libxcb-image0-dev libxcb-shm0-dev libxcb-icccm4-dev libxcb-sync-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-randr0-dev libxcb-render-util0-dev libxcb-util-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libatspi2.0-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev
sudo apt install -y gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
sudo apt install -y libssl-dev
sudo apt install -y rsync wget
mkdir rpi-sysroot rpi-sysroot/usr rpi-sysroot/opt 
mkdir qt-host qt-raspi qthost-build qtpi-build
```
