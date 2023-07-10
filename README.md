# qt6pi3a
Cross-compiling Qt 6 Raspberry pi
# PL
## Wstęp
Temat "cross-kompilacji" jest bardzo dobrze znany w kręgach embedded. Również QT ze względu na swoją popularność jest często wykorzystywana w różnych projektach. Jednakże najnowsza wersja wymaga użycia cmake, co na pierwszy rzut oka nie powinno być problem, aczkolwiek przy urzywaniu starszego hardwaru (w tym przypadku raspberry) może napsuć krwi. Oficjalna strona wiki QT również nie pomaga, gdyż w swojej wiki zawierte jest jedynie przeprowadzenie procesu na Rpi4. Poniżej przedstwione jest jak "skrosować" swój program dla Rpi3A+ i systemie Ubuntu 20.04, aczkolwiek rozumiejąc pewne zależności będzie się w stanie powtórzyć ten proces dla innych architektur/mikrokontrolerów.
## Przygotowanie
* **Raspberry**
  
Zacznijmy od "Maliny". Instalujemy na niej system operacyjny, w tym przypadku raspibian. Instalator można pobrać: 
