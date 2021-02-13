def convert_string_into_key_value_and_add_to_hash(string, hash_to_add_to)
  p partition = string.rpartition(' ')
  hash_to_add_to[partition.first] = partition.last.to_f
end

str = "The Dark Knight 2 10.0"
hash = {}

convert_string_into_key_value_and_add_to_hash(str, hash)
p hash #=> {"The Dark Knight 2"=>10.0}

p hash["The Dark Knight 2"]