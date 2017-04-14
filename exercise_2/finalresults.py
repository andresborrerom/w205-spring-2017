import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


conn = psycopg2.connect(database = "tcount", user="postgres", password="pass", host= "localhost", port = "5432")

cur = conn.cursor()

if len(sys.argv) != 2:

    cur.execute("SELECT word, count FROM tweetwordcount ORDER BY word")
    records = cur.fetchall()
    for rec in records:
        print '(' + str(rec[0]) + ', ' + str(rec[1]) + '), '
        
    exit(0)

word = sys.argv[1]


cur.execute("SELECT word, count FROM tweetwordcount")
records = cur.fetchall()

for rec in records:
    if rec[0] == word:
        print 'Total number of occurrences of "' + str(word) +'": ' + str(rec[1])
        
	exit(0)    

print word, "is not in the table"


conn.close()

