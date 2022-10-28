#!/bin/tclsh

set rc_path "/usr/local/etc/config/rc.d"


# Runs the RC script with the specified name and arguments.
#
# This procedure may run any script/executable at `/usr/local/etc/config/rc.d`.
#
# @param name The name of the RC script to run.
# @param args The arguments to pass to the RC script.
#
# @return The output of the RC script.
proc rc {name args} {
    global rc_path

    # Run the RC script specified by name.
    return [ exec "$rc_path/$name" {*}$args ]
}
