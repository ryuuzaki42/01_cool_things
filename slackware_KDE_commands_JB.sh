#!/bin/bash
#!/bin/bash
#
# Autor= João Batista Ribeiro
# Bugs, Agradecimentos, Críticas "construtivas"
# Mande me um e-mail. Ficarei Grato!
# e-mail: joao42lbatista@gmail.com
#
# Este programa é um software livre; você pode redistribui-lo e/ou
# modifica-lo dentro dos termos da Licença Pública Geral GNU como
# publicada pela Fundação do Software Livre (FSF); na versão 2 da
# Licença, ou (na sua opinião) qualquer versão.
#
# Este programa é distribuído na esperança que possa ser útil,
# mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO a
# qualquer MERCADO ou APLICAÇÃO EM PARTICULAR.
#
# Veja a Licença Pública Geral GNU para mais detalhes.
# Você deve ter recebido uma cópia da Licença Pública Geral GNU
# junto com este programa, se não, escreva para a Fundação do Software
#
# Livre(FSF) Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
#
# Script: Script to do the changes I do every installation
# of the Slackware (with KDE)
#
# Last update: 06/08/2017
#
echo "## Change in the Slackware - Script ##"

userNormal=$1 # User to work with
if [ "" -lt '1' ]; then
    echo -e "\nYou need pass the a user to work with\nJust exiting\n"
    exit 1
fi

#--------------------------- Adding a user ----------------------------------------------
# Adding a user passed by parameter
/usr/sbin/adduser "$userNormal"

#--------------------------- Changes in /etc/fstab --------------------------------------
# Comment the line with floppy disk
sed -i '/floppy/ s/^\/dev/#\/dev/g' /etc/fstab

#--------------------------- Changes in /etc/profile.d/lang.sh --------------------------
# Comment the line "export LANG=en_US"
sed '/^export LANG=en_US$/ s/export/#export/' lang.sh

# Uncomment the line "#export LANG=en_US.UTF-8"
sed '/^#export LANG=en_US.UTF-8$/ s/#export/export/' lang.sh

#--------------------------- Changes in /etc/profile.d/lang.csh -------------------------
# Comment the line "setenv LANG en_US"
sed '/^setenv LANG en_US$/ s/setenv/#setenv/' lang.csh

# Uncomment the line "#setenv LANG en_US.UTF-8"
sed '/^#setenv LANG en_US.UTF-8$/ s/#setenv/setenv/' lang.csh

#--------------------------- Changes in /etc/acpi/acpi_handler.sh -----------------------
# Comment the "power) /sbin/init 0" to now halt when the power button is pressed
sed '/power) \/sbin\/init 0/ s/^#*/#/' /etc/acpi/acpi_handler.sh

#--------------------------- Changes in /etc/inittab ------------------------------------
# Disable the standard console (ctrl + alt + f[1-6]) from 6 to 3
sed -i '/c[4-6]:12345/ s/^c/#c/g' /etc/inittab

# Duplicate the line with the runlevel "id:3:initdefault:" changing "id:3" for "id:4"
sed -i '/^id:3:initdefault:/ p; s/id:3/id:4/' /etc/inittab

# Comment the "id:3"
sed -i '/^id:3:initdefault:/ s/^id:3/#id:3/' /etc/inittab

#--------------------------- Create a swap file -----------------------------------------
# Create swap with 2 GiB
dd if=/dev/zero of=~/swapfile.img bs=1M count=2048 # 2 GiB

# Make the file a swap file
mkswap ~/swapfile.img

# Write the configurations in the fstab
echo "/home/j/swapfile.img swap         swap        defaults         0   0" >> /etc/fstab

# Active the SWAP
swapon -a

# Remove swap warnings
chmod 0600 "/home/$userNormal/swapfile.img"
chown root "/home/$userNormal/swapfile.img"

#--------------------------- end --------------------------------------------------------
echo "End the script
