#!/bin/sh
cd ~

#install git
yum -y install git

# install setuptools module
wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py
python ez_setup.py

# install python-pip
wget --no-check-certificate https://github.com/pypa/pip/archive/1.5.5.tar.gz
tar zvxf 1.5.5.tar.gz
cd pip-1.5.5/
python setup.py install
cd ~
rm -rf 1.5.5.tar.gz
rm -rf pip-1.5.5
rm -rf ez_setup.py
rm -rf setuptools-20.6.6.zip

pip install cymysql
yum install -y m2crypto
echo -e "\033[44;37;5m ####  python correlation have been installed  #### \033[0m "

# git clone manyuser
git clone -b manyuser https://github.com/VoganWong/shadowsocks.git
echo -e "\033[44;37;5m ####  manyusr have been downloaded  #### \033[0m "

# what's virt of your vps
yum -y install virt-what
virt-what
vps=$(virt-what)
if [ $vps == 'openvz' ]
then
    echo -e "\033[41;37m ####  your vps is not available to install serverSpeeder  #### \033[0m "
    echo 'exit'
    exit
else
    echo -e "\033[44;37;5m ####  your vps is available to install serverSpeeder  #### \033[0m "
    # install serverSpeeder
    cd ~
    MAC=$(cat /sys/class/net/eth0/address)
    KERNEL=$(cat /etc/redhat-release)

    chattr -i /serverspeeder/etc/apx-20341231.lic
    rm -rf /appex /serverspeeder

    wget https://www.seryox.com/serverSpeeder/CentOS/6.x/CentOS_6.6-2.6.32-573.1.1.el6.x86_64.gz
    tar xvzf CentOS_6.6-2.6.32-573.1.1.el6.x86_64.gz
    rm -f CentOS_6.6-2.6.32-573.1.1.el6.x86_64.gz

    cd server*/apx*/etc
    rm -f apx-20341231.lic
    wget "http://pubilc.download.seryox.com/lot.php?mac=${MAC}&year=2038&bw=204800" -O apx-20341231.lic
    cd ../..
    wget -O serverSpeeder.sh https://www.seryox.com/shell/.serverSpeeder.sh
    chmod +x serverSpeeder.sh
    chmod +x install.sh
    ./serverSpeeder.sh
    # chattr +i /serverspeeder/etc/apx-20341231.lic
    cd ~
    rm -rf serverSpeeder*
    echo -e "\033[44;37;5m ####  serverSpeeder have been installed  #### \033[0m "
    service serverSpeeder start
    sleep 3
    service serverSpeeder status
fi

echo -e "\033[44;37;5m ####  test your vps's speed  #### \033[0m "
# install speedtest-cli.py
wget -O speedtest-cli https://raw.github.com/sivel/speedtest-cli/master/speedtest_cli.py
chmod +x speedtest-cli
./speedtest-cli
