cut -d , -f 2 seasonal/*.csv | grep -v Tooth | sort | uniq -c
