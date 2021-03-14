function random() {
  MAX=$1
  : ${MAX:=15}
}

function loop() {
  for index in $(seq 1 $COUNT); do
    echo "index: ${index}"
  done
}

