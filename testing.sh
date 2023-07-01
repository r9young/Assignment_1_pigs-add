#/bin/dash

for snap_dir in .pig/index/.snapshot.*; do
    number=$(echo $snap_dir )
    echo $number
done