#!/bin/tclsh

source include/http.tcl
source include/rc.tcl


proc _status {} {
    # Delegate to the RC script.
    return [rc hm-cf-tunnel status]
}


http_status 200 OK
http_header Content-Type application/json
http_header_cors
http_head_end

# Check the status of the cloudflared service.
set code [catch { set status [_status] } message]

if { ![info exists status] } {
    # The status command failed. Use the first line of the error message.
    lassign [split $message \n] status
}

# Write JSON response with code and status.
puts [subst {{"code": $code, "status": "$status"}}]
