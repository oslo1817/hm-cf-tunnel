#!/bin/tclsh

source include/html.tcl
source include/http.tcl
source include/rc.tcl


proc _configure {token} {
    # Delegate to the RC script's command.
    return [rc hm-cf-tunnel configure $token ]
}


catch {
    # Parse request query string from CGI environment.
    array set query [http_query_decode $env(QUERY_STRING)]
}

if { [info exists query(token)] } {
    set token $query(token); # A cloudflared token was provided.

    if { [catch { set result [_configure $token] } message] } {
        # Something went wrong. Send the error message.

        http_status 500 "Internal Server Error"
        http_header Content-Type text/plain
        http_header_cors
        http_head_end

        puts $message
    } else {
        # The cloudflared service was successfully configured.

        http_status 204 "No Content"
        http_header_cors
        http_head_end
    }
} else {
    # No cloudflared token was provided.

    http_status 400 "Bad Request"
    http_header Content-Type text/plain
    http_header_cors
    http_head_end

    puts "no cloudflared service token was provided"
}
