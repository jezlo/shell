out=hosts.out.txt
function validaPing(){
	while read nodo;
	do
		host=`echo "$nodo" | awk '{print $2}'`
		ping -q -c4 $host > /dev/null
		if [ $? -eq 0 ]
		then
			echo -e "$nodo" | awk '{print $1, $2 " \t OK"}'
		else
			echo -e "$nodo" | awk '{print $1, $2 "\t Failed"}'
		fi
	done < $out
}

if [ -f $out ]
then
	echo "Validar contenido de $out"
	exit
else
	cat /etc/hosts | grep -v '^#' /etc/hosts | awk 'NF' > $out
	validaPing
	rm $out
fi
