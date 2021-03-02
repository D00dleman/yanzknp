from bottle import route, run, template, redirect
import subprocess
import json


config_file = "config.json"
ports = json.load(open(config_file, 'r'))
ports = [str(i) for i in ports]


def lsof(port):
    print("port")
    return subprocess.Popen(
        ["lsof", "-i:" + str(port)], 
        stdout=subprocess.PIPE
    ).stdout.read()[:-1].decode("utf-8")

  
def rpp(port): #read pid for port
    x = lsof(port).split("\n")
    return [i.split()[1] for i in x[1:]]


def killall(port):
    subprocess.Popen(["kill", "-TERM"] + rpp(port))
    return rpp(port) == []
  

@route("/")
def main():
    global ports
    lsof_dict = {}
    ports_list = []
    for i in ports:
        lsof_dict[i] = lsof(i).split("\n")
        ports_list.append(i)
    return template("index.tpl", lsofs=lsof_dict, ports=ports_list)


@route("/killall/<port>")
def ka(port):
    killall(port)
    redirect("/")
    return "{0}<br>{1}<br>{2}".format(str(port), str(rpp(port)), str(lsof(port))

  
run(host="localhost", port="8080")
