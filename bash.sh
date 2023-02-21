for i in *; do
  mv "$i" "`echo $i | sed "s/regex/replace_text/"`";
done

