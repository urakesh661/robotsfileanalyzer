# robotsfileanalyzer

Thi script will fetch the robots.txt file of the domain provided and then will access each file mentioned after appending the domain name(http as well as https) in the start.

Keyword "disallow" will be searched in the robots.txt file and then the filenames will be written to file "robotfile_path.txt".Then curl will be run for http and https protocol.
