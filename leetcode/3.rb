
def length_of_longest_substring(s)

    b_index = 0

    e_index = 0

    length_list = []

    while e_index < s.length - 1 do

        if s[b_index..e_index].include?(s[e_index + 1])

            length_list << e_index - b_index + 1

            b_index += s[b_index..e_index].index(s[e_index + 1]) + 1

        end

        e_index += 1

    end

    length_list.push(s[b_index..e_index].length)

    length_list.sort.last

end

p length_of_longest_substring("c")
p length_of_longest_substring("aa")
p length_of_longest_substring("ababc")
p length_of_longest_substring("au")
p length_of_longest_substring("")
p length_of_longest_substring("dvdf")
