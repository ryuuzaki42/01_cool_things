    ##   Script.r   ##

## Processo com mais uso de CPU
    ps -aux --sort=-pcpu | head

## Processo com mais uso de MEM (Memória | memory)
    ps -aux --sort -rss | head

## Disable KDE Wallet (KWALLET) Pop-ups in Chromium, Google Chrome and Opera
    # for not pop-up everytime you open them added in the end of file
    nano ~/.kde/share/config/kwalletrc

[Auto Deny]
kdewallet=Chromium,Opera,Chrome

    # Save and exit the file. Log out and back in again for the changes to take effect,
    # or simply enter the following into the terminal:
    killall -9 kwalletd

## Dia que sistema foi instalado
    # How do I find how long ago a Linux system was installed?
    ls -alct / | tail -1
    # or
    ls -alct / | tail -1 | awk '{print $6, $7, $8}'

## GhostScript - Reduzindo o tamanho de arquivos PDF pelo terminal
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dNOPAUSE -dBATCH -sOutputFile=novo.pdf velho.pdf
    # or
    gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -sOutputFile=novo.pdf velho.pdf

    Onde novo.pdf é o novo arquivo que será criado e velho.pdf é o antigo, o grande.
    gs :: Ou GhostScript, um interpretador e visualizador de arquivos PS e PDF.
    -sDEVICE :: Determina o dispositivo de saída do comando. Como estamos gerando um arquivo PDF,
        usaremos o dispositivo built-in pdfwrite;
    -dCompatibilityLevel :: Determina o nível de compatibilidade do PDF.
        Neste caso o level 1.3 é compatível com o Acrobat Reader 3 ou superior. Level 1.4 por exemplo
    já seria compatível apenas com Acrobat Reader 5 ou superior.
    -dNOPAUSE :: Desabilita o prompt (pausa) ao final de cada página processada.
    -dBATCH :: Processamento em batch. Caso omita esta opção, após o processamento você cairá no
        interpretador gs e precisará digitar "quit" para sair.

## Get the users normal users
    cat /etc/passwd | grep -vE "nologin|ftp" | grep home | awk -F':' '{ print $1}'
    # or
    cat /etc/passwd | awk -F: '$3 > 499 {print $1}'
    # or
    awk -F ':' '$3 > 499 {print $1}' /etc/passwd

    # test
    user_normal=`awk -F ':' '$3 > 499 {print $1}' /etc/passwd`
    ls /home/$user_normal

## Iniciar o Dropbox no KDE com ícone de notificações (system tray icon)
#!/bin/bash
cd /media/sda4/prog/dropbox/0not_change/
dbus-launch ../dropboxd

## Video para mp3
mplayer -dumpaudio arquivo_video.mp4 -dumpfile arquivo_audio.mp3

## Combinar dois arquivos de texto em duas colunas "arq1 arq2"
paste file1.txt file2.txt > fileFinal.txt

## Wget
    wget -c link -O filename_save.extensao --limit-rate=200000 # (195KB/s)

## Descobrir a placa-mãe sem programa
    # No Windows, no CMD
    wmic baseboard get product,manufacturer

    # No Gnu/Linux, como root
    dmidecode | more
    #Procure por "Base Board Information"
    digite /Base

## To get an ASCII man page file, without the annoying backspace/underscore attempts at underlining,
    # and weird sequences to do bolding:
    # man comand_to_get | col -b > comand_to_get.txt
    man ksh | col -b > ksh.txt

## Enable ssh X11 on slackware
    ## The remote server need GUI and that GUI need to be up

    ## To connect
    ssh -X user@ip

    Added in /etc/ssh/sshd_config # To anothers OS /etc/ssh/sshd_config
    X11Forwarding yes

    ## Restart the ssh service
    /etc/rc.d/rc.sshd restart

    ## Exit from this connection

    ## Before connect again, to enable the acess to any user to GUI
    xhost +

    ## To connect
    ssh -X user@ip
        ## or
    ssh -Y user@ip

    ssh -Y root@192.168.0.42

    ## To see conections konsole (look to the IP)
    w

    ## To use the display remote
    export DISPLAY=:0.0

    ## To use the display local
    export DISPLAY=ip_local_host:0.0
    export DISPLAY=192.168.0.13:0.0

    ## To test the display
    xclock &

## Warning packages removed Slackware
    removepkg *z | grep -E "WARNING|Removing package"

    TMPFILE=`mktemp`; removepkg *z | tee $TMPFILE; echo -e "\n\n\t$TMPFILE\n"; cat $TMPFILE | grep -E "WARNING|Removing package"
    # remove the file after?
    rm $TMPFILE

## Count files in the folder
    countFiles=`ls -la | cat -n | tail -n 1 | awk '{print $1}'`; echo "Count files in this folder: $countFiles"

## Count files of one type in the folder
    fileType=mp3; countFiles=`ls -la *$fileType| cat -n | tail -n 1 | awk '{print $1}'`; echo "Count files in this folder: $countFiles"

## Convet entire playlist from flac, oog, flac to mp3
    # 320 k
    for f in *.flac , *.m4a , *.ogg ; do ffmpeg -i "$f" -ab 320k "${f%.m4a}.mp3"; done

    # normal (small files)
    for f in *.flac , *.m4a , *.ogg ; do ffmpeg -i "$f" "${f%.m4a}.mp3"; done

## Rename several file adding some parte
# file_output.txt => f; ${f:2} => le_output.txt; ${f::-4} => file_output
    for f in *.sh ; do git mv "$f" "${f::-3}"_JBs.sh; done

## Remove part of the name of files
    #To temove extra.test
    rename "extra.test" "" *

## pdf to txt
	# need poppler package
    pdftotext input.pdf output.txt

    # or with -layout to keep the layout
    pdftotext -layout input.pdf output.txt

## Access ssh X11 on Windows
    ## Add in the remote server in /etc/ssh/sshd_config # To anothers OS /etc/ssh/sshd_config
    X11Forwarding yes

    ## Download and Install full Xming-fonts and Xming
    https://sourceforge.net/projects/xming/files/?source=navbar

    ## Change the shortcut to start Xming. Right click your mouse to go to properties.
    Add -ac to your XMing shortcut:
    "C:\Program Files\Xming\Xming.exe" :0 -clipboard -multiwindow -ac

    ## Start XMing

    ## Download putty
    http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html

    ## Configure putty
    In Session: Add the IP and port to remote server

    In Connection >> SSH >> X11: Mark Enable X11 Forwarding, set the display to: localhost:0
    and protocol to MTI-Magic-Cokie-1

    ## Connect on the putty
    ## export the display
    export DISPLAY=192.168.0.13:0.0

    ## To test the display
    xclock &

## RedShift GUI Error
    sed -i 's/|/,/g' ~/.redshiftgrc

## Linux echo only some lines
a=`screenfetch -E`
x=3
y=18
echo "$a" | sed -n -e "$x,$y p" -e "$y q"
    # or
cat -n file.txt | sed -n -e "$x,$y p" -e "$y q"

# Print from line 10 to line 20
    iline=10; fline=20; sed -n "$iline, $fline p" vehDist.ini
    #or
    iline=10; fline=20; cat -n file.txt | sed -n -e "$iline,$fline p" -e "$iline q"
    #or
    iline=10; fline=20; cat -n vehDist.ini | head -$fline | tail -$iline
    #or
    iline=10; fline=20; head -$fline file.txt | tail -$iline

## Localize arquivos grandes
    find . -size +1000M

    #b - blocos de 512-byte (este é o default, se não for utilizado nenhum sufixo)
    #c - bytes
    #w - palavras de dois bytes
    #k - Kilobytes (unidades de 1024 bytes)
    #M - Megabytes (unidades de 1048576 bytes)
    #G - Gigabytes (unidades de 1073741824 bytes)

## Expansão de urls encurtadas com curl
curl -sIL short-url | grep ^Location;

curl -sIL http://goo.gl/CwbmNk | grep ^Location;
  # Location: http://www.shellhacks.com/en/HowTo-Extract-Archives-targzbz2rarzip7ztbz2tgzZ

## How to compare the content of two or more directories
    # Compare dois diretórios
    diff -qr dir1/ dir2/

    # -q, report only when files differ
    # -s, report when two files are the same
    # -r, recursively compare any subdirectories found

## Remove Spotify pop-up notification when a song starts
    # Exit Spotify
    # Then edit
    ~/.config/spotify/Users/[Spotify user name]-user/prefs
    # And set
    ui.track_notifications_enabled=false

## Gmail list the archived emails
    has:nouserlabels -in:Sent -in:Chat -in:Draft -in:Inbox

    # Mais que 10m e mais de 1 ano
    larger:10m older_than:1y

    # https://support.google.com/mail/answer/7190

## Change size monitor
    xrandr --output LVDS1 --mode 1024x768
    xrandr --output LVDS1 --mode 1366x768

    xrandr -s 1024x768
    xrandr -s 1366x768

    # Add
    xrandr --output LVDS1 --mode 1024x768
    xrandr --output VGA1 --mode 1024x768
    xrandr --output LVDS1 --off
    xrandr --output VGA1 --mode 1440x900

    # Remove
    xrandr --output VGA1 --mode 1024x768
    xrandr --output LVDS1 --mode 1024x768
    xrandr --output VGA1 --off
    xrandr --output LVDS1 --mode 1366x768

## Comprimir zip em várias partes 
    7z a -v512m Large-file-separated-in-multi-parts.zip Large-Gigabytes-File.SQL

    # Large-file-separated-in-multi-parts.zip.001, Large-file-separated-in-multi-parts.zip.002,
    # Large-file-separated-in-multi-parts.zip.003, Large-file-separated-in-multi-parts.004 etc

## Smarty DNS
    http://www.smartydns.com/
    # trial 14 days

    192.241.143.47
    87.117.205.40
    37.139.11.137

    https://unlocator.com/
    # trial 7 days

    185.37.37.37
    185.37.37.185
    185.037.037.037
    185.037.037.185

## Open DNS
    # http://www.gigadns.com.br/
    189.38.95.95
    189.38.95.96

## Magic SysRq key
    # Enable? 1 - Yes, 0 - No
    cat /proc/sys/kernel/sysrq

    # To enable
    echo 1 > /proc/sys/kernel/sysrq

    # Keys
    un"R"aw take control of keyboard back from X,
    t"E"rminate send SIGTERM to all processes, allowing them to terminate gracefully,
    k"I"ll send SIGKILL to all processes, forcing them to terminate immediately,
    "S"ync flush data to disk,
    "U"nmount remount all filesystems read-only,
    re"B"oot

    "Raising Elephants Is So Utterly Boring", "Reboot Even If System Utterly Broken"
    or simply the word "BUSIER" read backwards


## Conversão de fim de linha entre sistemas operacionais (*nix e Windows)
    # Nos sistemas *nix, o fim de linha é assinalado pelo caracter line feed,
    # logo não existe um posicionamento na primeira coluna da próxima linha.
    # Nos sistemas Windows temos um caractere adicional no fim da linha (carriage return),
    # que precisa ser removido

    # DOS para Unix
    recode dos/CR-LF..l1 arquivo.txt
    # Unix para Windows
    recode l1..windows-1250
    # Unix para DOS
    recode l1..dos/CR-LF

    # Para simplificar, aliases:
alias dos2unix='recode dos/CR-LF..l1'
alias unix2win='recode l1..windows-1250'
alias unix2dos='recode l1..dos/CR-LF'

## Busca em vários arquivos de texto
    # Finding all files containing a text string on Linux
    # use -w to stands match the whole word
    grep -rn 'directory~$PWD' -e "pattern"

    -r or -R is recursive, -n is line number and -w stands match the whole word.
    -l (letter L) can be added to have just the file name.
    Along with these, --exclude or --include parameter could be used for efficient searching. Something like below:
    grep --include=\*.{c,h} -rnw 'directory' -e "pattern"
    This will only search through the files which have .c or .h extensions. Similarly a sample use of --exclude:
    grep --exclude=*.o -rnw 'directory' -e "pattern"
    Above will exclude searching all the files ending with .o extension.
    Just like exclude file its possible to exclude/include directories
    through --exclude-dir and --include-dir parameter, the following shows how to integrate --exclude-dir:
    grep --exclude-dir={dir1,dir2,*.dst} -rnw 'directory' -e "pattern"
    This works for me very well, to achieve almost the same purpose like yours.
    For more options : man grep

    grep -rn $PWD -e "24" > ../../../a.txt

## KDE - Minimize/Maximize Keyboard Shortcut
    Alt+F2 and type "systemsettings"
    then click on "Shortcuts and Gestures".
    The window management shortcuts are under "Global Keyboard shortcuts", then select "Kwin" from the drop-down menu.
    By default maximise is Alt+F11 and minimise is Alt+F10.

    You could set the keyboard shortcuts to the "Quick title" to move left/right etc

## Firefox Special Paste
    Use the shortcut Ctrl + Shift + V.
    #If you happen to have the Adblock Plus add-on installed it might have overridden it with displaying
    # the "Blockable Items on current page" sidebar.
    # In this case enter "about:config" in your address bar, then search for the key
    # "extensions.adblockplus.sidebar_key", remove the CTRL+SHIFT+V association and restart the browser.

## How can I suspend/hibernate from command line?
    #To get Hibernation
    su - root -c 'pm-hibernate'
    #To get Suspend
    su - root -c 'pm-suspend'

## Change the size on Google Slides
     Click the File "menu" and select "Page setup"
    Select a size from the drop down menu:
    Custom -> pixels: 1024 x 788

## vlc continue playback?
    interface> Main interfaces> QT:"Continue playback?" ask -> never

## Mesclando linhas de arquivos
$ cat arq1.txt
1
2

$ cat arq2.txt
a
b

$ paste -d '\n' arq1.txt arq2.txt
1
a
2
b

    # A diretiva '\n' indica o delimitador a ser usado para concatenar o conteúdo dos arquivos.
    # Nesse caso, foi utilizado a quebra de linha ('\n').

    # O comportamento padrão do comando paste é colocar as linhas dos arquivos separadas por tabulações:
$ paste arq1.txt arq2.txt
1       a
2       b

    # Nos exemplos utilizamos apenas dois arquivos, mas na prática podemos usar mais arquivos

 ## Assista Star War em modo ASCII
    telnet towel.blinkenlights.nl

## Ip externo pelo terminal
    wget -qO - icanhazip.com

 ## Popcorn-Time error, not found lib libudev.so.1
    ln -s /usr/lib64/libudev.so /usr/lib64/libudev.so.1

## Scan de rede sem fio / Wi-Fi
    iw dev wlan0 scan

    # iwlist is seriously deprecated. Remove it from your system and never use it again.
    # Do the same with iwconfig, iwspy. Those tools are ancient and were designed in an era where 802.11n didn't exist.
    # Kernel developers maintain a ugly compatibility layer to still support wireless-tools,
    # and this compatibility layer often lies.

## grep com mais de um valor
    cat file.txt | grep -E "Cell|Encryption|Quality|Last beacon|ESSID"
    # grep -E é o mesmo que egrep, aceita "A|B" e 'A|B'

## Saída de um processo para outro
     # tee >(proc1) >(proc2) >(proc3) | proc4
    iw dev wlan0 scan | grep "SSID" | nl
    iw dev wlan0 scan | grep -E "SSID:|signal:|beacon interval:|WPA|last seen:" | tee /dev/tty | grep -E "SSID" | wc -l
 
## Ver tamanho do pacote de rede
    netstat -i <interface>
    ifconfig <interface>

## Clonar pasta de um site ou baixar o conteúdo de pasta em um site
    lftp -c 'open http://slackware.com/~alien/multilib/ ; mirror -c -e 14.1'

    lftp -c 'open http://sumo.dlr.de/trac.wsgi/browser/trunk/sumo/tests/complex/tutorial/ ; mirror -c -e hello'

## Informações do Ip externo acesse
    http://ip-lookup.net/

## MEGA-MASTERKEY.txt
    KEfQYPeq5_bODHkqUCrMhQ

## sed troca \n por nova linha
    sed 's/\\n/\
/g'

## sed inserir uma nova linha
sed 's/regexp/\'$'\n/g'
    # regexp:' expressão que irá trocar

## Screenshot de 5 em 5 segundo no terminal
    count=0; while true; do ((count++)); import -window root -display :0 screen.$count.jpg; sleep 5; done

## shellscript quantidade de parâmentros
    Quantidade de parâmetros -> $# -> echo $#
    caminho com \ , add "" -> "var"

## backup do Grub (MBR) e restaurar
    dd if=/dev/sdc of=mbr.img count=1 bs=512

    ## Restaurar o Grub (MBR)
    dd of=/dev/sdc if=mbr.img
    # Use um live cd do Linux e o mbr.img que fez backup

## Senha aleatórias
    date +%s | md5sum | base64 | head -c 10 ; echo

## Pasta de review ou annotations do okular
    ~/.kde/share/apps/okular/docdata/

## Listagem ls normal > 1 2 3 4 5 6 8 9 10 11 12 13 ...
    ls -v

## lcd, mover e listar diretório
    alias lcd=changeDirectory
    function changeDirectory {
         cd $1 ; ls -l -a -v -h --color
    }

    # or
    alias lcd="cd $1 ; ls -l -a -v -h --color"

## Opções úteis do ls
    ls -lSrh
    ls -lXrh

    -l :: fornece saída detalhada
    -S :: coloca em ordem de tamanho
    -r :: inverte a listagem colocando por último os maiores arquivos
    -h :: fornece na saída um valor melhor para ser lido por humanos
    -X :: ordenar em ordem alfabética

## Ver maiores diretórios
    du -h | egrep -v "\./.+/" | sort -h

    du: -h :: fornece na saída um valor melhor para ser lido por humanos
    egrep: -v :: inverte o filtro, buscando por ocorrências que não possuam a expressão
    sort: -h :: compara valor melhores no modo humano

## Ignorar o ping no Gnu/Linux
    sysctl -w net.ipv4.icmp_echo_ignore_all=1

    # Religar
    sysctl -w net.ipv4.icmp_echo_ignore_all=0

    # Limitar respostas
    sysctl -w net.ipv4.icmp_echoreply_rate=10

## Teste MTU size and MTU Path. Executa ping com pacote de 1500 bytes e não aceita fragmentação (- M do)
    # Apenas root consegue definar o tamanho do ping (-s)
    ping -c 3 -s 1500 -M do google.com

    # Equivalante em Windows:
    ping -l 1500 -f google.com

## Copy
    #! / bin/bash # juntar / bin
    export LD_LIBRARY_PATH=".";
    cd /media/sda4/prog/copy/x86_64/
    ./CopyAgent

## Virtualbox start kernel service
    # Slackware KDE
    kdesu sh /etc/init.d/vboxdrv start; VirtualBox %U

    # Slackware XFCE
    gksu sh /etc/init.d/vboxdrv start; VirtualBox %U

    # Linux mint
    kdesudo sh /etc/init.d/vboxdrv start; VirtualBox %U

## Vmware start kernel service
    kdesu /usr/bin/svmware_auto.sh; /usr/bin/vmware %F

## VirtualBox definir tamanho da tela
    vboxmanage setextradata 'Nome de sua máquina Virtual' CustomVideoMode1 1366x768x32

## Verificar disco rígido
    # Se a partição for ext4, -f força o teste mesmo que os files clean
    fsck.ext4 -f /dev/sda5

    # Link:
    http://apoie.org/JulioNeves/index.html (cadeias)

## Criar várias pastas
    mkdir {1..25}
    # or
    mkdir folder_{1..25}

## Para remover várias pastas
    rm -r {1..25}

## Setar PATH
    export PATH=$PATH:/path/to/dir
    # ex java:
    export PATH=$PATH:/usr/lib64/java/bin:/usr/lib64/java/jre/bin:

## Swap em arquivo
    # Se a máquina tem até 2GB de RAM, coloque o dobro.
    # A partir daí, cada GB adicional de RAM é apenas RAM+2GB na swap.
    Vendo através do sistema de arquivos proc:
    cat /proc/swaps ou swapon -s

    # Criar arquivo para swap
    dd if=/dev/zero of=/dir/swapfile.img bs=1M count=200

    # Crie a área de swap no arquivo:
    mkswap /dir/swapfile.img

    # Ativar o swap
    swapon /dir/swapfile.img
        # *inserir no boot

    ## Resumo final -> 8 GiB
    dd if=/dev/zero of=/home/j/swapfile.img bs=1M count=8192
    mkswap /home/j/swapfile.img
    nano /etc/fstab
    /home/j/swapfile.img swap swap default 0 0

    # Se apresener "erro" de permissões de acesso
    chmod 600 swapfile.img

    # Ver valor de swappiness atual
    cat /proc/sys/vm/swappiness

    # To temporarily set the swappiness value:
    sysctl -w vm.swappiness=10

    # To set the swappiness value permanently, edit a sysctl configuration file
    nano /etc/sysctl.conf
    adicionar no arquivo -> vm.swappiness=10
    carregar o configuração padrão/permanente
    sysctl –p

## Kali Linux teclado abnt2 pt-br
    sudo setxkbmap -model abnt2 -layout br -variant abnt2

## Mover para pastas
    i=1; while [ $i -lt 25 ]; do mv *S02E$i* $i; i=$((i+1)); done

    i=1; while [ $i -lt 25 ]; do mv $i.* $i; i=$((i+1)); done

## Renomear arquivos
    ## >> *$igual0$i*.$extensao == *S01E0(i)*.srt
    i=1
    igual=S01E
    extensao=srt
    while [ $i -lt 25 ]; do
        if [ $i -lt 10 ]; then
            mv *$igual"0"$i*.$extensao $i.$extensao
        else
            mv *$igual$i*.$extensao $i.$extensao
        fi
        i=$((i+1))
    done

## Zipar vários arquivos
    i=1; while [ $i -lt 50 ]; do zip -r $i.zip $i; i=$((i+1)); done

## Ver codificação de um arquivo
    file --mime-encoding nome_do_arquivo

## Selecionar e renomear vários arquivos, copiando para outra pasta
    i=1;for arq in hone/l/imagem/*/* ; do cp $arq a/$i.jpg; i=$(($i+1));done

## Converter UTF-8 para ISO-8859-1
    iconv -f codificacao_de_origem -t codificacao_de_saida arquivo
    iconv -f utf-8 -t iso-8859-1 arquivo

    ## Converter ISO-8859-1 para UTF-8
    iconv -f iso-8859-1 -t utf-8 arquivo

    ## Necessário redirecionar a saida de arquivo para algum lugar
    iconv -f utf-8 -t iso-8859-1 arquivo > novo_arquivo

## Juntar pdf #precisa do pdftk
    pdftk arquivo1.pdf arquivo2.pdf cat output arquivo1e2.pdf

## OWNER PASSWORD REQUIRED - Aquivo criptografado/com senha
    # Se conseguir ler ele no leitor de pdf ele tem como senha espaço branco setado
    # qpdf --password=YOURPASSWORD-HERE --decrypt input.pdf output.pdf
    qpdf --password= --decrypt pretextual.pdf pretextual2.pdf

## sed
    echo "TV" | sed 's/TV/tv/g'

## contar caracteres
    wc -m

## Evince with not icons
    Criar o arquivo em ~/.config/gtk-3.0/settings.ini
    e no arquivo:

[Settings]
gtk-theme-name = Adwaita
gtk-fallback-icon-theme = gnome

## OMNeT++ estilo bonito # não utilize o tema oxygen default, use oxygen cold
    Criar o arquivo em ~/.config/gtk-3.0/settings.ini
    e no arquivo:

[Settings]
gtk-theme-name = oxygen-gtk
gtk-fallback-icon-theme = gnome

## OSD Lyrics sem ícones
    gtk-update-icon-cache /usr/share/icons/hicolor

## Pegar pedaço de uma string ou cortar string
    cut -c1-3 # pimeiro até o 3 caracteres

    cut -d ';' -f2 tabela.txt
    -d delimitador
    -fX número X referente a coluna que quer

## Trocar nome dos arquivo de iso88591 para utf8
    # Apenas testa
    convmv -f iso88591 -t utf8 -r nome_pasta

    ## Troca realmente
    convmv -f iso88591 -t utf8 -r nome_pasta --notest
        -f : diz qual que é a codificação que o arquivo está no momento (from)
        -t : diz qual é a codificação que o arquivo deverá ficar (to)
        -r : usada para alterar a codificação dos arquivos de dentro da pasta, recursivamente.
            Se você for alterar apenas o nome da pasta ou de um arquivo, retire essa opção.
        nome_pasta : o nome da pasta ou arquivo cuja codificação será alterada.
    O comando anterior apenas simulará o resultado da codificação e exibirá na tela.
    Caso esteja tudo correto, então aplique os resultados rodando o comando novamente,
    acrescido da opção --notest (são dois traços)

## Criando uma imagem ISO
    O mkisofs permite criar imagens ISO a partir de um diretório no HD. O “mk” vem de make,
    ou seja, criar. O “iso” vem de imagem ISO, enquanto o “fs” vem de sistemas de arquivos
    Ou seja, o nome mkisofs descreve bem o uso do programa, que é criar sistemas de arquivo ISO

    mkisofs -pad -r -J -o nome_do_arquivo.iso /diretorio_de_origem/

    * mkisofs : é o comando que chama o programa
    * -r : permite que qualquer cliente possa ler o conteúdo do arquivo
        Evita problemas ao tentar ler o arquivo no Windows
    * -J : Mais uma opção para manter compatibilidade como Windows. Ativa as extensões Joilet
    * -o : Especifica o nome do arquivo ISO que será criado
    * -R é o protocolo para o tipo de extensão Rock Ridge, comumente usado no Linux
    * -l permite mais de 31 caracteres para o nome do arquivo, pode ser que o MS-DOS
        não consiga enxergar estes caracteres, já que ele trabalha com um protocolo 8.3;
    * -V especifica uma identificação para o CD (rótulo);
    * -v caso seja esta opção acionada, serão exibidas em seu vídeo todas informações que saírem do mkisofs
    * nome_do_arquivo.iso : O nome do arquivo propriamente dito. Não se esqueça de sempre incluir a extensão .iso
    O arquivo é sempre gravado no diretório corrente
    * -pad este parâmetro é necessário em muitos OSs, inclusive no Linux,
         ele é acionado para evitar erros de entrada e saída
    * /diretório_de_origem/ : O diretório onde estão os arquivos que serão incluídos na imagem
        É possível especificar vários diretórios separados por espaços, como em:
        /home/ecouto/testes/ /home/ecouto/arquivos/

## Mplayer e suas loucuras! imagem da webcam com efeito MATRIX
    # Em uma linha apenas
    mplayer -fps 30 -vo matrixview -cache 128
        -framedrop -vo matrixview driver=v412:width=640:height=480:device= /dev/video0 tv://

## Apagar os arquivos definitivamente e/ou sobrescrever
    shred -n 3 -z file.ext

    Onde:
        -n 3 - número de interações ou gravações;
        -z - significa que o último padrão a ser gravado será zero

## Personalizando o terminal bash do Linux
    # opções disponíveis no PS1, aplicar no script em shell no seu local ($HOME/.bashrc e /root.bashrc)

    $PS1 é o prompt de comando
    $PS2 é solicitado quando um comando exige mais de uma linha
    Algumas opções do PS1
    \W: Exibe o nome do diretório (apenas o nome)
    \w: Exibe o nome do diretório (caminho completo)
    \d: Exibe a data
    \s: Exibe o nome do shell
    \h: Exibe o nome da máquina (hostname)
    \u: Exibe o nome do usuário
    \t: Exibe a hora
    O meu script shell que uso é esse: .bashrc
    #!/bin/bash
    if [ $(id -u) -eq 0 ]; then # se for root
        PS1="\\[$(tput setaf 1)\\][\\u@\\h:\\w] #\\[$(tput sgr0)\\]"
    else # user normal
        PS1="\\[$(tput setaf 8)\\][\\u@\\h:\\w] $"
    fi

## Adicionar plugins
    ln -s /usr/lib64/mozilla/plugins/ /home/j/.mozilla/

## Alterar brilho terminal
    cat /sys/class/backlight/acpi_video0/brightness
    echo 100 > /sys/class/backlight/acpi_video0/brightness

## Deslogar do skype ou logout skype
    Abri uma janela de um amigo qualquer e enviar /remotelogout

## Recuperar arquivos
    ./extundelete /dev/sdb2 --restore-all
    http://mapburghardt.blogspot.com.br/2012/05/recuperar-arquivos-deletados-em-ext4.html

## KDE tags
    %f - um nome de arquivo único
    %F - uma lista de arquivos; use nos aplicativos que podem abrir vários arquivos locais de uma vez
    %u - um único URL
    %U - uma lista de URLs
    %d - a pasta do arquivo a abrir
    %D - uma lista de pastas
    %i - o ícone
    %m - o mini-ícone
    %c - o título
    Ex: ’firefox’ inicie a sua navegação Web em ’www.kde.org’
    em vez do firefox, use firefox %u www.kde.org.

## gerar iso - (cdrkit)
    genisoimage -o file_output.iso floder_input/

## bc casas decimais
    echo "scale=2; 10/3" | bc
    scale=> quantas casas decimais.

# No bash
    # redirecionamento de entrada inline (<<) proxima palavra delimitador (comum EOF)
    c=`bc << EOF
    scale=2
    d=2
    e=(d + 2)
    f=(d + e)
    f+e
    EOF
    `; echo $c ##não esquecer da crase

    # Em script
    d=2
    c=`bc << EOF
    /*Comentário*/
    scale=2
    e=($d * 2)
    f=($d / 3)
    f+e /*Resultado desejado - nesse caso 10*/
    EOF
    ` # não esquecer de colocar a crase final
    echo $c

## Trocar caracteres em uma string
    echo "Olá.como.vai" | tr "." " "
    # resultado: Olá como vai

## Remover caracteres de uma string
    echo "Olá.como.vai" | tr -d "."
    # resultado: Olácomovai

## Usando select
    #!/bin/sh
    echo "Qual é o seu SO preferido ?"
    select var in "Linux" "Gnu Hurd" "Free BSD" "Other"; do
    break
    done
    echo "Você selecionou $var"

## Converter imagem em pdf
    convert *.jpg output.pdf

## Converter pdf em imagem
    convert input.pdf output.jpg

## Baixando sites
    wget -c -r -erobots=off -A ".jpg .png" #link_do_site#

## Compartilhamento de pasta no virtualbox
    ->Instal guest additions
    reboot

    No Gnu/Linux para montar a pasta
    mount -t vboxsf nome_pasta_compartilhada /media/nome_pasta
    ex: mount -t vboxsf sda2 /media/sf_sda2/

## Teste Capture som
    arecord | aplay

## Acertar data/tempo/hora
    ntpdate -u -b ntp1.ptb.de
    # or
    ntpq -p ntp1.ptb.de
    ntpdate -u -b bonehed.lcs.mit.edu
    ntpdate -u -b ntp.usp.br

## Comentário shell script várias
    : '
    Linha1 comentada
    Linha2 comentada
    Linha3 comentada
    '

    # or

    # com um delimitador
    :<< 'asd'
    Linha1 comentada
    Linha2 comentada
    Linha3 comentada
    asd

## Boot ValkyrieOS -> baseado no Slackware 14.1
    huge.s intel_pstate=disable

## Kernel Generic
    /usr/share/mkinitrd/mkinitrd_command_generator.sh
    # /usr/share/mkinitrd/mkinitrd_command_generator.sh -l /boot/vmlinuz-generic-3.2.29 >> /etc/lilo.conf

## Open terminal nautilus
    apt-get install nautilus-open-terminal
    nautilus -q

## How to force Dolphin to not execute executable files
    edit /usr/share/mime/packages/freedesktop.org.xml
    and find the line that starts the shellscript section:
    <mime-type type="application/x-shellscript">
    then scroll down to find this line within that section:
        <sub-class-of type="application/x-executable"/>
    then comment it out like so:
        <!-- <sub-class-of type="application/x-executable"/> -->
    save that, then compile it with this command:

    update-mime-database /usr/share/mime
    ## if unknown (Unknown media type in type ...)
    rm /usr/share/mime/packages/kde.xml
    update-mime-database /usr/share/mime
 
## Saber quando o Gnu/Linux foi instalado
    ls -lct /etc | tail -1 | awk '{print $6, $7, $8}'

## Redimensionar Imagens # Pacote Imagemagick
    # Sem modificar aspeto
    mogrify -resize 320x240 *.png

    # Modificar a relação de aspeto, se necessário
    mogrify -resize 320x240! foto.png

    # Redimensionar foto.png para 50% do ficheiro original e manter a relação de aspeto
    mogrify -resize 50% foto.png

    # Modificar apenas a largura da foto.png para 320 e manter a relação de aspeto
    mogrify -resize 240 foto.png

    # Modificar apenas a altura da foto.png para 320 e manter a relação de aspeto
    mogrify -resize x320 foto.png

## Netbeans em Português
    ./netbeans --locale pt:BR

## Windows ##

## Trocar de unidade cmd
    X: (onde X: é a unidade onde seu pendrive está conectado.)

## CMD
    del # apaga arquivo
    dir # mostra arquivos
    dir /A:H #mostra arquivos ocultos
    del /A:H x # apaga arquivo x oculto

## Windows 8 (8.1) boot modo seguro
    # Habilitar F8
    bcdedit /set {default} bootmenupolicy legacy

    # Desabilitar F8
    bcdedit /set {default} bootmenupolicy standard

## Remover vírus o Recycler bin
    # Link: (http://www.artigonal.com/seguranca-artigos/como-remover-o-virus-recy
    # cler-que-transforma-pastas-em-atalho-e-como-recuperar-seus-arquivos-novamente-6387104.html)
    attrib -a -h -r -s /s /d *.* # dentro da unidade

    -R Limpa o Atributo de arquivo somente leitura
    -A Limpa o Atributo de arquivo morto
    -S Limpa o Atributo de arquivo de sistema
    -H Limpa o Atributo de arquivo oculto
    /s Processa os arquivos correspondentes na pasta atual
    /d Inclui pastas no processamento

## Hibernação / hibernation
    # Disable
    powercfg.exe /hibernate off

    # Enable
    powercfg.exe /hibernate on

## How to install fonts in Slackware
    # move your fonts (*.ttf) to “/usr/share/fonts/TTF”
    # run those commands in “/usr/share/fonts” - root
    mkfontscale
    mkfontdir
    fc-cache -f -v

# Habilitar root
    sudo passwd root

## Mysql no Slackware
    # Para instalar a base de dados
    mysql_install_db

    # Necessário mudar as permissões do diretório inicial e assim o sock será gerado
    chown -R mysql.mysql /var/lib/mysql

    #Para iniciar o MySQL
    mysqld_safe &

    #Para definir a senha de root/administrador dos bancos de dados
    mysqladmin -u root password <escolha uma senha>

    #Logando no MySQL:
    mysql -u root -p

# Apache + PHP = em /etc/httpd/httpd.conf descomente a linha
# Include /etc/apache/mod_php.conf

    # Inicie o seu Apache
    /usr/sbin/apachectl start

    # Teste
    touch /var/www/htdocs/infophp.php
    echo "<?php phpinfo(); ?>" > /var/www/htdocs/infophp.php

    # URL:
    http://localhost/infophp.php