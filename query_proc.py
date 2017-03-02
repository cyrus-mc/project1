from flask import Flask
from flask import jsonify
from flask import request
import os.path
import re
app = Flask(__name__)

'''
Parse file into JSON

Lines in the file can be in one of three formats

   - key: array
   - key: word
   - array
'''

def readFile(filename):
  if os.path.isfile(filename):
    output = dict()
    pattern = re.compile("^[a-zA-Z0-9_\(\)\s]+:")
    with open(filename) as f:
      i = 0
      for line in f:
        i += 1
        if pattern.match(line):
          # this handles the first two cases (line starts with a key)
          fields = line.split(':')[1].strip().split(' ')
          if len(fields) == 1:
            output[line.split(':')[0].strip()] = fields[0]
          else:
            output[line.split(':')[0].strip()] = line.split(':')[1].strip().split(' ')
        else:
          # handles final case, array of words
          output['line_%d' % i] = line.strip().split(' ')

    return output

  else:
    return {'error': 'File %s does not exist' % (filename)}

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
