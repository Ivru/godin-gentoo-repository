#!/sbin/runscript

depend() {
    need net
    use dns logger
}

RUN_AS=nexus

checkconfig() {
    return 0
}

start() {
    checkconfig || return 1

    ebegin "Starting ${SVCNAME}"
    su $RUN_AS -c "/opt/nexus/nexus-oss-webapp-1.8.0/bin/jsw/linux-x86-32/nexus start"
    eend $?
}

stop() {
    ebegin "Stopping ${SVCNAME}"
    su $RUN_AS -c "/opt/nexus/nexus-oss-webapp-1.8.0/bin/jsw/linux-x86-32/nexus stop"
    eend $?
}
