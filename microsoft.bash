# Add the Microsoft Linux repository to a Debian (or derivative)

if test $(whoami) != root
then
	echo "Error: run with \`$ sudo bash -e \$FILE\`" >&2
	exit 1
fi

host=https://packages.microsoft.com
public_key=/etc/apt/trusted.gpg.d/microsoft.gpg

curl -sL $host/keys/microsoft.asc | gpg --dearmor > $public_key
echo "deb [signed-by=$public_key] $host/debian/11/prod/ bullseye main" \
    >> /etc/apt/sources.list
apt update

# apt install dotnet-sdk-7.0
