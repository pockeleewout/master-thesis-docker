#/usr/bin/env sh

# This is mostly for debugging
pwd

# Make sure that we have a model name defined
if [ "x${TRAIN_MODEL}" == "x" ]; then
	export TRAIN_MODEL=default;
fi


echo "Starting training, with options '${TRAIN_OPTS}' for model '${TRAIN_MODEL}'\n"
python train.py ${TRAIN_OPTS} --model ${TRAIN_MODEL}
echo "Training finished\n"


echo "Exporting logs to archive"
if [ -e "logs-${TRAIN_MODEL}.tgz" ] && [ ! -d "logs-${TRAIN_MODEL}.tgz" ]; then
	echo "Removing old archive"
	rm "logs-${TRAIN_MODEL}.tgz"
fi
tar -czf "logs-${TRAIN_MODEL}.tgz" logs/
rm -r logs/
echo "Finished exporting logs\n"


echo "Exporting reconstructions to archive"
if [ -e "reconstructions-${TRAIN_MODEL}.tgz" ] && [ ! -d "reconstructions-${TRAIN_MODEL}.tgz" ]; then
	echo "Removing old archive"
	rm "reconstructions-${TRAIN_MODEL}.tgz"
fi
tar -czf "reconstructions-${TRAIN_MODEL}.tgz" reconstructions/
rm -r reconstrions/
echo "Finished exporting reconstructions\n"

