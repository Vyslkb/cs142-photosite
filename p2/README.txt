Project 8 - Part 2 - Jennifer Farman

The security loophole was in the Movies Controller, which used the following line to query the movies table:

@movies = Movie.find_by_sql("SELECT * from movies" + clause + " ORDER BY title;")

Because it built the SQL conditions as pure strings, it was vulnerable to a SQL injection attack, which allowed me to input malicious SQL code as a parameter. I fixed the attack by using Movie.where(genre: genre), which avoids pure strings and thus properly sanitizes the user input.