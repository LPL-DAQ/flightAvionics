import socket
from configparser import ConfigParser

def parseIniFile(filepath, consoleType):
    iniParser = ConfigParser()
    try:
        with open(filepath) as f:
            iniParser.read_file(f)
    except IOError:
        print("ERROR:", filepath, "is missing")
        return None
    
    if consoleType not in iniParser.sections():
        print("ERROR: Invalid file for:", consoleType)
        return None
    
    #validation here
    return iniParser[consoleType]

#sends msg given a socket
def sendMsg(socket, msg):
    msg = str.encode(msg)
    socket.sendall(msg)