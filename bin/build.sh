***REMOVED***

for MANIFEST in Manifest.*; do
  FILENAME=$(printf "$MANIFEST" | sed s/Manifest\.//)
  rm -f "$FILENAME"

  printf "\nBuilding $MANIFEST into $FILENAME\n"

  while read ***REMOVED***le; do
    printf "Including: $***REMOVED***le\n"

    cat "$***REMOVED***le" >> "$FILENAME"

    printf "### end $***REMOVED***le\n\n" >> "$FILENAME"
  done < "$MANIFEST"
done
