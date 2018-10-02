#!/bin/bash

# No clue where this is run, with what installed, in what directory.
# Fix this now.
unameOut="$(uname -s)"
if [[ $unameOut =~ Linux* ]]
then
    echo Running on Linux -- good.
else
    echo Do not run this on anything but Linux.
    exit 1
fi

set -e 
cd "$(dirname "$0")"
export vd="10.0"
export vnd="100"
export ORIGIN=/usr/local/cuda/lib64

genstub () 
{
    DLLNAME=$1
    TARGETS=$2
    LOCAL=$3

    if [ "$LOCAL" = "true" ]; then
        RPATH='-Wl,-rpath=$ORIGIN'
    else
        RPATH=''
    fi

    rm -f empty.c
    touch empty.c
    LIBARG=""
    for TARGET in $TARGETS ; do
        gcc -shared -o ${TARGET} empty.c
        LIBARG="$LIBARG -l:${TARGET}"
    done
    gcc -Wl,--no-as-needed $RPATH -shared -o lib${DLLNAME}.so -fPIC -L. $LIBARG
    for TARGET in $TARGETS ; do
        rm -f ${TARGET}
    done
    rm -f empty.c

    echo "Mapped ${DLLNAME}.dll ==> ${TARGETS}"
}

# nvcuda.dll or libcuda.so.1 and nvml.dll or libnvidia-ml.so.1 are always installed by the GPU driver.
genstub nvcuda libcuda.so.1 false
genstub nvml libnvidia-ml.so.1 false

# These libraries are from the CUDA SDK and redistributed in the NuGet packages.
genstub cublas64_$vnd libcublas.so.$vd true
genstub cufft64_$vnd libcufft.so.$vd true
genstub curand64_$vnd libcurand.so.$vd true
genstub cusolver64_$vnd libcusolver.so.$vd true
genstub cusparse64_$vnd libcusparse.so.$vd true
genstub cudnn64_7 libcudnn.so.7.0 true
genstub nvgraph64_$vnd libnvgraph.so.$vd true
genstub nvrtc64_$vnd "libnvrtc.so.$vd libnvrtc-builtins.so" true
genstub nppc64_$vnd libnppc.so.$vd true
genstub nppial64_$vnd libnppial.so.$vd true
genstub nppicc64_$vnd libnppicc.so.$vd true
genstub nppicom64_$vnd libnppicom.so.$vd true
genstub nppidei64_$vnd libnppidei.so.$vd true
genstub nppif64_$vnd libnppif.so.$vd true
genstub nppig64_$vnd libnppig.so.$vd true
genstub nppim64_$vnd libnppim.so.$vd true
genstub nppist64_$vnd libnppist.so.$vd true
genstub nppisu64_$vnd libnppisu.so.$vd true
genstub nppitc64_$vnd libnppitc.so.$vd true
genstub npps64_$vnd libnpps.so.$vd true

