#!/bin/tclsh

source include/html.tcl
source include/http.tcl


set release_url "https://github.com/oskarlorenz/hm-cf-tunnel/releases/latest"
set version_url "https://raw.githubusercontent.com/oskarlorenz/hm-cf-tunnel/main/VERSION"


catch {
    set query $env(QUERY_STRING)
    set pairs [split $query &]

    foreach pair $pairs {
        if {$pair == "cmd=download"} {
            set command "download"; break
        }
    }
}


if { [info exists command]} {
    if { $command == "download" } {
        http_status 200 OK
        http_header Content-Type text/html
        http_head_end

        html; head
            meta http-equiv="refresh" content="0\; url=$release_url"
        head_end; html_end
    }
} else {
    http_status 200 OK
    http_header Content-Type text/plain
    http_head_end

    catch {
        set version [ exec /usr/bin/wget -qO- $version_url ]
    }

    if { [info exists version] } {
        puts $version
    } else {
        puts "n/a"
    }
}
