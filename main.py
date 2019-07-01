from bottle import route, run, template, redirect
import subprocess
import json

"""
x = subprocess.Popen(["lsof", "-i:" + port], stdout=subprocess.PIPE).stdout.read()[:-1].decode("utf-8").split("\n")

"""

configFile = "config.json"
ports = json.load(open(configFile, 'r'))
ports = [str(i) for i in ports]
def lsof(port):
  print("port")
  return subprocess.Popen(["lsof", "-i:" + str(port)], stdout=subprocess.PIPE).stdout.read()[:-1].decode("utf-8")

def rpp(port): #read pid for port
  x = lsof(port).split("\n")
  retList = [i.split()[1] for i in x[1:]]
  return retList

def killall(port):
  subprocess.Popen(["kill", "-TERM"] + rpp(port))
  if(rpp(port) == []):
    return True
  else:
    return False

@route("/")
def main():
  global ports
  lsofs = {}
  prts = []
  for i in ports:
    lsofs[i] = lsof(i).split("\n")
    prts.append(i)
    #ret += "<p>" + "<br>".join(lsof(i).split("\n")) + "</p><br>"
    #ret += '<a href="killall/' + i +'">Перезаргузить порт ' + i + '</a>'
    #ret += "<hr>"
  return template("index.tpl", lsofs=lsofs, ports=prts)

@route("/killall/<port>")
def ka(port):
  killall(port)
  redirect("/")
  return str(port) + "<br>" + str(rpp(port)) + "<br>" + str(lsof(port))
run(host="localhost", port="8080")