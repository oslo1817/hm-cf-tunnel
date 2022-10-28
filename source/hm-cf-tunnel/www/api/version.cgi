#!/bin/tclsh

source include/http.tcl
source include/rc.tcl


proc _version {} {
    # Delegate to the RC script.
    return [rc hm-cf-tunnel version]
}


# Determine the version of the addon.
set code [catch { set version [_version] } message]

if { ![info exists version] } {
    # The version command failed. Return the error message.

    http_status 500 "Internal Server Error"
    http_header Content-Type text/plain
    http_header_cors
    http_head_end

    puts $message
} else {
    # The version was successfully determined.

    http_status 200 OK
    http_header Content-Type text/plain
    http_header_cors
    http_head_end

    puts $version
}
