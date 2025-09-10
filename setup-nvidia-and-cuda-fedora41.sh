  14  lspci -k
   15  sudo dnf install akmod-nvidia xorg-x11-drv-nvidia-cuda
   16  sudo reboot
   17  sudo lspci -k
   18  sudo dnf install python3.11
   19  sudo dnf update 
   54  sudo tee /etc/yum.repos.d/cuda-fedora41.repo > /dev/null <<'EOF'
[cuda-fedora41-x86_64]
name=NVIDIA CUDA Repository
baseurl=https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/
enabled=1
gpgcheck=1
gpgkey=https://developer.download.nvidia.com/compute/cuda/repos/fedora41/x86_64/D42D0685.pub
EOF

   55  sudo dnf clean all
   56  sudo dnf makecache
   57  sudo dnf install -y cuda-toolkit-12-8
   58  vim .bashrc
export CUDA_HOME=/usr/local/cuda
export PATH="$CUDA_HOME/bin:$PATH"
export LD_LIBRARY_PATH="$CUDA_HOME/lib64:${LD_LIBRARY_PATH:-}"

   59  source .bashrc
   60  which nvcc
   61  nvcc --version
   62  source venv/bin/activate
   63  pip install --no-build-isolation flash-attn==2.8.3
   64  pip install 'instructlab[cuda]'    -C cmake.args="-DLLAMA_CUDA=on"    -C cmake.args="-DLLAMA_NATIVE=off"
   65  ilab
