# Server Performance Report

**Generated:** 2026-05-07T14:45:00Z

**OS:** Ubuntu 22.04.4 LTS

**Kernel:** Linux 6.8.0-107-generic x86_64

## Summary
- CPU: AMD EPYC 7443P — 24 physical cores / 48 logical CPUs
- Memory: 62 GiB total (≈55 GiB available)
- Disk: / (219 GiB, 29% used), /home on 9.1 TiB LVM
- GPUs: 2× NVIDIA GeForce RTX 3090 (24 GiB each), CUDA 12.2
- Docker CLI present; daemon inaccessible to current user (permission denied)

## Recommendations
- Add user to `docker` group for non-root Docker access:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

- Generate SSH key pair if needed:

```bash
ssh-keygen -t ed25519 -C "your.email@example.com"
```

- Install monitoring tools:

```bash
sudo apt update
sudo apt install -y htop glances
# nvtop install may require additional steps
```

- Run quick benchmarks if desired:

CPU (sysbench):

```bash
sudo apt install -y sysbench
sysbench --threads=48 --time=30 cpu run
```

Disk (fio example):

```bash
sudo apt install -y fio
fio --name=randwrite --filename=/tmp/testfile --bs=4k --size=1G --rw=randwrite --direct=1 --numjobs=4 --time_based --runtime=30
rm /tmp/testfile
```

GPU test (PyTorch quick check):

```bash
python3 -c "import torch; print(torch.cuda.device_count(), torch.cuda.get_device_name(0))"
```
