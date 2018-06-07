#!/bin/bash

# Here we set the morf_toolpath variable. Adapt if you need


morf_tool_dir=/home/pi/moRFeus_listener

function get_status () {

dummy=$(sudo $morf_tool_dir/morfeus_tool getCurrent)
sleep 0.1

echo "
****** moRFeus status

Frequency :  $(sudo $morf_tool_dir/morfeus_tool getFrequency)
Mode      :  $(sudo $morf_tool_dir/morfeus_tool getFunction)
Power     :  $(sudo $morf_tool_dir/morfeus_tool getCurrent)

$(date +%Y-%m-%d" "%H:%M:%S)

"
echo $status
export morf_tool_dir
}


