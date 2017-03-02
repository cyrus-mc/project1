from flask import Flask
from flask import jsonify
from flask import request
import os.path
app = Flask(__name__)

'''
Read in file, split into key / value and return dictionary result
'''
def readFile(filename, delimiter=':'):
  output = dict()

  # check if file exists
  if os.path.isfile(filename):
    with open(filename) as f:
      for line in f:
        if len(line.split(delimiter)) == 2:
          output[line.split(delimiter)[0].strip()] = line.split(delimiter)[1].strip()
        else:
          output[line.split(delimiter)[0].strip()] = ''
  else:
    output['error'] = 'File %s does not exist' % (filename)

  return output

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def catch_all(path):
  if path in [ 'cpuinfo', 'meminfo', 'uptime' ]:
    contents = readFile('/proc/%s' % (path))
    return jsonify(contents)
  else:
    return jsonify({"error": "Invalid filename specified"})

# main
if __name__ == "__main__":
	app.run(host="0.0.0.0", port=8080, debug=True)
