# Print the first and last date from each data file.
for filename in $@
do
    cut -d , -f 1 ____ | grep -v Date | sort | ____ -n 1
    cut -d , -f 1 ____ | grep -v Date | sort | ____ -n 1
done
