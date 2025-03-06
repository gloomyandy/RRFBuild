function get_value(filename, key, typ, default_value) {
  while (getline < filename) {
    if ($0 ~ "^" key "=") {
      split($0, parts, "=");
      if (typ == "P") {
        value = parts[2]
        sub("\\.", "_", value)
        print "P"value
      }
      else
      {
        print parts[2];
      }
      return;
    }
  }
  print default_value;
}

BEGIN {
  if (ARGC != 5) {
    print "Usage: awk -f script.awk filename key type default_value";
    exit 1;
  }
  get_value(ARGV[1], ARGV[2], ARGV[3], ARGV[4]);
}
