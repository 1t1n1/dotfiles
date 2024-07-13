# What is it?
Brightness is a simple program to modify the brightness of a Linux laptop

# Installation
``` shell
cd brightness/src
chmod 755 brightness.sh
# If you want to run the file as yourself:
sudo usermod -a -G video <your username>
# OR If you want to run the file as root:
sudo chown root:root brightness.sh
echo "PATH=$PATH:$(pwd)" >> ~/.bashrc  # Note : The file (~/.bashrc) may vary depending on your shell 
```
Note: I also had to modify the file /etc/default/grub and add the following line: 
`GRUB_CMDLINE_LINUX="acpi_backlight=intel_backlight"`
