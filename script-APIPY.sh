sudo apt install pip 
sudo apt install python3
sudo apt install mysql-server
#sudo apt install mysql-connector

function baixar_drivers_odbc() {
	if ! [[ "18.04 20.04 22.04" == *"$(lsb_release -rs)"* ]];
	then
	    echo "Ubuntu $(lsb_release -rs) is not currently supported.";
	    exit;
	fi

	sudo curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

	sudo curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list

	sudo apt-get update
	sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
	# optional: for bcp and sqlcmd
	sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18
	echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
	source ~/.bashrc
	# optional: for unixODBC development headers
	sudo apt-get install -y unixodbc-dev
}

baixar_drivers_odbc

for i in psutil time datetime date platform pyodbc mysql-connect; do
	echo 
	echo "Instalando biblioteca ${i}"
	sudo pip install i
done

#Chamando a API
python3 monitorar.py

