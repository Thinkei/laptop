***REMOVED***

for MANIFEST in Manifest.*; do
  FILENAME=`echo -n "$MANIFEST" | sed s/Manifest\.//`
  rm -f $FILENAME

  echo "\nBuilding $MANIFEST into $FILENAME"

  for ***REMOVED***le in `cat $MANIFEST`; do
    echo "Including: $***REMOVED***le"

    cat $***REMOVED***le >> $FILENAME

    echo "### end $***REMOVED***le\n" >> $FILENAME
  done

  chmod 755 $FILENAME
done
