/// Split string by a delimiter. Returns an array of tokens
/// @param string
/// @param token
function string_split(string, delimiter) {
	var terms, index = 0;
	terms[0] = "";
	terms[string_count(string, delimiter)] = "";
	
	for (var i = 1; i <= string_length(string); i++) {
		if (string_char_at(string, i) == delimiter) {
			index++;
			terms[index] = "";
			continue;
		}
			
		terms[index] += string_char_at(string ,i);
	}
	
	return terms;
}