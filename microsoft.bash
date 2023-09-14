# Install dotnet and Microsoft SQL Server on Linux
# https://packages.microsoft.com

# run as root
if test $(whoami) != root
then
	echo "Error: run with \`$ sudo bash -e \$FILE\`" >&2
	exit 1
fi

# dotnet and MSFT repo
curl -sL https://packages.microsoft.com/keys/microsoft.asc \
  | gpg --dearmor > /etc/apt/keyrings/microsoft.gpg # set public key
echo "deb [signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/debian/11/prod/ bullseye main" \
	>> /etc/apt/sources.list # add registry
apt update # up index
apt install -y dotnet-sdk-7.0 # install

# mssql database server
apt install -y docker.io # makse sure `docker` is
password="dasd787d--_ASDA897"
docker pull mcr.microsoft.com/mssql/server:2022-latest # install
docker run --name mssql -p 1433:1433 \
	-env "ACCEPT_EULA=Y" \
	-env "MSSQL_SA_PASSWORD=$password" \
	-d mcr.microsoft.com/mssql/server:2022-latest
docker exec -it mssql bash # enter box

# cat /var/opt/mssql/log/errorlog
# /opt/mssql-tools/bin/sqlcmd -S localhost -U SA
