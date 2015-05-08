#!/bin/sh

[ "$SOCKETDIR" ] || SOCKETDIR=/sock

echo "Ensuring that $SOCKETDIR exists"
mkdir -p $SOCKETDIR
echo "Creating socket $SOCKETDIR/1"
socat unix-listen:$SOCKETDIR/1 - &

while ! [ -S "$SOCKETDIR/1" ]; do
	sleep 1
done

echo "Creating hard link $SOCKETDIR/2 to $SOCKETDIR/1"
ln $SOCKETDIR/1 $SOCKETDIR/2

echo "Writing to $SOCKETDIR/2"
echo Hello world | socat unix-connect:$SOCKETDIR/2 -
RES=$?

cat <<EOF

======================================================================
EOF
if [ $RES -eq 0 ]; then
	echo TEST PASSED
else
	echo TEST FAILED
fi
cat <<EOF
======================================================================

EOF

