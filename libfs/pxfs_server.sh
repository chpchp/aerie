pkill -9 fsserver
/scratch/nvm/stamnos/libfs/build/src/scm/tool/pool/pool create -p /tmp/stamnos_pool -s 1024M
/scratch/nvm/stamnos/libfs/build/src/pxfs/tool/pxfs create -p /tmp/stamnos_pool -s 900M -t mfs
/scratch/nvm/stamnos/libfs/build/src/pxfs/server/fsserver -p 10000 -d 0 -s /tmp/stamnos_pool &
