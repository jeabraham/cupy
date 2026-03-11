#!/usr/bin/env bash
set -euo pipefail

source venv/bin/activate

export ROCM_HOME=/opt/rocm-7.2.0
export CUPY_INSTALL_USE_HIP=1
export HCC_AMDGPU_TARGET=gfx1201
export HIPCC=/opt/rocm-7.2.0/bin/hipcc
export CXX=/opt/rocm-7.2.0/bin/hipcc

mkdir -p ~/wheels

echo "ROCM_HOME=$ROCM_HOME"
echo "CUPY_INSTALL_USE_HIP=$CUPY_INSTALL_USE_HIP"
echo "HCC_AMDGPU_TARGET=$HCC_AMDGPU_TARGET"
echo "HIPCC=$HIPCC"
echo "CXX=$CXX"
"$HIPCC" --version

export CFLAGS="-I/opt/rocm-7.2.0/include -I/opt/rocm-7.2.0/include/hipcub -I/opt/rocm-7.2.0/include/rocprim -I/opt/rocm-7.2.0/include/rocthrust"
export LDFLAGS="-L/opt/rocm-7.2.0/lib -L/opt/rocm-7.2.0/lib64"


python -m pip wheel . -w ~/wheels --no-build-isolation
