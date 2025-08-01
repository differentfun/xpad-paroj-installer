# xpad-paroj-installer

🕹️ A simple shell script to install the custom [xpad driver](https://github.com/paroj/xpad) using DKMS on Debian-based systems (Debian, Ubuntu, MX Linux, etc.).

## 🚀 What This Does

This script automates the full process of:

- Removing the stock `xpad` kernel module
- Disabling it from auto-loading
- Installing required build tools (`dkms`, `build-essential`, `git`, etc.)
- Cloning the [paroj/xpad](https://github.com/paroj/xpad) repository
- Compiling the driver and installing it with DKMS
- Ensuring the custom driver persists across kernel updates

## 📦 Requirements

- Debian-based Linux distro (e.g., Debian, Ubuntu, MX Linux)
- `sudo` privileges
- Internet connection (to clone and install packages)

## 🔧 Installation

Clone this repo and run the script:

```bash
git clone https://github.com/differentfun/xpad-paroj-installer.git
```

```bash
cd xpad-paroj-installer
```

```bash
chmod +x install_xpad.sh
```

```bash
./install_xpad.sh
```

## 📥 What Gets Installed

- `dkms`, `build-essential`, `git`
- The patched xpad driver from `paroj/xpad`
- A DKMS module at `/usr/src/xpad-0.4`

## 🧹 Optional: HP Accelerometer blacklister
With that script, you can prevent your HP notebook to see assign the accelerometer driver to the joypad. Be warned, that script will prevent the load of the accelerometer module (if you have an hdd, you'll loose the anti-impact protection).

## 🧹 Optional: Revert to stock xpad

If needed, you can remove the DKMS version and restore the original:

```bash
sudo dkms remove -m xpad -v 0.4 --all
```

```bash
sudo mv /lib/modules/$(uname -r)/kernel/drivers/input/joystick/xpad.ko.disabled /lib/modules/$(uname -r)/kernel/drivers/input/joystick/xpad.ko
```

```bash
sudo update-initramfs -u
```


## 🙏 Credits

- Driver source: [paroj/xpad](https://github.com/paroj/xpad)
- Script created by [differentfun](https://github.com/differentfun)
