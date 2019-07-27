#!/bin/bash

# Author: Dries Verachtert <dries.verachtert@dries.eu>

t_Log "Running $0 - test XmlTextReader of libxml2-python"

if [ "$centos_ver" -ge 8 ] ; then
PYTHON=python3
else
PYTHON=python
fi

cat << 'EOF' | $PYTHON - | grep -q 'test succeeded'
import libxml2
import sys
try:
  from StringIO import StringIO
except ImportError:
  from io import StringIO

# Load a small xml structure
xmlStr = StringIO("""<?xml version="1.0"?>
<tests><test name="XmlTextReader"><key1>val1</key1><key2>val2</key2><key3 /></test></tests>""")
xmlBuf = libxml2.inputBuffer(xmlStr)
xmlReader = xmlBuf.newTextReader("reader")

def checkRead(reader, name, isEmptyElementVal, nodeTypeVal, hasAttributesVal):
	retval = reader.Read()
	if retval != 1:
		print("Error: bad retval when reading " + name)
		sys.exit(1)
	if reader.Name() != name:
		print("Error: expected=" + name + ", actual=" + reader.Name())
		sys.exit(1)
	if reader.NodeType() != nodeTypeVal:
		print("Error: node " + name + " has wrong nodetype: " + str(reader.NodeType()))
		sys.exit(1)
	if reader.IsEmptyElement() != isEmptyElementVal:
		print("Error: node " + name + " has wrong isEmptyElement: " + str(reader.IsEmptyElement()))
		sys.exit(1)
	if reader.HasAttributes() != hasAttributesVal:
		print("Error: node " + name + " has wrong hasAttributes: " + str(reader.HasAttributes()))
		sys.exit(1)

# Test one by one each part of the loaded xml structure
checkRead(xmlReader, "tests", 0, 1, 0) # 1 = start of element
checkRead(xmlReader, "test", 0, 1, 1)  
checkRead(xmlReader, "key1", 0, 1, 0)
checkRead(xmlReader, "#text", 0, 3, 0) # 3 = text node
checkRead(xmlReader, "key1", 0, 15, 0) # 15 = close tag
checkRead(xmlReader, "key2", 0, 1, 0)
checkRead(xmlReader, "#text", 0, 3, 0)
checkRead(xmlReader, "key2", 0, 15, 0)
checkRead(xmlReader, "key3", 1, 1, 0)
checkRead(xmlReader, "test", 0, 15, 1)
checkRead(xmlReader, "tests", 0, 15, 0)
print ("test succeeded")
EOF
