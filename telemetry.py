import socket
from configparser import ConfigParser

def parseIniFile(filepath, consoleType):
    iniParser = ConfigParser()
    try:
        with open(filepath) as f:
            iniParser.read_file(f)
    except IOError:
        print("ERROR: config.ini is missing")
        return None
    
    if consoleType not in iniParser.sections():
        print("ERROR: Invalid Ini File")
        return None
    
    #validation here
    return iniParser[consoleType]

#opens a socket given the ip and the port 
def openSocket(ip:str, port:int):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((ip, port))
    return s

#connects with a socket
def connect(socket):
    socket.listen(1)
    clientsocket, address = socket.accept()
    print(f"Connection from {address} has been established.")
    return clientsocket

#sends msg given a socket
def sendMsg(socket, msg):
    msg = str.encode(msg)
    socket.sendall(msg)