#!/usr/bin/env python3
#A python script to illustrate how password storage works using salts and hashes
#Joe McManus josephmc@alumni.cmu.edu

import argparse
import hashlib
from prettytable import PrettyTable
import sqlite3
import os
import random
import string

parser = argparse.ArgumentParser(description='Example Password Storage IS3800')
parser.add_argument('--add', help="add a user to the db",  action="store_true")
parser.add_argument('--query', help="query",  action="store_true")
parser.add_argument('--passwd', help="password", action="store")
parser.add_argument('--user', help="username", action="store")

args=parser.parse_args()

def queryOneRow(query):
    cursor=db.cursor()
    cursor.execute(query)
    result=cursor.fetchone()
    db.commit()
    return(result)
def queryOneRowVar(query, var):
    t=(var,)
    cursor=db.cursor()
    cursor.execute(query,t)
    result=cursor.fetchone()
    return(result)

def sha512Hash(data):
    hashObject = hashlib.sha512(data.encode())
    return hashObject.hexdigest()


#first check to see if we have a database, if not initialise with aggie
dbFile="example.sq3"
if not os.path.exists(dbFile):
    print("Initializing Password DB")
    db = sqlite3.connect(dbFile)
    db.row_factory = sqlite3.Row
    query="""CREATE TABLE passwords (ID INTEGER PRIMARY KEY, username VARCHAR(255) UNIQUE, password VARCHAR(1024), salt VARCHAR(1024))"""
    queryOneRow(query)
    table= PrettyTable(["Option", "Value"])
    table.add_row(["Username", args.user])
    table.add_row(["Clear Password", args.passwd])
    table.add_row(["Salt", salt])
    table.add_row(["Encrypted Password", encryptedPass])
    print(table)

def queryAllRowsVar(query,var):
    cursor=db.cursor()
    t=(var,)
    cursor.execute(query,t)
    result=cursor.fetchall()
    return(result)

if args.add:
    salt=sha512Hash(''.join(random.SystemRandom().choice(string.ascii_uppercase + string.digits) for _ in range(512)))
    encryptedPass=sha512Hash(args.passwd + salt)
    db = sqlite3.connect(dbFile)
    db.row_factory = sqlite3.Row
    t=(args.user, encryptedPass, salt)
    query="INSERT into passwords (ID, username, password, salt) values(NULL,?,?,?)"
    cursor=db.cursor()
    cursor.execute(query, t)
    db.commit() 
    
if args.query:
    db = sqlite3.connect(dbFile)
    db.row_factory = sqlite3.Row
    query="select password, salt from passwords where username=?"
    #password, salt = queryOneRowVar(query, args.user)
    result= queryAllRowsVar(query, args.user)
    if len(result) == 0: 
        print("Error: No user " + args.user + " found")
        quit()
    password,salt=result[0][0], result[0][1]
    userPass=sha512Hash(args.passwd + salt)
    table= PrettyTable(["Option", "Value"])
    table.add_row(["Username", args.user])
    table.add_row(["Clear Password", args.passwd])
    table.add_row(["Salt", salt])
    table.add_row(["Stored Password", password])
    table.add_row(["Created Password", userPass])
    print(table)


