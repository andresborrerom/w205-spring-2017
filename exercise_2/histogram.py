import sys
import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT


conn = psycopg2.connect(database = "tcount", user="postgres", password="pass", host= "localhost", port = "5432")

cur = conn.cursor()

if len(sys.argv) != 2:

    print "you must enter the numbers in the form leastnumber,greatestnumber" 
    exit(0)

numbers = [int(n) for n in sys.argv[1].split(",")] 
print numbers[0]
print numbers[1]

found = 0

cur.execute("SELECT word, count FROM tweetwordcount")
records = cur.fetchall()

for rec in records:
    if rec[1] >= numbers[0] and rec[1] <= numbers[1]:
        print str(rec[0]) + ': ' + str(rec[1])
        found = 1

if found == 0:
    print 'There are no words` occurrences that much those numbers'





conn.close()

