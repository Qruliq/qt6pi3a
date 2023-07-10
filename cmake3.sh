sudo apt-get install build-essential libssl-dev
wget https://github.com/Kitware/CMake/releases/download/v3.25.0/cmake-3.25.0.tar.gz
tar -zxvf cmake-3.25.0.tar.gz
cd cmake-3.25.0
./bootstrap
make
sudo make install
cd ..
cmake --version
