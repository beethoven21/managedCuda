#!/bin/bash

set -e 
cd "$(dirname "$0")"

genstub () 
{
    DLLNAME=$1
    TARGET=$2

    rm -f empty.c
    touch empty.c
    gcc-6 -shared -o ${TARGET} empty.c    
    gcc-6 -Wl,--no-as-needed -shared -o lib${DLLNAME}.so -fPIC -L. -l:${TARGET}
    rm -f ${TARGET}
    rm -f empty.c

    echo "Mapped ${DLLNAME}.dll ==> ${TARGET}"
}


# nvcuda.dll or libcuda.so.1 is always installed by the GPU driver.
genstub nvcuda libcuda.so.1

# These libraries are from the CUDA SDK and redistributed in the NuGet packages.
genstub cublas64_91 libcublas.so.9.1
genstub cufft64_91 libcufft.so.9.1
genstub curand64_91 libcurand.so.9.1
genstub cusolver64_91 libcusolver.so.9.1
genstub cusparse64_91 libcusparse.so.9.1
genstub nvgraph64_91 libnvgraph.so.9.1
genstub nvrtc64_91 libnvrtc.so.9.1

# cuDNN redistribution is prohibited.
genstub cudnn64_7 libcudnn.so.7.0

#genstub nppi64_80 libnppi.so.8.0
#genstub nppc64_80 libnppc.so.8.0
#genstub npps64_80 libnpps.so.8.0
