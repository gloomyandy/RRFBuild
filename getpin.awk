function find_value(filename, key, default_value) {
  # Pass the key, filename, and default_value as arguments
  while ((getline < filename) > 0) {
    # Split the line into value and keys
    value = $1
    keys = $2
    # Split the keys into an array
    num_keys = split(keys, key_array, ",")

    # Iterate through the keys and check if the desired key exists
    for (i = 1; i <= num_keys; i++) {
      if (key_array[i] == key) {
        # If the key is found, print the value and exit
        sub("\\.", "_", value)
        return "P"value #stop processing once a match is found.
      }
    }
  }
  return default_value # Return default value if no match
}

BEGIN {
  if (ARGC != 4) {
    print "Usage: awk -f script.awk filename key default_value";
    exit 1;
  }
  print find_value(ARGV[1], ARGV[2], ARGV[3]);
}
