WiFi_Check

Purpose:
Script checks to see if WiFi has a network IP and if not
restart WiFi

Control the ACT led to indicate status

Uses a lock file which prevents the script from running more
than one at a time.  If lockfile is old, it removes it

For more info:  
http://rpi.tnet.com/project/scripts/wifi_check

---

### Create and install a deb

```bash
cd wifi-monitor_1.0.0-1
dpkg-buildpackage -uc -b
sudo apt install ../wifi-monitor_1.0.0-1_all.deb
```

### Alternative, less brainiac installation

```bash
rm -rf wifi-monitor_1.0.0-1/debian
dpkg-deb --build wifi-monitor_1.0.0-1
sudo apt install ./wifi-monitor_1.0.0-1.deb
```

### Delete the package
```bash
sudo apt purge wifi-monitor
```

### View logs from the script

```bash
journalctl -t wifi-check
journalctl -t wifi-led
```

### View logs from the service

```bas
journalctl -u wifi-monitor.service -e
journalctl -u wifi-led.service -e
```


