# Sur /mnt/build

if [ "(id -u)" -ne ]; then
	echo "Le script doit etre lancer avec sudo"
	exit 1
fi

# Nous telechargons le kernel 
# sudo wget https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.9.tar.gz

# Et puis nous décompréssons 
sudo tar -xzvf linux-6.9.tar.gz 
# Selon ce que vous avex installer 6.9 peut ne pas etre le nom de votre fichier # Deplacons nous sur le dossier du noyau pour la suite 
cd linux-6.9/
cp /boot/config-$(uname -r) .config
make oldconfig
nano Makefile
make menuconfig
make clean
make -j$(nproc) bindeb-pkg
dpkg -i linux-image-6.9.0-*.deb linux-headers-6.9.0-*.deb
update-grub
