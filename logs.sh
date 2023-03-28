user=${1}
host=${2}
destination_folder=${3}

#создать 5 файлов в /var/log

for i in {1..5}; do
  touch "/var/log/file-${i}.log"
  echo "Hello file ${i}" > "/var/log/file-${i}.log"
done

#копируем файлы на удалённую машину

scp /var/log/*.log ${username}@${host}:${destination_folder}

#отправляем find на хостовую машину для поиска файлов старше 7 дней

ssh ${username}@${host} find ${destination_folder} -type f -name "file*.log" -mtime +7 -delete

#в cronetab закинуть запись 00 00 * * * userToRunScript /path/to/script/logs.sh userToConnect hostToConnect folderOnHost
