echo %1
docker build . --build-arg input_zip=%1 --output type=tar,dest=outputs/%1.tar