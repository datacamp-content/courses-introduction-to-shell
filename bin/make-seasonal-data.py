#!/usr/bin/env python

'''Make CSV data files in filesys/seasonal/*.csv.'''

import sys
import csv
import random
from datetime import datetime, timedelta

FILENAME_TEMPLATE = './filesys/seasonal/{}.csv'
FILENAME_STEMS = 'spring summer autumn winter'.split()
HEADER = 'Date Tooth'.split()
TEETH = 'incisor canine bicuspid molar wisdom'.split()
MIN_RECORDS = 20
MAX_RECORDS = 30
DATE_FORMAT = '%Y-%m-%d'
START_DATE = datetime.strptime('2017-01-01', DATE_FORMAT)
ONE_DAY = timedelta(days=1)
DATE_RANGE = 250

def main():
    random.seed(20170101)
    for stem in FILENAME_STEMS:
        path = FILENAME_TEMPLATE.format(stem)
        records = [[datetime.strftime(START_DATE + random.randrange(DATE_RANGE) * ONE_DAY, DATE_FORMAT),
                    random.choice(TEETH)]
                   for r in range(random.randint(MIN_RECORDS, MAX_RECORDS))]
        records.sort()
        records.insert(0, HEADER)
        csv.writer(open(path, 'w'), lineterminator='\n').writerows(records)

if __name__ == '__main__':
    main()
