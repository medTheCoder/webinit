#!/bin/bash
DIR_LOG="/var/opt/init/logs"
[[ ! -d $DIR_LOG ]] && mkdir -p $DIR_LOG

NAME=`basename $0`
DATE=$(date +'%Y-%m-%d_%HH%Mm%Ss')
LOG=${DIR_LOG}/${NAME}_${DATE}.log
DIR_SCRIPT=`dirname $0`

# Functions
log() {
   echo $1 >>$LOG
}
trace() {
   echo $1
   log "$1"
}
echo "See log file : $LOG"

# Script BEGIN
log "BEGIN of ${NAME} $(date +'%Y-%m-%d_%HH%Mm%Ss')"

log "> Protection contre les Smurf Attack"
echo "1" > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts

log "> Eviter le source routing"
echo "0" > /proc/sys/net/ipv4/conf/all/accept_source_route

log "> Protection contre les attaques de type Syn Flood"
echo "1" > /proc/sys/net/ipv4/tcp_syncookies
echo "1024" > /proc/sys/net/ipv4/tcp_max_syn_backlog
echo "1" > /proc/sys/net/ipv4/conf/all/rp_filter

log "> Desactivation de l'autorisation des redirections ICMP"
echo "0" > /proc/sys/net/ipv4/conf/all/accept_redirects
echo "0" > /proc/sys/net/ipv4/conf/all/secure_redirects

log "> Eviter le log des paquets icmp errones"
echo "1" > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses

log "> Activaction du log des paquets aux adresses sources falsifiees ou non routables"
echo "1" > /proc/sys/net/ipv4/conf/all/log_martians

trace "=>  Securisation done !"

log "END of ${NAME} $(date +'%Y-%m-%d_%HH%Mm%Ss')"

exit 0
