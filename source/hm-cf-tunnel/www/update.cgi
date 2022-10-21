#!/bin/tclsh

source html.tcl


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
        puts -nonewline "Content-Type: text/html; charset=utf-8\r\n\r\n"

        puts [
            html {} [
                head {} [
                    meta "http-equiv='refresh' content='0; url=$release_url'"
                ]
            ]
        ]
    }
} else {
    puts -nonewline "Content-Type: text/plain; charset=utf-8\r\n\r\n"

    catch {
        set version [ exec /usr/bin/wget -qO- $version_url ]
    }

    if { [info exists version] } {
        puts $version
    } else {
        puts "n/a"
    }
}
