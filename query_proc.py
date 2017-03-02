from flask import Flask
from flask import jsonify
from flask import request
app = Flask(__name__)

'''
Read in file, split into key / value and return dictionary result
'''
def readFile(filename, delimiter=':'):
  output = dict()
  with open(filename) as f:
    for line in f:
      if len(line.split(delimiter)) == 2:
        output[line.split(delimiter)[0].strip()] = line.split(delimiter)[1].strip()
      else:
        output[line.split(delimiter)[0].strip()] = ''

  return output

'''
Return system uptime
'''
def getUptime():
  output = dict()

  with open('/proc/uptime') as f:
    metrics = f.readline().split(' ')
    
    output['1'] = metrics[0]
    output['5'] = metrics[1]
    output['15'] = metrics[2]
  
  return output
    
    
@app.route('/cpuinfo')
def cpuinfo():
  print request.path
  contents = readFile('/proc/cpuinfo')
  return jsonify(contents)

@app.route('/meminfo')
def meminfo():
  contents = readFile('/proc/meminfo')
  return jsonify(contents)

@app.route('/uptime')
def uptime():
  contents = readFile('/proc/uptime', ' ')
  return jsonify(contents)

# main
if __name__ == "__main__":
	app.run(host="0.0.0.0", port=8080, debug=True)
