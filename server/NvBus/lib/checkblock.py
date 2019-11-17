import time
import os
import socket
import httplib, urllib 




def readpid():
    all_the_text=0
    try:
        all_the_text="0"
        file_object = open('c:\\play-1.2.3\\NvBus\\server.pid')
        print "open file ok"
        all_the_text = file_object.read()
        file_object.close()
        print "pid=" + all_the_text
    finally:
        return all_the_text

def checkandprintstack():
    i=0
    j=0
    while(True):
        if j==0:
            j=j+1
            pid=readpid()
            commandstring="jstack -l " + pid + " >> c:\\play-1.2.3\\NvBus\\logs\\block\\checkport-start.log"
            print commandstring
            try:
                os.popen(commandstring)
            except Exception, e:
                print 'print false'
        if checkurl()==1:
            j=j+1
            
            print 'check false'
            pid=readpid()
            if int(pid)>0 :
                if j>10000:
                    return
                print 'pid=' + pid
                if i==200:
                    i=0
                commandstring1="date  >> c:\\play-1.2.3\\NvBus\\logs\\block\\checkport" + str(i) + ".log"
                commandstring="jstack -l " + pid + " >> c:\\play-1.2.3\\NvBus\\logs\\block\\checkport" + str(i) +".log"
                i=i+1
                print commandstring
                try:
                    os.popen(commandstring1)
                    os.popen(commandstring)
                except Exception, e:
                    print 'print false'
                #time.sleep(3)
                #executebyconf("stop")
                #time.sleep(5)
                #executebyconf("start")
                #time.sleep(100)
        time.sleep(10)

g_httpcnn=()
ishttpconnect=0

def checkurl():
    global g_httpcnn
    global ishttpconnect
    surl = "127.0.0.1"
    port = "9000"

    try:
        #if ishttpconnect==0:
        g_httpcnn = httplib.HTTPConnection(surl,port,False,5)
        ishttpconnect=1
        print 'response'
        #test_data = {'sql':sql,'connConfigName':connConfigName}
        #test_data_urlencode = urllib.urlencode(test_data)
        #headers = {"Content-type": "application/x-www-form-urlencoded","Accept": "text/plain"}  
        g_httpcnn.request("GET", "/")
        response = g_httpcnn.getresponse()  
        returnVal = response.read()
        if response.status!=200:
            print 'connection false'
            return 1
        else:
            print 'connection ok'
            return 0
    except Exception, e:
        print 'connection exception'
        print e
        return 1
    finally:
        if g_httpcnn:
             g_httpcnn.close()
  

if __name__ == '__main__':
    checkandprintstack()
