# Host rpimonitor configuration info

## rpimonitor config

### ifconfig

```bash
mfunk@rpimonitor:~ $ ifconfig -a
br-d23477798e33: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.18.0.1  netmask 255.255.0.0  broadcast 172.18.255.255
        inet6 fe80::985f:6cff:fed3:b1a3  prefixlen 64  scopeid 0x20<link>
        ether 9a:5f:6c:d3:b1:a3  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

docker0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        inet6 fe80::b4cf:d0ff:feb5:e736  prefixlen 64  scopeid 0x20<link>
        ether b6:cf:d0:b5:e7:36  txqueuelen 0  (Ethernet)
        RX packets 17912383  bytes 20079128594 (18.7 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 18908673  bytes 12766320441 (11.8 GiB)
        TX errors 0  dropped 7 overruns 0  carrier 0  collisions 0

eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.1.1.3  netmask 255.255.255.0  broadcast 10.1.1.255
        inet6 fe80::81a1:9d87:cae5:7a6e  prefixlen 64  scopeid 0x20<link>
        ether dc:a6:32:47:10:35  txqueuelen 1000  (Ethernet)
        RX packets 28552012  bytes 10639597424 (9.9 GiB)
        RX errors 0  dropped 12  overruns 0  frame 0
        TX packets 31721009  bytes 21892650247 (20.3 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 738  bytes 74021 (72.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 738  bytes 74021 (72.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

tailscale0: flags=4305<UP,POINTOPOINT,RUNNING,NOARP,MULTICAST>  mtu 1280
        inet 100.125.93.20  netmask 255.255.255.255  destination 100.125.93.20
        inet6 fd7a:115c:a1e0::9337:5d14  prefixlen 128  scopeid 0x0<global>
        inet6 fe80::4d3b:ec6f:8289:b1f3  prefixlen 64  scopeid 0x20<link>
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 500  (UNSPEC)
        RX packets 386966  bytes 49732969 (47.4 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 387722  bytes 43714519 (41.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

veth07a9ddd: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::b04d:dfff:fe2c:7f5b  prefixlen 64  scopeid 0x20<link>
        ether b2:4d:df:2c:7f:5b  txqueuelen 0  (Ethernet)
        RX packets 11639877  bytes 1131667286 (1.0 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 5978724  bytes 483738151 (461.3 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

veth0c05f08: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::8450:1cff:fe65:45f7  prefixlen 64  scopeid 0x20<link>
        ether 86:50:1c:65:45:f7  txqueuelen 0  (Ethernet)
        RX packets 5637404  bytes 408886886 (389.9 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 11269333  bytes 773124161 (737.3 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

veth4245a16: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::3c73:42ff:fe16:5710  prefixlen 64  scopeid 0x20<link>
        ether 3e:73:42:16:57:10  txqueuelen 0  (Ethernet)
        RX packets 61177  bytes 3378354 (3.2 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 91710  bytes 5747170 (5.4 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

veth440394c: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::58b4:4aff:fecc:ae12  prefixlen 64  scopeid 0x20<link>
        ether 5a:b4:4a:cc:ae:12  txqueuelen 0  (Ethernet)
        RX packets 2557784  bytes 2478981152 (2.3 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2589783  bytes 2086596411 (1.9 GiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

veth69d151f: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::142e:51ff:fe25:3490  prefixlen 64  scopeid 0x20<link>
        ether 16:2e:51:25:34:90  txqueuelen 0  (Ethernet)
        RX packets 3  bytes 126 (126.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 333  bytes 24282 (23.7 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

veth9ab66e0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::2c69:47ff:fe28:bb63  prefixlen 64  scopeid 0x20<link>
        ether 2e:69:47:28:bb:63  txqueuelen 0  (Ethernet)
        RX packets 390686  bytes 932429561 (889.2 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 389598  bytes 43678567 (41.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlan0: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether dc:a6:32:47:10:36  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

mfunk@rpimonitor:~ $
```

### docker ps

```bash
mfunk@rpimonitor:~ $ docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED         STATUS                 PORTS                                         NAMES
dcbe7e87b27c   louislam/uptime-kuma:1          "/usr/bin/dumb-init …"   10 months ago   Up 13 days (healthy)   0.0.0.0:3001->3001/tcp, [::]:3001->3001/tcp   uptime-kuma
581f3bb0a997   bbernhard/signal-cli-rest-api   "/entrypoint.sh"         11 months ago   Up 13 days (healthy)   0.0.0.0:9922->8080/tcp, [::]:9922->8080/tcp   signal-api
381184a49e55   teslamate/grafana:latest        "/run.sh"                11 months ago   Up 13 days             0.0.0.0:3000->3000/tcp, [::]:3000->3000/tcp   mfunk-grafana-1
9dec35198f2f   postgres:17                     "docker-entrypoint.s…"   11 months ago   Up 13 days             5432/tcp                                      mfunk-database-1
35610547bfc8   eclipse-mosquitto:2             "/docker-entrypoint.…"   11 months ago   Up 13 days             1883/tcp                                      mfunk-mosquitto-1
959edc8f1fcc   teslamate/teslamate:latest      "tini -- /bin/sh /en…"   11 months ago   Up 13 days             0.0.0.0:4000->4000/tcp, [::]:4000->4000/tcp   mfunk-teslamate-1
mfunk@rpimonitor:~ $
```

### Backup mount point

```bash
mfunk@rpimonitor:~ $ mount nas1.thefunkhouse.net/volume1/Backup
mount: nas1.thefunkhouse.net/volume1/Backup: cannot find in /etc/fstab.
mfunk@rpimonitor:~ $ sudo mkdir -p /mnt/backup
mfunk@rpimonitor:~ $ sudo mount -t nfs -o nfsvers=3 nas1.thefunkhouse.net:/volume1/backup /mnt/backup
Created symlink /run/systemd/system/remote-fs.target.wants/rpc-statd.service → /lib/systemd/system/rpc-statd.service.
mfunk@rpimonitor:~ $ df -h
Filesystem                             Size  Used Avail Use% Mounted on
udev                                   1.6G     0  1.6G   0% /dev
tmpfs                                  760M  1.7M  758M   1% /run
/dev/mmcblk0p2                          58G   13G   42G  24% /
tmpfs                                  1.9G  1.1M  1.9G   1% /dev/shm
tmpfs                                  5.0M   16K  5.0M   1% /run/lock
/dev/mmcblk0p1                         510M   67M  444M  14% /boot/firmware
tmpfs                                  380M  4.0K  380M   1% /run/user/1000
nas1.thefunkhouse.net:/volume1/backup  3.5T  485G  3.0T  14% /mnt/backup
mfunk@rpimonitor:~ $ cd /mnt/backup
mfunk@rpimonitor:/mnt/backup $ ls -al
total 4
drwxr-xr-x 1 root root   12 Jul 10 17:28 .
drwxr-xr-x 3 root root 4096 Jul 10 16:35 ..
mfunk@rpimonitor:/mnt/backup $
```

### Backup mount point added to fstab

```bash
mfunk@rpimonitor:~ $ cat /etc/fstab
proc            /proc           proc    defaults          0       0
PARTUUID=a6e79279-01  /boot/firmware  vfat    defaults          0       2
PARTUUID=a6e79279-02  /               ext4    defaults,noatime  0       1
# a swapfile is not a swap partition, no line here
#   use  dphys-swapfile swap[on|off]  for that
# Backup
nas1.thefunkhouse.net:/volume1/backup /mnt/backup nfs nfsvers=3,rw,hard,intr 0 0
mfunk@rpimonitor:~ $
```
