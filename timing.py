import time

ref_time =  time.time()

def setRefTime(HH,MM,SS):
    global ref_time
    #reference time. An arbitrary time during the day used as a 
    #reference on all the machines
    t = time.localtime()
    ref_time = time.mktime((t.tm_year,t.tm_mon,t.tm_mday,HH,MM,SS,t.tm_wday,t.tm_yday,t.tm_isdst))

# setRefTime(00,00,00)

#gets the time
def missionTime():
    #returns formated time stamp of the time ellepased in seconds since the reference time

    time_ellapsed = time.time()-ref_time

    time_stamp = "{:0>9.3f}".format(time_ellapsed)

    return time_stamp

#gets the difference in time between the two
def getTimeDiff(first:str, last:str):
    
    sol = float(last) - float(first)
    if sol < 0:
        #print("WARNING: SERVER OPERATED THRU MIDNIGHT")
        sol += 86400
    return sol
